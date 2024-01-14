import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_initialization_controllers.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const UserProfilePage({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return PullToRefresh(
      fadeOnBuild: true,
      circleColor: Colorz.yellow255,
      onRefresh: () async {

        final UserModel? _userModel = await UserProtocols.refetch(
            userID: Authing.getUserID(),
        );

        if (_userModel != null){

          UsersProvider.proSetMyUserModel(
            userModel: _userModel,
            notify: true,
          );

          await initializeUserBzz(
            notify: true,
          );

        }


      },
      child: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        child: UserProfileBanners(
            showContacts: true,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
