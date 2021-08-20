

import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
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
  static Future<bool> superDialog({
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

  @override
  Widget build(BuildContext context) {

    BorderRadius _borders = Borderers.superBorderAll(context, 20);
    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _dialogHeight = height == null ? _screenHeight * 0.4 : height;
    double _dialogWidth = Scale.superDialogWidth(context);

    double _dialogVerticalMargin = (_screenHeight - _dialogHeight) / 2;
    double _dialogHorizontalMargin = (_screenWidth - _dialogWidth) / 2;


    return AlertDialog(
      backgroundColor: Colorz.Nothing,
      // shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
      contentPadding: const EdgeInsets.all(0),
      elevation: 10,

      insetPadding: EdgeInsets.symmetric(
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
                padding: EdgeInsets.symmetric(horizontal: _dialogHorizontalMargin, vertical: _dialogVerticalMargin),
                color: Colorz.Black80,
                child: Container(
                  width: _screenWidth - (_dialogHorizontalMargin * 2),
                  height: _screenHeight - (_dialogVerticalMargin * 2),
                  // color: Colorz.Yellow,
                  child: Stack(
                    children: <Widget>[

                      // BlurLayer(borders: _borders,),

                      Container(
                        width: _dialogWidth,
                        height: _dialogHeight,
                        decoration: BoxDecoration(
                            color: Colorz.SkyDarkBlue,
                            boxShadow: Shadowz.appBarShadow,
                            borderRadius: _borders
                        ),

                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Expanded(
                              child: Container(
                                // color: Colorz.SkyDarkBlue,
                                // padding: EdgeInsets,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[

                                    /// TITLE
                                    if (title != null)
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
                                      ),

                                    /// BODY
                                    SuperVerse(
                                      verse: body.runtimeType == String ? body : body.toString(),
                                      color: Colorz.White255,
                                      maxLines: 6,
                                      // designMode: true,
                                      margin: Ratioz.appBarMargin,
                                    ),

                                    if (child != null)
                                      Center(child: child),

                                  ],
                                ),
                              ),
                            ),

                            /// BUTTONS
                            if (boolDialog != null)
                              Row(
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

    );
  }
}
