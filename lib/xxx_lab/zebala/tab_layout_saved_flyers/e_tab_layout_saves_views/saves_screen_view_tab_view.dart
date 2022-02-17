// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
// import 'package:bldrs/b_views/z_components/tab_bars/saved_flyers_screen_tab_bar.dart';
// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/d_providers/ui_provider.dart';
// import 'package:bldrs/xxx_lab/zebala/tab_layout_saved_flyers/e_tab_layout_saves_views/saves_screen_view_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class TabLayoutSavedFlyersScreenView extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const TabLayoutSavedFlyersScreenView({
//     @required this.tabController,
//     @required this.selectionMode,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final TabController tabController;
//   final bool selectionMode;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return OldMaxBounceNavigator(
//       child: NestedScrollView(
//         physics: const BouncingScrollPhysics(),
//         floatHeaderSlivers: true,
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
//
//           return <Widget>[
//
//             /// SAVED FLYER SCREEN SLIVER TABS
//             Consumer<UiProvider>(
//               builder: (BuildContext ctx, UiProvider uiProvider, Widget child) {
//
//                 final FlyerType _currentFlyerTypeTab = uiProvider.currentSavedFlyerTypeTab;
//
//                 return SavedFlyersTabBar(
//                   tabController: tabController,
//                   currentFlyerTypeTab: _currentFlyerTypeTab,
//                 );
//
//               },
//             ),
//           ];
//
//         },
//
//         /// FLYERS GRIDS PAGES
//         body: Consumer<FlyersProvider>(
//           builder: (_, FlyersProvider flyersProvider, Widget child){
//
//             final List<FlyerModel> _savedFlyers = flyersProvider.savedFlyers;
//             final List<FlyerModel> _selectedFlyers = flyersProvider.selectedFlyers;
//
//             return
//
//               SavedFlyersScreenViewPagesInTabView(
//                 tabController: tabController,
//                 savedFlyers: _savedFlyers,
//                 selectionMode: selectionMode,
//                 selectedFlyers: _selectedFlyers,
//               );
//
//           },
//         ),
//
//       ),
//     );
//   }
// }
