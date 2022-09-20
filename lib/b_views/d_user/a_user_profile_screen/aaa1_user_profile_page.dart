import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const UserProfilePage({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      child: UserProfileBanners(
          showContacts: true
      ),
    );

  }
// -----------------------------------------------------------------------------
}
