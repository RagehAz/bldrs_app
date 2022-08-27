import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/editors/contacts_bubble.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_banner.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserProfileBanners extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfileBanners({
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
      _string = '$_title ${xPhrase( context, 'phid_at')} $_company';
    }
    else {
      _string = null;
    }

    return _string;
  }

  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = userModel ?? UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return Column(
      children: <Widget>[

        /// USER BANNER
        UserBanner(
          userModel: _userModel,
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
}
