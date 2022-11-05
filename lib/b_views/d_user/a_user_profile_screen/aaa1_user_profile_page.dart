import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/layouts/pull_to_refresh.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      onRefresh: () async {

        final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

        final UserModel _userModel = await UserProtocols.refetchUser(
            context: context,
            userID: _usersProvider.myUserModel.id,
        );

        _usersProvider.setMyUserModelAndAuthModel(
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
