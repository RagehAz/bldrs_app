import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/z_components/bubbles/b_variants/user_bubbles/a_user_profile_banners.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:fire/super_fire.dart';
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

        }

      },
      child: const SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: MirageModel.mirageInsets2,
        child: UserProfileBanners(
            showContacts: true,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
