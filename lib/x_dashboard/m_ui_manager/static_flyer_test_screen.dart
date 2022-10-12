import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
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
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
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

        const String flyerID = 'upQofLWCS1adHGU497A7';

        _flyerModel = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: flyerID,
        );

        setState(() {});

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
