import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/e_my_settings_page/user_settings_page_controllers.dart';
import 'package:bldrs/b_screens/c_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/z_components/bubbles/b_variants/user_bubbles/aa_user_banner.dart';
import 'package:bldrs/z_components/bubbles/b_variants/user_bubbles/aa_user_counters_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contacts_bubble.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class UserProfileBanners extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfileBanners({
    this.userModel,
    this.showContacts = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel? userModel;
  final bool showContacts;
  /// --------------------------------------------------------------------------
  static String? generateTitleCompanyString({
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

    return _string;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel? _userModel = userModel ?? UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    final bool _editorMode = userModel == null;

    return Column(
      children: <Widget>[

        // const Padding(
        //   padding: EdgeInsets.only(bottom: 10),
        //   child: GoogleAdRectangleBanner(),
        // ),

        UserBanner(
          userModel: _userModel,
        ),

        /// USER_NEEDS_BANNER
        // UserNeedsBanner(
        //   userModel: _userModel,
        //   editorMode: _editorMode,
        // ),

        /// USER COUNTERS BUBBLE
        UserCounterBubble(
          userModel: _userModel,
        ),

        /// CONTACTS
        if (showContacts == true)
          ContactsBubble(
            contacts: _userModel?.contacts,
            location: _userModel?.location,
            canLaunchOnTap: true,
            showMoreButton: _editorMode,
            showBulletPoints: true,
            contactsArePublic: _userModel?.contactsArePublic ?? false,
            onMoreTap: () => onEditProfileTap(
              initialTab: UserEditorTab.contacts,
            ),
          ),

      ],
    );
  }
// -----------------------------------------------------------------------------
}
