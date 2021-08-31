import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/notifications/audioz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/notification/noti_model.dart';

class NotiChannelz{
  static String _ahmedURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/slidesPics%2FXmwKpOsu1RZW3YfDAkli_00.jpg?alt=media&token=a4c8a548-74d2-4086-b3db-1678f46db00a';
// -----------------------------------------------------------------------------
  static String notiChannelName(NotiChannel channel){
    switch (channel){
      case NotiChannel.basic: return 'Basic Notifications'; break;
      case NotiChannel.scheduled: return 'Scheduled Notifications'; break;
      default: return 'Basic Notifications';
    }
  }
// -----------------------------------------------------------------------------
  static Future<void> createWelcomeNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Numberers.createUniqueID(),
        channelKey: notiChannelName(NotiChannel.basic),
        title: '${Emojis.shape_red_triangle_pointed_up} Welcome to Bldrs.net',
        body: 'Browse Thousands of flyers and pick your choices',
        bigPicture: _ahmedURL,//'resource://drawable/res_red_bldrs',
        notificationLayout: NotificationLayout.BigPicture,
        color: Colorz.Yellow255,
        backgroundColor: Colorz.BloodTest,
      ),
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> createScheduledNotification() async {



    await AwesomeNotifications().createNotification(

        content: NotificationContent(
          id: Numberers.createUniqueID(),
          channelKey: notiChannelName(NotiChannel.scheduled),
          title: '${Emojis.hotel_bellhop_bell} Alert from Bldrs.net',
          body: 'You need to open the app now, not tomorrow, not after tomorrow, NOW !, Do I make my self clear ? or you want me to repeat What I have just wrote,, read again !',
          bigPicture: 'resource://drawable/res_red_bldrs',
          notificationLayout: NotificationLayout.BigPicture,
          color: Colorz.Yellow255,
          backgroundColor: Colorz.SkyDarkBlue,
        ),

        actionButtons: <NotificationActionButton>[
          NotificationActionButton(
            key: 'MARK_DONE',
            label: 'Mark Done',
            icon: 'resource://drawable/res_flat_logo',
            buttonType: ActionButtonType.KeepOnTop,
            autoCancel: false,
            enabled: true,
          ),
        ],

        schedule: NotificationCalendar(
          repeats: true,
          weekday: 1,
          hour: 5,
          minute: 10,
          second: 10,
          millisecond: 10,
          month: 8,
          // timeZone:
          // weekOfMonth:,
          // weekOfYear: ,
          // year: ,
          // day: ,
          // allowWhileIdle: ,
          // era: ,
          // timeZone: ,
        ),

        // NotificationSchedule(
        //   allowWhileIdle: true,
        //   // crontabSchedule:
        //   initialDateTime: DateTime.now(),
        //   preciseSchedules: <DateTime>[
        //     DateTime.now(),
        //   ],
        // ),

    );
  }
// -----------------------------------------------------------------------------
  static Future<void> cancelScheduledNotification() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
// -----------------------------------------------------------------------------
  static NotificationChannel basicNotificationChannel(){
    return
      NotificationChannel(
        channelKey: notiChannelName(NotiChannel.basic),
        channelName: notiChannelName(NotiChannel.basic),
        channelDescription: 'this is for testing', // this will be visible to user in android notification settings
        defaultColor: Colorz.Yellow255,
        channelShowBadge: true,
        icon: 'resource://drawable/res_flat_logo',
        ledColor: Colorz.Yellow255,
        importance: NotificationImportance.High,
        locked: true,
        playSound: true,
        soundSource: 'resource://raw/res_hi',//Audioz.randomBldrsNameSoundPath(),
        enableLights: true,
        enableVibration: true,

      );
  }
// -----------------------------------------------------------------------------
  static NotificationChannel scheduledNotificationChannel(){
    return
      NotificationChannel(
        channelKey: notiChannelName(NotiChannel.scheduled),
        channelName: notiChannelName(NotiChannel.scheduled),
        channelDescription: 'This is the first scheduled notification', // this will be visible to user in android notification settings
        defaultColor: Colorz.Yellow255,
        channelShowBadge: true,
        enableLights: true,
        icon: 'resource://drawable/res_flat_logo',
        ledColor: Colorz.Yellow255,
        importance: NotificationImportance.High,
        enableVibration: true,
        playSound: true,
        locked: true,
        soundSource: Audioz.randomBldrsNameSoundPath(),

      );
  }
// -----------------------------------------------------------------------------

}