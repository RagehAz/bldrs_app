import 'dart:async';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/f_cloud/cloud_functions.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/user_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
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
  // StreamSubscription _iosSubscription;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
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
  // --------------------
  @override
  void dispose() {

    super.dispose();
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

    FCM.blogNotificationSettings(_settings);
  }
  // --------------------
  Future<String> _getToken() async {
    final String _fcmToken = await _fcm.getToken();
    blog('_getToken : _fcmToken : $_fcmToken');
    return _fcmToken;
  }
  // --------------------
  void _subscribeToFlyers() {
    _fcm.subscribeToTopic('flyers');
    blog('subscribed to [ flyers ]');
  }
  // --------------------
  void _unsubscribeFromFlyers() {
    _fcm.unsubscribeFromTopic('flyers');
  }
  // --------------------
  Future<void> _updateMyUserFCMToken() async {

    await FCM.updateMyUserFCMToken(context: context);

  }
  // --------------------
  // --------------------
  NoteModel _note;
  bool _noteIsOn = false;
  // --------------------
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
  // --------------------
  // String _received = 'Nothing yet';
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return CenteredListLayout(
      titleVerse: Verse.plain('Notifications'),
      skyType: SkyType.night,
      columnChildren: <Widget>[

        const Stratosphere(),

        /// REQUEST PERMISSION
        WideButton(
          verse: Verse.plain('Request Permission'),
          onTap: () async {
            await checkPermissions();
          },
        ),

        /// GET TOKEN
        WideButton(
          verse: Verse.plain('Get Token'),
          onTap: () async {
            await _getToken();
          },
        ),

        /// SUBSCRIBE TO FLYER
        WideButton(
          verse: Verse.plain('Subscribe to flyer'),
          onTap: () async {
            _subscribeToFlyers();
          },
        ),

        /// UNSUBSCRIBE FROM FLYER
        WideButton(
          verse: Verse.plain('UN-Subscribe to flyer'),
          onTap: () async {
            _unsubscribeFromFlyers();
          },
        ),

        /// UPDATE MY USER FCM TOKEN
        WideButton(
          verse: Verse.plain('update my user fcm token'),
          onTap: () async {
            await _updateMyUserFCMToken();
          },
        ),

        /// NOTIFICATION IS ON
        WideButton(
          verse: Verse.plain(_noteIsOn == true ? 'Notification on' : 'Notification is off'),
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
          verse: Verse.plain('call CloudFunction.callSendFCMToDevice'),
          color: Colorz.blue80,
          onTap: () async {

            final UserModel _user = await UserFireOps.readUser(context: context, userID: AuthFireOps.superUserID());

            final NoteModel _note = NoteModel.dummyNote().copyWith(
              title: '1111111111',
              body: '222222222',
              receiverID: _user.id,
              receiverType: NoteSenderOrRecieverType.user,
              sendFCM: true,
              token: _user.fcmToken.token,
            );

            final Map<String, dynamic> _noteMap = _note.toMap(toJSON: true);
            // await Fire.readDoc(
            //   context: context,
            //   collName: FireColl.notes,
            //   docName: '0y4PVyUKCOOflclNi61X',
            // );

            // Mapper.blogMap(_noteMap);

            final dynamic map = await CloudFunction.call(
              context: context,
              functionName: CloudFunction.callSendFCMToDevice,
              mapToPass: _noteMap,
            );

            blog('The Map type : ${map.runtimeType} : map : $map');

            // setState(() {
            //   _received = 'received : ${map.toString()}';
            // });

          },
        ),

        /// SEND NOTE
        WideButton(
          verse: Verse.plain('send note to call\n[ sendNotificationToDevice ]'),
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
              senderType: NoteSenderOrRecieverType.bldrs,
              receiverID: _userModel.id,
              receiverType: NoteSenderOrRecieverType.user,
              title: 'booobo',
              body: 'dodo',
              metaData: NoteModel.defaultMetaData,
              sentTime: DateTime.now(),
              attachment: null,
              attachmentType: NoteAttachmentType.non,
              seen: false,
              seenTime: null,
              sendFCM: true,
              type: NoteType.notice,
              response: null,
              responseTime: null,
              buttons: null,
              token: _userModel?.fcmToken?.token,
              topic: NoteModel.dummyTopic,
            );

            await NoteFireOps.createNote(
              context: context,
              noteModel: _noteModel,
            );

            await TopDialog.showTopDialog(
              context: context,
              firstVerse: Verse.plain('Note Sent Successfully x'),
            );

          },
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
