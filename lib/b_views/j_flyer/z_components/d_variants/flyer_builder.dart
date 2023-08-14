// ignore_for_file: unused_element
import 'dart:async';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:flutter/material.dart';

enum RenderFlyer {
  allSlides,
  firstSlide,
  keep,
}

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
  final Widget Function(bool loading, FlyerModel? flyerModel) builder;
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
      return builder(false, flyerModel);
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
    super.key
  });
  // -----------------------------------------------------------------------------
  final String? flyerID;
  final double flyerBoxWidth;
  final Function(String? flyerID)? onFlyerNotFound;
  final RenderFlyer renderFlyer;
  final SlidePicType slidePicType;
  final bool onlyFirstSlide;
  final Widget Function(bool loading, FlyerModel? flyerModel) builder;
  final FlyerModel? flyerModel;
  // -----------------------------------------------------------------------------
  @override
  State<_FutureFlyerBuilder> createState() => _FutureFlyerBuilderState();
  // -----------------------------------------------------------------------------
}

class _FutureFlyerBuilderState extends State<_FutureFlyerBuilder> {
  // -----------------------------------------------------------------------------
  FlyerModel? _flyerModel;
  bool _loading = true;
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

      asyncInSync(() async {
        await _fetchAndRenderFlyer();
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

    // FlyerProtocols.disposeRenderedFlyer(
    //   mounted: mounted,
    //   flyerModel: _flyerModel,
    //   invoker: '_FutureFlyerBuilder',
    // );

    super.dispose();
  }
  // --------------------
  Future<void> _fetchAndRenderFlyer() async {

    if (mounted == true){
      setState(() {
        _loading = true;
      });
    }

    if (mounted == true){

      FlyerModel? _flyer = widget.flyerModel ?? await FlyerProtocols.fetchFlyer(
        flyerID: widget.flyerID,
      );

      if (_flyer != null) {

        if (widget.renderFlyer == RenderFlyer.firstSlide && mounted == true) {
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

        else if (widget.renderFlyer == RenderFlyer.allSlides && mounted == true) {

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
            _loading = false;
          });
        }

      }

      else {

        if (widget.onFlyerNotFound != null) {
          widget.onFlyerNotFound!.call(widget.flyerID);
        }

      }

    }

    if (_loading == true && mounted == true){
      setState(() {
        _loading = false;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return widget.builder(_loading, _flyerModel);

  }
  // -----------------------------------------------------------------------------
}
