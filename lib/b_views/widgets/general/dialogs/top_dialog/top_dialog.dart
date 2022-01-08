import 'package:another_flushbar/flushbar.dart';
import 'package:bldrs/b_views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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
  /// --------------------------------------------------------------------------
  static Future<void> showTopDialog({
    @required BuildContext context,
    @required String verse,
    String secondLine,
    Color color,
    Function onTap,
  }) async {
    final Color _dialogColor = color ?? Colorz.yellow255;

    final double _screenWidth = Scale.superScreenWidth(context);

    await Flushbar(
      /// BEHAVIOUR - POSITIONING ----------------------------------------------
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      isDismissible: true,
      blockBackgroundInteraction:
          false, // prevents gestures on background widgets

      /// SIZING ----------------------------------------------
      maxWidth: _screenWidth,
      borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.all(Ratioz.appBarMargin),

      /// COLORING ----------------------------------------------
      routeColor: null, // SCREEN BACKGROUND COLOR
      backgroundColor: _dialogColor, // DIALOG BACKGROUND COLOR
      // barBlur: 50,
      backgroundGradient: null,
      boxShadows: Shadowz.appBarShadow,
      routeBlur: null,

      /// BORDERS ----------------------------------------------
      // borderColor: Colorz.Black255,
      // borderWidth: 1,

      /// ANIMATION ----------------------------------------------
      forwardAnimationCurve: Curves.easeInOut,
      duration: const Duration(seconds: 6),
      animationDuration: const Duration(milliseconds: 400),
      reverseAnimationCurve: Curves.easeInOut,

      ///   LEFT BAR INDICATOR ----------------------------------------------
      leftBarIndicatorColor: null,

      /// LEADING ----------------------------------------------
      icon: null,

      /// TITLE ----------------------------------------------
      titleText: Container(
        width: BldrsAppBar.width(context),
        height: BldrsAppBar.height(context, AppBarType.basic) - 5,
        decoration: BoxDecoration(
          // color: Colorz.Black255,
          borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SuperVerse(
              verse: verse,
              color: Colorz.black255,
            ),
            SuperVerse(
              verse: secondLine,
              size: 1,
              color: Colorz.black255,
              weight: VerseWeight.thin,
              italic: true,
              maxLines: 2,
            ),
          ],
        ),
      ),

      /// BODY ----------------------------------------------
      messageText: Container(),
      messageColor: null,
      messageSize: null,

      /// ACTION BUTTON ----------------------------------------------
      mainButton: null,
      // DreamBox(
      //   height: 40,
      //   width: 100,
      //   verse: 'main button',
      //   verseScaleFactor: 0.5,
      // ),

      /// PROGRESS INDICATOR ----------------------------------------------
      showProgressIndicator: false,
      progressIndicatorBackgroundColor: Colorz.yellow255,
      // progressIndicatorController: AnimationController(),
      // progressIndicatorValueColor: ,

      /// INTERACTIONS ----------------------------------------------
      onTap: (Flushbar<dynamic> flushbar) {
        blog('on tap : flushbar : $flushbar');
      },

      onStatusChanged: (FlushbarStatus status) {
        blog('status is : $status');
      },

      /// UNKNOWN ----------------------------------------------
      message: 'SHIKA',
      title: 'wtf',
      endOffset: Offset.zero,
      shouldIconPulse: false,
      positionOffset: 50,
      // userInputForm: ,
    ).show(context);
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);

    return Flushbar(
      message: verse,
      onTap: onTap,
      duration: const Duration(milliseconds: 5000),
      title: 'wtf',
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      borderRadius: Borderers.superBorderAll(context, 0),
      animationDuration: const Duration(milliseconds: 5000),
      backgroundColor: Colorz.black10,
      barBlur: 5,
      backgroundGradient: null,
      blockBackgroundInteraction: true,
      borderColor: null,
      borderWidth: _screenWidth,
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      flushbarPosition: FlushbarPosition.TOP,
      boxShadows: const <BoxShadow>[],
      endOffset: Offset.zero,
      flushbarStyle: FlushbarStyle.FLOATING,
      forwardAnimationCurve: Curves.easeInOut,
      isDismissible: true,
      leftBarIndicatorColor: Colorz.blue125,
      mainButton: const DreamBox(
        height: 40,
        width: 100,
        verse: 'main button',
        verseScaleFactor: 0.5,
      ),
      maxWidth: _screenWidth,
      messageColor: Colorz.white255,
      messageSize: 20,
      messageText: const SuperVerse(
        verse: 'Message text',
        size: 1,
      ),
      onStatusChanged: (FlushbarStatus status) {
        blog('status is : $status');
      },
      positionOffset: 0,
      progressIndicatorBackgroundColor: Colorz.cyan50,
      // progressIndicatorController: AnimationController(),
      // progressIndicatorValueColor: ,
      reverseAnimationCurve: Curves.easeInOut,
      routeBlur: 0,
      routeColor: Colorz.black255,
      shouldIconPulse: true,
      showProgressIndicator: true,
      titleColor: Colorz.bloodTest,
      titleSize: 15,
      titleText: const SuperVerse(
        verse: 'title text',
        size: 1,
      ),
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
}