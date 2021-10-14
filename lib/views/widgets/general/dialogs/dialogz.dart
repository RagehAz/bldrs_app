import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class Dialogz{
// -----------------------------------------------------------------------------
  static Future<void> maxSlidesReached(BuildContext context, int maxLength) async {
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Max. Images reached',
      body: 'Can not add more than $maxLength images in one slide',
      boolDialog: false,
    );
  }
// -----------------------------------------------------------------------------
  static Future<void> authErrorDialog({BuildContext context, dynamic result}) async {

    final List<Map<String, dynamic>> _errors = <Map<String, dynamic>>[
      /// SIGN IN ERROR
      {
        'error' : '[firebase_auth/user-not-found]',// There is no user record corresponding to this identifier. The user may have been deleted.',
        'reply' : Wordz.emailNotFound(context),
      },
      {
        'error' : '[firebase_auth/network-request-failed]',// A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
        'reply' : 'No Internet connection available',
      },
      {
        'error' : '[firebase_auth/invalid-email]',// The email address is badly formatted.',
        'reply' : Wordz.emailWrong(context),
      },
      {
        'error' : '[firebase_auth/wrong-password]',// The password is invalid or the user does not have a password.',
        'reply' : Wordz.wrongPassword(context), /// TASK : should link accounts authentication
      },
      {
        'error' : '[firebase_auth/too-many-requests]',// We have blocked all requests from this device due to unusual activity. Try again later.',
        'reply' : 'Too many failed sign in attempts.\nThis device is put on hold for some time to secure the account', /// TASK : should link accounts authentication and delete this dialog
      },
      {
        'error' : 'PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)',
        'reply' : 'Sorry, Could not sign in by google.',
      },
      /// REGISTER ERRORS
      {
        'error' : '[firebase_auth/email-already-in-use]',// The email address is already in use by another account.',
        'reply' : Wordz.emailAlreadyRegistered(context),
      },
      {
        'error' : '[firebase_auth/invalid-email]',// The email address is badly formatted.',
        'reply' : Wordz.emailWrong(context),
      },
      /// SHARED ERRORS
      {
        'error' : null,
        'reply' : Wordz.somethingIsWrong(context),
      },
    ];

    // print('authErrorDialog result : $result');

    String _errorReply;

    for (var map in _errors){

      bool _mapContainsTheError = TextChecker.stringContainsSubString(
        string: result,
        subString: map['error'],
        multiLine: false,
        caseSensitive: true,
      );

      if (_mapContainsTheError == true){
        _errorReply = map['reply'];
        break;
      }

      else {
        _errorReply = 'Sorry, Something went wrong, please try again.';
      }

    }

    // [firebase_auth/user-not-found]
    // [firebase_auth/user-not-found]

    print('_errorReply : $_errorReply');

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Could not continue !',
      body: _errorReply,
      boolDialog: false,
    );

  }
// -----------------------------------------------------------------------------
  static Future<bool> bzzDeactivationDialog({
    BuildContext context,
    List<BzModel> bzzToDeactivate,
    List<BzModel> bzzToKeep,
  }) async {

    final bool _bzzReviewResult = await CenterDialog.showCenterDialog(
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
                bzzModels: bzzToDeactivate,
                onTap: (value){print(value);},
                numberOfColumns: 6,
                numberOfRows: 1,
                scrollDirection: Axis.horizontal,
                title: 'These Accounts will be deactivated',
              ),

            if (bzzToKeep.length != 0)
              BzzBubble(
                bzzModels: bzzToKeep,
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
  static Future<bool> flyersDeactivationDialog({
    BuildContext context,
    List<BzModel> bzzToDeactivate,
    @required List<FlyerModel> flyers,
  }) async {

    final int _totalNumOfFlyers = FlyerModel.getNumberOfFlyersFromBzzModels(bzzToDeactivate);
    final int _numberOfBzz = bzzToDeactivate.length;

    final bool _flyersReviewResult = await CenterDialog.showCenterDialog(
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
                    flyers: flyers,
                    flyerSizeFactor: 0.2,
                    numberOfColumns: 2,
                    title: 'flyers of ${bzzToDeactivate[index].name}',
                    numberOfRows: 1,
                    bubbleWidth: CenterDialog.dialogWidth(context: context) - (Ratioz.appBarMargin * 4),
                    onTap: (value){
                      print(value);
                    },
                  );
              },



            ),
          ),

          const SuperVerse(
            verse: 'Would you like to continue ?',
            margin: 10,
          ),

        ],
      ),
    );


    return _flyersReviewResult;
  }// -----------------------------------------------------------------------------

}