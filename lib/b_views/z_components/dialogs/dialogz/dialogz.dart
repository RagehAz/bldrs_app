import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/bzz_bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/flyers_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
Future<void> authErrorDialog({BuildContext context, dynamic result}) async {

  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

  final List<Map<String, dynamic>> _errors = <Map<String, dynamic>>[
    /// SIGN IN ERROR
    <String, dynamic>{
      'error': '[firebase_auth/user-not-found]', // There is no user record corresponding to this identifier. The user may have been deleted.',
      'reply': superPhrase(context, 'phid_emailNotFound', providerOverride: _phraseProvider),
    },
    <String, dynamic>{
      'error': '[firebase_auth/network-request-failed]', // A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
      'reply': superPhrase(context, 'phid_no_internet_connection', providerOverride: _phraseProvider),
    },
    <String, dynamic>{
      'error':
      '[firebase_auth/invalid-email]', // The email address is badly formatted.',
      'reply': superPhrase(context, 'phid_emailWrong', providerOverride: _phraseProvider),
    },
    <String, dynamic>{
      'error': '[firebase_auth/wrong-password]', // The password is invalid or the user does not have a password.',
      'reply': superPhrase(context, 'phid_wrongPassword', providerOverride: _phraseProvider),

      /// TASK : should link accounts authentication
    },
    <String, dynamic>{
      'error': '[firebase_auth/too-many-requests]', // We have blocked all requests from this device due to unusual activity. Try again later.',
      'reply': superPhrase(context, 'phid_too_many_fails_error', providerOverride: _phraseProvider),

      /// TASK : should link accounts authentication and delete this dialog
    },
    <String, dynamic>{
      'error': 'PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)',
      'reply': superPhrase(context, 'phid_could_not_sign_by_google', providerOverride: _phraseProvider),
    },

    /// REGISTER ERRORS
    <String, dynamic>{
      'error': '[firebase_auth/email-already-in-use]', // The email address is already in use by another account.',
      'reply': superPhrase(context, 'phid_emailAlreadyRegistered', providerOverride: _phraseProvider),
    },
    <String, dynamic>{
      'error': '[firebase_auth/invalid-email]', // The email address is badly formatted.',
      'reply': superPhrase(context, 'phid_emailWrong', providerOverride: _phraseProvider),
    },

    /// SHARED ERRORS
    <String, dynamic>{
      'error': null,
      'reply': superPhrase(context, 'phid_somethingIsWrong', providerOverride: _phraseProvider),
    },
  ];

  // blog('authErrorDialog result : $result');

  String _errorReply;

  for (final Map<String, dynamic> map in _errors) {
    final bool _mapContainsTheError = TextChecker.stringContainsSubString(
      string: result,
      subString: map['error'],
    );

    if (_mapContainsTheError == true) {
      _errorReply = map['reply'];
      break;
    } else {
      _errorReply = superPhrase(context, 'phid_something_went_wrong_error', providerOverride: _phraseProvider);
    }
  }

  // [firebase_auth/user-not-found]
  // [firebase_auth/user-not-found]

  blog('_errorReply : $_errorReply');

  await CenterDialog.showCenterDialog(
    context: context,
    title: superPhrase(context, 'phid_a_could_not_continue_title', providerOverride: _phraseProvider),
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
    child: SizedBox(
      height: Scale.superScreenHeight(context) * 0.45,
      child: ListView(
        children: <Widget>[
          if (bzzToDeactivate.isNotEmpty)
            BzzBubble(
              bzzModels: bzzToDeactivate,
              onTap: (BzModel bzModel) {

                bzModel.blogBz(methodName: 'dialog bz Tapped ahowwan');

              },
              numberOfColumns: 6,
              numberOfRows: 1,
              title: 'These Accounts will be deactivated',
            ),
          if (bzzToKeep.isNotEmpty)
            BzzBubble(
              bzzModels: bzzToKeep,
              onTap: (BzModel bzModel) {
                bzModel.blogBz(methodName: 'Dialog 2 bzModel aho tapped');
              },
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
  final int _totalNumOfFlyers =
      FlyerModel.getNumberOfFlyersFromBzzModels(bzzToDeactivate);
  final int _numberOfBzz = bzzToDeactivate.length;

  final bool _flyersReviewResult = await CenterDialog.showCenterDialog(
    context: context,
    title: '',
    body:
        'You Have $_totalNumOfFlyers flyers that will be deactivated and can not be retrieved',
    boolDialog: true,
    height: Scale.superScreenHeight(context) * 0.9,
    child: Column(
      children: <Widget>[
        SizedBox(
          // width: superBubbleClearWidth(context),
          height: Scale.superScreenHeight(context) * 0.6,
          child: ListView.builder(
            itemCount: _numberOfBzz,
            itemExtent: 200,
            itemBuilder: (BuildContext context, int index) {
              return FlyersBubble(
                flyers: flyers,
                flyerSizeFactor: 0.2,
                numberOfColumns: 2,
                title: 'flyers of ${bzzToDeactivate[index].name}',
                numberOfRows: 1,
                bubbleWidth: CenterDialog.getWidth(context) - (Ratioz.appBarMargin * 4),
                onTap: (String value) {
                  blog(value);
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
    numberOfWidgets: cities.length + 1,
    builder: (BuildContext context, PhraseProvider _phraseProvider){

      return <Widget>[

        const SuperVerse(
          verse: 'Please confirm your city',
        ),

        ...List<Widget>.generate(cities.length, (int index) {

          final CityModel _foundCity = cities[index];
          final String _foundCityName = superPhrase(context, _foundCity.cityID);

          return BottomDialog.wideButton(
              context: context,
              verse: _foundCityName,
              icon: Flag.getFlagIconByCountryID(_foundCity.countryID),
              onTap: () {
                blog('city selected aho $_foundCityName');

                _city = _foundCity;
                Nav.goBack(context);
                // await null;
              });
        }),

      ];

    }
  );

  return _city;
}
// -----------------------------------------------------------------------------
