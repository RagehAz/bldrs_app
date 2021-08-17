import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsTestScreen extends StatefulWidget {

  @override
  _NotificationsTestScreenState createState() => _NotificationsTestScreenState();
}

class _NotificationsTestScreenState extends State<NotificationsTestScreen> {
  final fbm = FirebaseMessaging();


  @override
  void initState() {
    /// for ios notifications
    fbm.requestNotificationPermissions();
    fbm.configure(

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

        onLaunch: (msgMap){
          // print('Notification : onLaunch : msgMap : $msgMap');
          receiveAndActUponNoti(msgMap: msgMap, notiType: NotiType.onLaunch);

          return;
        }

        );

    super.initState();
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

              await fbm.setAutoInitEnabled(false);
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
              '_noti.notification.title : ${_noti?.notification?.title}\n'
              ' '
              '_noti.notification.body : ${_noti?.notification?.body}\n'
              ' '
              '_noti.data : ${_noti?.data}\n',
            maxLines: 100,
          ),
        ],
    );
  }
}
// -----------------------------------------------------------------------------