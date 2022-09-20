import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x5_user_settings_page_controllers.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
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
  static Verse generateTitleCompanyString({
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
      _string = '$_title ${xPhrase( context, 'phid_at')} $_company';
    }
    else {
      _string = null;
    }

    return Verse(
      text: _string,
      translate: false,
    );

  }
  // --------------------
  static bool canShowTitleCompanyLine({
    @required UserModel userModel,
  }){
    bool _can = false;

    if (
    TextCheck.isEmpty(userModel?.title) == false
        ||
        TextCheck.isEmpty(userModel?.company) == false
    ){
      _can = true;
    }

    return _can;
  }
  // --------------------
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
    // --------------------
    final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(userModel);
    final String _userName = userModel?.name ?? 'phid_unknown_bldr';
    // --------------------
    final Function _onTap = _thereAreMissingFields == false ?
    null : () => onEditProfileTap(context);
    // --------------------
    final bool _itIsMe = userModel?.id == AuthFireOps.superUserID();
    // --------------------
    return Bubble(
      headerViewModel: const BubbleHeaderVM(),
      childrenCentered: true,
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
            userModel: userModel,
            loading: false,
            showEditButton: _thereAreMissingFields && _itIsMe,
            onTap: _onTap,
          ),
        ),

        /// USER NAME
        SuperVerse(
          verse: Verse(
            text: _userName,
            translate: false,
          ),
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
          verse: Verse(
            text: Timers.generateString_in_bldrs_since_month_yyyy(context, userModel?.createdAt),
            translate: false,
          ),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey255,
        ),

        /// AUTHORSHIP LINE
        if (UserModel.checkUserIsAuthor(userModel) == true)
          SuperVerse(
            verse: Verse(
              text: '##Author in ${getBzzString(userModel: userModel)}',
              translate: true,
              variables: getBzzString(userModel: userModel),
            ),
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
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
