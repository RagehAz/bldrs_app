import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class StaticFlyerTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StaticFlyerTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StaticFlyerTestState createState() => _StaticFlyerTestState();
  /// --------------------------------------------------------------------------
}

class _StaticFlyerTestState extends State<StaticFlyerTest> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
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

      _triggerLoading().then((_) async {

        const String flyerID = 'upQofLWCS1adHGU497A7';

        _flyerModel = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: flyerID,
        );
        _bzModel = await BzProtocols.fetchBz(
          context: context,
          bzID: _flyerModel.bzID,
        );


        setState(() {

        });

        await _triggerLoading();
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
  FlyerModel _flyerModel;
  BzModel _bzModel;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        if (_flyerModel != null)
          FlyerHero(
            key: const ValueKey<String>('FlyerHero'),
            heroTag: createHeroTag(
              heroTag: 'test',
              flyerID: _flyerModel.id,
            ),
            flyerZone: _flyerModel.zone,
            // flyerIsSaved: ValueNotifier(false),
            isFullScreen: false,
            minWidthFactor: 0.4,
            // onSaveFlyer: null,
            // progressBarModel: null,
            flyerModel: _flyerModel,
            bzModel: _bzModel,
            // heroTag: 'TestNewFlyer${_flyerModel.id}',
            // onFlyerTap: (){
            //   blog('kokoko');
            // },
            // onMoreTap: (){
            //   blog('kddddddokoko');
            // },

        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}