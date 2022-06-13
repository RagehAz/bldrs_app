// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/b_views/y_views/g_user/b_0_user_screen_view_pages.dart';
// import 'package:bldrs/b_views/z_components/tab_bars/user_screen_tab_bar.dart';
// import 'package:bldrs/d_providers/ui_provider.dart';
// import 'package:bldrs/d_providers/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class UserScreenView extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const UserScreenView({
//     @required this.tabController,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final TabController tabController;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return NestedScrollView(
//       physics: const BouncingScrollPhysics(),
//       floatHeaderSlivers: true,
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
//
//         return <Widget>[
//
//           /// USER SCREEN SLIVER TABS
//           Consumer<UiProvider>(
//             builder: (BuildContext ctx, UiProvider uiProvider, Widget child) {
//
//               final UserTab _currentUserTab = uiProvider.currentUserTab;
//
//               return UserScreenTabBar(
//                 tabController: tabController,
//                 currentUserTab: _currentUserTab,
//               );
//
//             },
//           ),
//
//         ];
//
//       },
//
//       /// MY BZ SCREEN PAGES
//       body: Consumer<UsersProvider>(
//         builder: (_, UsersProvider usersProvider, Widget child){
//
//           final UserModel _myUserModel = usersProvider.myUserModel;
//
//           return
//
//               UserScreenViewPages(
//                 tabController: tabController,
//                 userModel: _myUserModel,
//               );
//
//         },
//       ),
//
//     );
//
//   }
// }
