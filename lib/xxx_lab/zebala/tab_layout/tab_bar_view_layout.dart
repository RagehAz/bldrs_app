// import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
// import 'package:bldrs/xxx_lab/zebala/tab_layout/tab_model.dart';
// import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class TabBarViewLayout extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const TabBarViewLayout({
//     @required this.tabModels,
//     @required this.tabController,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final List<TabModel> tabModels;
//   final TabController tabController;
//   /// --------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//
//     final List<Widget> _tabs = TabModel.getTabButtonsFromTabModels(tabModels);
//     final List<Widget> _pages = TabModel.getPageWidgetsFromTabModels(tabModels);
//
//     return MaxBounceNavigator(
//       child: NestedScrollView(
//         physics: const BouncingScrollPhysics(),
//         floatHeaderSlivers: true,
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return <Widget>[
//             DefaultTabController(
//               length: tabModels.length,
//               child: SliverAppBar(
//                 collapsedHeight: Ratioz.stratosphere,
//                 backgroundColor: Colorz.blackSemi230,
//                 leadingWidth: 0,
//                 leading: Container(),
//                 floating: true,
//                 bottom: TabBar(
//                   controller: tabController,
//                   physics: const BouncingScrollPhysics(),
//                   // labelColor: Colorz.BloodTest,
//
//                   // indicatorColor: Colorz.BloodTest,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   indicatorWeight: 0,
//                   indicator: BoxDecoration(
//                     color: Colorz.yellow255,
//                     borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12 + 2.5),
//                   ),
//
//                   isScrollable: true,
//                   padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
//                   labelPadding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
//
//                   // onTap: (int x){
//                   //   print('x is : $x');
//                   // },
//
//                   tabs: <Widget>[..._tabs,],
//                 ),
//               ),
//             ),
//           ];
//         },
//         body: TabBarView(
//           physics: const BouncingScrollPhysics(),
//           controller: tabController,
//           children: <Widget>[..._pages,],
//         ),
//       ),
//     );
//   }
// }
