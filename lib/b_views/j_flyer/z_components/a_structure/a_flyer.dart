import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
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
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
    }
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

        if (widget.flyerModel != null){

          _bzModel.value = await BzProtocols.fetchBz(
            context: context,
            bzID: widget.flyerModel.bzID,
          );

        }

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// XXXX
  @override
  void dispose() {
    _loading.dispose();
    _bzModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.flyerModel == null){

      return FlyerBox(
        flyerBoxWidth: widget.flyerBoxWidth,
        boxColor: Colorz.white10,
      );

    }

    else {

      return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget flyer){

          if (loading == true){

            return FlyerBox(
              flyerBoxWidth: widget.flyerBoxWidth,
              boxColor: Colorz.white10,
            );

            // return FlyerLoading(
            //   flyerBoxWidth: widget.flyerBoxWidth,
            // );

          }

          else {
            return flyer;
          }

        },
        child: WidgetFader(
          fadeType: FadeType.fadeIn,
          duration: const Duration(milliseconds: 100),
          child: ValueListenableBuilder(
            valueListenable: _bzModel,
            builder: (_, BzModel bzModel, Widget child){

              return FlyerHero(
                flyerModel: widget.flyerModel,
                bzModel: _bzModel.value,
                isFullScreen: false,
                flyerBoxWidth: widget.flyerBoxWidth,
                heroTag: '${widget.screenName}/${widget.flyerModel.id}/',
              );

            },
          ) ,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
