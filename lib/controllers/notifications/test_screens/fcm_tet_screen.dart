import 'dart:async';
import 'dart:io';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/cloud_functions.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/fcm_token.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';


class FCMTestScreen extends StatefulWidget {

  @override
  _FCMTestScreenState createState() => _FCMTestScreenState();
}

class _FCMTestScreenState extends State<FCMTestScreen> {
  /// FCM : firebase cloud messaging
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  StreamSubscription iosSubscription;

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
    String _userID = superUserID();
    // User _firebaseUser = superFirebaseUser();

    String _fcmToken = await _fcm.getToken();

    if (_fcmToken != null){

      FCMToken _token = FCMToken(
          token: _fcmToken,
          createdAt: FieldValue.serverTimestamp(),
          platform: Platform.operatingSystem,
      );

      await Fire.updateDocField(
        context: context,
        collName: FireCollection.users,
        docName: _userID,
        field: 'fcmToken',
        input: _token.toMap(),
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
      onError: (error) => print(error),
      methodName: 'receiveAndActUponNoti',
      functions: (){
        _noti = NotiModel.decipherNotiModel(msgMap);
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
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);

    return TestLayout(
        screenTitle: 'Notifications',
        appbarButtonVerse: 'button',
        appbarButtonOnTap: (){
          print('wtf');
        },
        listViewWidgets: <Widget>[

          Stratosphere(),

          DreamBox(
            height: 50,
            verse: 'recieve noti ops',
            onTap: (){
              print('operating noti');

              receiveAndActUponNoti(
                msgMap: null,
                notiType: null,
              );
            },
          ),

          SizedBox(
            width: 100,
            height: 10,
          ),

          DreamBox(
            height: 40,
            width: 200,
            verse: _notiIsOn == true ? 'Notification on' : 'Notification is off',
            color: _notiIsOn == true ? Colorz.Red255 : Colorz.Grey50,
            verseColor: _notiIsOn == true ? Colorz. White255 : Colorz.Black255,
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

          SizedBox(
            width: 100,
            height: 10,
          ),

          // if (_notiIsOn == true)
          SuperVerse(
            verse:
              '_noti.notification.title : ${_noti?.notiContent?.title}\n'
              ' '
              '_noti.notification.body : ${_noti?.notiContent?.body}\n'
              ' '
              '_noti.data : ${_noti?.metaData}\n',
            maxLines: 100,
          ),

          DreamBox(
            height: 60,
            width: 250,
            verse: 'call function',
            verseScaleFactor: 0.7,
            color: Colorz.Blue80,
            verseColor: Colorz.Black255,
            verseShadow: false,
            onTap: () async {

              dynamic map = await CloudFunctionz.callFunction(cloudFunctionName: 'sayHello');

              print("The Map is Amazingly : $map");

            },
          ),


          Container(
            child: Row(

              children: <Widget>[

                Container(
                  width: _screenWidth * 0.5,
                  height: 300,
                  color: Colorz.BloodTest,
                  child: Column(
                    children: <Widget>[

                      StreamBuilder<int>(
                        stream: _stopWatchTimer.rawTime,
                        initialData: _stopWatchTimer.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data;
                          final displayTime = StopWatchTimer.getDisplayTime(value, hours: _isHours);

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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          /// START
                          DreamBox(
                            height: 60,
                            width: 100,
                            verse: 'Start',
                            verseScaleFactor: 0.7,
                            color: Colorz.Blue80,
                            verseColor: Colorz.Black255,
                            verseShadow: false,
                            onTap: _startCounter,
                          ),

                          /// STOP
                          DreamBox(
                            height: 60,
                            width: 100,
                            verse: 'Stop',
                            verseScaleFactor: 0.7,
                            color: Colorz.Blue80,
                            verseColor: Colorz.Black255,
                            verseShadow: false,
                            onTap: _stopCounter,
                          ),

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          /// STOP
                          DreamBox(
                            height: 60,
                            width: 100,
                            verse: 'Lap',
                            verseScaleFactor: 0.7,
                            color: Colorz.Blue80,
                            verseColor: Colorz.Black255,
                            verseShadow: false,
                            onTap: _lapCounter,
                          ),

                          /// RESET
                          DreamBox(
                            height: 60,
                            width: 100,
                            verse: 'Reset',
                            verseScaleFactor: 0.7,
                            color: Colorz.Blue80,
                            verseColor: Colorz.Black255,
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
                  color: Colorz.Blue80,
                  child: StreamBuilder<List<StopWatchRecord>>(
                    stream: _stopWatchTimer.records,
                    initialData: _stopWatchTimer.records.value,
                    builder: (context, snap){

                      final List<StopWatchRecord> records = snap.data;

                      if (records.isEmpty){
                        return Container();
                      }

                      else {
                        return ListView.builder(
                            itemCount: records.length,
                            controller: _scrollController,
                            itemBuilder: (ctx, index){

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
          ),

        ],
    );
  }

}
// -----------------------------------------------------------------------------