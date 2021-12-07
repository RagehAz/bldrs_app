import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class CenterDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CenterDialog({
    @required this.body,
    @required this.title,
    @required this.boolDialog,
    @required this.height,
    @required this.confirmButtonText,
    this.child,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic body;
  final String title;
  final bool boolDialog;
  final double height;
  final Widget child;
  final String confirmButtonText;
  /// --------------------------------------------------------------------------
  static Future<bool> showCenterDialog({
    @required BuildContext context,
    dynamic body,
    String title,
    bool boolDialog = false,
    double height,
    Widget child,
    String confirmButtonText = 'Ok',
  }) async {

    final bool _result = await showDialog(
      context: context,
      builder: (BuildContext ctx)=> CenterDialog(
        // context: context,
        // ctx: ctx,
        body: body,
        title: title,
        height: height,
        boolDialog: boolDialog,
        confirmButtonText: confirmButtonText,
        child: child,
      ),
    );

    return _result;

  }
// -----------------------------------------------------------------------------
  static double dialogWidth({BuildContext context, }){
    return Scale.superScreenWidth(context) * 0.85;
  }
// -----------------------------------------------------------------------------
  static const double dialogCornerValue = 20;
// -----------------------------------------------------------------------------
  static BorderRadius dialogBorders(BuildContext context){
    return Borderers.superBorderAll(context, dialogCornerValue);
  }
// -----------------------------------------------------------------------------
//   static double dialogVerticalMargin({BuildContext context, double dialogHeight}){
//     double _screenHeight = Scale.superScreenHeight(context);
//     return (_screenHeight - dialogHeight) / 2;
//   }
// // -----------------------------------------------------------------------------
//   static double dialogHorizontalMargin({BuildContext context, double dialogWidth}){
//     double _screenWidth = Scale.superScreenWidth(context);
//     return (_screenWidth - dialogWidth) / 2;
//   }
// -----------------------------------------------------------------------------
  static double dialogHeight({BuildContext context, double heightOverride}){
    final double _screenHeight = Scale.superScreenHeight(context);
    final double _height = heightOverride ?? _screenHeight * 0.4;
    return _height;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    final BorderRadius _dialogBorders = dialogBorders(context);

    final double _dialogHeight = dialogHeight(
      context: context,
      heightOverride: height,
    );

    final double _dialogWidth = dialogWidth(context: context);

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

    return SafeArea(
      child: AlertDialog(
        backgroundColor: Colorz.nothing,
        // shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
        contentPadding: EdgeInsets.zero,
        elevation: 10,

        insetPadding: EdgeInsets.zero,

        content: Builder(
          builder: (BuildContext context){
            return

              GestureDetector(
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
                        color: Colorz.skyDarkBlue,
                        boxShadow: Shadowz.appBarShadow,
                        borderRadius: _dialogBorders
                    ),

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
                                child: title == null ? Container() :
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
                                  verse: body.runtimeType == String ? body : body.toString(),
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
                                    onTap: () => Nav.goBack(context, argument: false),
                                  ),

                                DialogButton(
                                  verse: boolDialog == true ? 'Yes' : confirmButtonText,
                                  verseColor: Colorz.black230,
                                  color: Colorz.yellow255,
                                  onTap: boolDialog == true ?
                                      () => Nav.goBack(context, argument: true)
                                      :
                                      () => Nav.goBack(context),
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
