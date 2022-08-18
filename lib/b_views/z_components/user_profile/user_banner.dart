import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/zone_line.dart';
import 'package:bldrs/c_controllers/d_user_controllers/a_user_profile/a5_user_settings_controllers.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserBanner({
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
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
      _string = '$_title ${xPhrase(context, 'phid_at')} $_company';
    }
    else {
      _string = null;
    }

    return _string;
  }
  // -----------------------------------------------------------------------------
  static bool canShowTitleCompanyLine({
    @required UserModel userModel,
  }){
    bool _can = false;

    if (
    Stringer.checkStringIsNotEmpty(userModel?.title) == true
        ||
        Stringer.checkStringIsNotEmpty(userModel?.company) == true
    ){
      _can = true;
    }

    return _can;
  }
// -----------------------------------------------------------------------------
  static String getBzzString({
    @required UserModel userModel,
  }){

    userModel.blogUserModel();

    if (UserModel.checkUserIsAuthor(userModel) == true){
      return Stringer.generateStringFromStrings(
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

    final bool _thereAreMissingFields = UserModel.checkMissingFields(userModel);
    final String _userName = userModel?.name ?? xPhrase(context, 'phid_unknown_bldr');

    final Function _onTap = _thereAreMissingFields == false ?
    null : () => onEditProfileTap(context);

    final bool _itIsMe = userModel?.id == AuthFireOps.superUserID();

    return Bubble(
      centered: true,
      onBubbleTap: _onTap,
      columnChildren: <Widget>[

        /// PADDING
        const SizedBox(
          width: 20,
          height: 20,
        ),

        /// USER PIC
        Center(
          child: UserBalloon(
            size: 80,
            userStatus: userModel?.status,
            userModel: userModel,
            loading: false,
            showEditButton: _thereAreMissingFields && _itIsMe,
            onTap: _onTap,
          ),
        ),

        /// USER NAME
        SuperVerse(
          verse: _userName,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.white10,
          // onTap: _onTap,
        ),

        /// USER JOB TITLE
        if (canShowTitleCompanyLine(userModel: userModel) == true)
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
          verse: Timers.generateString_in_bldrs_since_month_yyyy(context, userModel?.createdAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey255,
        ),

        /// AUTHORSHIP LINE
        if (UserModel.checkUserIsAuthor(userModel) == true)
          SuperVerse(
            verse: 'Author in ${getBzzString(userModel: userModel)}',
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.grey255,
          ),

        /// PADDING
        const SizedBox(
          width: 20,
          height: 20,
        ),

      ],
    );

  }
}
