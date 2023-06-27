import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/animators/widgets/widget_fader.dart';

class HeroicFlyer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HeroicFlyer({
    required this.flyerBoxWidth,
    required this.flyerModel,
    required this.screenName,
    required this.gridWidth,
    required this.gridHeight,
    super.key
  });
  
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final String screenName;
  final double gridWidth;
  final double gridHeight;
  /// --------------------------------------------------------------------------
  @override
  _HeroicFlyerState createState() => _HeroicFlyerState();

/// --------------------------------------------------------------------------
}

class _HeroicFlyerState extends State<HeroicFlyer> {
  // -----------------------------------------------------------------------------
  FlyerModel renderedSmallFlyer;
  String _heroPath;

  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);

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
    _heroPath = '${widget.screenName}/${widget.flyerModel?.id}/';
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _triggerLoading(setTo: true).then((_) async {
        await _preparations();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();

    //
    // if (mounted == true){
    //   if (Mapper.checkCanLoopList(_flyerModel?.slides) == true){
    //     blog('xxxxx - === >>> disposing flyer[0] SLIDE IMAGE');
    //     _flyerModel?.slides?.first?.uiImage?.dispose();
    //   }
    //   blog('xxxxx - === >>> disposing flyer LOGO IMAGE');
    //   _flyerModel?.bzLogoImage?.dispose();
    //
    // }

    FlyerProtocols.disposeRenderedFlyer(
      mounted: mounted,
      flyerModel: renderedSmallFlyer,
      invoker: 'HeroicFlyer',
    );

    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(HeroicFlyer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.flyerModel != widget.flyerModel) {
      unawaited(_preparations());
    }
  }
  // --------------------
  ///
  Future<void> _preparations() async {
    if (widget.flyerModel != null) {
      if (mounted == true) {
        final FlyerModel _renderedSmallFlyer = await FlyerProtocols.renderSmallFlyer(
          flyerModel: widget.flyerModel,
        );

        // await Future.wait(<Future>[
        //
        //   /// OVERRIDE SLIDES
        //   FlyerProtocols._imagifyFirstSlide(widget.flyerModel)
        //       .then((FlyerModel flyer){
        //     _renderedSmallFlyer = _renderedSmallFlyer.copyWith(
        //       slides: flyer.slides,
        //     );
        //   }),
        //
        //   /// OVERRIDE BZ LOGO IMAGE
        //   FlyerProtocols._imagifyBzLogo(widget.flyerModel)
        //       .then((FlyerModel flyer){
        //         _renderedSmallFlyer = _renderedSmallFlyer.copyWith(
        //           bzLogoImage: flyer.bzLogoImage,
        //         );
        //       }),
        //
        //   /// GET BZ
        //   BzProtocols.fetchBz(
        //     context: context,
        //     bzID: widget.flyerModel.bzID,
        //   ).then((BzModel bzModel){
        //
        //     setNotifier(
        //       notifier: _bzModel,
        //       mounted: mounted,
        //       value: bzModel,
        //     );
        //
        //   }),
        //
        // ]);

        if (mounted) {
          setState(() {
            renderedSmallFlyer = _renderedSmallFlyer;
            _heroPath = '${widget.screenName}/${renderedSmallFlyer?.id}/';
          });
        }
      }
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget? child) {

          if (loading == true) {
            return FlyerLoading(
              flyerBoxWidth: widget.flyerBoxWidth,
              animate: true,
              direction: Axis.vertical,
            );
          }

          else {

            if (renderedSmallFlyer == null){
              blog('(${widget.flyerModel.id}) renderedSmallFlyer == null');
              return FlyerBox(
                flyerBoxWidth: widget.flyerBoxWidth,
              );
            }

            else {
              blog('(${widget.flyerModel.id}) renderedSmallFlyer != null');
              return WidgetFader(
                fadeType: FadeType.fadeIn,
                duration: const Duration(milliseconds: 300),
                child: FlyerHero(
                  renderedFlyer: renderedSmallFlyer,
                  canBuildBigFlyer: false,
                  flyerBoxWidth: widget.flyerBoxWidth,
                  heroPath: _heroPath,
                  invoker: 'Flyer',
                  gridWidth: widget.gridWidth,
                  gridHeight: widget.gridHeight,
                ),
              );
            }

          }
        }
    );

  }
// -----------------------------------------------------------------------------
}
