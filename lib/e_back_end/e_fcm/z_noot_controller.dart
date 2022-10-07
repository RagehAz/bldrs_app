import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';

abstract class NootController {
  // -----------------------------------------------------------------------------

  NootController();

  // -----------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  /// Use this method to detect when a new notification or a schedule is created
  @pragma('vm:entry-point')
  static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {

    blogReceivedNotification(
      noot: receivedNotification,
      invoker: 'onNotificationCreatedMethod',
    );

  }
  // -----------------------------------------------------------------------------
  /// Use this method to detect every time that a new notification is displayed
  @pragma('vm:entry-point')
  static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {

    blogReceivedNotification(
      noot: receivedNotification,
      invoker: 'onNotificationDisplayedMethod',
    );

  }
  // -----------------------------------------------------------------------------
  /// Use this method to detect if the user dismissed a notification
  @pragma('vm:entry-point')
  static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {

    blogReceivedAction(
      action: receivedAction,
      invoker: 'onDismissActionReceivedMethod',
    );

  }
  // -----------------------------------------------------------------------------
  /// Use this method to detect when the user taps on a notification or action button
  @pragma('vm:entry-point')
  static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {

    blogReceivedAction(
      action: receivedAction,
      invoker: 'onActionReceivedMethod',
    );

    // await Dialogs.confirmProceed(
    //     context: context,
    //     titleVerse: Verse.plain('Navigate ???'),
    // );

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    await BldrsAppStarter.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
            (route) => (route.settings.name != '/notification-page') || route.isFirst,
        arguments: receivedAction
    );

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  static void blogReceivedNotification({
    @required ReceivedNotification noot,
    @required String invoker,
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
      blog('noot.roundedLargeIcon   : ${noot.roundedLargeIcon}');
      blog('noot.roundedBigPicture  : ${noot.roundedBigPicture}');

    }
    else {
      blog('notification is null');
    }

    blog('blogReceivedNotification : $invoker : END');
  }
  // --------------------
  static void blogReceivedAction({
    @required ReceivedAction action,
    @required String invoker,
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
