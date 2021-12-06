import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
  Future<void> maxSlidesReached(BuildContext context, int maxLength) async {
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Max. Images reached',
      body: 'Can not add more than $maxLength images in one slide',
    );
  }
// -----------------------------------------------------------------------------
  Future<void> authErrorDialog({BuildContext context, dynamic result}) async {

    final List<Map<String, dynamic>> _errors = <Map<String, dynamic>>[
      /// SIGN IN ERROR
      <String, dynamic>{
        'error' : '[firebase_auth/user-not-found]',// There is no user record corresponding to this identifier. The user may have been deleted.',
        'reply' : Wordz.emailNotFound(context),
      },
      <String, dynamic>{
        'error' : '[firebase_auth/network-request-failed]',// A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
        'reply' : 'No Internet connection available',
      },
      <String, dynamic>{
        'error' : '[firebase_auth/invalid-email]',// The email address is badly formatted.',
        'reply' : Wordz.emailWrong(context),
      },
      <String, dynamic>{
        'error' : '[firebase_auth/wrong-password]',// The password is invalid or the user does not have a password.',
        'reply' : Wordz.wrongPassword(context), /// TASK : should link accounts authentication
      },
      <String, dynamic>{
        'error' : '[firebase_auth/too-many-requests]',// We have blocked all requests from this device due to unusual activity. Try again later.',
        'reply' : 'Too many failed sign in attempts.\nThis device is put on hold for some time to secure the account', /// TASK : should link accounts authentication and delete this dialog
      },
      <String, dynamic>{
        'error' : 'PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)',
        'reply' : 'Sorry, Could not sign in by google.',
      },
      /// REGISTER ERRORS
      <String, dynamic>{
        'error' : '[firebase_auth/email-already-in-use]',// The email address is already in use by another account.',
        'reply' : Wordz.emailAlreadyRegistered(context),
      },
      <String, dynamic>{
        'error' : '[firebase_auth/invalid-email]',// The email address is badly formatted.',
        'reply' : Wordz.emailWrong(context),
      },
      /// SHARED ERRORS
      <String, dynamic>{
        'error' : null,
        'reply' : Wordz.somethingIsWrong(context),
      },
    ];

    // print('authErrorDialog result : $result');

    String _errorReply;

    for (final Map<String, dynamic> map in _errors){

      final bool _mapContainsTheError = TextChecker.stringContainsSubString(
        string: result,
        subString: map['error'],
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
    );

  }
// -----------------------------------------------------------------------------
  Future<bool> bzzDeactivationDialog({
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
                onTap: (String value){print(value);},
                numberOfColumns: 6,
                numberOfRows: 1,
                title: 'These Accounts will be deactivated',
              ),

            if (bzzToKeep.length != 0)
              BzzBubble(
                bzzModels: bzzToKeep,
                onTap: (String value){print(value);},
                numberOfColumns: 6,
                numberOfRows: 1,
                title: 'Can not deactivate these businesses',
              ),

            const SuperVerse(
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
    @required BuildContext context,
    @required List<FlyerModel> flyers,
    List<BzModel> bzzToDeactivate,
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
              itemExtent: 200,
              itemBuilder: (BuildContext context, int index){

                return
                  FlyersBubble(
                    flyers: flyers,
                    flyerSizeFactor: 0.2,
                    numberOfColumns: 2,
                    title: 'flyers of ${bzzToDeactivate[index].name}',
                    numberOfRows: 1,
                    bubbleWidth: CenterDialog.dialogWidth(context: context) - (Ratioz.appBarMargin * 4),
                    onTap: (String value){
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
  }
// -----------------------------------------------------------------------------
  Future<CityModel> confirmCityDialog({
    @required BuildContext context,
    @required List<CityModel> cities,
}) async {

    CityModel _city;

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 50,
      buttons: <Widget>[

        const SuperVerse(
          verse: 'Please confirm your city',
        ),

        ...List<Widget>.generate(cities.length,
                (int index){

              final CityModel _foundCity = cities[index];
              final String _foundCityName = Name.getNameByCurrentLingoFromNames(context, _foundCity.names);

              return
                BottomDialog.wideButton(
                    context: context,
                    verse: _foundCityName,
                    icon: Flag.getFlagIconByCountryID(_foundCity.countryID),
                    onTap: (){

                      print('city selected aho ${_foundCityName}');

                      _city = _foundCity;
                      Nav.goBack(context);
                      // await null;

                    }
                );

            }

        ),

      ],
    );

    return _city;
}
// -----------------------------------------------------------------------------
