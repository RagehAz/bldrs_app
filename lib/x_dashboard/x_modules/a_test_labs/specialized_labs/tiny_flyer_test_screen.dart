import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/a_static_flyer.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class TinyFlyerTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const TinyFlyerTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _TinyFlyerTestState createState() => _TinyFlyerTestState();
  /// --------------------------------------------------------------------------
}

class _TinyFlyerTestState extends State<TinyFlyerTest> {
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
  /// XXXX
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
  BzModel _bzModel;
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        if (_flyerModel != null)
        StaticFlyer(
          flyerBoxWidth: 400,
          flyerModel: _flyerModel,
          bzModel: _bzModel,
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
