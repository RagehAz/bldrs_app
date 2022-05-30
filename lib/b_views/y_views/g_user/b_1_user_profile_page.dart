import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/zone_line.dart';
import 'package:bldrs/b_views/z_components/user_profile/contacts_bubble.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfilePage({
    @required this.userModel,
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
  bool _canShowTitleCompanyLine(){
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
  String _getBzzString(){

    userModel.blogUserModel();

    if (UserModel.userIsAuthor(userModel) == true){
      return generateStringFromStrings(
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

    final String _userName = userModel?.name ?? superPhrase(context, 'phid_unknown_bldr');

    final bool _thereAreMissingFields = UserModel.thereAreMissingFields(userModel);

    return Column(
      children: <Widget>[

        const SizedBox(
          width: 20,
          height: 20,
        ),

        /// USER PIC
        UserBalloon(
          size: 80,
          userStatus: userModel?.status,
          userModel: userModel,
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
        if (_canShowTitleCompanyLine() == true)
        SuperVerse(
          italic: true,
          weight: VerseWeight.thin,
          verse: generateTitleCompanyString(
              userModel: userModel,
              context: context,
          ),
        ),

        /// USER LOCALE
        ZoneLine(
          zoneModel: userModel?.zone,
        ),

        /// JOINED AT
        SuperVerse(
          verse: Timers.getString_in_bldrs_since_month_yyyy(context, userModel?.createdAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey255,
        ),

        if (UserModel.userIsAuthor(userModel) == true)
          SuperVerse(
            verse: 'Author in ${_getBzzString()}',
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.grey255,
          ),

        /// CONTACTS
        if (showContacts == true)
        ContactsBubble(
          contacts: userModel?.contacts,
          location: userModel?.location,
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
