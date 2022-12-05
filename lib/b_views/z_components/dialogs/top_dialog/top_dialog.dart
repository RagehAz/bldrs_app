import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class TopDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TopDialog({
    @required this.verse,
    @required this.onTap,
    // @required this.duration,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Function onTap;
  // final int duration;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeTopDialog(BuildContext context) async {

    final GlobalKey _key = UiProvider.proGetTopDialogKey(
      context: context,
      listen: false,
    );

    final Flushbar _flushbar = _key?.currentWidget;

    if (_flushbar?.isDismissed() == false){
      await _flushbar.dismiss();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showTopDialog({
    @required BuildContext context,
    @required Verse firstVerse,
    Verse secondVerse,
    Color color = Colorz.yellow255,
    Color textColor = Colorz.black255,
    Function onTap,
    int milliseconds = 5000,
  }) async {

    await closeTopDialog(context);

    final double _screenWidth = Scale.screenWidth(context);
    final double _bubbleWidth = BldrsAppBar.width(context);

    await Flushbar(
      key: UiProvider.proGetTopDialogKey(context: context, listen: false),

      /// BEHAVIOUR - POSITIONING ----------------------------------------------
      // dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      // flushbarStyle: FlushbarStyle.FLOATING,
      // isDismissible: true,
      // blockBackgroundInteraction: false, // prevents gestures on background widgets

      /// SIZING ----------------------------------------------
      maxWidth: _screenWidth,
      borderRadius: BldrsAppBar.corners,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(Ratioz.appBarMargin),

      /// COLORING ----------------------------------------------
      // routeColor: null, // SCREEN BACKGROUND COLOR
      backgroundColor: color, // DIALOG BACKGROUND COLOR
      // barBlur: 50,
      // backgroundGradient: null,
      boxShadows: Shadower.appBarShadow,
      // routeBlur: null,

      /// BORDERS ----------------------------------------------
      // borderColor: Colorz.Black255,
      // borderWidth: 1,

      /// ANIMATION ----------------------------------------------
      forwardAnimationCurve: Curves.easeOutBack,
      duration: Duration(milliseconds: milliseconds ?? 1000),
      animationDuration: const Duration(milliseconds: 150),
      reverseAnimationCurve: Curves.elasticOut,

      ///   LEFT BAR INDICATOR ----------------------------------------------
      // leftBarIndicatorColor: null,

      /// LEADING ----------------------------------------------
      // icon: null,

      /// TITLE ----------------------------------------------
      titleText: Container(
        width: _bubbleWidth,
        constraints: BoxConstraints(
          minHeight: BldrsAppBar.height(context, AppBarType.basic) - 5,
        ),
        decoration: const BoxDecoration(
          // color: Colorz.Black255,
          borderRadius: BldrsAppBar.corners,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// FIRST LINE
            SuperVerse(
              width: _bubbleWidth,
              verse: firstVerse,
              color: textColor,
              maxLines: 3,
              margin: 5,
            ),

            /// SECOND LINE
            if (secondVerse != null)
              SuperVerse(
                width: _bubbleWidth,
                verse: secondVerse,
                size: 1,
                color: textColor,
                weight: VerseWeight.thin,
                italic: true,
                maxLines: 2,
                margin: 5,
              ),

          ],
        ),
      ),

      /// BODY ----------------------------------------------
      messageText: const SizedBox(),
      // messageColor: null,
      // messageSize: null,

      /// ACTION BUTTON ----------------------------------------------
      // mainButton: null,
      // DreamBox(
      //   height: 40,
      //   width: 100,
      //   verse:  'main button',
      //   verseScaleFactor: 0.5,
      // ),

      /// PROGRESS INDICATOR ----------------------------------------------
      // showProgressIndicator: false,
      progressIndicatorBackgroundColor: Colorz.yellow255,
      // progressIndicatorController: AnimationController(),
      // progressIndicatorValueColor: ,

      /// INTERACTIONS ----------------------------------------------
      onTap: (Flushbar<dynamic> flushbar) {

        closeTopDialog(context);
        // blog('on tap : flushbar : ${flushbar.onTap}');

      },

      onStatusChanged: (FlushbarStatus status) {

        // switch (status) {
        //   case FlushbarStatus.SHOWING:
        //     {
        //       doSomething();
        //       break;
        //     }
        //   case FlushbarStatus.IS_APPEARING:
        //     {
        //       doSomethingElse();
        //       break;
        //     }
        //   case FlushbarStatus.IS_HIDING:
        //     {
        //       doSomethingElse();
        //       break;
        //     }
        //   case FlushbarStatus.DISMISSED:
        //     {
        //       doSomethingElse();
        //       break;
        //     }
        // }

      },

      /// UNKNOWN ----------------------------------------------
      message: 'SHIKA',
      title: 'wtf',
      endOffset: Offset.zero,
      shouldIconPulse: false,
      // positionOffset: 0,
      // userInputForm: ,
    ).show(context);
  }
  // --------------------
  /// BUG THE SHIT OUT OF LIFE
  /*
  static void showUnawaitedTopDialog({
    @required BuildContext context,
    @required Verse firstVerse,
    Verse secondVerse,
    Color color = Colorz.yellow255,
    Color textColor = Colorz.black255,
    Function onTap,
    int milliseconds = 5000,
  }){

    unawaited(showTopDialog(
      context: context,
      firstVerse: firstVerse,
      secondVerse: secondVerse,
      color: color,
      textColor: textColor,
      onTap: onTap,
      milliseconds: milliseconds,
    ));

  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);

    return Flushbar(
      message: verse,
      onTap: onTap,
      duration: const Duration(milliseconds: 5000),
      // title: 'wtf',
      // padding: EdgeInsets.zero,
      // margin: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      animationDuration: const Duration(milliseconds: 5000),
      backgroundColor: Colorz.black10,
      barBlur: 5,
      // backgroundGradient: null,
      blockBackgroundInteraction: true,
      // borderColor: null,
      borderWidth: _screenWidth,
      // dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      boxShadows: const <BoxShadow>[],
      endOffset: Offset.zero,
      // flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.easeInOut,
      // isDismissible: true,
      leftBarIndicatorColor: Colorz.blue125,
      // mainButton: const DreamBox(
      //   height: 40,
      //   width: 100,
      //   verse:  'main button',
      //   verseScaleFactor: 0.5,
      // ),
      maxWidth: _screenWidth,
      messageColor: Colorz.white255,
      messageSize: 20,
      // messageText: const SuperVerse(
      //   verse:  'Message text',
      //   size: 1,
      // ),
      // onStatusChanged: (FlushbarStatus status) {
      //   blog('status is : $status');
      // },
      // positionOffset: 0,
      progressIndicatorBackgroundColor: Colorz.cyan50,
      // progressIndicatorController: AnimationController(),
      // progressIndicatorValueColor: ,
      reverseAnimationCurve: Curves.easeInOut,
      routeBlur: 0,
      routeColor: Colorz.black255,
      // shouldIconPulse: true,
      showProgressIndicator: true,
      titleColor: Colorz.bloodTest,
      titleSize: 15,
      // titleText: const SuperVerse(
      //   verse:  'title text',
      //   size: 1,
      // ),
      // userInputForm: ,
      icon: const DreamBox(
        width: 40,
        height: 40,
        icon: Iconz.dvGouran,
        color: Colorz.darkRed255,
        margins: EdgeInsets.zero,
      ),
    )..show(context);

  }
  // --------------------
}
