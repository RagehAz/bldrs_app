import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/notifications/audioz.dart';
import 'package:bldrs/controllers/notifications/noti_ops.dart';
import 'package:bldrs/controllers/notifications/test_screens/second_noti_test_screen.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AwesomeNotiTestScreen extends StatefulWidget {


  @override
  _AwesomeNotiTestScreenState createState() => _AwesomeNotiTestScreenState();
}

class _AwesomeNotiTestScreenState extends State<AwesomeNotiTestScreen> {
  //var vibrationPattern = new Int64List.fromList([1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000]);
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  AwesomeNotifications _awesomeNotification;
  GlobalKey _scaffoldKey;
  @override
  void initState() {
    super.initState();

    /// should be put in main
    // FirebaseMessaging.onBackgroundMessage(_firebasePushHandler)


    // final _scaffoldKey = GlobalKey<ScaffoldState>();

    _awesomeNotification = AwesomeNotifications();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _triggerLoading().then((_) async {
        bool _isAllowed = await _awesomeNotification.isNotificationAllowed();

        if (_isAllowed == false) {
          bool _result = await CenterDialog.showCenterDialog(
            context: context,
            title: 'Allow notifications',
            body: 'To be able to know what is going on',
            boolDialog: true,
          );

          if (_result == true) {
            await _awesomeNotification.requestPermissionToSendNotifications();
          }

          await Nav.goBack(context);
        }

        await _notiStream(context);

        _triggerLoading();

      });

      _isInit = false;
    }
  }

  @override
  void dispose(){
    _awesomeNotification.actionSink.close();
    _awesomeNotification.createdSink.close();
    super.dispose();
  }
// -----------------------------------------------------------------------------
//   Future<void> _firebasePushHandler(RemoteMessage message){
//     print('_firebasePushHandler : message : $message');
//
//     _awesomeNotification.createNotificationFromJsonData(message.data);
//   }
// -----------------------------------------------------------------------------
  Future<void> _notiStream(BuildContext context) async {

    print('starting notiStream');
    print('_awesomeNotification.isNotificationAllowed() : ${await _awesomeNotification.isNotificationAllowed()}');

    if (_awesomeNotification.isNotificationAllowed() != null) {


      _awesomeNotification.createdStream.listen((notification) async {

        print('the FUCKING notification is aho 5ara :  Channel : ${notification.channelKey} : id : ${notification.id}');

        await _flickerPyramids();

        // await NavDialog.showNavDialog(
        //   context: context,
        //   firstLine: 'Notification created',
        //   secondLine: 'sent on Channel : ${notification.channelKey} : id : ${notification.id}',
        //   isBig: true,
        // );
      });

      _awesomeNotification.actionStream.listen((notification) async {

        bool _isBasicChannel = notification.channelKey == NotiOps.getNotiChannelName(NotiChannel.basic);
        bool _isIOS = DeviceChecker.deviceIsIOS();

        if (_isBasicChannel && _isIOS){

          int _x = await _awesomeNotification.getGlobalBadgeCounter();

          await _awesomeNotification.setGlobalBadgeCounter(_x - 1);

        }
        
        await Nav.pushAndRemoveUntil(
            context: context,
            screen: SecondNotiTestScreen(thing: 'thing'),
        );
      });


    }

    print('ended notiStream');

  }
// -----------------------------------------------------------------------------
  Future<void> _onSendNotification() async {
      await NotiOps.createWelcomeNotification();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSendScheduledNotification() async {
    await NotiOps.createScheduledNotification();
  }
// -----------------------------------------------------------------------------
  String _pyramids;
  Future<void> _flickerPyramids() async {

    // Duration _duration = Ratioz.duration150ms;

      setState(() {
          _pyramids = Iconz.PyramidsWhite;
      });

      await Future.delayed(Duration(milliseconds: 50), (){
        setState(() {
        _pyramids = Iconz.PyramidsYellow;
        });
      });

    await Future.delayed(Duration(milliseconds: 100), (){
      setState(() {
        _pyramids = Iconz.PyramidsWhite;
      });
    });

    await Future.delayed(Duration(milliseconds: 150), (){
      setState(() {
        _pyramids = Iconz.PyramidsYellow;
      });
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _multiFlickerPyramids() async {
    await _flickerPyramids();

    String _audio = Audioz.randomBldrsNameSoundPath();
    print(_audio);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      scaffoldKey: _scaffoldKey,
      appBarType: AppBarType.Basic,
      pyramids: _pyramids == null ? Iconz.PyramidsYellow : _pyramids,
      loading: _loading,
      pageTitle: 'Awesome notification test',

      layoutWidget: Column(
        children: <Widget>[

          Stratosphere(),

          Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            child: DreamBox(
              height: 60,
              width: 250,
              verse: 'Send Notification Bitch !',
              verseScaleFactor: 0.7,
              color: Colorz.Yellow255,
              verseColor: Colorz.Black255,
              verseShadow: false,
              onTap: _onSendNotification,
            ),
          ),

          DreamBox(
            height: 60,
            width: 250,
            verse: 'multi Flicker Pyramids',
            verseScaleFactor: 0.7,
            color: Colorz.Yellow255,
            verseColor: Colorz.Black255,
            verseShadow: false,
            onTap: () async {

              await _multiFlickerPyramids();


            },
          ),

          DreamBox(
            height: 60,
            width: 250,
            verse: 'send scheduled',
            verseScaleFactor: 0.7,
            color: Colorz.Yellow255,
            verseColor: Colorz.Black255,
            verseShadow: false,
            onTap: _onSendScheduledNotification,
          ),

          DreamBox(
            height: 60,
            width: 250,
            verse: 'cancel schedules',
            verseScaleFactor: 0.7,
            color: Colorz.Yellow255,
            verseColor: Colorz.Black255,
            verseShadow: false,
            onTap: () async {
              await NotiOps.cancelScheduledNotification();
            },
          ),

        ],
      ),
    );
  }
}
