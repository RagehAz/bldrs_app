import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class Flyer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const Flyer({
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
  _FlyerState createState() => _FlyerState();
  /// --------------------------------------------------------------------------
}

class _FlyerState extends State<Flyer> {
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
     _heroPath = '${widget.screenName}/${widget.flyerModel.id}/';
     super.initState();
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
    _flyerModel?.slides[0].uiImage?.dispose();
    _flyerModel?.bzLogoImage?.dispose();
    _bzModel.dispose();
    super.dispose();
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
          BzProtocols.fetch(
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

        setState(() {
          _flyerModel = _flyerWithUiImages;
        });

      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.flyerModel == null){

      blog('Building loading flyer red : FLYER IS NULL');

      return FlyerLoading(
        flyerBoxWidth: widget.flyerBoxWidth,
        animate: true,
        boxColor: Colorz.bloodTest,
      );

    }

    else {

      return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget flyer){

          if (loading == true){

            blog('Building flyer [LOADING]---> ( $_heroPath )');

            return FlyerLoading(
              flyerBoxWidth: widget.flyerBoxWidth,
              animate: true,
              // boxColor: widget.flyerModel.slides[0].midColor,
            );

          }

          else {
            return flyer;
          }

        },
        child: Stack(
          children: <Widget>[

            // /// FLYER MATTRESS
            // FlyerLoading(
            //   flyerBoxWidth: widget.flyerBoxWidth,
            //   animate: false,
            // ),

            WidgetFader(
              fadeType: FadeType.fadeIn,
              duration: const Duration(milliseconds: 300),
              child: ValueListenableBuilder(
                valueListenable: _bzModel,
                builder: (_, BzModel bzModel, Widget child){

                  return FlyerHero(
                    flyerModel: _flyerModel,
                    bzModel: bzModel,
                    isFullScreen: false,
                    flyerBoxWidth: widget.flyerBoxWidth,
                    heroTag: _heroPath,
                  );

                },
              ) ,
            ),

          ],
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
