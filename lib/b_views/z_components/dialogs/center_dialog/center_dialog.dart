import 'package:bldrs/b_views/z_components/auth/password_bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/b_auth_controllers/b_0_auth_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  static Future<String> showPasswordDialog(BuildContext context) async {

    final TextEditingController _password = TextEditingController();

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Enter Your password',
      onOk: () async {

        closeCenterDialog(context);

      },
      child: PasswordBubbles(
          boxWidth: CenterDialog.clearWidth(context),
          passwordController: _password,
          showPasswordOnly: true,
          passwordValidator: () => passwordValidation(
            context: context,
            password: _password.text,
          ),
          onObscureTap: (){
            final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
            _uiProvider.triggerTextFieldsObscured();
          },
          passwordConfirmationController: null,
          passwordConfirmationValidator: null,
          onSubmitted: (String text) => CenterDialog.closeCenterDialog(context),
      ),
    );

    return _password.text;
  }
// -----------------------------------------
  static void closeCenterDialog(BuildContext context){
    Nav.goBack(context);
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

    return SafeArea(
      child: AlertDialog(
        backgroundColor: Colorz.nothing,
        // shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
        contentPadding: EdgeInsets.zero,
        elevation: 10,

        insetPadding: EdgeInsets.zero,

        content: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => Nav.goBack(context),
              child: Container(
                width: _screenWidth,
                height: _screenHeight,
                // padding: EdgeInsets.symmetric(horizontal: _dialogHorizontalMargin, vertical: _dialogVerticalMargin),
                color: Colorz.black80,
                alignment: Alignment.center,
                child: Container(
                  width: _dialogWidth,
                  height: _dialogHeight,
                  decoration: BoxDecoration(
                      color: color,
                      boxShadow: Shadowz.appBarShadow,
                      borderRadius: _dialogBorders),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

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
                                margin: Ratioz.appBarMargin,
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
                                      Nav.goBack(context, argument: false),
                                ),

                              DialogButton(
                                verse: _confirmButtonText,
                                verseColor: Colorz.black230,
                                color: Colorz.yellow255,
                                onTap: boolDialog == true ? () => Nav.goBack(context, argument: true)
                                    : onOk ?? () => Nav.goBack(context),
                              ),

                            ],
                          ),
                        ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
