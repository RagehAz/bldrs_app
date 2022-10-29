import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

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
      layoutWidget: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        child: UserProfileBanners(
          userModel: userModel,
          showContacts: userModel.contactsArePublic ?? true,
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
