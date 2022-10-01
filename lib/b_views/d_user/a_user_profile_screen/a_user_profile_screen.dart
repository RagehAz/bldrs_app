import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/aa_user_screen_view_pages.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/user_fire_ops.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfileScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final UserModel _user = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    _user?.blogUserModel(methodName: 'UserProfileScreen');
    // --------------------
    return ObeliskLayout(
      initiallyExpanded: true,
      canGoBack: true,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain('Reload'),
          onTap: () async {

            unawaited(WaitDialog.showWaitDialog(
              context: context,
              loadingVerse: Verse.plain('Re-loading your profile'),
              canManuallyGoBack: true,
            ));

            final UserModel _fireUserModel = await UserFireOps.readUser(
              context: context,
              userID: AuthFireOps.superUserID(),
            );

            _fireUserModel.blogUserModel();

            await UserProtocols.updateLocally(
              context: context,
              newUserModel: _fireUserModel,
            );

            await WaitDialog.closeWaitDialog(context);

          },
        ),

      ],
      navModels: <NavModel>[

        ...List.generate(UserModel.userProfileTabsList.length, (index){

          final UserTab _userTab = UserModel.userProfileTabsList[index];

          return NavModel(
            id: NavModel.getUserTabNavID(_userTab),
            titleVerse: UserModel.translateUserTab(context: context, userTab: _userTab),
            icon: UserModel.getUserTabIcon(_userTab),
            screen: UserScreenViewPages.pages[index],
          );

        }),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
