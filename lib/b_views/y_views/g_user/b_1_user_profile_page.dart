import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/zone_line.dart';
import 'package:bldrs/b_views/z_components/user_profile/contacts_bubble.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfilePage({
    this.userModel,
    this.showContacts = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final bool showContacts;
  /// --------------------------------------------------------------------------
  static String generateTitleCompanyString({
    @required UserModel userModel,
    @required BuildContext context,
  }){

    String _string;

    final String _title = userModel?.title;
    final String _company = userModel.company;

    if (_title == null && _company == null){
      _string = null;
    }
    else if (_title == null && _company != null){
      _string = _company;
    }
    else if (_title != null && _company == null){
      _string = _title;
    }
    else if (_title != null && _company != null){
      _string = '$_title ${superPhrase(context, 'phid_at')} $_company';
    }
    else {
      _string = null;
    }

    return _string;
  }
// -----------------------------------------------------------------------------
  static bool _canShowTitleCompanyLine({
    @required UserModel userModel,
  }){
    bool _can = false;

    if (
    stringIsNotEmpty(userModel?.title) == true
        ||
    stringIsNotEmpty(userModel?.company) == true
    ){
    _can = true;
    }

    return _can;
  }
// -----------------------------------------------------------------------------
  static String _getBzzString({
    @required UserModel userModel,
  }){

    userModel.blogUserModel();

    if (UserModel.checkUserIsAuthor(userModel) == true){
      return TextGen.generateStringFromStrings(
        strings: userModel.myBzzIDs,
        stringsSeparator: ','
      );

    }
    else {
      return null;
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = userModel ?? UsersProvider.proGetMyUserModel(context, listen: true);
    final String _userName = _userModel?.name ?? superPhrase(context, 'phid_unknown_bldr');

    final bool _thereAreMissingFields = UserModel.checkMissingFields(_userModel);

    return Column(
      children: <Widget>[

        const SizedBox(
          width: 20,
          height: 20,
        ),

        /// USER PIC
        UserBalloon(
          size: 80,
          userStatus: _userModel?.status,
          userModel: _userModel,
          loading: false,
          showEditButton: _thereAreMissingFields,
          onTap: _thereAreMissingFields == false ? null
              :
          () => onEditProfileTap(context),
        ),

        /// USER NAME
        SuperVerse(
          verse: _userName,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.white10,
        ),

        /// USER JOB TITLE
        if (_canShowTitleCompanyLine(userModel: _userModel) == true)
        SuperVerse(
          italic: true,
          weight: VerseWeight.thin,
          verse: generateTitleCompanyString(
              userModel: _userModel,
              context: context,
          ),
        ),

        /// USER LOCALE
        ZoneLine(
          zoneModel: _userModel?.zone,
        ),

        /// JOINED AT
        SuperVerse(
          verse: Timers.generateString_in_bldrs_since_month_yyyy(context, _userModel?.createdAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey255,
        ),

        if (UserModel.checkUserIsAuthor(_userModel) == true)
          SuperVerse(
            verse: 'Author in ${_getBzzString(userModel: _userModel)}',
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.grey255,
          ),

        /// CONTACTS
        if (showContacts == true)
        ContactsBubble(
          contacts: _userModel?.contacts,
          location: _userModel?.location,
          canLaunchOnTap: true,
        ),

        /// BOTTOM PADDING
        const SizedBox(
          height: 30,
        ),

      ],
    );
  }
}
