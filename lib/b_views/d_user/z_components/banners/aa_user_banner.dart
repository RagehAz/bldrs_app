import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/user_settings_page_controllers.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/bz_buttons/bz_tile_button.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class UserBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserBanner({
    required this.userModel,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel? userModel;
  final double? width;
  /// --------------------------------------------------------------------------
  static Verse generateTitleCompanyString({
    required UserModel? userModel,
  }){

    String? _string;

    final String? _title = userModel?.title;
    final String? _company = userModel?.company;

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
      _string = '$_title ${getWord('phid_at')} $_company';
    }
    else {
      _string = null;
    }

    return Verse(
      id: _string,
      translate: false,
    );

  }
  // --------------------
  static bool canShowTitleCompanyLine({
    required UserModel? userModel,
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
  static String? getBzzString({
    required UserModel? userModel,
  }){

    // userModel.blogUserModel();

    if (UserModel.checkUserIsAuthor(userModel) == true){
      return Stringer.generateStringFromStrings(
          strings: userModel!.myBzzIDs,
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
    final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
      userModel: userModel,
    );
    final String _userName = userModel?.name ?? getWord('phid_unknown_bldr');
    // --------------------
    final Function? _onTap = _thereAreMissingFields == false ?
    null : () => onEditProfileTap(
      initialTab: UserEditorTab.pic,
    );
    // --------------------
    final bool _itIsMe = UserModel.checkItIsMe(userModel?.id);

    final bool _userIsAuthor = UserModel.checkUserIsAuthor(userModel);

    final double _bubbleWidth = Bubble.bubbleWidth(
      context: context,
      bubbleWidthOverride: width,
    );

    final double _clearWidth = Bubble.clearWidth(
      context: context,
      bubbleWidthOverride: width,
    );

    // --------------------
    return Bubble(
      width: _bubbleWidth,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
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
        BldrsText(
          verse: Verse(
            id: _userName,
            translate: false,
          ),
          width: _clearWidth,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.white10,
          // onTap: _onTap,
        ),

        /// USER JOB TITLE
        if (canShowTitleCompanyLine(userModel: userModel) == true)
          BldrsText(
            width: _clearWidth,
            italic: true,
            weight: VerseWeight.thin,
            verse: generateTitleCompanyString(
              userModel: userModel,
            ),
          ),

        /// USER LOCALE
        ZoneLine(
          width: _clearWidth,
          zoneModel: userModel?.zone,
          // centered: true,
        ),

        /// JOINED AT
        BldrsText(
          width: _clearWidth,
          verse: Verse(
            id: BldrsTimers.generateString_in_bldrs_since_month_yyyy(userModel?.createdAt),
            translate: false,
          ),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey255,
        ),

        /// SEPARATOR
        if (_userIsAuthor == true)
        SeparatorLine(
          width: _clearWidth * 0.5,
          withMargins: true,
        ),

        /// AUTHOR IN STRING
        if (_userIsAuthor == true)
          BldrsText(
            width: _clearWidth,
            verse: const Verse(
              id: 'phid_author_in',
              translate: true,
            ),
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.grey255,
            margin: const EdgeInsets.only(bottom: 10),
          ),

        /// MY BZZ
        if (_userIsAuthor == true)
        FutureBuilder(
          future: BzProtocols.fetchBzz(bzzIDs: userModel?.myBzzIDs),
          builder: (_, AsyncSnapshot snap){

            final List<BzModel>? _bzzModels = snap.data;

            return Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 5,
              spacing: 5,
              children: <Widget>[

                if (Mapper.checkCanLoopList(_bzzModels) == true)
                ...List.generate(_bzzModels!.length, (index){

                  final BzModel _bzModel = _bzzModels[index];

                  return BzTileButton(
                    bzModel: _bzModel,
                    height: 50,
                    width: (_bzModel.name?.length ?? 0) > 20 ?
                    _clearWidth - 20
                        :
                    null,
                    onTap: () => BldrsNav.jumpToBzPreviewScreen(
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
