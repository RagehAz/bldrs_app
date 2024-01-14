// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/z_components/buttons/flyer_type_button.dart';
// import 'package:bldrs/z_components/tab_bars/bldrs_sliver_tab_bar.dart';
// import 'package:bldrs/c_controllers/g_user_controllers/x1_user_profile_page_controllers.dart';
// import 'package:flutter/material.dart';
//
//
// class UserScreenTabBar extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const UserScreenTabBar({
//     required this.tabController,
//     required this.currentUserTab,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final TabController tabController;
//   final UserTab currentUserTab;
//   /// --------------------------------------------------------------------------
//   bool _isSelected({
//     required BuildContext context,
//     required UserTab userTab,
//   }){
//
//     bool _isSelected = false;
//
//     if (currentUserTab == userTab){
//       _isSelected = true;
//     }
//
//     return _isSelected;
//   }
// // -----------------------------------------------------------------------------
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return BldrsSliverTabBar(
//       tabController: tabController,
//       tabs: <Widget>[
//
//         /// IT HAS TO BE LIST.GENERATE ma3lesh
//         ...List.generate(UserModel.userProfileTabsList.length, (index){
//
//           final UserTab _userTab = UserModel.userProfileTabsList[index];
//           final String _userTabString = UserModel.translateUserTab(
//             context: context,
//             userTab: _userTab,
//           );
//
//           return
//
//             FlyerTypeButton(
//               key: ValueKey<String>('user_tab_button_$_userTabString'),
//               verse: _userTabString,
//               icon: UserModel.getUserTabIcon(_userTab),
//               isSelected: _isSelected(
//                 context: context,
//                 userTab: _userTab,
//               ),
//               onTap: () => onChangeUserScreenTabIndex(
//                 context: context,
//                 tabController: tabController,
//                 index: index,
//               ),
//             );
//
//         }
//         ),
//       ],
//     );
//   }
// }
