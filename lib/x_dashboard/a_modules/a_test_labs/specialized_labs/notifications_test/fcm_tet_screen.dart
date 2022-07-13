import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/fcm_token.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart' as CloudFunctionz;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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

  // StreamSubscription _iosSubscription;

  @override
  void initState() {
    super.initState();

    /// for ios notifications
    if (Platform.isIOS) {
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
    final String _userID = superUserID();
    // User _firebaseUser = superFirebaseUser();

    final String _fcmToken = await _fcm.getToken();

    if (_fcmToken != null) {
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
  NoteModel _note;
  bool _noteIsOn = false;
  void _setNoti(NoteModel note) {
    if (note != null) {
      setState(() {
        _note = note;
        _noteIsOn = true;
      });
    }
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  String _received = 'Nothing yet';

  @override
  Widget build(BuildContext context) {

    return CenteredListLayout(
      title: 'Notifications',
      columnChildren: <Widget>[

        const Stratosphere(),

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
        DreamBox(
          height: 50,
          width: 250,
          verse: 'call cloud function \n$_received',
          verseScaleFactor: 0.7,
          verseMaxLines: 2,
          color: Colorz.blue80,
          verseColor: Colorz.black255,
          verseShadow: false,
          onTap: () async {

            final dynamic map = await CloudFunctionz.callFunction(
                context: context,
                cloudFunctionName: 'sayHello',
            );

            blog('The Map is Amazingly : $map');

            setState(() {
              _received = 'received : ${map.toString()}';
            });

          },
        ),

      ],
    );
  }
}
// -----------------------------------------------------------------------------
