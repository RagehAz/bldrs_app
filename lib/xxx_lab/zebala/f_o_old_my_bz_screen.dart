
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'dart:async';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/a_models/zone/city_model.dart';
// import 'package:bldrs/a_models/zone/country_model.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/tab_layout.dart';
// import 'package:bldrs/b_views/widgets/specific/bz/appbar/bz_app_bar.dart';
// import 'package:bldrs/b_views/y_views/f_bz_views/f_3_bz_about_tab.dart';
// import 'package:bldrs/b_views/y_views/f_bz_views/f_2_bz_flyers_tab.dart';
// import 'package:bldrs/b_views/y_views/f_bz_views/f_6_bz_powers_tab.dart';
// import 'package:bldrs/b_views/y_views/f_bz_views/f_5_bz_targets_tab.dart';
// import 'package:bldrs/b_views/z_components/layouts/tab_model.dart';
// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/d_providers/zone_provider.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class OldMyBzScreen extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const OldMyBzScreen({
//     @required this.bzModel,
//     @required this.userModel,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final BzModel bzModel;
//   final UserModel userModel;
//   /// --------------------------------------------------------------------------
//   @override
//   _OldMyBzScreenState createState() => _OldMyBzScreenState();
//   /// --------------------------------------------------------------------------
// }
//
// class _OldMyBzScreenState extends State<OldMyBzScreen> with SingleTickerProviderStateMixin {
//   // bool _showOldFlyers;
//   BzModel _bzModel;
//   List<FlyerModel> _flyers;
//   CountryModel _bzCountry;
//   CityModel _bzCity;
//   // double _bubblesOpacity = 0;
//   TabController _tabController;
//   int _currentTabIndex = 0;
// // -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   bool _loading = false;
//   Future<void> _triggerLoading({Function function}) async {
//     if (function == null) {
//       setState(() {
//         _loading = !_loading;
//       });
//     } else {
//       setState(() {
//         _loading = !_loading;
//         function();
//       });
//     }
//
//     _loading == true
//         ? blog('LOADING--------------------------------------')
//         : blog('LOADING COMPLETE--------------------------------------');
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//     blog('1 - we got temp bzModel');
//
//     _bzModel = widget.bzModel;
//     // _showOldFlyers = false;
//
//     _tabModels = createBzTabModels();
//
//     _tabController = TabController(vsync: this, length: BzModel.bzPagesTabsTitles.length);
//
//     _tabController.addListener(() async {
//       await _onChangeTab(_tabController.index);
//     });
//
//     _tabController.animation.addListener(() {
//       if (_tabController.indexIsChanging == false) {
//         _onChangeTab((_tabController.animation.value).round());
//       }
//     });
//
//   }
// // -----------------------------------------------------------------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//       _triggerLoading().then((_) async {
//
//         final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//         final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
//
//         final List<FlyerModel> _bzFlyers = await _flyersProvider.fetchAllBzFlyersByBzID(
//             context: context,
//             bzID: widget.bzModel.id,
//         );
//
//         final CountryModel _country = await _zoneProvider.fetchCountryByID(
//             context: context,
//             countryID: widget.bzModel.zone.countryID
//         );
//
//         final CityModel _city = await _zoneProvider.fetchCityByID(
//             context: context,
//             cityID: widget.bzModel.zone.cityID
//         );
//
//         unawaited(_triggerLoading(function: () {
//           _bzCountry = _country;
//           _bzCity = _city;
//           _flyers = _bzFlyers;
//           // _bubblesOpacity = 1;
//           _tabModels = createBzTabModels();
//         }));
//       });
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
// // -----------------------------------------------------------------------------
//   List<TabModel> _tabModels = <TabModel>[];
//   List<TabModel> createBzTabModels() {
//     final List<TabModel> _models = <TabModel>[
//
//       /// 0 : Flyers
//       BzFlyersTab.flyersTabModel(
//         bzModel: _bzModel,
//         isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] ==
//             BzModel.bzPagesTabsTitles[0],
//         onChangeTab: (int index) => _onChangeTab(index),
//         tabIndex: 0,
//         tinyFlyers: _flyers,
//         bzCountry: _bzCountry,
//         bzCity: _bzCity,
//       ),
//
//       /// 1 : ABOUT
//       BzAboutTab.aboutTabModel(
//         bzModel: _bzModel,
//         isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] ==
//             BzModel.bzPagesTabsTitles[1],
//         onChangeTab: (int index) => _onChangeTab(index),
//         tabIndex: 1,
//       ),
//
//       /// 2 : Targets
//       BzTargetsTab.targetsTabModel(
//         bzModel: _bzModel,
//         isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] ==
//             BzModel.bzPagesTabsTitles[2],
//         onChangeTab: (int index) => _onChangeTab(index),
//         tabIndex: 2,
//       ),
//
//       /// 3 : Powers
//       BzPowersTab.powersTabModel(
//         bzModel: _bzModel,
//         isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] ==
//             BzModel.bzPagesTabsTitles[3],
//         onChangeTab: (int index) => _onChangeTab(index),
//         tabIndex: 3,
//       ),
//
//     ];
//
//     return _models;
//   }
// // -----------------------------------------------------------------------------
//   Future<void> _onChangeTab(int index) async {
//
//     setState(() {
//       _currentTabIndex = index;
//       _tabModels = createBzTabModels();
//     });
//
//     _tabController.animateTo(index,
//         curve: Curves.easeIn, duration: Ratioz.duration150ms);
//
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return TabLayout(
//       tabModels: _tabModels,
//       tabController: _tabController,
//       currentIndex: _currentTabIndex,
//       appBarRowWidgets: const <Widget>[
//
//         BzAppBar(
//           // bzModel: _bzModel,
//           // userModel: widget.userModel,
//           // cityModel: _bzCity,
//           // countryModel: _bzCountry,
//         ),
//
//       ], //bzPageAppBarWidgets(),
//     );
//   }
// }
