import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CenterDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CenterDialog({
    @required this.bodyVerse,
    @required this.title,
    @required this.boolDialog,
    @required this.height,
    @required this.invertButtons,
    @required this.confirmButtonVerse,
    @required this.child,
    @required this.onOk,
    @required this.color,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse bodyVerse;
  final Verse title;
  final bool boolDialog;
  final double height;
  final Widget child;
  final Verse confirmButtonVerse;
  final Color color;
  final Function onOk;
  final bool invertButtons;
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  static double getWidth(BuildContext context) {
    return Scale.superScreenWidth(context) * 0.85;
  }
  // --------------------
  static double clearWidth(BuildContext context){
    return getWidth(context) - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static const double dialogCornerValue = 20;
  // --------------------
  static BorderRadius dialogBorders(BuildContext context) {
    return Borderers.cornerAll(context, dialogCornerValue);
  }
  // --------------------
  static double getHeight({
    @required BuildContext context,
    double heightOverride,
  }) {
    final double _screenHeight = Scale.superScreenHeight(context);
    final double _height = heightOverride ?? _screenHeight * 0.4;
    return _height;
  }
  // -----------------------------------------------------------------------------

  /// COLORS

  // --------------------
  static const Color activeButtonColor = Colorz.yellow255;
  static const Color defaultButtonColor = Colorz.white50;
  // -----------------------------------------------------------------------------

  /// LAUNCHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> showCenterDialog({
    @required BuildContext context,
    Verse bodyVerse,
    Verse titleVerse,
    bool boolDialog = false,
    double height,
    Widget child,
    Verse confirmButtonVerse,
    Color color = Colorz.skyDarkBlue,
    Function onOk,
    bool invertButtons = false,
  }) async {

    final bool _result = await showDialog(
      context: context,
      builder: (BuildContext ctx) => CenterDialog(
        bodyVerse: bodyVerse,
        title: titleVerse,
        height: height,
        boolDialog: boolDialog,
        confirmButtonVerse: confirmButtonVerse,
        color: color,
        onOk: onOk,
        invertButtons: invertButtons,
        child: child,
      ),
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeCenterDialog(BuildContext context) async {
    await Nav.goBack(
      context: context,
      invoker: 'closeCenterDialog',
    );
  }
  // --------------------
  /*
//   static double dialogVerticalMargin({BuildContext context, double dialogHeight}){
//     double _screenHeight = Scale.superScreenHeight(context);
//     return (_screenHeight - dialogHeight) / 2;
//   }
// // -----------------------------------------------------------------------------
//   static double dialogHorizontalMargin({BuildContext context, double dialogWidth}){
//     double _screenWidth = Scale.superScreenWidth(context);
//     return (_screenWidth - dialogWidth) / 2;
//   }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  Verse _getConfirmButtonVerse(){

    Verse _verse = boolDialog ?
    const Verse(
      text: 'phid_yes',
      translate: true,
    )
        :
    const Verse(
      text: 'phid_ok',
      translate: true,
    );

    if (confirmButtonVerse != null){
      _verse = confirmButtonVerse;
    }

    return _verse;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // --------------------
    final BorderRadius _dialogBorders = dialogBorders(context);
    // --------------------
    final double _dialogHeight = getHeight(
      context: context,
      heightOverride: height,
    );
    // --------------------
    final double _dialogWidth = getWidth(context);
    // double _dialogVerticalMargin = dialogVerticalMargin(
    //   context: context,
    //   dialogHeight: _dialogHeight,
    // );
    // double _dialogHorizontalMargin = dialogHorizontalMargin(
    //   context: context,
    //   dialogWidth: _dialogWidth,
    // );
    const double _buttonHeight = DialogButton.height;
    // final double _contentZoneHeight = _dialogHeight - _buttonZoneHeight;
    const double _buttonZoneHeight = _buttonHeight + (2 * Ratioz.appBarPadding);
    // --------------------
    final bool _keyboardIsOn = Keyboard.keyboardIsOn(context);
    final double _keyboardHeight = _keyboardIsOn == true ? MediaQuery.of(context).viewInsets.bottom : 0;
    // --------------------
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.black80,
        resizeToAvoidBottomInset: true,
        body: AlertDialog(
          backgroundColor: Colorz.nothing,
          // shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
          contentPadding: EdgeInsets.zero,
          elevation: 10,

          insetPadding: EdgeInsets.zero,

          content: Builder(
            builder: (BuildContext xxx) {

              return WidgetFader(
                fadeType: FadeType.fadeIn,
                min: 0.7,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeInOutCirc,
                builder: (double value, Widget child){

                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: value,
                      child: child,
                    ),
                  );

                },
                child: GestureDetector(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: GestureDetector(
                      onTap: () async {
                        await Nav.goBack(
                          context: context,
                          invoker: 'CenterDialog tapping outside the dialog',
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        width: _screenWidth,
                        // height: ,
                        constraints: BoxConstraints(
                          minHeight: _keyboardIsOn == true ? (_screenHeight - _keyboardHeight * 0.5) : _screenHeight,
                        ),
                        alignment: Alignment.center,
                        color: Colorz.nothing, // to let parent gesture detector detect this container
                        child: GestureDetector(
                          onTap: (){
                            blog('tapping on dialog bubble');
                            Keyboard.closeKeyboard(context);
                          },
                          child: Container(
                            width: _dialogWidth,
                            // height: _dialogHeight,
                            constraints: BoxConstraints(
                              minHeight: _dialogHeight,
                            ),
                            decoration: BoxDecoration(
                              color: color,
                              boxShadow: Shadower.appBarShadow,
                              borderRadius: _dialogBorders,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                /// TITLE
                                Container(
                                  width: _dialogWidth,
                                  alignment: Alignment.center,
                                  // color: Colorz.BloodTest,
                                  child: title == null ? Container()
                                      :
                                  SuperVerse(
                                    verse: title,
                                    color: Colorz.yellow255,
                                    shadow: true,
                                    size: 3,
                                    italic: true,
                                    maxLines: 2,
                                    // labelColor: Colorz.Yellow,
                                    margin: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 5,
                                      left: Ratioz.appBarMargin,
                                      right: Ratioz.appBarMargin,
                                    ),
                                  ),
                                ),

                                /// BODY
                                if (TextCheck.isEmpty(bodyVerse?.text) == false)
                                  SizedBox(
                                    width: _dialogWidth,
                                    // height: _bodyZoneHeight,
                                    child: SuperVerse(
                                      verse: bodyVerse,
                                      maxLines: 20,
                                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: Ratioz.appBarMargin),
                                    ),
                                  ),

                                /// child
                                if (child != null)
                                  Column(
                                    children: <Widget>[

                                      SeparatorLine(
                                        width: _dialogWidth,
                                      ),

                                      Container(
                                        width: _dialogWidth,
                                        constraints: BoxConstraints(
                                          maxHeight: _dialogHeight * 0.6,
                                        ),
                                        child: SingleChildScrollView(
                                            physics: const BouncingScrollPhysics(),
                                            child: child
                                        ),
                                      ),

                                      SeparatorLine(
                                        width: _dialogWidth,
                                      ),

                                    ],
                                  ),

                                /// BUTTONS
                                if (boolDialog != null)
                                  SizedBox(
                                    width: _dialogWidth,
                                    height: _buttonZoneHeight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[

                                        /// NO BUTTON
                                        if (boolDialog == true && invertButtons == false)
                                          DialogButton(
                                            verse: const Verse(
                                              text: 'phid_no',
                                              translate: true,
                                              casing: Casing.capitalizeFirstChar,
                                            ),
                                            color: defaultButtonColor,
                                            onTap: () => Nav.goBack(
                                                  context: xxx,
                                                  invoker: 'CenterDialog.No',
                                                  passedData: false,
                                                ),
                                          ),

                                        /// YES BUTTON
                                        DialogButton(
                                          verse: _getConfirmButtonVerse(),
                                          verseColor: invertButtons == true ? Colorz.white255 : Colorz.black230,
                                          color: invertButtons == true ? defaultButtonColor : activeButtonColor,
                                          onTap:
                                          boolDialog == true ? () => Nav.goBack(
                                              context: xxx,
                                              invoker: 'CenterDialog.yes',
                                              passedData: true
                                          )
                                              :
                                          onOk ?? () => Nav.goBack(
                                                context: xxx,
                                                invoker: 'CenterDialog.ok',
                                              ),
                                        ),

                                        /// NO BUTTON
                                        if (boolDialog == true && invertButtons == true)
                                          DialogButton(
                                            verse: const Verse(
                                              text: 'phid_no',
                                              translate: true,
                                              casing: Casing.capitalizeFirstChar,
                                            ),
                                            verseColor: Colorz.black230,
                                            color: activeButtonColor,
                                            onTap: () => Nav.goBack(
                                                  context: xxx,
                                                  invoker: 'CenterDialog.No',
                                                  passedData: false,
                                                ),
                                          ),

                                      ],
                                    ),
                                  ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

            },
          ),
        ),
      ),
    );
    // --------------------
  }
// --------------------
}
