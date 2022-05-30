// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart' as FlyerTypeClass;
// import 'package:bldrs/b_views/widgets/general/buttons/flyer_type_button.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/tab_layout.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/stacks/saved_flyers_grid.dart';
// import 'package:bldrs/b_views/z_components/layouts/tab_model.dart';
// import 'package:bldrs/c_controllers/e_saves_controller.dart';
// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
// import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// /// TASK : if flyer is deleted from database, its ID will still remain in user's saved flyers
// /// then we need to handle this situation
// class OldSavedFlyersScreen extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const OldSavedFlyersScreen({
//     this.selectionMode = false,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final bool selectionMode;
//   /// --------------------------------------------------------------------------
//   @override
//   _OldSavedFlyersScreenState createState() => _OldSavedFlyersScreenState();
//   /// --------------------------------------------------------------------------
// }
//
// class _OldSavedFlyersScreenState extends State<OldSavedFlyersScreen> with SingleTickerProviderStateMixin {
//   int _currentTabIndex;
//   List<FlyerTypeClass.FlyerType> _sectionsList;
//   List<FlyerModel> _allFlyers;
//   TabController _tabController;
//   List<FlyerModel> _selectedFlyers;
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//     _allFlyers = _flyersProvider.savedFlyers;
//
//     _tabController = TabController(vsync: this, length: sectionsTabs.length);
//
//     // createSavedFlyersTabModels(
//     //   context: context,
//     //   allFlyers: _allFlyers,
//     //   tabController: _tabController,
//     //   selectionMode: widget.selectionMode,
//     // );
//
//     _sectionsList = addAllButtonToTabs();
//     _currentTabIndex = 0;
//     _tabModels = createTabModels();
//
//
//     _tabController.addListener(() async {
//       _onSetCurrentTab(_tabController.index);
//
//       // onSetCurrentTab(
//       //   context: context,
//       //   tabController: _tabController,
//       //   tabIndex: _tabController.index,
//       // );
//
//     });
//
//     _tabController.animation.addListener(() {
//       if (_tabController.indexIsChanging == false) {
//         _onSetCurrentTab((_tabController.animation.value).round());
//
//         // onSetCurrentTab(
//         //   context: context,
//         //   tabController: _tabController,
//         //   tabIndex: (_tabController.animation.value).round(),
//         // );
//
//       }
//     });
//
//     ///
//     if (widget.selectionMode == true) {
//       _selectedFlyers = <FlyerModel>[];
//     }
//
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// // -----------------------------------------------------------------------------
//   List<FlyerTypeClass.FlyerType> addAllButtonToTabs() {
//
//     const List<FlyerTypeClass.FlyerType> _originalList = FlyerTypeClass.sectionsList;
//     // const List<FlyerTypeClass.FlyerType> _newListWithAddButton = <SectionClass.Section>[
//     //   SectionClass.Section.all,
//     //   ..._originalList
//     // ];
//
//     return _originalList;
//   }
// // -----------------------------------------------------------------------------
//   List<TabModel> _tabModels = <TabModel>[];
//   List<TabModel> createTabModels() {
//     final List<TabModel> _models = <TabModel>[];
//
//     for (int i = 0; i < _sectionsList.length; i++) {
//       _models.add(TabModel(
//         tabButton: TabButton(
//           verse: TextGen.flyerTypePluralStringer(context, _sectionsList[i]),
//           icon: Iconizer.flyerTypeIconOff(_sectionsList[i]),
//           isSelected: _sectionsList[_currentTabIndex] == _sectionsList[i],
//           onTap: () {
//             blog('tapping on ${_sectionsList[i]}');
//             _onSetCurrentTab(i);
//           },
//         ),
//         page: SavedFlyersGrid(
//           selectionMode: widget.selectionMode,
//           onSelectFlyer: (FlyerModel flyer) => _onSelectFlyer(flyer),
//           selectedFlyers: _selectedFlyers,
//           flyers: FlyerModel.filterFlyersByFlyerType(
//             flyers: _allFlyers,
//             flyerType: _sectionsList[i],
//           ),
//         ),
//       ));
//     }
//
//     return _models;
//   }
//
// // -----------------------------------------------------------------------------
//   void _onSetCurrentTab(int index) {
//     setState(() {
//       _currentTabIndex = index;
//       _tabModels = createTabModels();
//     });
//
//     _tabController.animateTo(index,
//         curve: Curves.easeIn,
//         duration: Ratioz.duration150ms
//     );
//   }
// // -----------------------------------------------------------------------------
//   void _onSelectFlyer(FlyerModel flyer) {
//     blog('selecting flyer : ${flyer.id}');
//
//     final bool _alreadySelected = FlyerModel.flyersContainThisID(
//       flyers: _selectedFlyers,
//       flyerID: flyer.id,
//     );
//
//     if (_alreadySelected == true) {
//       setState(() {
//         _selectedFlyers.remove(flyer);
//         _tabModels = createTabModels();
//       });
//     } else {
//       setState(() {
//         _selectedFlyers.add(flyer);
//         _tabModels = createTabModels();
//       });
//     }
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return TabLayout(
//       tabModels: _tabModels,
//       pageTitle: 'Saved flyers ', //${TextGenerator.sectionStringer(context, _sectionsList[_currentIndex])}',
//       tabController: _tabController,
//       currentIndex: _currentTabIndex,
//       selectionMode: widget.selectionMode,
//       selectedItems: _selectedFlyers,
//     );
//
//     // return MainLayout(
//     //   appBarType: AppBarType.basic,
//     //   skyType: SkyType.black,
//     //   pyramidsAreOn: true,
//     //   pageTitle: 'Saved flyers',
//     //   sectionButtonIsOn: false,
//     //   zoneButtonIsOn: false,
//     //   onBack: widget.selectionMode == false ? null :
//     //       () {Nav.goBack(context, argument: _selectedFlyers);},
//     //   layoutWidget: SavedFlyersScreenView(
//     //     tabController: _tabController,
//     //   ),
//     // );
//
//   }
// }

// -----------------------------------------------------------------------------
// OLD CONTROLLER METHODS

/*

// -----------------------------------------------------------------------------
// const List<FlyerType> sectionsTabs = sectionsList;
// -----------------------------------------------------------------------------
// void createSavedFlyersTabModels({
//   @required BuildContext context,
//   @required TabController tabController,
//   @required bool selectionMode,
//   @required List<FlyerModel> allFlyers,
// }){
//
//   final List<TabModel> _models = <TabModel>[];
//
//
//   for (int i = 0; i < sectionsTabs.length; i++) {
//
//     _models.add(
//
//         TabModel(
//
//           tabButton: _createSectionTabButton(
//               context: context,
//               tabIndex: i,
//               tabController: tabController
//           ),
//           page: _createSavedFlyersGridPage(
//             context: context,
//             selectionMode: selectionMode,
//             allFlyers: allFlyers,
//             section: sectionsTabs[i],
//           ),
//         )
//
//     );
//   }
//
//   // return _models;
//
//   final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//   _uiProvider.setSavedFlyersTabModels(_models);
//
// }
// -----------------------------------------------------------------------------
// Widget _createSectionTabButton({
//   @required BuildContext context,
//   @required int tabIndex,
//   @required TabController tabController,
// }){
//
//   final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//   final int _currentTabIndex = _uiProvider.savedFlyersCurrentTabIndex;
//
//   const List<FlyerType> _sectionsTabs = sectionsList;
//   final FlyerType _section = _sectionsTabs[tabIndex];
//
//   return
//     TabButton(
//       key: ValueKey<String>('saved_flyer_tab_button_$tabIndex'),
//       verse: TextGen.flyerTypePluralStringer(context, _section),
//       icon: Iconizer.flyerTypeIconOff(_section),
//       isSelected: _sectionsTabs[_currentTabIndex] == _section,
//       onTap: () {
//
//         onSetCurrentTab(
//           context: context,
//           tabIndex: tabIndex,
//           tabController: tabController,
//         );
//
//       },
//     );
// }
// -----------------------------------------------------------------------------
// Widget _createSavedFlyersGridPage({
//   @required BuildContext context,
//   @required bool selectionMode,
//   @required List<FlyerModel> allFlyers,
//   @required FlyerType section,
// }){
//
//   final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//   final List<FlyerModel> _selectedFlyers = _flyersProvider.selectedFlyers;
//
//   return
//     SavedFlyersGrid(
//       key: ValueKey<String>('saved_flyers_grid_page_$section'),
//       selectionMode: selectionMode,
//       onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
//         context: context,
//         flyer: flyer,
//       ),
//       selectedFlyers: _selectedFlyers,
//       flyers: FlyerModel.filterFlyersByFlyerType(
//         flyers: allFlyers,
//         flyerType: section,
//       ),
//     );
//
// }
// -----------------------------------------------------------------------------
// void onSetCurrentTab({
//   @required BuildContext context,
//   @required int tabIndex,
//   @required TabController tabController,
// }){
//
//   /// set saved flyers current tab index
//   final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//   _uiProvider.setSavedFlyersCurrentTabIndex(tabIndex);
//
//   /// REBUILD TAB MODELS
//   _uiProvider.setSavedFlyersCurrentTabIndex(tabIndex);
//   // setState(() {
//   //   _tabModels = createTabModels();
//   // });
//
//
//   /// ANIMATE
//   tabController.animateTo(tabIndex,
//       curve: Curves.easeIn,
//       duration: Ratioz.duration150ms
//   );
//
// }
// -----------------------------------------------------------------------------


 */
