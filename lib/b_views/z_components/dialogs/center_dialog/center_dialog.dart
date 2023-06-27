import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class CenterDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CenterDialog({
    required this.bodyVerse,
    required this.title,
    required this.boolDialog,
    required this.height,
    required this.invertButtons,
    required this.confirmButtonVerse,
    required this.child,
    required this.onOk,
    required this.color,
    required this.copyOnTap,
    this.bodyCentered = true,
    this.noVerse = const Verse(
      id: 'phid_no',
      translate: true,
      casing: Casing.capitalizeFirstChar,
    ),
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse bodyVerse;
  final bool bodyCentered;
  final Verse title;
  final bool boolDialog;
  final double height;
  final Widget child;
  final Verse confirmButtonVerse;
  final Color color;
  final Function onOk;
  final bool invertButtons;
  final bool copyOnTap;
  final Verse noVerse;
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  static double getWidth(BuildContext context) {

    return Scale.responsive(
      context: context,
      landscape: Scale.screenShortestSide(context) * 0.85,
      portrait: Scale.screenWidth(context) * 0.85,
    );

  }
  // --------------------
  static double clearWidth(BuildContext context){
    return getWidth(context) - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static const double dialogCornerValue = 20;
  // --------------------
  static BorderRadius dialogBorders() {
    return Borderers.cornerAll(dialogCornerValue);
  }
  // --------------------
  static double getHeight({
    required BuildContext context,
    double? heightOverride,
  }) {
    final double _screenHeight = Scale.screenHeight(context);
    final double _height = heightOverride ?? _screenHeight * 0.4;
    return _height;
  }
  // --------------------
  static const Verse _noVerse = Verse(
      id: 'phid_no',
      translate: true,
      casing: Casing.capitalizeFirstChar,
    );
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
    Verse? bodyVerse,
    Verse? titleVerse,
    bool boolDialog = false,
    double? height,
    Widget? child,
    Verse? confirmButtonVerse,
    Verse? noVerse,
    Color color = Colorz.skyDarkBlue,
    Function? onOk,
    bool invertButtons = false,
    bool copyOnTap = false,
    bool bodyCentered = true,
  }) async {

    final bool _result = await showDialog(
      context: getMainContext(),
      builder: (BuildContext ctx) => CenterDialog(
        bodyVerse: bodyVerse,
        title: titleVerse,
        height: height,
        boolDialog: boolDialog,
        confirmButtonVerse: confirmButtonVerse,
        noVerse: noVerse,
        color: color ?? Colorz.skyDarkBlue,
        onOk: onOk,
        invertButtons: invertButtons,
        copyOnTap: copyOnTap,
        bodyCentered: bodyCentered,
        child: child,
      ),
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeCenterDialog() async {
    await Nav.goBack(
      context: getMainContext(),
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
      id: 'phid_yes',
      translate: true,
    )
        :
    const Verse(
      id: 'phid_ok',
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
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
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
    final bool _keyboardIsOn = Keyboard.keyboardIsOn();
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
                builder: (double value, Widget? child){

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

                            if (copyOnTap == true){
                              Keyboard.copyToClipboardAndNotify(copy: title?.id);
                            }

                            Keyboard.closeKeyboard();
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
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                /// TITLE
                                Container(
                                  width: _dialogWidth,
                                  alignment: Alignment.center,
                                  // color: Colorz.BloodTest,
                                  child: title == null ? Container()
                                      :
                                  BldrsText(
                                    width: _dialogWidth * 0.9,
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
                                if (TextCheck.isEmpty(bodyVerse?.id) == false)
                                  SizedBox(
                                    width: _dialogWidth,
                                    // height: _bodyZoneHeight,
                                    child: BldrsText(
                                      width: _dialogWidth * 0.9,
                                      verse: bodyVerse,
                                      maxLines: 20,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: Ratioz.appBarMargin * 2,
                                      ),
                                      centered: bodyCentered,
                                    ),
                                  ),

                                /// child
                                if (child != null)
                                  Column(
                                    children: <Widget>[

                                      SeparatorLine(
                                        width: _dialogWidth,
                                        color: Colorz.yellow200,
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
                                            verse: noVerse ?? _noVerse,
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
                                          onTap: boolDialog == true ? () => Nav.goBack(
                                            context: xxx,
                                            invoker: 'CenterDialog.yes',
                                            passedData: true,
                                            addPostFrameCallback: true,
                                          )
                                              :
                                          onOk ?? () => Nav.goBack(
                                            context: xxx,
                                            invoker: 'CenterDialog.ok',
                                            addPostFrameCallback: true,
                                          ),
                                        ),

                                        /// NO BUTTON
                                        if (boolDialog == true && invertButtons == true)
                                          DialogButton(
                                            verse: noVerse ?? _noVerse,
                                            verseColor: Colorz.black230,
                                            color: activeButtonColor,
                                            onTap: () => Nav.goBack(
                                              context: xxx,
                                              invoker: 'CenterDialog.No',
                                              passedData: false,
                                              addPostFrameCallback: true,
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
