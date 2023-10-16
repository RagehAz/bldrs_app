import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/c_noot_action_protocols.dart';
import 'package:flutter/scheduler.dart';



/// for AWESOME NOTIFICATION VERSION 7.
abstract class NootController {
  // -----------------------------------------------------------------------------

  NootController();

  // -----------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  /// Use this method to detect when a new notification or a schedule is created
  @pragma('vm:entry-point')
  static Future <void> onNotificationCreatedMethod(ReceivedNotification rNoot) async {

    // blogReceivedNotification(
    //   noot: rNoot,
    //   invoker: 'onNotificationCreatedMethod',
    // );




  }
  // -----------------------------------------------------------------------------
  /// Use this method to detect every time that a new notification is displayed
  @pragma('vm:entry-point')
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification rNoot) async {

    // blogReceivedNotification(
    //   noot: rNoot,
    //   invoker: 'onNotificationDisplayedMethod',
    // );

    // await _testNoot(
    //   rNoot: rNoot,
    //   invoker: 'onNotificationDisplayedMethod',
    // );

  }
  // -----------------------------------------------------------------------------
  /// Use this method to detect if the user dismissed a notification
  @pragma('vm:entry-point')
  static Future <void> onDismissActionReceivedMethod(ReceivedAction rNoot) async {

    // blogReceivedAction(
    //   action: rNoot,
    //   invoker: 'onDismissActionReceivedMethod',
    // );

    // await _testNoot(
    //   rNoot: rNoot,
    //   invoker: 'onDismissActionReceivedMethod',
    // );

  }
  // -----------------------------------------------------------------------------
  /// Use this method to detect when the user taps on a notification or action button
  @pragma('vm:entry-point')
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {

    // blogReceivedAction(
    //   action: receivedAction,
    //   invoker: 'onActionReceivedMethod',
    // );

    SchedulerBinding.instance.addPostFrameCallback((_) async {

      await NootActionProtocols.onNootTap(
        noteModel: NoteModel.decipherRemoteMessage(
          map: receivedAction.payload,
        ),
      );

    });

    // await Dialogs.confirmProceed(
    //     context: context,
    //     titleVerse: Verse.plain('Navigate ???'),
    // );

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // await mainNavKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction
    // );

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  static void blogReceivedNotification({
    required ReceivedNotification? noot,
    required String invoker,
  }){
    blog('blogReceivedNotification : $invoker : START');

    if (noot != null){

      blog('noot.id                 : ${noot.id}');
      blog('noot.channelKey         : ${noot.channelKey}');
      blog('noot.groupKey           : ${noot.groupKey}');
      blog('noot.title              : ${noot.title}');
      blog('noot.body               : ${noot.body}');
      blog('noot.summary            : ${noot.summary}');
      blog('noot.showWhen           : ${noot.showWhen}');
      blog('noot.payload            : ${noot.payload}');
      blog('noot.icon               : ${noot.icon}');
      blog('noot.largeIcon          : ${noot.largeIcon}');
      blog('noot.bigPicture         : ${noot.bigPicture}');
      blog('noot.customSound        : ${noot.customSound}');
      blog('noot.autoDismissible    : ${noot.autoDismissible}');
      blog('noot.wakeUpScreen       : ${noot.wakeUpScreen}');
      blog('noot.fullScreenIntent   : ${noot.fullScreenIntent}');
      blog('noot.criticalAlert      : ${noot.criticalAlert}');
      blog('noot.color              : ${noot.color}');
      blog('noot.backgroundColor    : ${noot.backgroundColor}');
      blog('noot.privacy            : ${noot.privacy}');
      blog('noot.category           : ${noot.category}');
      // blog('noot.actionType         : ${noot.actionType}');
      blog('noot.bigPictureImage    : ${noot.bigPictureImage}');
      blog('noot.bigPicturePath     : ${noot.bigPicturePath}');
      blog('noot.bodyWithoutHtml    : ${noot.bodyWithoutHtml}');
      blog('noot.createdDate        : ${noot.createdDate}');
      blog('noot.fullScreenIntent   : ${noot.fullScreenIntent}');
      blog('noot.displayedDate      : ${noot.displayedDate}');
      blog('noot.createdSource      : ${noot.createdSource}');
      blog('noot.createdLifeCycle   : ${noot.createdLifeCycle}');
      blog('noot.displayedLifeCycle : ${noot.displayedLifeCycle}');

    }
    else {
      blog('notification is null');
    }

    blog('blogReceivedNotification : $invoker : END');
  }
  // --------------------
  static void blogReceivedAction({
    required ReceivedAction? action,
    required String invoker,
  }){
    blog('blogReceivedAction : $invoker : START');

    if (action != null){

      blog('action.actionLifeCycle : ${action.actionLifeCycle}');
      blog('action.dismissedLifeCycle : ${action.dismissedLifeCycle}');
      blog('action.buttonKeyPressed : ${action.buttonKeyPressed}');
      blog('action.buttonKeyInput : ${action.buttonKeyInput}');
      blog('action.actionDate : ${action.actionDate}');
      blog('action.dismissedDate : ${action.dismissedDate}');

    }
    else {
      blog('action is null');
    }

    blog('blogReceivedAction : $invoker : END');
  }
// -----------------------------------------------------------------------------
}

class NootListener {
  // -----------------------------------------------------------------------------

  const NootListener();

  // -----------------------------------------------------------------------------
  /// DEPRECATED
  /*

  /// ACTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static StreamSubscription? listenToNootActionStream(){

    final StreamSubscription? _sub = FCM.getAwesomeNoots()?.actionStream
        .listen((ReceivedNotification? receivedNotification) async {

      // NootController.blogReceivedNotification(
      //   noot: receivedNotification,
      //   invoker: 'listenToNootActionStream',
      // );

      SchedulerBinding.instance.addPostFrameCallback((_) async {

        await NootNavToProtocols.onNootTap(
          noteModel: NoteModel.decipherRemoteMessage(
            map: receivedNotification?.payload,
          ),
        );

      });


    });

    return _sub;
  }
  // -----------------------------------------------------------------------------

  /// CREATED

  // --------------------
  /// TESTED : WORKS PERFECT
  static StreamSubscription? listenToNootCreatedStream(){

    final StreamSubscription? _sub = FCM.getAwesomeNoots()?.createdStream
        .listen((ReceivedNotification? receivedNotification) {

          // blog('listenToNootCreatedStream --- START');

      // SchedulerBinding.instance.addPostFrameCallback((_) async {
      //
      //   await FCMStarter.pushGlobalNootFromReceivedNotification(
      //     rNoot: receivedNotification,
      //     invoker: 'listenToNootCreatedStream',
      //   );
      //
      // });

          // NootController.blogReceivedNotification(
          //   noot: receivedNotification,
          //   invoker: 'listenToNootCreatedStream',
          // );

          // blog('listenToNootCreatedStream --- END');

        });

    return _sub;
  }
  // -----------------------------------------------------------------------------

  /// DISMISSED

  // --------------------
  ///
  static StreamSubscription? listenToNootDismissedStream(){

    final StreamSubscription? _sub = FCM.getAwesomeNoots()?.dismissedStream // BUG : STREAM IS ALREADY ACTIVE AT THIS POINT I DUNNO HOW
        .listen((ReceivedNotification? receivedNotification) {

      blog('listenToNootDismissedStream --- START');

      NootController.blogReceivedNotification(
        noot: receivedNotification,
        invoker: 'listenToNootDismissedStream',
      );

      blog('listenToNootDismissedStream --- END');

    });

    return _sub;
  }
  // -----------------------------------------------------------------------------

  /// DISPLAYED

  // --------------------
  ///
  static StreamSubscription? listenToNootDisplayedStream(){

    final StreamSubscription? _sub = FCM.getAwesomeNoots()?.dismissedStream
        .listen((ReceivedNotification? receivedNotification) {

      blog('listenToNootDismissedStream --- START');

      NootController.blogReceivedNotification(
        noot: receivedNotification,
        invoker: 'listenToNootDismissedStream',
      );

      blog('listenToNootDismissedStream --- END');

    });

    return _sub;
  }
   */
  // -----------------------------------------------------------------------------
}
