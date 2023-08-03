// ignore_for_file: unused_element
import 'dart:async';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:flutter/material.dart';

class FlyerBuilder extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerBuilder({
    required this.flyerID,
    required this.builder,
    required this.flyerBoxWidth,
    required this.renderFlyer,
    required this.slidePicType,
    required this.onlyFirstSlide,
    this.flyerModel,
    this.onFlyerNotFound,
    this.loadingWidget,
    super.key
  });
  // -----------------------------------------------------------------------------
  final String? flyerID;
  final double flyerBoxWidth;
  final Function(String? flyerID)? onFlyerNotFound;
  final FlyerModel? flyerModel;
  final RenderFlyer renderFlyer;
  final SlidePicType slidePicType;
  final bool onlyFirstSlide;
  final Widget Function(FlyerModel? flyerModel) builder;
  final Widget? loadingWidget;
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
        _shouldBuildByFlyer = flyerModel?.slides?.first.frontImage != null;
      }
      /// WHEN RENDER ALL SLIDES
      else {
        final bool? _allSlidesAreRendered = flyerModel?.slides?.every((slide) => slide.frontImage != null);
        _shouldBuildByFlyer = _allSlidesAreRendered ?? false;
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
        slidePicType: slidePicType,
        onlyFirstSlide: onlyFirstSlide,
        builder: builder,
        loadingWidget: loadingWidget,
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class _FutureFlyerBuilder extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const _FutureFlyerBuilder({
    required this.flyerID,
    required this.builder,
    required this.flyerBoxWidth,
    required this.renderFlyer,
    required this.slidePicType,
    required this.onlyFirstSlide,
    required this.flyerModel,
    required this.onFlyerNotFound,
    required this.loadingWidget,
    super.key
  });
  // -----------------------------------------------------------------------------
  final String? flyerID;
  final double flyerBoxWidth;
  final Function(String? flyerID)? onFlyerNotFound;
  final RenderFlyer renderFlyer;
  final SlidePicType slidePicType;
  final bool onlyFirstSlide;
  final Widget Function(FlyerModel? flyerModel) builder;
  final FlyerModel? flyerModel;
  final Widget? loadingWidget;
  // -----------------------------------------------------------------------------
  @override
  State<_FutureFlyerBuilder> createState() => _FutureFlyerBuilderState();
  // -----------------------------------------------------------------------------
}

class _FutureFlyerBuilderState extends State<_FutureFlyerBuilder> {
  // -----------------------------------------------------------------------------
  FlyerModel? _flyerModel;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        await _fetchAndRenderFlyer();

        await _triggerLoading(setTo: false);
      });

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

    if (mounted == true){

      FlyerModel? _flyer = widget.flyerModel ?? await FlyerProtocols.fetchFlyer(
        flyerID: widget.flyerID,
      );

      if (_flyer != null) {

        if (widget.renderFlyer == RenderFlyer.firstSlide && mounted) {
          _flyer = await FlyerProtocols.renderSmallFlyer(
            flyerModel: _flyer,
            slidePicType: widget.slidePicType,
            onlyFirstSlide: widget.onlyFirstSlide,
            onRenderEachSlide: (FlyerModel flyer){
              if (mounted == true){
                setState(() {
                  _flyerModel = _flyer;
                });}
            }
          );
        }

        else if (widget.renderFlyer == RenderFlyer.allSlides && mounted) {

          /// SMALL
          _flyer = await FlyerProtocols.renderBigFlyer(
              flyerModel: _flyer,
              slidePicType: SlidePicType.small,
              onRenderEachSlide: (FlyerModel flyer){
                if (mounted == true){
                  setState(() {
                    _flyerModel = _flyer;
                  });}
              }
              );

          /// BIG
          if (widget.slidePicType != SlidePicType.small){
            _flyer = await FlyerProtocols.renderBigFlyer(
                flyerModel: _flyer,
                slidePicType: widget.slidePicType,
                onRenderEachSlide: (FlyerModel flyer){
                  if (mounted == true){
                    setState(() {
                      _flyerModel = _flyer;
                    });}
                }
                );
          }

        }

        // ignore: invariant_booleans
        if (mounted == true){
          setState(() {
            _flyerModel = _flyer;
          });
        }

      }

      else {

        if (widget.onFlyerNotFound != null) {
          widget.onFlyerNotFound!.call(widget.flyerID);
        }

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
      builder: (_, bool loading, Widget? child) {

        if (loading == true) {
          return widget.loadingWidget ?? FlyerLoading(
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
