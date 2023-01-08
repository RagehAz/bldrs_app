import 'dart:async';

import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';


import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CloudFunctionsTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CloudFunctionsTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _CloudFunctionsTestState createState() => _CloudFunctionsTestState();
/// --------------------------------------------------------------------------
}

class _CloudFunctionsTestState extends State<CloudFunctionsTest> {
  // -----------------------------------------------------------------------------
  ///
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;
  ///
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
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {

        /// do Futures here

        unawaited(_triggerLoading(setTo: false));
      });
    }
    _isInit = false;
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
// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      title: Verse.plain('Cloud Functions test'),
      appBarRowWidgets: const <Widget>[],
      child: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: Ratioz.stratosphere),
          children: <Widget>[

            WideButton(
                verse: Verse.plain('call a cloud function callable_sayHello'),
                onTap: () async {
                  final dynamic map = await CloudFunction.call(
                      context: context,
                      functionName: 'n001_notifyUser',
                      mapToPass: <String, dynamic>{
                        'from': AuthFireOps.superUserID(),
                        'to': '60a1SPzftGdH6rt15NF96m0j9Et2', // rageh by facebook
                        'title': 'Targetted notification',
                        'body':
                        'this is by far the first true targeted notification in this app',
                      });
                  blog('done : map is : $map');
                }
            ),

            /// INCREMENT FLYER COUNTER
            SettingsWideButton(
              verse: Verse.plain('INCREMENT FLYER COUNTER'),
              icon: Iconz.addFlyer,
              onTap: () async {

                unawaited(TopDialog.showTopDialog(
                    context: context,
                    firstVerse: Verse.plain('sending request to nour')
                )
                );

                // await CounterOps.incrementFlyerCounter(
                //   context: context,
                //   flyerID: 'flyerID',
                //   fieldName: 'shares',
                //   collName: 'bzzCounters',
                //   increment: true,
                // );


                const int _numberOfTimes = 1000;

                final List<Future<dynamic>> futures = <Future<dynamic>>[];

                for (int i = 0; i < _numberOfTimes; i++){
                  futures.add(CloudFunction.incrementDocFieldNourMethod(
                    context: context,
                    docID: 'xx',
                    fieldName: 'xx',
                    collName: 'xx',
                    increment: true,
                  ));
                }

                await Future.wait(futures);

                // blogMap(_map, invoker: 'REAL FUCKING TIME MAP IS :');


                await TopDialog.showTopDialog(
                  context: context,
                  firstVerse: Verse.plain('$_numberOfTimes requestS sent'),
                );

                // blogMap(_map, invoker: 'REAL FUCKING TIME MAP IS :');

              },
            ),

            WideButton(
              width: 250,
              verse: Verse.plain('realBypassUpdate'),
              onTap: () async {

                pushWaitDialog(
                  context: context,
                  verse: Verse.plain('Posting Http request aho'),
                  canManuallyGoBack: true,
                );

                const String _link = 'https://e8da-197-133-201-44.ngrok.io/realBypassUpdate';

                final Map<String, dynamic> input = {
                  'collName': 'colors',
                  'docName' : 'colorID',
                  'input' : 'test',
                };

                final http.Response _response = await http.post(
                  Uri.parse(_link),
                  body: input,
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                );

                blog('response.body : ${_response.body}');
                blog('response.request.headers : ${_response.request.headers}');

                await WaitDialog.closeWaitDialog(context);

              },
            ),

          ],
        ),
      ),
    );
  }
}
