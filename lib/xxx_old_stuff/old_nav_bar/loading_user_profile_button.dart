// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/components/nav_bar_button.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/nav_bar_methods.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/d_providers/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
//
// class LoadingUserProfileButton extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const LoadingUserProfileButton({
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final UserModel _userModel = UsersProvider.proGetMyUserModel(context, listen: true);
//
//     return NavBarButton(
//         size: NavBar.navBarButtonWidth,
//         text: superPhrase(context, 'phid_profile'),
//         icon: Iconz.normalUser,
//         iconSizeFactor: 0.7,
//         barType: NavBar.barType,
//         clipperWidget: UserBalloon(
//           size: NavBar.circleWidth,
//           loading: false,
//           userModel: _userModel,
//         )
//     );
//
//   }
// }
