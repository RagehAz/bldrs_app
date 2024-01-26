import 'dart:async';

import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/components/drawing/separator_line.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BldrsCenterDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsCenterDialog({
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
    this.noVerse,
    this.canExit = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? bodyVerse;
  final bool bodyCentered;
  final Verse? title;
  final bool? boolDialog;
  final double? height;
  final Widget? child;
  final Verse? confirmButtonVerse;
  final Color color;
  final Function? onOk;
  final bool invertButtons;
  final bool copyOnTap;
  final Verse? noVerse;
  final bool canExit;
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
    bool? boolDialog = false,
    double? height,
    Widget? child,
    Verse? confirmButtonVerse,
    Verse? noVerse,
    Color? color = Colorz.blackSemi230,
    Function? onOk,
    bool invertButtons = false,
    bool copyOnTap = false,
    bool bodyCentered = true,
    bool canExit = true,
  }) async {

    final bool? _result = await showDialog(
      context: getMainContext(),
      builder: (BuildContext ctx) => BldrsCenterDialog(
        bodyVerse: bodyVerse,
        title: titleVerse,
        height: height,
        boolDialog: boolDialog,
        confirmButtonVerse: confirmButtonVerse,
        noVerse: noVerse,
        color: color ?? Colorz.blackSemi230,
        onOk: onOk,
        invertButtons: invertButtons,
        copyOnTap: copyOnTap,
        bodyCentered: bodyCentered,
        canExit: canExit,
        child: child,
      ),
    );

    return Mapper.boolIsTrue(_result);
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
  Verse? _getConfirmButtonVerse(){

    Verse? _verse = Mapper.boolIsTrue(boolDialog) ?
    getVerse('phid_yes')
        :
    getVerse('phid_ok');

    if (confirmButtonVerse != null){
      _verse = confirmButtonVerse;
    }

    return _verse;
  }
  // --------------------
  static double getButtonZoneHeight = DialogButton.height + (2 * Ratioz.appBarPadding);
  // --------------------
  Future<void> exit({
    required bool isButton,
    dynamic passedData,
  }) async {

    if ((canExit || Mapper.boolIsTrue(boolDialog)) && isButton){

      await Nav.goBack(
        context: getMainContext(),
        invoker: 'CenterDialog exit',
        passedData: passedData,
      );

    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    final BorderRadius _dialogBorders = dialogBorders();
    // --------------------
    final double _dialogHeight = getHeight(
      context: context,
      heightOverride: height,
    );
    // --------------------
    final double _dialogWidth = getWidth(context);
    // double _dialogVer
    // ticalMargin = dialogVerticalMargin(
    //   context: context,
    //   dialogHeight: _dialogHeight,
    // );
    // double _dialogHorizontalMargin = dialogHorizontalMargin(
    //   context: context,
    //   dialogWidth: _dialogWidth,
    // );
    // const double _buttonHeight = DialogButton.height;
    // final double _contentZoneHeight = _dialogHeight - _buttonZoneHeight;
    // --------------------
    final bool _keyboardIsOn = Keyboard.keyboardIsOn();
    final double _keyboardHeight = _keyboardIsOn == true ? MediaQuery.of(context).viewInsets.bottom : 0;
    // --------------------
    final Verse? _noVerse = getVerse('phid_no', casing: Casing.capitalizeFirstChar);
    // --------------------
    final bool _hasLeftNoButton = Mapper.boolIsTrue(boolDialog) == true && invertButtons == false;
    final bool _hasRightNoButton = Mapper.boolIsTrue(boolDialog) == true && invertButtons == true;
    final bool _hasOnlyOneButton = _hasLeftNoButton == false && _hasRightNoButton == false;

    final double? _yesButtonWidth = _hasOnlyOneButton == true ? clearWidth(context)
        :
        invertButtons == true ? 80
        :
      120;

    final double _noButtonWidth = invertButtons == true ? 120 : 80;
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      canGoBack: canExit,
      appBarType: AppBarType.non,
      skyType: SkyType.non,
      onBack: () => exit(
        isButton: false,
      ),
      child: AlertDialog(
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
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: GestureDetector(
                  onTap: () => exit(
                    isButton: false,
                  ),
                  onLongPress: () async {

                    if (kDebugMode){
                      await Nav.goBack(context: context);
                    }

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
                      onTap: () async {

                        if (copyOnTap == true){
                          unawaited(Keyboard.copyToClipboardAndNotify(copy: title?.id));
                        }

                        await Keyboard.closeKeyboard();
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
                                      maxHeight: _dialogHeight * 0.7,
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
                                height: getButtonZoneHeight,
                                child: UiProvider.checkAppIsLeftToRight() == true ?

                                /// ENGLISH ( LTR )
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    /// NO BUTTON
                                    if (_hasLeftNoButton == true)
                                      DialogButton(
                                        width: 80,
                                        verse: noVerse ?? _noVerse,
                                        color: defaultButtonColor,
                                        onTap: () => exit(
                                          passedData: false,
                                          isButton: true,
                                        ),
                                      ),

                                    /// YES BUTTON
                                    DialogButton(
                                      width: _yesButtonWidth,
                                      verse: _getConfirmButtonVerse(),
                                      verseColor: invertButtons == true ? Colorz.white255 : Colorz.black230,
                                      color: invertButtons == true ? defaultButtonColor : activeButtonColor,
                                      onTap: () async {

                                        onOk?.call();

                                        if (Mapper.boolIsTrue(boolDialog) == true){
                                          await exit(
                                            passedData: true,
                                            isButton: true,
                                          );
                                        }

                                        else {
                                          await exit(
                                            isButton: true,
                                          );
                                        }

                                      },
                                    ),

                                    /// NO BUTTON
                                    if (_hasRightNoButton == true)
                                      DialogButton(
                                        width: _noButtonWidth,
                                        verse: noVerse ?? _noVerse,
                                        verseColor: Colorz.black230,
                                        color: activeButtonColor,
                                        onTap: () => exit(
                                          passedData: false,
                                          isButton: true,
                                        ),
                                      ),

                                  ],
                                )

                                    :
                                /// ARABIC ( RTL )
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    /// NO BUTTON
                                    if (_hasRightNoButton == true)
                                      DialogButton(
                                        width: _noButtonWidth,
                                        verse: noVerse ?? _noVerse,
                                        verseColor: Colorz.black230,
                                        color: activeButtonColor,
                                        onTap: () => exit(
                                          isButton: true,
                                          passedData: false,
                                        ),
                                      ),

                                    /// YES BUTTON
                                    DialogButton(
                                      width: _yesButtonWidth,
                                      verse: _getConfirmButtonVerse(),
                                      verseColor: invertButtons == true ? Colorz.white255 : Colorz.black230,
                                      color: invertButtons == true ? defaultButtonColor : activeButtonColor,
                                      onTap: () async {
                                        onOk?.call();
                                        if (Mapper.boolIsTrue(boolDialog) == true){
                                          await exit(
                                            isButton: true,
                                            passedData: true,
                                          );
                                        }
                                        else {
                                          await exit(
                                            isButton: true,
                                          );
                                        }
                                      },
                                    ),

                                    /// NO BUTTON
                                    if (_hasLeftNoButton == true)
                                      DialogButton(
                                        width: 80,
                                        verse: noVerse ?? _noVerse,
                                        color: defaultButtonColor,
                                        onTap: () => exit(
                                          isButton: true,
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
            );

          },
        ),
      ),
    );
    // --------------------
  }
  // --------------------
}
