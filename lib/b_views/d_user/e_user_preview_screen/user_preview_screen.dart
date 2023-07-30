// ignore_for_file: unused_element
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

class UserPreviewScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserPreviewScreen({
    required this.userModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel? userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final bool _userIsNotFound = userModel == null || userModel?.id == null;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      child: _userIsNotFound == true ?
      const _NoUserFoundView()
          :
      _UserProfileView(userModel: userModel!),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class _NoUserFoundView extends StatelessWidget {

  const _NoUserFoundView({
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return const Stack(
      alignment: Alignment.center,
      children: <Widget>[

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
    required this.userModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return PullToRefresh(
        circleColor: Colorz.yellow255,
        onRefresh: () async {

          final UserModel? _userModel = await UserProtocols.refetch(userID: userModel.id);

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
