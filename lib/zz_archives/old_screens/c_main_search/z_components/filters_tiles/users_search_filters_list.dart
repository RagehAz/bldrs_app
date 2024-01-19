import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/m_search/user_search_model.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/z_components/building_blocks/filter_bool_tile.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/z_components/building_blocks/filter_multi_button_tile.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/z_components/building_blocks/filters_box.dart';
import 'package:bldrs/zz_archives/old_screens/c_main_search/z_components/filters_tiles/zone_filter_tile.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class UserSearchFiltersList extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const UserSearchFiltersList({
    required this.userSearchModel,
    required this.onZoneSwitchTap,
    required this.onZoneTap,
    required this.onUserSearchTypeSwitchTap,
    required this.onUserSearchTypeTap,
    required this.onSignInMethodSwitchTap,
    required this.onSignInMethodTap,
    required this.onGenderSwitchTap,
    required this.onGenderTap,
    required this.onLangSwitchTap,
    required this.onLangTap,
    required this.onOnlyPublicContactsSwitchTap,
    required this.onOnlyAuthorsSwitchTap,
    required this.onOnlyAdminsSwitchTap,
    required this.onOnlyVerifiedEmailsSwitchTap,
    required this.onOnlyCanReceiveNotification,
    super.key
  });
  // --------------------
  final UserSearchModel? userSearchModel;
  final Function(bool value) onZoneSwitchTap;
  final Function onZoneTap;
  final Function(bool value) onUserSearchTypeSwitchTap;
  final Function(UserSearchType userSearchType) onUserSearchTypeTap;
  final Function(bool value) onSignInMethodSwitchTap;
  final Function(SignInMethod) onSignInMethodTap;
  final Function(bool value) onGenderSwitchTap;
  final Function(Gender gender) onGenderTap;
  final Function(bool value) onLangSwitchTap;
  final Function(String lang) onLangTap;
  final Function(bool value) onOnlyPublicContactsSwitchTap;
  final Function(bool value) onOnlyAuthorsSwitchTap;
  final Function(bool value) onOnlyAdminsSwitchTap;
  final Function(bool value) onOnlyVerifiedEmailsSwitchTap;
  final Function(bool value) onOnlyCanReceiveNotification;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SearchFilterBox(
      children: <Widget>[

      /// ZONE
      ZoneFilterTile(
        zone: userSearchModel?.zone,
        onSwitchTap: onZoneSwitchTap,
        onTileTap: onZoneTap,
      ),

      /// USER SEARCH TYPE
      FilterMultiButtonTile(
        icon: Iconz.search,
        verse: const Verse(
          id: 'phid_search_method',
          translate: true,
        ),
        switchValue: userSearchModel?.searchType != null,
        onSwitchTap: onUserSearchTypeSwitchTap,
        items: UserSearchModel.userSearchTypes,
        selectedItem: userSearchModel?.searchType,
        itemVerse: (dynamic type) => Verse.plain(TextMod.removeTextBeforeFirstSpecialCharacter(
            text: type.toString(),
            specialCharacter: '.'),
        ),
        onItemTap: (dynamic type) {

          final UserSearchType _type = type;
          onUserSearchTypeTap(_type);

          },
      ),

      /// SIGN IN METHOD
      FilterMultiButtonTile(
        icon: Iconz.comGooglePlay,
        verse: const Verse(
          id: 'phid_sign_in_method',
          translate: true,
        ),
        switchValue: userSearchModel?.signInMethod != null,
        onSwitchTap: onSignInMethodSwitchTap,
        items: AuthModel.signInMethodsList,
        selectedItem: userSearchModel?.signInMethod,
        itemVerse: (dynamic method) => Verse.plain(AuthModel.cipherSignInMethod(method)),
        onItemTap: (dynamic method) {
          final SignInMethod _method = method;
          onSignInMethodTap(_method);
          },
      ),

      /// GENDER
      FilterMultiButtonTile(
        icon: Iconz.female,
        verse: const Verse(id: 'phid_gender', translate: true,),
        switchValue: userSearchModel?.gender != null,
        onSwitchTap: onGenderSwitchTap,
        items: UserModel.gendersList,
        selectedItem: userSearchModel?.gender,
        itemVerse: (dynamic gender) => Verse(id: UserModel.getGenderPhid(gender), translate: true),
        onItemTap: (dynamic gender) {
          final Gender _gender = gender;
          onGenderTap(_gender);
          },
      ),

      /// LANGUAGE
      FilterMultiButtonTile(
        icon: Iconz.language,
        verse: const Verse(id: 'phid_language', translate: true,),
        switchValue: userSearchModel?.language != null,
        onSwitchTap: onLangSwitchTap,
        items: Localizer.supportedLangCodes,
        selectedItem: userSearchModel?.language,
        itemVerse: (dynamic lang) => Verse(id: lang, translate: false),
        onItemTap: (dynamic lang) {
          final String _lang = lang;
          onLangTap(_lang);
          },
      ),

      /// ONLY USERS WITH PUBLIC CONTACTS
      FilterBoolTile(
        icon: Iconz.comWebsite,
        verse: Verse.plain('Only users with public contacts'),
        iconIsBig: false,
        switchValue: userSearchModel?.onlyWithPublicContacts,
        onSwitchTap: onOnlyPublicContactsSwitchTap,
      ),

      /// ONLY BZ AUTHORS
      FilterBoolTile(
        icon: Iconz.bz,
        verse: Verse.plain('Only Business Authors'),
        iconIsBig: false,
        switchValue: userSearchModel?.onlyBzAuthors,
        onSwitchTap: onOnlyAuthorsSwitchTap,
      ),

      /// ONLY CAN RECEIVE NOTIFICATION
      FilterBoolTile(
        icon: Iconz.notification,
        verse: Verse.plain('Only Can Receive Notification'),
        iconIsBig: false,
        switchValue: userSearchModel?.onlyCanReceiveNotification,
        onSwitchTap: onOnlyCanReceiveNotification,
      ),

      /// ONLY BLDRS ADMIN
      FilterBoolTile(
        icon: Iconz.viewsIcon,
        verse: Verse.plain('Only Bldrs Admins'),
        iconIsBig: false,
        switchValue: userSearchModel?.onlyBldrsAdmins,
        onSwitchTap: onOnlyAdminsSwitchTap,
      ),

      /// ONLY USERS WITH VERIFIED EMAILS
      FilterBoolTile(
        icon: Iconz.check,
        verse: Verse.plain('Only Users with verified emails'),
        iconIsBig: false,
        switchValue: userSearchModel?.onlyVerifiedEmails,
        onSwitchTap: onOnlyVerifiedEmailsSwitchTap,
      ),

    ],
    );
  }
  // -----------------------------------------------------------------------------
}
