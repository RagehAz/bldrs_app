import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
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

    final bool _userIsNotFound = userModel == null || userModel.id == null;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      child: _userIsNotFound == true ?
      const _NoUserFoundView()
          :
      _UserProfileView(userModel: userModel),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class _NoUserFoundView extends StatelessWidget {
  const _NoUserFoundView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: const <Widget>[

        BldrsBox(
          height: 400,
          width: 400,
          icon: Iconz.normalUser,
          bubble: false,
          opacity: 0.04,
        ),

        BldrsText(
        verse: Verse(
          id: 'phid_user_not_found',
          translate: true,
        ),
        size: 3,
        maxLines: 2,
      ),

      ],
    );

  }

}

class _UserProfileView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _UserProfileView({
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return PullToRefresh(
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
      );
  }
  /// --------------------------------------------------------------------------
}
