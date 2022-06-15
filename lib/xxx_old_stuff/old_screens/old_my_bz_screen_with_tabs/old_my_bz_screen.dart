// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/xxx_lab/xxx_old_stuff/old_screens/old_my_bz_screen_with_tabs/f_0_my_bz_screen_view.dart';
// import 'package:bldrs/xxx_lab/xxx_old_stuff/old_screens/old_my_bz_screen_with_tabs/old_bz_app_bar.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
// import 'package:bldrs/c_controllers/f_bz_controllers/my_bz_screen_controller.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/d_providers/ui_provider.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class OldMyBzScreen extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const OldMyBzScreen({
//     @required this.bzModel,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final BzModel bzModel;
//   /// --------------------------------------------------------------------------
//   @override
//   _OldMyBzScreenState createState() => _OldMyBzScreenState();
// /// --------------------------------------------------------------------------
// }
//
// class _OldMyBzScreenState extends State<OldMyBzScreen> with SingleTickerProviderStateMixin {
// // -----------------------------------------------------------------------------
//   TabController _tabController;
//   final ScrollController _scrollViewController = ScrollController();
//   UiProvider _uiProvider;
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//
//     _uiProvider = Provider.of<UiProvider>(context, listen: false);
//
//     _tabController = TabController(
//       vsync: this,
//       length: BzModel.bzPagesTabsTitlesInEnglishOnly.length,
//       initialIndex: getInitialMyBzScreenTabIndex(context),
//     );
//
//     _tabController.animation.addListener(
//             () => onChangeMyBzScreenTabIndexWhileAnimation(
//           context: context,
//           tabController: _tabController,
//         )
//     );
//
//     _scrollViewController.addListener(() {
//
//       final double _currentScroll = _scrollViewController.position.pixels;
//
//       blog('out : scroll is at : $_currentScroll');
//
//     });
//
//     super.initState();
//   }
// // -----------------------------------------------------------------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//
//       _uiProvider.startController(
//               () async {
//
//                 _uiProvider.triggerLoading(
//                   setLoadingTo: true,
//                   notify: true,
//                   callerName: 'MyBzScreen didChangeDependencies',
//                 );
//
//                 await initializeMyBzScreen(
//                   context: context,
//                   bzModel: widget.bzModel,
//                 );
//
//                 _uiProvider.triggerLoading(
//                   setLoadingTo: false,
//                   callerName: 'MyBzScreen didChangeDependencies',
//                   notify: true,
//                 );
//
//               }
//               );
//
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose(); /// tamam
//   }
// // -----------------------------------------------------------------------------
//   bool _canBuild(BuildContext context){
//
//
//     final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
//         context: context,
//         listen: true,
//     );
//
//     final List<FlyerModel> _bzFlyers = BzzProvider.proGetActiveBzFlyers(
//         context: context,
//         listen: true,
//     );
//
//     final bool _isLoading =  _uiProvider.isLoading;
//
//
//     if (
//     _bzModel != null
//     &&
//     _bzFlyers != null
//     &&
//     _isLoading == false
//     ){
//       return true;
//     }
//
//     else {
//       return false;
//     }
//
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final bool _canBuildWidgets = _canBuild(context);
//
//     return MainLayout(
//       key: ValueKey('my_bz_screen_${widget.bzModel.id}'),
//         appBarType: AppBarType.basic,
//         skyType: SkyType.black,
//         pyramidsAreOn: true,
//         sectionButtonIsOn: false,
//         zoneButtonIsOn: false,
//         onBack: () => onCloseMyBzScreen(context: context),
//         appBarRowWidgets: <Widget>[
//           if (_canBuildWidgets == true)
//             const BzAppBar(),
//         ],
//         layoutWidget:
//         _canBuildWidgets == true ?
//         MyBzScreenView(
//           tabController: _tabController,
//           scrollViewController: _scrollViewController,
//         )
//             :
//         const SizedBox()
//
//     );
//
//   }
// }
