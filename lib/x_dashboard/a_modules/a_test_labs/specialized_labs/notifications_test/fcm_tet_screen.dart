import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/fcm_token.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_protocols/user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FCMTestScreen({Key key}) : super(key: key);

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
  // StreamSubscription _iosSubscription;
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
    final String _fcmToken = await _getToken();

    /// UNSUBSCRIBING FROM TOKEN INSTRUCTIONS
    /*
         - Unsubscribe stale tokens from topics
         Managing topics subscriptions to remove stale registration
         tokens is another consideration. It involves two steps:

         - Your app should resubscribe to topics once per month and/or
          whenever the registration token changes. This forms a self-healing
          solution, where the subscriptions reappear automatically
          when an app becomes active again.

         - If an app instance is idle for 2 months (or your own staleness window)
         you should unsubscribe it from topics using the Firebase Admin
         SDK to delete the token/topic mapping from the FCM backend.

         - The benefit of these two steps is that your fanouts will occur
         faster since there are fewer stale tokens to fan out to, and your
          stale app instances will automatically resubscribe once they are active again.

     */

    final UserModel _myUserModel =
        UsersProvider.proGetMyUserModel(context: context, listen: false);

    if (_fcmToken != null && _myUserModel != null) {
      if (_myUserModel.fcmToken.token != _fcmToken) {
        final FCMToken _token = FCMToken(
          token: _fcmToken,
          createdAt: DateTime.now(),
          platform: Platform.operatingSystem,
        );

        final UserModel _updated = _myUserModel.copyWith(
          fcmToken: _token,
        );

        await UserProtocol.updateMyUserEverywhereProtocol(
          context: context,
          newUserModel: _updated,
        );
      }
    }
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
  @override
  void dispose() {
    super.dispose();

    /// tamam
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
          verse: 'Request Permission',
          onTap: () async {
            await checkPermissions();
          },
        ),

        /// GET TOKEN
        WideButton(
          verse: 'Get Token',
          onTap: () async {
            await _getToken();
          },
        ),

        /// SUBSCRIBE TO FLYER
        WideButton(
          verse: 'Subscribe to flyer',
          onTap: () async {
            _subscribeToFlyers();
          },
        ),

        /// UNSUBSCRIBE FROM FLYER
        WideButton(
          verse: 'UN-Subscribe to flyer',
          onTap: () async {
            _unsubscribeFromFlyers();
          },
        ),

        /// UPDATE MY USER FCM TOKEN
        WideButton(
          verse: 'update my user fcm token',
          onTap: () async {
            await _updateMyUserFCMToken();
          },
        ),

        /// NOTIFICATION IS ON
        WideButton(
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
          width: superScreenWidth(context),
          color: Colorz.bloodTest,
          child: SuperVerse(
            verse: '_note.notification.title : ${_note?.title}\n'
                '_note.notification.body : ${_note?.body}\n'
                '_note.data : ${_note?.metaData}',
            maxLines: 100,
            margin: 20,
          ),
        ),

        /// CLOUD FUNCTION
        WideButton(
          width: 250,
          verse: 'call cloud function \n$_received',
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
          verse: 'send note to call\n[ sendNotificationToDevice ]',
          color: Colorz.blue80,
          onTap: () async {

            const String _userID = '7B8qNuRdXAfyIm5HaIKfne3qKIw2';

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
              title: 'This is going to be Awesome',
              body: 'Isa will work',
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
                context: context, noteModel: _noteModel);

            await TopDialog.showTopDialog(
              context: context,
              firstLine: 'Note Sent Successfully',
            );
          },
        ),
      ],
    );
  }
}
// -----------------------------------------------------------------------------
