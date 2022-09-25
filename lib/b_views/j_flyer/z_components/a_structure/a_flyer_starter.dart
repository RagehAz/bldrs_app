// import 'dart:async';
//
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/a_models/zone/city_model.dart';
// import 'package:bldrs/a_models/zone/country_model.dart';
// import 'package:bldrs/a_models/zone/zone_model.dart';
// import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
// import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_footer_controller.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_loading.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_full_screen.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
// import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
// import 'package:bldrs/b_views/z_components/sizing/expander.dart';
// import 'package:bldrs/d_providers/user_provider.dart';
// import 'package:bldrs/f_helpers/drafters/sliders.dart';
// import 'package:dismissible_page/dismissible_page.dart';
// import 'package:flutter/material.dart';
//
// class FlyerStarter extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const FlyerStarter({
//     @required this.flyerModel,
//     @required this.minWidthFactor,
//     @required this.heroTag,
//     this.isFullScreen = false,
//     this.startFromIndex = 0,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final FlyerModel flyerModel;
//   final double minWidthFactor;
//   final bool isFullScreen;
//   final String heroTag;
//   final int startFromIndex;
//   /// --------------------------------------------------------------------------
//   @override
//   _FlyerStarterState createState() => _FlyerStarterState();
//   /// --------------------------------------------------------------------------
// }
//
// class _FlyerStarterState extends State<FlyerStarter> {
//   // -----------------------------------------------------------------------------
//   final ValueNotifier<BzModel> _bzModelNotifier = ValueNotifier(null);
//   final ValueNotifier<ZoneModel> _flyerZoneNotifier = ValueNotifier(null);
//   final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
//   // --------------------
//   final ValueNotifier<bool> _flyerIsSaved = ValueNotifier<bool>(false);
//   // --------------------
//   FlyerModel _flyerModel;
//   // -----------------------------------------------------------------------------
//   /// --- LOADING BLOCK
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({
//     @required setTo,
//   }) async {
//
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//       addPostFrameCallBack: false,
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     _flyerModel = widget.flyerModel;
//
//     _flyerIsSaved.value = UserModel.checkFlyerIsSaved(
//       userModel: UsersProvider.proGetMyUserModel(context: context, listen: false),
//       flyerID: _flyerModel.id,
//     );
//
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (
//         _isInit == true &&
//         mounted == true &&
//         _flyerModel != null &&
//         _flyerModel?.id != null
//     ) {
//
//       _triggerLoading(setTo: true).then((_) async {
//         // ----------
//         BzModel _bzModel;
//         // ----------
//         /// BZ MODEL
//         if (mounted == true){
//           _bzModel = await getFlyerBzModel(
//             context: context,
//             flyerModel: _flyerModel,
//           );
//         }
//         // ----------
//         CountryModel _flyerCountry;
//         /// FLYER ZONE
//         if (mounted == true){
//           _flyerCountry = await getFlyerBzCountry(
//             context: context,
//             countryID: _flyerModel.zone.countryID,
//           );
//         }
//         // ----------
//         CityModel _flyerCity;
//         if (mounted == true){
//           _flyerCity = await getFlyerBzCity(
//             context: context,
//             cityID: _flyerModel.zone.cityID,
//           );
//         }
//         // ----------
//         /// STARTING INDEX
//         final int _startingIndex = getPossibleStartingIndex(
//           flyerModel: _flyerModel,
//           bzModel: _bzModel,
//           heroTag: widget.heroTag,
//           startFromIndex: widget.startFromIndex,
//         );
//         // ----------
//         /// SETTERS
//         // ----------
//         if (mounted == true){
//
//           _bzModelNotifier.value = _bzModel;
//
//           _flyerZoneNotifier.value = getZoneModel(
//             context: context,
//             countryID: _flyerCountry.id,
//             cityModel: _flyerCity,
//             districtID: _flyerModel.zone.districtID,
//           );
//
//           final int _numberOfSlides = getNumberOfSlides(
//             flyerModel: _flyerModel,
//             bzModel: _bzModel,
//             heroTag: widget.heroTag,
//           );
//
//           _progressBarModel.value = ProgressBarModel(
//             swipeDirection: SwipeDirection.next,
//             index: _startingIndex,
//             numberOfStrips: _numberOfSlides,
//           );
//
//         }
//         // ----------
//         await _triggerLoading(setTo: false);
//         // ----------
//       });
//
//       _isInit = false;
//     }
//
//     super.didChangeDependencies();
//   }
//   // --------------------
//   /// TAMAM
//   @override
//   void dispose() {
//     _loading?.dispose();
//     _bzModelNotifier?.dispose();
//     _flyerZoneNotifier?.dispose();
//     _progressBarModel?.dispose();
//     _flyerIsSaved?.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   Future<void> _openFullScreenFlyer() async {
//
//     _flyerModel.blogFlyer(methodName: '_openFullScreenFlyer');
//
//     unawaited(recordFlyerView(
//       context: context,
//       index: 0,
//       flyerModel: _flyerModel,
//     ));
//
//     await context.pushTransparentRoute(
//         FlyerScreen(
//           key: const ValueKey<String>('Flyer_Full_Screen'),
//           flyerModel: _flyerModel,
//           bzModel: _bzModelNotifier.value,
//           minWidthFactor: widget.minWidthFactor,
//           flyerZone: _flyerZoneNotifier.value,
//           heroTag: widget.heroTag,
//           // progressBarModel: _progressBarModel,
//           // flyerIsSaved: _flyerIsSaved,
//           // onSaveFlyer: onTriggerSave,
//         )
//     );
//
//   }
//   // --------------------
//   Future<void> onTriggerSave() async {
//
//     if (mounted == true){
//       await onSaveFlyer(
//           context: context,
//           flyerModel: _flyerModel,
//           slideIndex: _progressBarModel.value.index,
//           flyerIsSaved: _flyerIsSaved
//       );
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return ValueListenableBuilder(
//         key: const ValueKey<String>('FlyerStarter'),
//         valueListenable: _loading,
//         builder: (_, bool isLoading, Widget flyerHeroTree){
//
//           if (isLoading == true || _flyerModel == null){
//             return FlyerLoading(
//               flyerBoxWidth: widget.minWidthFactor,
//             );
//           }
//
//           else {
//
//             return flyerHeroTree;
//
//           }
//
//         },
//       child: ValueListenableBuilder<BzModel>(
//           valueListenable: _bzModelNotifier,
//           builder: (_, BzModel bzModel, Widget flyerLoading){
//
//             return ValueListenableBuilder<ZoneModel>(
//                 valueListenable: _flyerZoneNotifier,
//                 builder: (_, ZoneModel flyerZone, Widget child){
//
//                   if (bzModel == null || _flyerModel == null){
//                     return flyerLoading;
//                   }
//
//                   else {
//
//                     return GestureDetector(
//                       onTap: _openFullScreenFlyer,
//                       child: FlyerHero(
//                         key: const ValueKey<String>('Flyer_hero'),
//                         flyerModel: _flyerModel,
//                         bzModel: bzModel,
//                         flyerZone: flyerZone,
//                         minWidthFactor: widget.minWidthFactor,
//                         isFullScreen: widget.isFullScreen,
//                         heroTag: widget.heroTag,
//                         // progressBarModel: _progressBarModel,
//                         // onSaveFlyer: onTriggerSave,
//                         // flyerIsSaved: _flyerIsSaved,
//                       ),
//                     );
//
//                   }
//
//                 }
//             );
//
//           },
//         child: FlyerLoading(flyerBoxWidth: widget.minWidthFactor,),
//       ),
//     );
//
//   }
//   // -----------------------------------------------------------------------------
// }
