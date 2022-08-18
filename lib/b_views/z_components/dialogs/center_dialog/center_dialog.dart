import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CenterDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CenterDialog({
    @required this.body,
    @required this.title,
    @required this.boolDialog,
    @required this.height,
    this.confirmButtonText,
    this.child,
    this.color = Colorz.skyDarkBlue,
    this.onOk,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic body;
  final String title;
  final bool boolDialog;
  final double height;
  final Widget child;
  final String confirmButtonText;
  final Color color;
  final Function onOk;
// -----------------------------------------------------------------------------

  /// SIZES

// -----------------------------------------
  static double getWidth(BuildContext context) {
    return Scale.superScreenWidth(context) * 0.85;
  }
// -----------------------------------------
  static double clearWidth(BuildContext context){
    return getWidth(context) - (2 * Ratioz.appBarMargin);
  }
// -----------------------------------------
  static const double dialogCornerValue = 20;
// -----------------------------------------
  static BorderRadius dialogBorders(BuildContext context) {
    return Borderers.superBorderAll(context, dialogCornerValue);
  }
// -----------------------------------------
  static double getHeight({
    @required BuildContext context,
    double heightOverride,
  }) {
    final double _screenHeight = Scale.superScreenHeight(context);
    final double _height = heightOverride ?? _screenHeight * 0.4;
    return _height;
  }
// -----------------------------------------------------------------------------

  /// LAUNCHERS

// -----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> showCenterDialog({
    @required BuildContext context,
    dynamic body = '',
    String title,
    bool boolDialog = false,
    double height,
    Widget child,
    String confirmButtonText,
    Color color = Colorz.skyDarkBlue,
    Function onOk,
  }) async {

    final bool _result = await showDialog(
      context: context,
      builder: (BuildContext ctx) => CenterDialog(
        // context: context,
        // ctx: ctx,
        body: body,
        title: title,
        height: height,
        boolDialog: boolDialog,
        confirmButtonText: confirmButtonText,
        color: color,
        onOk: onOk,
        child: child,
      ),
    );

    return _result;
  }
// -----------------------------------------
  /// TESTED : WORKS PERFECT
  static void closeCenterDialog(BuildContext context){
    Nav.goBack(
      context: context,
      invoker: 'closeCenterDialog',
    );
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  String _getConfirmButtonText(){

    String _text = boolDialog ? 'Yes' : 'Ok';

    if (confirmButtonText != null){
      _text = confirmButtonText;
    }

    return _text;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    final BorderRadius _dialogBorders = dialogBorders(context);

    final double _dialogHeight = getHeight(
      context: context,
      heightOverride: height,
    );

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
    const double _buttonZoneHeight = _buttonHeight + (2 * Ratioz.appBarPadding);
    final double _contentZoneHeight = _dialogHeight - _buttonZoneHeight;

    final String _confirmButtonText = _getConfirmButtonText();

    final bool _keyboardIsOn = Keyboard.keyboardIsOn(context);
    final double _keyboardHeight = _keyboardIsOn == true ? MediaQuery.of(context).viewInsets.bottom : 0;

    blog('in dialog : _keyboardIsOn : $_keyboardIsOn');

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

              return GestureDetector(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: GestureDetector(
                    onTap: (){
                      Nav.goBack(
                        context: context,
                        invoker: 'CenterDialog tapping outside the dialog',
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width: _screenWidth,
                      height: _keyboardIsOn == true ? (_screenHeight - _keyboardHeight * 0.5) : _screenHeight,
                      alignment: Alignment.center,
                      color: Colorz.nothing, // to let parent gesture detector detect this container
                      child: GestureDetector(
                        onTap: (){
                          blog('tapping on dialog bubble');
                          Keyboard.closeKeyboard(context);
                        },
                        child: Container(
                          width: _dialogWidth,
                          height: _dialogHeight,
                          decoration: BoxDecoration(
                            color: color,
                            boxShadow: Shadower.appBarShadow,
                            borderRadius: _dialogBorders,
                          ),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[

                              /// TITLE - BODY - CHILD
                              Container(
                                width: _dialogWidth,
                                height: _contentZoneHeight,
                                alignment: Alignment.center,
                                // color: Colorz.White30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    /// TITLE
                                    Container(
                                      width: _dialogWidth,
                                      // height: _titleZoneHeight,
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
                                        margin: Ratioz.appBarMargin,
                                      ),
                                    ),

                                    /// BODY
                                    SizedBox(
                                      width: _dialogWidth,
                                      // height: _bodyZoneHeight,
                                      child: SuperVerse(
                                        verse: body.runtimeType == String ? body
                                            :
                                        body.toString(),
                                        maxLines: 6,
                                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: Ratioz.appBarMargin),
                                      ),
                                    ),

                                    /// child
                                    if (child != null)
                                      SizedBox(
                                          width: _dialogWidth,
                                          // height: _childZoneHeight,
                                          child: child
                                      ),

                                  ],
                                ),
                              ),

                              /// BUTTONS
                              if (boolDialog != null)
                                SizedBox(
                                  width: _dialogWidth,
                                  height: _buttonZoneHeight,
                                  // color: Colorz.BloodTest,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      if (boolDialog == true)
                                        DialogButton(
                                          verse: 'No',
                                          color: Colorz.white80,
                                          onTap: () =>
                                              Nav.goBack(
                                                context: xxx,
                                                invoker: 'CenterDialog.No',
                                                passedData: false,
                                              ),
                                        ),

                                      DialogButton(
                                        verse: _confirmButtonText,
                                        verseColor: Colorz.black230,
                                        color: Colorz.yellow255,
                                        onTap:
                                        boolDialog == true ?
                                            () => Nav.goBack(
                                                context: xxx,
                                                invoker: 'CenterDialog.yes',
                                                passedData: true
                                            )
                                            :
                                        onOk ??
                                                () => Nav.goBack(
                                                  context: xxx,
                                                  invoker: 'CenterDialog.ok',
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
      ),
    );
  }
}
