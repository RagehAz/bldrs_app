import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
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
      // blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        if (_flyerModel != null)
          Flyer(
            key: const ValueKey<String>('FlyerHero'),
            flyerBoxWidth: 250,
            screenName: 'FlyerTestScreen',
            flyerModel: _flyerModel,
        ),

        const SizedBox(
          height: 20,
          width: 20,
        ),

        // if (_flyerModel != null)
        //   Stack(
        //     children: <Widget>[
        //
        //       // StaticHeader(
        //       //     flyerBoxWidth: Scale.superScreenWidth(context),
        //       //     bzModel: _bzModel,
        //       //     authorID: _flyerModel.id,
        //       //     flyerShowsAuthor: true
        //       // ),
        //
        //       Opacity(
        //         opacity: 0.5,
        //         child: HeaderTemplate(
        //           flyerBoxWidth: Scale.superScreenWidth(context),
        //
        //         ),
        //       ),
        //
        //     ],
        //   ),



      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
