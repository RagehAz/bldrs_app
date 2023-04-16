import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class UserProfilePage extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const UserProfilePage({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return PullToRefresh(
      fadeOnBuild: true,
      circleColor: Colorz.yellow255,
      onRefresh: () async {

        final UserModel _userModel = await UserProtocols.refetch(
            context: context,
            userID: OfficialAuthing.getUserID(),
        );

        UsersProvider.proSetMyUserModel(
          context: context,
          userModel: _userModel,
          notify: true,
        );

      },
      child: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        child: UserProfileBanners(
            showContacts: true
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
