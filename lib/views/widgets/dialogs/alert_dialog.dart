import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/theme/wordz.dart';

// -----------------------------------------------------------------------------
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
  double _screenWidth = Scale.superScreenWidth(context);
  double _screenHeight = Scale.superScreenHeight(context);

  double _dialogHeight = height == null ? _screenHeight * 0.4 : height;
  double _dialogWidth = Scale.superDialogWidth(context);

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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                /// TITLE
                                if (title != '' || title != null)
                                  SuperVerse(
                                    verse: title,
                                    color: Colorz.White,
                                    // designMode: true,
                                    margin: 15,
                                  ),

                                /// BODY
                                SuperVerse(
                                  verse: body.runtimeType == String ? body : body.toString(),
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
                                  boxMargins: const EdgeInsets.all(Ratioz.appBarMargin),
                                  verse: 'No',
                                  verseColor: Colorz.BlackBlack,
                                  color: Colorz.WhiteSmoke,
                                  verseScaleFactor: 0.6,
                                  boxFunction: () => Nav.goBack(context, argument: false)
                              ),

                            DreamBox(
                                height: 50,
                                width: 100,
                                boxMargins: const EdgeInsets.all(Ratioz.appBarMargin),
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
Future<void> tryAndCatch({Function finals, BuildContext context, Function functions, String methodName,}) async {
  try{
    await functions();
  } catch (error){

    print('$methodName : tryAndCatch ERROR : $error');

    await superDialog(
      context: context,
      title: 'ops',
      body: error,
      boolDialog: false,
    );

    // throw(error);
  }
}
// -----------------------------------------------------------------------------
Future<dynamic> tryCatchAndReturn({Function finals, BuildContext context, Function functions, String methodName,}) async {
  try{
    await functions();
  } catch (error){

    // await superDialog(
    //   context: context,
    //   title: 'ops',
    //   body: error,
    //   boolDialog: false,
    // );

    print('$methodName : tryAndCatch ERROR : $error');

    return error.toString();
  }
}
// -----------------------------------------------------------------------------
Future<void> authErrorDialog({BuildContext context, dynamic result}) async {

  List<Map<String, dynamic>> _errors = <Map<String, dynamic>>[

    // SIGN IN ERROR
    {
      'error' : '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.',
      'reply' : Wordz.emailNotFound(context),
    },
    {
      'error' : '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
      'reply' : 'No Internet connection available',
    },
    {
      'error' : '[firebase_auth/invalid-email] The email address is badly formatted.',
      'reply' : Wordz.emailWrong(context),
    },
    {
      'error' : '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.',
      'reply' : Wordz.wrongPassword(context), /// TASK : should link accounts authentication
    },
    {
      'error' : '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.',
      'reply' : 'Too many failed sign in attempts.\nThis device is put on hold for some time to secure the account', /// TASK : should link accounts authentication and delete this dialog
    },
    {
      'error' : 'PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)',
      'reply' : 'Sorry, Could not sign in by google.',
    },

    // REGISTER ERRORS
    {
      'error' : '[firebase_auth/email-already-in-use] The email address is already in use by another account.',
      'reply' : Wordz.emailAlreadyRegistered(context),
    },
    {
      'error' : '[firebase_auth/invalid-email] The email address is badly formatted.',
      'reply' : Wordz.emailWrong(context),
    },

    // SHARED ERRORS
    {
      'error' : null,
      'reply' : Wordz.somethingIsWrong(context),
    },

  ];

  print('authErrorDialog result : $result');

  Map<String, dynamic> _errorMap = _errors.firstWhere((map) => map['error'] == result.toString(), orElse: () => null) ;
  print('_errorMap : $_errorMap');

  String _errorReply = _errorMap == null ? null : _errorMap['reply'];
  print('_errorReply : $_errorReply');

  await superDialog(
    context: context,
    title: 'Ops!',
    body: _errorMap == null ? result : _errorReply,
    boolDialog: false,
  );

}
// -----------------------------------------------------------------------------
Future<bool> bzzDeactivationDialog({
  BuildContext context,
  List<BzModel> bzzToDeactivate,
  List<BzModel> bzzToKeep,
}) async {

  bool _bzzReviewResult = await superDialog(
    context: context,
    title: 'You Have ${bzzToDeactivate.length + bzzToKeep.length} business accounts',
    body: 'All Business accounts will be deactivated except those shared with other authors',
    boolDialog: true,
    height: Scale.superScreenHeight(context) * 0.8,
    child: Container(
      height: Scale.superScreenHeight(context) * 0.45,
      child: ListView(
        children: <Widget>[

          if (bzzToDeactivate.length != 0)
            BzzBubble(
            tinyBzz: TinyBz.getTinyBzzFromBzzModels(bzzToDeactivate),
            onTap: (value){print(value);},
            numberOfColumns: 6,
            numberOfRows: 1,
            scrollDirection: Axis.horizontal,
            title: 'These Accounts will be deactivated',
          ),

          if (bzzToKeep.length != 0)
          BzzBubble(
            tinyBzz: TinyBz.getTinyBzzFromBzzModels(bzzToKeep),
            onTap: (value){print(value);},
            numberOfColumns: 6,
            numberOfRows: 1,
            scrollDirection: Axis.horizontal,
            title: 'Can not deactivate these businesses',
          ),

          SuperVerse(
            verse: 'Would you like to continue ?',
            margin: 10,
          ),

        ],
      ),
    ),
  );

  return _bzzReviewResult;

}
// -----------------------------------------------------------------------------
Future<bool> flyersDeactivationDialog({
  BuildContext context,
  List<BzModel> bzzToDeactivate,
}) async {

  int _totalNumOfFlyers = FlyerModel.getNumberOfFlyersFromBzzModels(bzzToDeactivate);
  int _numberOfBzz = bzzToDeactivate.length;

  bool _flyersReviewResult = await superDialog(
    context: context,
    title: '',
    body: 'You Have $_totalNumOfFlyers flyers that will be deactivated and can not be retrieved',
    boolDialog: true,
    height: Scale.superScreenHeight(context) * 0.9,
    child: Column(
      children: <Widget>[

        Container(
          // width: superBubbleClearWidth(context),
          height: Scale.superScreenHeight(context) * 0.6,
          child: ListView.builder(
            itemCount: _numberOfBzz,
            scrollDirection: Axis.vertical,
            itemExtent: 200,
            itemBuilder: (context, index){

              return
                FlyersBubble(
                  tinyFlyers: TinyFlyer.getTinyFlyersFromBzModel(bzzToDeactivate[index]),
                  flyerSizeFactor: 0.2,
                  numberOfColumns: 2,
                  title: 'flyers of ${bzzToDeactivate[index].bzName}',
                  numberOfRows: 1,
                  bubbleWidth: Scale.superDialogWidth(context) - (Ratioz.appBarMargin * 4),
                  onTap: (value){
                    print(value);
                  },
                );
            },



          ),
        ),

        SuperVerse(
          verse: 'Would you like to continue ?',
          margin: 10,
        ),

      ],
    ),
  );


  return _flyersReviewResult;
}