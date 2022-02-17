// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/zone/city_model.dart';
// import 'package:bldrs/a_models/zone/country_model.dart';
// import 'package:bldrs/b_views/widgets/general/buttons/flyer_type_button.dart';
// import 'package:bldrs/b_views/y_views/f_bz/f_2_bz_flyers_page.dart';
// import 'package:bldrs/b_views/y_views/f_bz/f_3_bz_about_page.dart';
// import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_targets_page.dart';
// import 'package:bldrs/b_views/y_views/f_bz/f_6_bz_powers_page.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:flutter/material.dart';
//
// class TabModel {
//   /// --------------------------------------------------------------------------
//   const TabModel({
//     @required this.tabButton,
//     @required this.page,
//   });
//   /// --------------------------------------------------------------------------
//   final Widget tabButton;
//   final Widget page;
//   /// --------------------------------------------------------------------------
//   static List<Widget> getPageWidgetsFromTabModels(List<TabModel> tabModels) {
//     final List<Widget> _widgets = <Widget>[];
//
//     for (final TabModel tabModel in tabModels) {
//       _widgets.add(tabModel.page);
//     }
//
//     return _widgets;
//   }
// // -----------------------------------------------------------------------------
//   static List<Widget> getTabButtonsFromTabModels(List<TabModel> tabModels) {
//     final List<Widget> _widgets = <Widget>[];
//
//     for (final TabModel tabModel in tabModels) {
//       _widgets.add(tabModel.tabButton);
//     }
//
//     return _widgets;
//   }
// // -----------------------------------------------------------------------------
//   static TabModel oldFlyersTabModel({
//     @required Function onChangeTab,
//     @required BzModel bzModel,
//     @required List<FlyerModel> tinyFlyers,
//     @required bool isSelected,
//     @required int tabIndex,
//     @required CountryModel bzCountry,
//     @required CityModel bzCity,
//   }) {
//     return TabModel(
//       tabButton: TabButton(
//         key: ValueKey<String>('bz_flyers_tab_${bzModel.id}'),
//         verse: BzModel.bzPagesTabsTitles[tabIndex],
//         icon: Iconz.flyerGrid,
//         isSelected: isSelected,
//         onTap: () => onChangeTab(tabIndex),
//         iconSizeFactor: 0.7,
//         triggerIconColor: false,
//       ),
//       page: BzFlyersTab(
//         key: ValueKey<String>('bz_flyers_page_${bzModel.id}'),
//         bzModel: bzModel,
//         flyers: tinyFlyers,
//         bzCountry: bzCountry,
//         bzCity: bzCity,
//       ),
//     );
//   }
// // -----------------------------------------------------------------------------
//   static TabModel oldAboutTabModel({
//     @required Function onChangeTab,
//     @required BzModel bzModel,
//     @required bool isSelected,
//     @required int tabIndex,
//   }) {
//     return TabModel(
//       tabButton: TabButton(
//         key: ValueKey<String>('bz_about_tab_${bzModel.id}'),
//         verse: BzModel.bzPagesTabsTitles[tabIndex],
//         icon: Iconz.info,
//         iconSizeFactor: 0.7,
//         isSelected: isSelected,
//         onTap: () => onChangeTab(tabIndex),
//       ),
//       page: BzAboutTab(
//         key: ValueKey<String>('bz_about_page_${bzModel.id}'),
//         bzModel: bzModel,
//       ),
//     );
//   }
// // -----------------------------------------------------------------------------
//   static TabModel targetsTabModel({
//     @required Function onChangeTab,
//     @required BzModel bzModel,
//     @required bool isSelected,
//     @required int tabIndex,
//   }) {
//     return TabModel(
//       tabButton: TabButton(
//         key: ValueKey<String>('bz_targets_tab_${bzModel.id}'),
//         verse: BzModel.bzPagesTabsTitles[tabIndex],
//         icon: Iconz.target,
//         isSelected: isSelected,
//         onTap: () => onChangeTab(tabIndex),
//         iconSizeFactor: 0.7,
//       ),
//       page: BzTargetsTab(
//         key: ValueKey<String>('bz_targets_page_${bzModel.id}'),
//         bzModel: bzModel,
//       ),
//     );
//   }
// // -----------------------------------------------------------------------------
//   static TabModel powersTabModel({
//     @required Function onChangeTab,
//     @required BzModel bzModel,
//     @required bool isSelected,
//     @required int tabIndex,
//   }) {
//     return TabModel(
//       tabButton: TabButton(
//         key: ValueKey<String>('bz_powers_tab_${bzModel.id}'),
//         verse: BzModel.bzPagesTabsTitles[tabIndex],
//         icon: Iconz.power,
//         isSelected: isSelected,
//         onTap: () => onChangeTab(tabIndex),
//         iconSizeFactor: 0.7,
//       ),
//       page: BzPowersTab(
//         key: ValueKey<String>('bz_powers_page_${bzModel.id}'),
//         bzModel: bzModel,
//       ),
//     );
//   }
// // -----------------------------------------------------------------------------
// }
