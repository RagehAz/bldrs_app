import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/x4_user_settings_page_controllers.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/bz_tile_button.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
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
    final bool _itIsMe = UserModel.checkItIsMe(userModel?.id);

    final bool _userIsAuthor = UserModel.checkUserIsAuthor(userModel);
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
          // centered: true,
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

        /// SEPARATOR
        if (_userIsAuthor == true)
        SeparatorLine(
          width: Bubble.clearWidth(context) * 0.5,
          withMargins: true,
        ),

        /// AUTHOR IN STRING
        if (_userIsAuthor == true)
          const SuperVerse(
            verse: Verse(
              text: 'phid_author_in',
              translate: true,
            ),
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.grey255,
            margin: EdgeInsets.only(bottom: 10),
          ),

        /// MY BZZ
        if (_userIsAuthor == true)
        FutureBuilder(
          future: BzProtocols.fetchBzz(context: context, bzzIDs: userModel?.myBzzIDs),
          builder: (_, AsyncSnapshot snap){

            final List<BzModel> _bzzModels = snap.data;

            return Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 5,
              spacing: 5,
              children: <Widget>[

                if (Mapper.checkCanLoopList(_bzzModels) == true)
                ...List.generate(_bzzModels.length, (index){

                  final BzModel _bzModel = _bzzModels[index];

                  return BzTileButton(
                    bzModel: _bzModel,
                    height: 50,
                    onTap: () => Nav.jumpToBzPreviewScreen(
                        context: context,
                        bzID: _bzModel.id,
                    ),
                  );

                }),

              ],
            );

            },
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
