import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/controllers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/controllers/notifications/audioz.dart' as Audioz;
import 'package:bldrs/controllers/notifications/noti_ops.dart' as NotiOps;
import 'package:bldrs/controllers/notifications/test_screens/second_noti_test_screen.dart';
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class AwesomeNotiTestScreen extends StatefulWidget {
  const AwesomeNotiTestScreen({Key key}) : super(key: key);


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
        final bool _isAllowed = await _awesomeNotification.isNotificationAllowed();

        if (_isAllowed == false) {
          final bool _result = await CenterDialog.showCenterDialog(
            context: context,
            title: 'Allow notifications',
            body: 'To be able to know what is going on',
            boolDialog: true,
          );

          if (_result == true) {
            await _awesomeNotification.requestPermissionToSendNotifications();
          }

          Nav.goBack(context);
          // await null;
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


      _awesomeNotification.createdStream.listen((ReceivedNotification notification) async {

        print('the FUCKING notification is aho 5ara :  Channel : ${notification.channelKey} : id : ${notification.id}');

        await _flickerPyramids();

        // await NavDialog.showNavDialog(
        //   context: context,
        //   firstLine: 'Notification created',
        //   secondLine: 'sent on Channel : ${notification.channelKey} : id : ${notification.id}',
        //   isBig: true,
        // );
      });

      _awesomeNotification.actionStream.listen((ReceivedAction notification) async {

        final bool _isBasicChannel = notification.channelKey == NotiOps.getNotiChannelName(NotiChannel.basic);
        final bool _isIOS = DeviceChecker.deviceIsIOS();

        if (_isBasicChannel && _isIOS){

          final int _x = await _awesomeNotification.getGlobalBadgeCounter();

          await _awesomeNotification.setGlobalBadgeCounter(_x - 1);

        }
        
        await Nav.pushAndRemoveUntil(
            context: context,
            screen: const SecondNotiTestScreen(
                // thing: 'thing'
            ),
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
          _pyramids = Iconz.pyramidsWhite;
      });

      await Future<void>.delayed(const Duration(milliseconds: 50), (){
        setState(() {
        _pyramids = Iconz.pyramidsYellow;
        });
      });

    await Future<void>.delayed(const Duration(milliseconds: 100), (){
      setState(() {
        _pyramids = Iconz.pyramidsWhite;
      });
    });

    await Future<void>.delayed(const Duration(milliseconds: 150), (){
      setState(() {
        _pyramids = Iconz.pyramidsYellow;
      });
    });

  }
// -----------------------------------------------------------------------------
  Future<void> _multiFlickerPyramids() async {
    await _flickerPyramids();

    final String _audio = Audioz.randomBldrsNameSoundPath();
    print(_audio);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      scaffoldKey: _scaffoldKey,
      appBarType: AppBarType.basic,
      pyramids: _pyramids == null ? Iconz.pyramidsYellow : _pyramids,
      loading: _loading,
      pageTitle: 'Awesome notification test',

      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          Container(
            width: 300,
            height: 300,
            alignment: Alignment.center,
            child: DreamBox(
              height: 60,
              width: 250,
              verse: 'Send Notification Bitch !',
              verseScaleFactor: 0.7,
              color: Colorz.yellow255,
              verseColor: Colorz.black255,
              verseShadow: false,
              onTap: _onSendNotification,
            ),
          ),

          DreamBox(
            height: 60,
            width: 250,
            verse: 'multi Flicker Pyramids',
            verseScaleFactor: 0.7,
            color: Colorz.yellow255,
            verseColor: Colorz.black255,
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
            color: Colorz.yellow255,
            verseColor: Colorz.black255,
            verseShadow: false,
            onTap: _onSendScheduledNotification,
          ),

          DreamBox(
            height: 60,
            width: 250,
            verse: 'cancel schedules',
            verseScaleFactor: 0.7,
            color: Colorz.yellow255,
            verseColor: Colorz.black255,
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
