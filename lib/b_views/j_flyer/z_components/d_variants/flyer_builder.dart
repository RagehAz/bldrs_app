import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FlyerBuilder extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerBuilder({
    @required this.flyerID,
    @required this.builder,
    @required this.flyerBoxWidth,
    @required this.renderFlyer,
    this.flyerModel,
    this.onFlyerNotFound,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String flyerID;
  final double flyerBoxWidth;
  final Function onFlyerNotFound;
  final FlyerModel flyerModel;
  final RenderFlyer renderFlyer;
  final Widget Function(FlyerModel flyerModel) builder;
  // -----------------------------------------------------------------------------
  bool shouldDirectlyBuildByFlyerModel(){
    bool _shouldBuildByFlyer = false;

    /// FLYER MODEL IS NULL
    if (flyerModel == null){
      _shouldBuildByFlyer = false;
    }

    /// FLYER MODEL IS NOT NULL
    else {

      /// WHEN KEEP NON RENDERED
      if (renderFlyer == RenderFlyer.keep){
        _shouldBuildByFlyer = true;
      }
      /// WHEN RENDER FIRST SLIDE
      else if (renderFlyer == RenderFlyer.firstSlide){
        _shouldBuildByFlyer = flyerModel.slides.first.uiImage != null;
      }
      /// WHEN RENDER ALL SLIDES
      else {
        final bool _allSlidesAreRendered = flyerModel.slides.every((slide) => slide.uiImage != null);
        _shouldBuildByFlyer = _allSlidesAreRendered;
      }

    }

    return _shouldBuildByFlyer;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _shouldDirectlyBuildByFlyerModel = shouldDirectlyBuildByFlyerModel();

    if (_shouldDirectlyBuildByFlyerModel == true) {
      return builder(flyerModel);
    }

    else {

      return _FutureFlyerBuilder(
        flyerID: flyerID,
        flyerModel: flyerModel,
        flyerBoxWidth: flyerBoxWidth,
        onFlyerNotFound: onFlyerNotFound,
        renderFlyer: renderFlyer,
        builder: builder,
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class _FutureFlyerBuilder extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const _FutureFlyerBuilder({
    @required this.flyerID,
    @required this.builder,
    @required this.flyerBoxWidth,
    @required this.renderFlyer,
    @required this.flyerModel,
    @required this.onFlyerNotFound,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String flyerID;
  final double flyerBoxWidth;
  final Function onFlyerNotFound;
  final RenderFlyer renderFlyer;
  final Widget Function(FlyerModel flyerModel) builder;
  final FlyerModel flyerModel;
  // -----------------------------------------------------------------------------
  @override
  State<_FutureFlyerBuilder> createState() => _FutureFlyerBuilderState();
  // -----------------------------------------------------------------------------
}

class _FutureFlyerBuilderState extends State<_FutureFlyerBuilder> {
  // -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _fetchAndRenderFlyer();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant _FutureFlyerBuilder oldWidget) {

    if (oldWidget.flyerID != widget.flyerID ||
    oldWidget.flyerModel != widget.flyerModel ||
    oldWidget.renderFlyer != widget.renderFlyer
    ){

      unawaited(_fetchAndRenderFlyer());

    }

    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();

    // FlyerProtocols.disposeRenderedFlyer(
    //   mounted: mounted,
    //   flyerModel: _flyerModel,
    //   invoker: '_FutureFlyerBuilder',
    // );

    super.dispose();
  }
  // --------------------
  Future<void> _fetchAndRenderFlyer() async {

    await _triggerLoading(setTo: true);

    FlyerModel _flyer = widget.flyerModel ?? await FlyerProtocols.fetchFlyer(
      context: context,
      flyerID: widget.flyerID,
    );

    if (_flyer != null) {

      if (widget.renderFlyer == RenderFlyer.firstSlide && mounted) {
        _flyer = await FlyerProtocols.renderSmallFlyer(
          context: context,
          flyerModel: _flyer,
        );
      }

      else if (widget.renderFlyer == RenderFlyer.allSlides && mounted) {
        _flyer = await FlyerProtocols.renderBigFlyer(
          context: context,
          flyerModel: _flyer,
        );
      }

      if (mounted == true){
        setState(() {
          _flyerModel = _flyer;
        });
      }

    }

    else {

      if (widget.onFlyerNotFound != null) {
        widget.onFlyerNotFound();
      }

    }

    await _triggerLoading(setTo: false);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('FlyerBuilder'),
      valueListenable: _loading,
      builder: (_, bool loading, Widget child) {

        if (loading == true) {
          return FlyerLoading(
            flyerBoxWidth: widget.flyerBoxWidth,
            animate: true,
            direction: Axis.vertical,
          );
        }

        else {
          return widget.builder(_flyerModel);
        }

      },
    );

  }
  // -----------------------------------------------------------------------------
}

enum RenderFlyer {
  allSlides,
  firstSlide,
  keep,
}
