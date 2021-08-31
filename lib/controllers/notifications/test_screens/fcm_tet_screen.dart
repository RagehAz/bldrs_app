import 'dart:async';
import 'dart:io';

import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/fcm_token.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMTestScreen extends StatefulWidget {

  @override
  _FCMTestScreenState createState() => _FCMTestScreenState();
}

class _FCMTestScreenState extends State<FCMTestScreen> {
  /// FCM : firebase cloud messaging
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();



    /// for ios notifications
    if (Platform.isIOS){

      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        _saveDeviceTokenToUserDocInFireStore();
      });

    _fcm.requestNotificationPermissions(
        IosNotificationSettings(
          alert: true,
          badge: true,
          provisional: true,
          sound: true,
        )
    );

    }

    else {
      _saveDeviceTokenToUserDocInFireStore();
    }

    _fcm.configure(

      /// when app is running on screen
        onMessage: (msgMap){
          // print('Notification : onMessage : msgMap : $msgMap');

          receiveAndActUponNoti(msgMap: msgMap, notiType: NotiType.onMessage);

          return;
          },

        /// when app running in background and notification tapped while having
        /// msg['data']['click_action'] == 'FLUTTER_NOTIFICATION_CLICK';
        onResume: (msgMap){
          // print('Notification : onResume : msgMap : $msgMap');
          receiveAndActUponNoti(msgMap: msgMap, notiType: NotiType.onResume);
          return;
          },

        // onBackgroundMessage: (msg){
        //   print('Notification : onBackgroundMessage : msg : $msg');
        //   return;
        //   },


        /// when app is terminated and needs to launch from scratch
        onLaunch: (msgMap){
          // print('Notification : onLaunch : msgMap : $msgMap');
          receiveAndActUponNoti(msgMap: msgMap, notiType: NotiType.onLaunch);

          return;
        }

        );

    // fbm.getToken();
    _fcm.subscribeToTopic('flyers');
    // firebaseMessaging.unsubscribeFromTopic('flyers');
  }
// -----------------------------------------------------------------------------
   Future<void> _saveDeviceTokenToUserDocInFireStore() async {
    String _userID = superUserID();
    User _firebaseUser = superFirebaseUser();

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
  @override
  Widget build(BuildContext context) {
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
        ],
    );
  }
}
// -----------------------------------------------------------------------------