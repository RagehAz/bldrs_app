import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
// ----------------------------------------------------------------------
AlertDialog superAlert (BuildContext context, BuildContext ctx, dynamic error, String title) {

  BorderRadius _borders = Borderers.superBorderAll(context, 20);

  return
    AlertDialog(

      // title: SuperVerse(verse: title, color: Colorz.BlackBlack,),

      content: Builder(
        builder: (context){
          return
              Stack(
                children: <Widget>[

                  BlurLayer(
                    borders: _borders,
                  ),

                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colorz.WhiteGlass,
                      borderRadius: _borders
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[

                        SuperVerse(
                          verse: title,
                          color: Colorz.White,
                          margin: Ratioz.ddAppBarMargin,
                        ),

                        Expanded(child: Container(),),

                        SuperVerse(
                          verse: error.toString(),
                          color: Colorz.White,
                          maxLines: 10,
                        ),

                        Expanded(child: Container(),),

                        DreamBox(
                            height: 50,
                            boxMargins: EdgeInsets.all(Ratioz.ddAppBarMargin),
                            verse: 'I Understand',
                            verseColor: Colorz.BlackBlack,
                            color: Colorz.Yellow,
                            verseScaleFactor: 0.6,
                            boxFunction: () => Nav.goBack(context)
                        )

                      ],
                    ),
                  ),

                ],
              );
        },
      ),

      backgroundColor: Colorz.Nothing,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderAll(context, 20)),
      contentPadding: EdgeInsets.all(10),
      actionsOverflowButtonSpacing: 10,
      actionsPadding: EdgeInsets.all(5),

      insetPadding: EdgeInsets.symmetric(
          vertical: (superScreenHeight(context) * 0.32), horizontal: 35
      ),

      buttonPadding: EdgeInsets.all(5),
      titlePadding: EdgeInsets.all(20),



      // actions: <Widget>[
      //
      //   DreamBox(
      //     width: 321,
      //     height: 50,
      //     color: Colorz.Yellow,
      //     verse: 'I Understand',
      //     verseColor: Colorz.BlackBlack,
      //     verseScaleFactor: 0.8,
      //     verseWeight: VerseWeight.bold,
      //     boxFunction: () => goBack(context),
      //   ),
      // ],

    );
}
// ----------------------------------------------------------------------
Future<dynamic> superDialog(BuildContext context, dynamic error, String title) async {
  Future<dynamic> _dialog = showDialog(
    context: context,
    builder: (ctx)=> superAlert(context, ctx, error, title),
  );
  return _dialog;
}
// ----------------------------------------------------------------------
/// TASK : create bool dialog
// Future<bool> boolDialog(BuildContext context, String message, ) async {
//   bool _result;
//
//   Future<dynamic> _dialog = showDialog(
//     context: context,
//     builder: (ctx){
//       _result = await boolAlert(context, ctx, error, title);
//     },
//   );
//
//   return _result;
// }
// ----------------------------------------------------------------------
// Future<dynamic> superDialog2(BuildContext context, dynamic error, String title) async {
//   Future<dynamic> _dialog = showDialog(
//       context: context,
//       builder: (_)
//       Dialog(
//     backgroundColor: Colorz.White,
//     insetPadding: EdgeInsets.all(Ratioz.ddAppBarMargin * 2),
//
//   ));
//   return _dialog;
// }
// ----------------------------------------------------------------------
Future<void> tryAndCatch({Function finals, BuildContext context, Function functions,}) async {
  try{
    await functions();
  } catch (error){
    superDialog(context, error, 'ops');
    print('TRY CATCH ERROR IS : ($error)');
    throw(error);
  }
}
// ----------------------------------------------------------------------
