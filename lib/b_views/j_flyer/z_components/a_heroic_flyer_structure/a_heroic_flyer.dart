import 'dart:async';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:widget_fader/widget_fader.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class HeroicFlyer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HeroicFlyer({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.screenName,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final String screenName;
  /// --------------------------------------------------------------------------
  @override
  _HeroicFlyerState createState() => _HeroicFlyerState();
  /// --------------------------------------------------------------------------
}

class _HeroicFlyerState extends State<HeroicFlyer> {
  // -----------------------------------------------------------------------------
   final ValueNotifier<BzModel> _bzModel = ValueNotifier(null);
   FlyerModel _flyerModel;
   String _heroPath;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
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


    if (mounted == true){
      if (Mapper.checkCanLoopList(_flyerModel?.slides) == true){
        blog('xxxxx - === >>> disposing flyer[0] SLIDE IMAGE');
        _flyerModel?.slides?.first?.uiImage?.dispose();
      }
      blog('xxxxx - === >>> disposing flyer LOGO IMAGE');
      _flyerModel?.bzLogoImage?.dispose();
      _bzModel.dispose();

    }
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
  Future<void> _preparations() async {

    if (widget.flyerModel != null){

      if (mounted == true){

        FlyerModel _flyerWithUiImages = widget.flyerModel;

        await Future.wait(<Future>[

          /// OVERRIDE SLIDES
          FlyerProtocols.imagifyFirstSlide(widget.flyerModel)
              .then((FlyerModel flyer){
            _flyerWithUiImages = _flyerWithUiImages.copyWith(
              slides: flyer.slides,
            );
          }),

          /// OVERRIDE BZ LOGO IMAGE
          FlyerProtocols.imagifyBzLogo(widget.flyerModel)
              .then((FlyerModel flyer){
                _flyerWithUiImages = _flyerWithUiImages.copyWith(
                  bzLogoImage: flyer.bzLogoImage,
                );
              }),

          /// GET BZ
          BzProtocols.fetchBz(
            context: context,
            bzID: widget.flyerModel.bzID,
          ).then((BzModel bzModel){

            setNotifier(
              notifier: _bzModel,
              mounted: mounted,
              value: bzModel,
            );

          }),

        ]);

        if (mounted){
          setState(() {
            _flyerModel = _flyerWithUiImages;
            _heroPath = '${widget.screenName}/${_flyerModel?.id}/';
          });
        }

      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return  WidgetFader(
      fadeType: FadeType.fadeIn,
      duration: const Duration(milliseconds: 300),
      child: ValueListenableBuilder(
        valueListenable: _bzModel,
        builder: (_, BzModel bzModel, Widget child){

          blog('flyer : _heroPath : $_heroPath : widget.screenName : ${widget.screenName}');

          return FlyerHero(
            flyerModel: _flyerModel,
            bzModel: bzModel,
            canBuildBigFlyer: false,
            flyerBoxWidth: widget.flyerBoxWidth,
            heroPath: _heroPath,
            invoker: 'Flyer',
          );

        },
      ) ,
    );

  }
  // -----------------------------------------------------------------------------
}
