import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/aa_user_banner.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/aa_user_needs_banner.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contacts_bubble.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';

class UserProfileBanners extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfileBanners({
    this.userModel,
    this.showContacts = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final bool showContacts;
  /// --------------------------------------------------------------------------
  static String generateTitleCompanyString({
    required UserModel userModel,
    required BuildContext context,
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
      _string = '$_title ${xPhrase('phid_at')} $_company';
    }
    else {
      _string = null;
    }

    return _string;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = userModel ?? UsersProvider.proGetMyUserModel(
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

        /// USER NEEDS BANNER
        UserNeedsBanner(
          userModel: _userModel,
          editorMode: _editorMode,
        ),

        /// CONTACTS
        if (showContacts == true)
          ContactsBubble(
            contacts: _userModel?.contacts,
            location: _userModel?.location,
            canLaunchOnTap: true,
          ),

      ],
    );
  }
// -----------------------------------------------------------------------------
}
