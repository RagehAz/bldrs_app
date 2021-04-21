import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
// ----------------------------------------------------------------------
AlertDialog _superAlert ({
  BuildContext context,
  BuildContext ctx,
  dynamic body,
  String title,
  bool boolDialog,
  double height,
  Widget child,
}) {

  BorderRadius _borders = Borderers.superBorderAll(context, 20);
  double _screenWidth = superScreenWidth(context);
  double _screenHeight = superScreenHeight(context);

  double _dialogHeight = height == null ? _screenHeight * 0.4 : height;
  double _dialogWidth = _screenWidth * 0.8;

  double _dialogVerticalMargin = (_screenHeight - _dialogHeight) / 2;
  double _dialogHorizontalMargin = (_screenWidth - _dialogWidth) / 2;

  return
    AlertDialog(
      backgroundColor: Colorz.Nothing,
      // elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
      contentPadding: const EdgeInsets.all(0),
      insetPadding: EdgeInsets.symmetric(
          vertical: _dialogVerticalMargin,
          horizontal: _dialogHorizontalMargin,
      ),

      content: Builder(
        builder: (context){
          return

              Stack(
                children: <Widget>[

                  BlurLayer(borders: _borders,),

                  Container(
                    width: _dialogWidth,
                    height: _dialogHeight,
                    decoration: BoxDecoration(
                      color: Colorz.WhiteGlass,
                      borderRadius: _borders
                    ),

                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Expanded(
                          child: Container(
                            
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                /// TITLE
                                if (title != '')
                                  SuperVerse(
                                    verse: title,
                                    color: Colorz.White,
                                    // designMode: true,
                                    margin: 15,
                                  ),

                                /// BODY
                                SuperVerse(
                                  verse: body.toString(),
                                  color: Colorz.White,
                                  maxLines: 6,
                                  // designMode: true,
                                  margin: 10,
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
                              DreamBox(
                                  height: 50,
                                  width: 100,
                                  boxMargins: EdgeInsets.all(Ratioz.ddAppBarMargin),
                                  verse: 'No',
                                  verseColor: Colorz.BlackBlack,
                                  color: Colorz.WhiteSmoke,
                                  verseScaleFactor: 0.6,
                                  boxFunction: () => Nav.goBack(context, argument: false)
                              ),

                            DreamBox(
                                height: 50,
                                width: 100,
                                boxMargins: EdgeInsets.all(Ratioz.ddAppBarMargin),
                                verse: boolDialog == true ? 'Yes' : 'Ok',
                                verseColor: Colorz.BlackBlack,
                                color: Colorz.Yellow,
                                verseScaleFactor: 0.6,
                                boxFunction:
                                boolDialog == true ?
                                    () => Nav.goBack(context, argument: true)
                                    :
                                    () => Nav.goBack(context)
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              );
        },
      ),

    );
}
// ----------------------------------------------------------------------
Future<bool> superDialog({
  BuildContext context,
  dynamic body,
  String title,
  bool boolDialog,
  double height,
  Widget child,
}) async {

  bool _result = await showDialog(
    context: context,
    builder: (ctx)=> _superAlert(
        context: context,
        ctx: ctx,
        body: body,
        title: title,
        height: height,
        boolDialog: boolDialog,
        child: child,
    ),
  );

  return _result;

}
// ----------------------------------------------------------------------
Future<void> tryAndCatch({Function finals, BuildContext context, Function functions,}) async {
  try{
    await functions();
  } catch (error){

    await superDialog(
      context: context,
      title: 'ops',
      body: error,
      boolDialog: false,
    );

    print('TRY CATCH ERROR IS : ($error)');
    throw(error);
  }
}
// ----------------------------------------------------------------------
