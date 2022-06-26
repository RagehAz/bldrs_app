import 'dart:async';

import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart' as CloudFunctionz;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/real/real.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CloudFunctionsTest extends StatefulWidget {

  const CloudFunctionsTest({
    Key key
  }) : super(key: key);

  @override
  _CloudFunctionsTestState createState() => _CloudFunctionsTestState();

}

class _CloudFunctionsTestState extends State<CloudFunctionsTest> {

  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
      if (function == null) {
        setState(() {
          _loading = !_loading;
        });
      } else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
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
      _triggerLoading().then((_) async {
        /// do Futures here

        unawaited(_triggerLoading(function: () {
          /// set new values here
        }));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
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
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      pageTitle: 'Cloud Functions test',
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: Ratioz.stratosphere),
          children: <Widget>[

            WideButton(
                verse: 'call a cloud function callable_sayHello',
                onTap: () async {
                  final dynamic map = await CloudFunctionz.callFunction(
                      context: context,
                      cloudFunctionName: 'n001_notifyUser',
                      toDBMap: <String, dynamic>{
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
              verse: 'INCREMENT FLYER COUNTER',
              icon: Iconz.addFlyer,
              onTap: () async {

                unawaited(TopDialog.showTopDialog(
                    context: context,
                    firstLine: 'sending request to nour')
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
                  futures.add(Real.incrementDocField(
                    context: context,
                    docID: 'flyerID',
                    fieldName: 'shares',
                    collName: 'bzzCounters',
                    increment: true,
                  ));
                }

                await Future.wait(futures);

                // blogMap(_map, methodName: 'REAL FUCKING TIME MAP IS :');


                await TopDialog.showTopDialog(
                  context: context,
                  firstLine: '$_numberOfTimes requestS sent',
                );

                // blogMap(_map, methodName: 'REAL FUCKING TIME MAP IS :');

              },
            ),

            WideButton(
              width: 250,
              verse: 'realBypassUpdate',
              onTap: () async {

                unawaited(WaitDialog.showWaitDialog(
                  context: context,
                  loadingPhrase: 'Posting Http request aho',
                  canManuallyGoBack: true,
                ),

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

                WaitDialog.closeWaitDialog(context);

              },
            ),

          ],
        ),
      ),
    );
  }
}