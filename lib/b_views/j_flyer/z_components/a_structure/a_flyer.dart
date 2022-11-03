import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_small_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/d_flight_flyer.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
   String _heroTag;
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
     _heroTag = '${widget.screenName}/${widget.flyerModel.id}/';
     super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        if (widget.flyerModel != null){

          if (mounted == true){

            final BzModel _bz = await BzProtocols.fetch(
              context: context,
              bzID: widget.flyerModel.bzID,
            );

            setNotifier(
              notifier: _bzModel,
              mounted: mounted,
              value: _bz,
            );

          }

        }

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
    _bzModel.dispose();
    super.dispose();
  }
   // --------------------------------------------------------------------------
   ///
   Widget buildFlight(
       BuildContext flightContext,
       Animation<double> animation,
       HeroFlightDirection flightDirection,
       BuildContext fromHeroContext,
       BuildContext toHeroContext,
       ){

     return FlightFlyer(
       flyerModel: widget.flyerModel,
       bzModel: _bzModel.value,
       flyerBoxWidth: widget.flyerBoxWidth,
       heroTag: _heroTag,
       animation: animation,
       flightContext: flightContext,
       flightDirection: flightDirection,
     );

   }
   // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.flyerModel == null){

      return FlyerLoading(
        flyerBoxWidth: widget.flyerBoxWidth,
        animate: false,
      );

    }

    else {

      return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget flyer){

          if (loading == true){

            return FlyerLoading(
              flyerBoxWidth: widget.flyerBoxWidth,
              animate: false,
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
              fadeType: FadeType.stillAtMax,
              duration: const Duration(milliseconds: 100),
              child: ValueListenableBuilder(
                valueListenable: _bzModel,
                builder: (_, BzModel bzModel, Widget child){

                  return Hero(
                    key: const ValueKey<String>('FlyerHero'),
                    tag: _heroTag,
                    flightShuttleBuilder: buildFlight,
                    child: SmallFlyer(
                      flyerBoxWidth: widget.flyerBoxWidth,
                      bzModel: bzModel,
                      flyerModel: widget.flyerModel,
                      heroTag: _heroTag,
                      // flightTweenValue: 0,
                      // flightDirection: FlightDirection.non,
                    ),
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
