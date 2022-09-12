import 'dart:async';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/fire/ops/note_fire_ops.dart';
import 'package:bldrs/e_db/fire/ops/user_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/notifications.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FCMTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FCMTestScreenState createState() => _FCMTestScreenState();
  /// --------------------------------------------------------------------------
}

class _FCMTestScreenState extends State<FCMTestScreen> {
// -----------------------------------------------------------------------------
  /// FCM : firebase cloud messaging
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
// -----------------------------------------------------------------------------
  /// StreamSubscription _iosSubscription;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    /// for ios notifications
    // if (Platform.isIOS) {
    //   // iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
    //   //   _saveDeviceTokenToUserDocInFireStore();
    //   // });
    //   //
    //   // _fcm.requestPermission(
    //   //   alert: true,
    //   //   badge: true,
    //   //   provisional: true,
    //   //   sound: true,
    //   //   announcement: true,
    //   //   carPlay: true,
    //   //   criticalAlert: true,
    //   // );
    //
    //   // }
    //
    //   // else {
    //   //   _saveDeviceTokenToUserDocInFireStore();
    //   // }
    //
    //   // fbm.getToken();
    //   // firebaseMessaging.unsubscribeFromTopic('flyers');
    // }
  }
// -----------------------------------------------------------------------------
  void _subscribeToFlyers() {
    _fcm.subscribeToTopic('flyers');
    blog('subscribed to [ flyers ]');
  }
// ------------------------------------
  void _unsubscribeFromFlyers() {
    _fcm.unsubscribeFromTopic('flyers');
  }
// ------------------------------------
  Future<String> _getToken() async {
    final String _fcmToken = await _fcm.getToken();
    blog('_getToken : _fcmToken : $_fcmToken');
    return _fcmToken;
  }
// ------------------------------------
  Future<void> _updateMyUserFCMToken() async {

    await Notifications.updateMyUserFCMToken(context: context);

  }
// -----------------------------------------------------------------------------
  Future<void> checkPermissions() async {
    final NotificationSettings _settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    blog(_settings.toString());
  }
// -----------------------------------------------------------------------------
  NoteModel _note;
  bool _noteIsOn = false;

  /*
  void _setNoti(NoteModel note) {
    if (note != null) {
      setState(() {
        _note = note;
        _noteIsOn = true;
      });
    }
  }
   */
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {

    super.dispose();
  }

// -----------------------------------------------------------------------------
  String _received = 'Nothing yet';
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    blog('FUCK YOU');

    return CenteredListLayout(
      title: 'Notifications',
      columnChildren: <Widget>[

        const Stratosphere(),

        /// REQUEST PERMISSION
        WideButton(
          translate: false,
          verse:  'Request Permission',
          onTap: () async {
            await checkPermissions();
          },
        ),

        /// GET TOKEN
        WideButton(
          translate: false,
          verse:  'Get Token',
          onTap: () async {
            await _getToken();
          },
        ),

        /// SUBSCRIBE TO FLYER
        WideButton(
          translate: false,
          verse:  'Subscribe to flyer',
          onTap: () async {
            _subscribeToFlyers();
          },
        ),

        /// UNSUBSCRIBE FROM FLYER
        WideButton(
          translate: false,
          verse:  'UN-Subscribe to flyer',
          onTap: () async {
            _unsubscribeFromFlyers();
          },
        ),

        /// UPDATE MY USER FCM TOKEN
        WideButton(
          translate: false,
          verse:  'update my user fcm token',
          onTap: () async {
            await _updateMyUserFCMToken();
          },
        ),

        /// NOTIFICATION IS ON
        WideButton(
          translate: false,
          verse: _noteIsOn == true ? 'Notification on' : 'Notification is off',
          color: _noteIsOn == true ? Colorz.red255 : Colorz.grey50,
          verseColor: _noteIsOn == true ? Colorz.white255 : Colorz.white80,
          onTap: () async {

            setState(() {
              _noteIsOn = false;
              _note = null;
            });

            await _fcm.setAutoInitEnabled(false);
            blog('the thing is : ');

          },
        ),

        /// NOTIFICATION DATA
        // if (_noteIsOn == true)
        Container(
          width: Scale.superScreenWidth(context),
          color: Colorz.bloodTest,
          child: SuperVerse(
            verse: Verse(
              text: '_note.notification.title : ${_note?.title}\n'
                  '_note.notification.body : ${_note?.body}\n'
                  '_note.data : ${_note?.metaData}',
              translate: false,
            ),
            maxLines: 100,
            margin: 20,
          ),
        ),

        /// CLOUD FUNCTION
        WideButton(
          translate: false,
          width: 250,
          verse:  'call cloud function \n$_received',
          color: Colorz.blue80,
          onTap: () async {

            final dynamic map = await CloudFunction.callFunction(
              context: context,
              cloudFunctionName: CloudFunction.sendNotificationToDevice,
            );

            blog('The Map type : ${map.runtimeType} : map : $map');

            setState(() {
              _received = 'received : ${map.toString()}';
            });

          },
        ),

        /// SEND NOTE
        WideButton(
          translate: false,
          verse:  'send note to call\n[ sendNotificationToDevice ]',
          color: Colorz.blue80,
          onTap: () async {

            // user1 : '7B8qNuRdXAfyIm5HaIKfne3qKIw2';
            final String _userID = AuthFireOps.superUserID();

            final UserModel _userModel = await UserFireOps.readUser(
                context: context,
                userID: _userID,
            );

            final NoteModel _noteModel = NoteModel(
              id: 'x',
              senderID: NoteModel.bldrsSenderID,
              senderImageURL: NoteModel.bldrsLogoURL,
              noteSenderType: NoteSenderType.bldrs,
              receiverID: _userModel.id,
              receiverType: NoteReceiverType.user,
              title: 'booobo',
              body: 'dodo',
              metaData: NoteModel.defaultMetaData,
              sentTime: DateTime.now(),
              attachment: null,
              attachmentType: NoteAttachmentType.non,
              seen: false,
              seenTime: null,
              sendFCM: true,
              noteType: NoteType.announcement,
              response: null,
              responseTime: null,
              buttons: null,
              token: _userModel?.fcmToken?.token,
            );

            await NoteFireOps.createNote(
              context: context,
              noteModel: _noteModel,
            );

            await TopDialog.showTopDialog(
              context: context,
              firstLine: 'Note Sent Successfully x',
            );

          },
        ),

      ],
    );
  }
}
// -----------------------------------------------------------------------------
