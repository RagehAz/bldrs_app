// import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
// import 'package:bldrs/c_controllers/e_saves_controller.dart';
// import 'package:bldrs/d_providers/ui_provider.dart';
// import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
// import 'package:bldrs/xxx_lab/zebala/tab_layout_saved_flyers/e_tab_layout_saves_views/saves_screen_view_tab_view.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// /// SCREEN
// class SavedFlyersScreenInTabView extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const SavedFlyersScreenInTabView({
//     this.selectionMode = false,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final bool selectionMode;
//   /// --------------------------------------------------------------------------
//   @override
//   _SavedFlyersScreenInTabViewState createState() => _SavedFlyersScreenInTabViewState();
// }
//
// class _SavedFlyersScreenInTabViewState extends State<SavedFlyersScreenInTabView> with SingleTickerProviderStateMixin {
//   TabController _tabController;
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//
//     _tabController = TabController(
//         vsync: this,
//         length: sectionsList.length,
//         initialIndex: getInitialSavedFlyersTabIndex(context)
//     );
//
//     /// LISTENS TO TAB CHANGE AFTER SWIPE ANIMATION ENDS
//     // _tabController.addListener(() => _onChangeTabIndex(_tabController.index));
//
//     /// LISTEN TO TAB CHANGE WHILE ANIMATION
//     _tabController.animation.addListener(
//         () => onChangeSavedFlyersTabIndexWhileAnimation(
//           context: context,
//           tabController: _tabController,
//         )
//     );
//
//     super.initState();
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void didChangeDependencies() {
//     final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//
//     _uiProvider.startController((){
//
//       // createSavedFlyersTabModels(
//       //   context: context,
//       //   tabController: _tabController,
//       //   selectionMode: widget.selectionMode,
//       //   allFlyers: [],
//       // );
//
//     });
//
//     super.didChangeDependencies();
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// // -----------------------------------------------------------------------------
//   void _passSelectedFlyersBack(){
//
//     /// shall pass selected flyers through flyers provider
//     Nav.goBack(context, argument:
//     // _selectedFlyers
//     [],
//     );
//
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return MainLayout(
//       appBarType: AppBarType.basic,
//       skyType: SkyType.black,
//       pyramidsAreOn: true,
//       pageTitle: 'Saved flyers',
//       sectionButtonIsOn: false,
//       zoneButtonIsOn: false,
//       onBack: widget.selectionMode ? _passSelectedFlyersBack : null,
//       layoutWidget: TabLayoutSavedFlyersScreenView(
//         tabController: _tabController,
//         selectionMode: widget.selectionMode,
//       ),
//
//     );
//
//   }
// }
