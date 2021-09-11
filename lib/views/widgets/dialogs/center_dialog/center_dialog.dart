import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class CenterDialog extends StatelessWidget {
  final dynamic body;
  final String title;
  final bool boolDialog;
  final double height;
  final Widget child;

  const CenterDialog({
    @required this.body,
    @required this.title,
    @required this.boolDialog,
    @required this.height,
    @required this.child,
});
// -----------------------------------------------------------------------------
  static Future<bool> showCenterDialog({
    BuildContext context,
    dynamic body,
    String title,
    bool boolDialog,
    double height,
    Widget child,
  }) async {

    bool _result = await showDialog(
      context: context,
      builder: (ctx)=> CenterDialog(
        // context: context,
        // ctx: ctx,
        body: body,
        title: title,
        height: height,
        boolDialog: boolDialog,
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
  static double dialogCornerValue(){
    return 20;
  }
// -----------------------------------------------------------------------------
  static BorderRadius dialogBorders(BuildContext context){
    return Borderers.superBorderAll(context, dialogCornerValue());
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
    double _screenHeight = Scale.superScreenHeight(context);
    double _height = heightOverride == null ? _screenHeight * 0.4 : heightOverride;
    return _height;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    BorderRadius _dialogBorders = dialogBorders(context);

    double _dialogHeight = dialogHeight(
      context: context,
      heightOverride: height,
    );

    double _dialogWidth = dialogWidth(context: context);

    // double _dialogVerticalMargin = dialogVerticalMargin(
    //   context: context,
    //   dialogHeight: _dialogHeight,
    // );
    // double _dialogHorizontalMargin = dialogHorizontalMargin(
    //   context: context,
    //   dialogWidth: _dialogWidth,
    // );

    double _buttonHeight = DialogButton.height();
    double _buttonZoneHeight = _buttonHeight + (2 * Ratioz.appBarPadding);
    double _contentZoneHeight = _dialogHeight - _buttonZoneHeight;

    return SafeArea(
      child: AlertDialog(
        backgroundColor: Colorz.Nothing,
        // shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
        contentPadding: const EdgeInsets.all(0),
        elevation: 10,

        insetPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        ),

        content: Builder(
          builder: (context){
            return

              GestureDetector(
                onTap: () => Nav.goBack(context),
                child: Container(
                  width: _screenWidth,
                  height: _screenHeight,
                  // padding: EdgeInsets.symmetric(horizontal: _dialogHorizontalMargin, vertical: _dialogVerticalMargin),
                  color: Colorz.Black80,
                  alignment: Alignment.center,
                  child: Container(
                    width: _dialogWidth,
                    height: _dialogHeight,
                    decoration: BoxDecoration(
                        color: Colorz.SkyDarkBlue,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  color: Colorz.Yellow255,
                                  shadow: true,
                                  size: 3,
                                  italic: true,
                                  maxLines: 2,
                                  // labelColor: Colorz.Yellow,
                                  // designMode: true,
                                  margin: Ratioz.appBarMargin,
                                  centered: true,
                                ),
                              ),

                              /// BODY
                              Container(
                                width: _dialogWidth,
                                // height: _bodyZoneHeight,
                                child: SuperVerse(
                                  verse: body.runtimeType == String ? body : body.toString(),
                                  color: Colorz.White255,
                                  maxLines: 6,
                                  // designMode: true,
                                  margin: Ratioz.appBarMargin,
                                  centered: true,
                                ),
                              ),

                              /// child
                              if (child != null)
                                Container(
                                    width: _dialogWidth,
                                    // height: _childZoneHeight,
                                    child: child
                                ),

                            ],
                          ),
                        ),


                        /// BUTTONS
                        if (boolDialog != null)
                          Container(
                            width: _dialogWidth,
                            height: _buttonZoneHeight,
                            // color: Colorz.BloodTest,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                if (boolDialog == true)
                                  DialogButton(
                                    verse: 'No',
                                    verseColor: Colorz.White255,
                                    width: 100,
                                    color: Colorz.White80,
                                    onTap: () => Nav.goBack(context, argument: false),
                                  ),

                                DialogButton(
                                  verse: boolDialog == true ? 'Yes' : 'Ok',
                                  verseColor: Colorz.Black230,
                                  width: 100,
                                  color: Colorz.Yellow255,
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
