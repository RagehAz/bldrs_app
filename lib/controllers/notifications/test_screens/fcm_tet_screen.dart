import 'dart:async';
import 'dart:io';

import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/db/fire/methods/cloud_functions.dart' as CloudFunctionz;
import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/user/fcm_token.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class FCMTestScreen extends StatefulWidget {
  const FCMTestScreen({Key key}) : super(key: key);

  @override
  _FCMTestScreenState createState() => _FCMTestScreenState();
}

class _FCMTestScreenState extends State<FCMTestScreen> {
  /// FCM : firebase cloud messaging
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // StreamSubscription _iosSubscription;

  @override
  void initState() {
    super.initState();



    /// for ios notifications
    if (Platform.isIOS){

      // iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
      //   _saveDeviceTokenToUserDocInFireStore();
      // });
      //
      // _fcm.requestPermission(
      //   alert: true,
      //   badge: true,
      //   provisional: true,
      //   sound: true,
      //   announcement: true,
      //   carPlay: true,
      //   criticalAlert: true,
      // );

    }

    else {
      _saveDeviceTokenToUserDocInFireStore();
    }


    // fbm.getToken();
    _fcm.subscribeToTopic('flyers');
    // firebaseMessaging.unsubscribeFromTopic('flyers');
  }
// -----------------------------------------------------------------------------
   Future<void> _saveDeviceTokenToUserDocInFireStore() async {
    final String _userID = FireAuthOps.superUserID();
    // User _firebaseUser = superFirebaseUser();

    final String _fcmToken = await _fcm.getToken();

    if (_fcmToken != null){

      final FCMToken _token = FCMToken(
          token: _fcmToken,
          createdAt: DateTime.now(),
          platform: Platform.operatingSystem,
      );

      await Fire.updateDocField(
        context: context,
        collName: FireColl.users,
        docName: _userID,
        field: 'fcmToken',
        input: _token.toMap(toJSON: false),
      );

    }
   }
// -----------------------------------------------------------------------------

  NotiModel _noti;
  bool _notiIsOn = false;
  void _setNoti(NotiModel noti){

    if (noti != null){
      setState(() {
        _noti = noti;
        _notiIsOn = true;
      });
    }

  }
// -----------------------------------------------------------------------------
  void receiveAndActUponNoti({dynamic msgMap, NotiType notiType}){
    print('receiveAndActUponNoti : notiType : $notiType');

    NotiModel _noti;

    tryAndCatch(
      context: context,
      onError: (String error) => print(error),
      methodName: 'receiveAndActUponNoti',
      functions: (){
        _noti = NotiModel.decipherNotiModel(
          map: msgMap,
          fromJSON: false,
        );
      },
    );

    _setNoti(_noti);
  }
// -----------------------------------------------------------------------------

  /// STOP WATCH
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final bool _isHours = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  void _startCounter(){
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void _stopCounter(){
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void _lapCounter(){
    _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
  }

  void _resetCounter(){
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    setState(() {
      _received = 'Nothing yet';
    });
  }

  String _received = 'Nothing yet';

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    return TestingLayout(
        screenTitle: 'Notifications',
        appbarButtonVerse: 'button',
        appbarButtonOnTap: (){
          print('wtf');
        },
        listViewWidgets: <Widget>[

          const Stratosphere(),

          DreamBox(
            height: 50,
            verse: 'recieve noti ops',
            onTap: (){
              print('operating noti');

              receiveAndActUponNoti();

            },
          ),

          const SizedBox(
            width: 100,
            height: 10,
          ),

          DreamBox(
            height: 40,
            width: 200,
            verse: _notiIsOn == true ? 'Notification on' : 'Notification is off',
            color: _notiIsOn == true ? Colorz.red255 : Colorz.grey50,
            verseColor: _notiIsOn == true ? Colorz. white255 : Colorz.black255,
            verseShadow: false,
            onTap: () async {
              setState(() {
                _notiIsOn = false;
                _noti = null;
              });

              await _fcm.setAutoInitEnabled(false);
              print('the thing is : ');

            },
          ),

          const SizedBox(
            width: 100,
            height: 10,
          ),

          // if (_notiIsOn == true)
          SuperVerse(
            verse:
              '_noti.notification.title : ${_noti?.title}\n'
              ' '
              '_noti.notification.body : ${_noti?.body}\n'
              ' '
              '_noti.data : ${_noti?.metaData}\n',
            maxLines: 100,
          ),

          DreamBox(
            height: 60,
            width: 250,
            verse: 'call cloud function \n'
                '$_received',
            verseScaleFactor: 0.7,
            verseMaxLines: 2,
            color: Colorz.blue80,
            verseColor: Colorz.black255,
            verseShadow: false,
            onTap: () async {

              _startCounter();

              final dynamic map = await CloudFunctionz.callFunction(
                  context: context,
                  cloudFunctionName: 'sayHello'
              );

              _lapCounter();

              print('The Map is Amazingly : $map');

              setState(() {
                _received = 'received : ${map.toString()}';
              });

              _lapCounter();

              _stopCounter();
            },
          ),


          Row(

            children: <Widget>[

              Container(
                width: _screenWidth * 0.5,
                height: 300,
                color: Colorz.bloodTest,
                child: Column(
                  children: <Widget>[

                    StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (BuildContext context, AsyncSnapshot<int> snap) {

                        final int value = snap.data;

                        final String displayTime = StopWatchTimer.getDisplayTime(value, hours: _isHours);

                        return
                          DreamBox(
                            height: 150,
                            width: 200,
                            verse: displayTime,
                            verseScaleFactor: 0.7,
                          );
                      },
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        /// START
                        DreamBox(
                          height: 60,
                          width: 100,
                          verse: 'Start',
                          verseScaleFactor: 0.7,
                          color: Colorz.blue80,
                          verseColor: Colorz.black255,
                          verseShadow: false,
                          onTap: _startCounter,
                        ),

                        /// STOP
                        DreamBox(
                          height: 60,
                          width: 100,
                          verse: 'Stop',
                          verseScaleFactor: 0.7,
                          color: Colorz.blue80,
                          verseColor: Colorz.black255,
                          verseShadow: false,
                          onTap: _stopCounter,
                        ),

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        /// STOP
                        DreamBox(
                          height: 60,
                          width: 100,
                          verse: 'Lap',
                          verseScaleFactor: 0.7,
                          color: Colorz.blue80,
                          verseColor: Colorz.black255,
                          verseShadow: false,
                          onTap: _lapCounter,
                        ),

                        /// RESET
                        DreamBox(
                          height: 60,
                          width: 100,
                          verse: 'Reset',
                          verseScaleFactor: 0.7,
                          color: Colorz.blue80,
                          verseColor: Colorz.black255,
                          verseShadow: false,
                          onTap: _resetCounter,
                        ),

                      ],
                    ),

                  ],
                ),
              ),

              Container(
                width: _screenWidth * 0.5,
                height: 300,
                color: Colorz.blue80,
                child: StreamBuilder<List<StopWatchRecord>>(
                  stream: _stopWatchTimer.records,
                  initialData: _stopWatchTimer.records.value,
                  builder: (BuildContext context, AsyncSnapshot<List<StopWatchRecord>> snap){

                    final List<StopWatchRecord> records = snap.data;

                    if (records.isEmpty){
                      return Container();
                    }

                    else {
                      return ListView.builder(
                          itemCount: records.length,
                          controller: _scrollController,
                          itemBuilder: (BuildContext ctx, int index){

                            final StopWatchRecord record = records[index];

                            return
                              SuperVerse(
                                verse: '${index+1} : ${record.displayTime}',
                                size: 1,
                              );

                          }
                          );
                    }

                  },
                ),
              ),

            ],

          ),

        ],
    );
  }

}
// -----------------------------------------------------------------------------
