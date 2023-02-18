import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:page_transition/page_transition.dart';

class UserPreviewScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserPreviewScreen({
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      child: PullToRefresh(
        circleColor: Colorz.yellow255,
        onRefresh: () async {

          final UserModel _userModel = await UserProtocols.refetch(
              context: context,
              userID: userModel.id,
          );

          final bool _identical = UserModel.usersAreIdentical(
              user1: userModel,
              user2: _userModel,
          );

          if (_identical == false){

            await Nav.replaceScreen(
                context: context,
                transitionType: PageTransitionType.fade,
                screen: UserPreviewScreen(
                  userModel: _userModel,
                ),
            );

          }

        },
        fadeOnBuild: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: Stratosphere.stratosphereSandwich,
          child: UserProfileBanners(
            userModel: userModel,
            showContacts: userModel.contactsArePublic ?? true,
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
