import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/a_heroic_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:animators/animators.dart';
import 'package:scale/scale.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class StaticFlyerTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StaticFlyerTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StaticFlyerTestScreenState createState() => _StaticFlyerTestScreenState();
  /// --------------------------------------------------------------------------
}

class _StaticFlyerTestScreenState extends State<StaticFlyerTestScreen> {
  // -----------------------------------------------------------------------------
  Offset position ;
  FlyerModel _flyerModel;
  // BzModel _bzModel;
  // FlightDirection _flight = FlightDirection.non;
  double _tweenValue = 0;
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
    position = Offset.zero;
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        // 5VOZyFGDaY3WHfFKzzkH

        const String flyerID = 'tuKZixD2pEazLtyyALOV';

        FlyerModel flyer = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: flyerID,
        );
        // final BzModel bz = await BzProtocols.fetch(context: context, bzID: flyer.bzID);

        flyer = await FlyerProtocols.renderBigFlyer(
          context: context,
          flyerModel: flyer,
        );

        setState(() {
          _flyerModel = flyer;
        //   _bzModel = bz;
        });

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
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // _flyerModel?.blogFlyer(invoker: 'flyerTest');
    // --------------------

    final double _flyerBoxWidth = FlyerDim.flyerWidthByFactor(context, Animators.limitTweenImpact(
        maxDouble: 1,
        minDouble: 0.3,
        tweenValue: _tweenValue,
    ));
    
    final Widget _flyerWidget = HeroicFlyer(
      // key: const ValueKey<String>('FlyerHero_testthing'),
      flyerBoxWidth: _flyerBoxWidth,
      screenName: 'FlyerTestScreenWidgetthing',
      flyerModel: _flyerModel,
      // heroTag: 'FlyerTestScreen',
      // bzModel: _bzModel,
      // flightDirection: _flight,
      // flightTweenValue: _tweenValue,
    );

    return MainLayout(
      loading: _loading,
      // canGoBack: true,
      appBarType: AppBarType.basic,
      appBarRowWidgets: [

        AppBarButton(
          icon: Iconz.arrowDown,
          onTap: (){
            final double _newValue = _tweenValue - 0.1;
            setState(() {
              // _flight = FlightDirection.push;
            _tweenValue = _newValue < 0 ? 0 : _newValue;
            });
          },
        ),

        const Expander(),

        AppBarButton(
          icon: Iconz.arrowUp,
          onTap: (){
            final double _newValue = _tweenValue + 0.1;
            setState(() {
              // _flight = FlightDirection.pop;
              _tweenValue = _newValue > 1 ? 1 : _newValue;
            });
          },
        ),

      ],
      child: Stack(
        children: [

          Container(
            width: Scale.screenWidth(context),
            height: Scale.screenHeight(context),
            color: Colorz.bloodTest,

          ),

          if (_flyerModel != null)
            _flyerWidget

            // if (_flyerModel != null)
            // SuperPositioned(
            //   enAlignment: Alignment.center,
            //   verticalOffset: position.dy,
            //   horizontalOffset: position.dx,
            //   child: Draggable(
            //     onDraggableCanceled: (Velocity velocity, Offset offset){
            //       setState(() => position = offset);
            //     },
            //
            //     // axis: Axis.horizontal,
            //     affinity: Axis.vertical,
            //     feedback: const SizedBox(), //_flyerWidget,
            //     // childWhenDragging: const SizedBox(),
            //     rootOverlay: true,
            //     child: _flyerWidget,
            //   ),
            // ),


        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
