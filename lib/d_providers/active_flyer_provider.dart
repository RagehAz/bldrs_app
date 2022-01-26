// import 'package:bldrs/a_models/zone/city_model.dart';
// import 'package:bldrs/a_models/zone/country_model.dart';
// import 'package:bldrs/b_views/z_components/sizing/expander.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/d_providers/zone_provider.dart';
// import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// /// THIS CONTROLLERS ACTIVE FLYER STATES
// // final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
// class ActiveFlyerProvider extends ChangeNotifier {
// // -----------------------------------------------------------------------------
//   /// NOTIFIER
//   void _notify(bool notify){
//     if (notify == true){
//       notifyListeners();
//     }
//   }
// // -----------------------------------------------------------------------------
//
//   /// ACTIVE FLYER ID
//
// // -------------------------------------
//   String _activeFlyerID;
// // -------------------------------------
//   String get activeFlyerID => _activeFlyerID;
// // -------------------------------------
//   void setActiveFlyerID({@required String setTo, @required bool notify}){
//     _activeFlyerID = setTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// NUMBER OF STRIPS
//
// // -------------------------------------
//   int _numberOfStrips = 0;
// // -------------------------------------
//   int get numberOfStrips => _numberOfStrips;
// // -------------------------------------
//   void setNumberOfStrips({@required int setTo, @required bool notify}){
//     _numberOfStrips = setTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// ACTIVE FLYER BZ COUNTRY AND CITY
//
// // -------------------------------------
//   CountryModel _activeFlyerBzCountry;
//   CityModel _activeFlyerBzCity;
// // -------------------------------------
//   CountryModel get activeFlyerBzCountry => _activeFlyerBzCountry;
//   CityModel get activeFlyerBzCity => _activeFlyerBzCity;
// // -------------------------------------
//   Future<void> getSetActiveFlyerBzCountryAndCity({
//     @required BuildContext context,
//     @required String countryID,
//     @required String cityID,
//     bool notify,
//   }) async {
//
//     final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
//     final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(
//         context: context,
//         countryID: countryID
//     );
//     final CityModel _bzCity = await _zoneProvider.fetchCityByID(
//         context: context,
//         cityID: cityID,
//     );
//
//     setActiveFlyerBzCountryAndCity(
//       bzCountry: _bzCountry,
//       bzCity: _bzCity,
//       notify: notify,
//     );
//
//   }
// // -------------------------------------
//   void setActiveFlyerBzCountryAndCity({
//     @required CountryModel bzCountry,
//     @required CityModel bzCity,
//     @required bool notify,
//   }){
//     _activeFlyerBzCountry = bzCountry;
//     _activeFlyerBzCity = bzCity;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// FOLLOW IS ON
//
// // -------------------------------------
//   bool _followIsOn = false;
// // -------------------------------------
//   bool get followIsOn => _followIsOn;
// // -------------------------------------
//   void setFollowIsOn({@required bool setFollowIsOnTo, @required bool notify}){
//     _followIsOn = setFollowIsOnTo;
//     _notify(notify);
//   }
// // -------------------------------------
//   Future<void> getSetFollowIsOn({
//     @required BuildContext context,
//     @required String bzID,
//     @required bool notify
//   }) async {
//
//     final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//     final bool _isOn = _bzzProvider.checkFollow(
//       context: context,
//       bzID: bzID,
//     );
//
//     setFollowIsOn(
//         setFollowIsOnTo: _isOn,
//         notify: notify,
//     );
//
//   }
// // -----------------------------------------------------------------------------
//
//   /// CURRENT SLIDE INDEX
//
// // -------------------------------------
//   int _currentSlideIndex = 0;
// // -------------------------------------
//   int get currentSlideIndex => _currentSlideIndex;
// // -------------------------------------
//   void setCurrentSlideIndex({
//     @required int setIndexTo,
//     @required bool notify
//   }){
//     _currentSlideIndex = setIndexTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// PROGRESS BAR OPACITY
//
// // -------------------------------------
//   double _progressBarOpacity = 1;
// // -------------------------------------
//   double get progressBarOpacity => _progressBarOpacity;
// // -------------------------------------
//   void setProgressBarOpacity({
//     @required double setOpacityTo,
//     bool notify = true
//   }){
//     _progressBarOpacity = setOpacityTo;
//
//     blog('THE PROGRESS BAR OPACITY IS NOW $_progressBarOpacity');
//
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// HEADER IS EXPANDED
//
// // -------------------------------------
//   bool _headerIsExpanded = false;
// // -------------------------------------
//   bool get headerIsExpanded => _headerIsExpanded;
// // -------------------------------------
//   void setHeaderIsExpanded({
//     @required bool setHeaderIsExpandedTo,
//     @required bool notify,
//   }){
//     _headerIsExpanded = setHeaderIsExpandedTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// HEADER PAGE OPACITY
//
// // -------------------------------------
//   double _headerPageOpacity = 0;
// // -------------------------------------
//   double get headerPageOpacity => _headerPageOpacity;
// // -------------------------------------
//   void setHeaderPageOpacity({@required double setOpacityTo, @required bool notify}){
//     _headerPageOpacity = setOpacityTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// CAN DISMISS FLYER
//
// // -------------------------------------
//   bool _canDismissFlyer = true;
// // -------------------------------------
//   bool get canDismissFlyer => _canDismissFlyer;
// // -------------------------------------
//   void setCanDismissFlyer({@required bool setTo, @required bool notify}){
//     _canDismissFlyer = setTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// SHOWING FULL SCREEN FLYER
//
// // -------------------------------------
//   bool _showingFullScreenFlyer = false;
// // -------------------------------------
//   bool get showingFullScreenFlyer => _showingFullScreenFlyer;
// // -------------------------------------
//   void setShowingFullScreenFlyer({@required bool setTo, @required bool notify}){
//     _showingFullScreenFlyer = setTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
//
//   /// SWIPE DIRECTION
//
// // -------------------------------------
//   Sliders.SwipeDirection _swipeDirection = Sliders.SwipeDirection.next;
// // -------------------------------------
//   Sliders.SwipeDirection get swipeDirection => _swipeDirection;
// // -------------------------------------
//   void setSwipingDirection({@required Sliders.SwipeDirection setTo, @required bool notify}){
//     _swipeDirection = setTo;
//     _notify(notify);
//   }
// // -----------------------------------------------------------------------------
// }
