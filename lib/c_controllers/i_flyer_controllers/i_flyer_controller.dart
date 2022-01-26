import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// // -----------------------------------------------------------------------------
// void onCloseFullScreenFlyer(BuildContext context){
//
//   final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
//
//   /// ACTIVE FLYER BZ COUNTRY AND CITY
//   _activeFlyerProvider.setActiveFlyerBzCountryAndCity(
//     bzCountry: null,
//     bzCity: null,
//     notify: false,
//   );
//
//   /// FOLLOW IS ON
//   _activeFlyerProvider.setFollowIsOn(
//       setFollowIsOnTo: false,
//       notify: false
//   );
//
//   /// CURRENT SLIDE INDEX
//   _activeFlyerProvider.setCurrentSlideIndex(
//     setIndexTo: 0,
//     notify: false,
//   );
//
//   /// PROGRESS BAR OPACITY
//   _activeFlyerProvider.setProgressBarOpacity(
//     setOpacityTo: 0,
//     notify: false,
//   );
//
//   /// HEADER IS EXPANDED
//   _activeFlyerProvider.setHeaderIsExpanded(
//     setHeaderIsExpandedTo: false,
//     notify: false,
//   );
//
//   /// HEADER PAGE OPACITY
//   _activeFlyerProvider.setHeaderPageOpacity(
//     setOpacityTo: 0,
//     notify: false,
//   );
//
//   /// SHOWING FULL SCREEN FLYER
//   _activeFlyerProvider.setCanDismissFlyer(
//       setTo: false,
//       notify: true
//   );
//
//   Nav.goBack(context);
// }
// // -----------------------------------------------------------------------------
// Future<void> onOpenFullScreenFlyer({
//   @required BuildContext context,
//   @required BzModel bzModel,
//   @required FlyerModel flyerModel,
// }) async {
//
//   final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
//
//   _activeFlyerProvider.setShowingFullScreenFlyer(
//       setTo: true,
//       notify: false
//   );
//
//   _activeFlyerProvider.setCanDismissFlyer(
//       setTo: true,
//       notify: false,
//   );
//
//   _setActiveFlyerID(
//     context: context,
//     flyerID: flyerModel.id,
//     notify: false,
//   );
//
//   _setNumberOfStrips(
//     context: context,
//     numberOfStrips:  flyerModel.slides.length,
//     notify: false,
//   );
//
//   /// can get them in didChangedDependencies and pass them
//   /// through constructors, but this will be easier
//   await _getFlyerBzCountryAndCity(
//     context: context,
//     bzModel: bzModel,
//     notify: true,
//   );
//
// }
// -----------------------------------------------------------------------------
Future<BzModel> getFlyerBzModel({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  final BzModel _bzModel = await _bzzProvider.fetchBzModel(
      context: context,
      bzID: flyerModel.bzID
  );

  return _bzModel;
}
// -----------------------------------------------------------------------------
Future<CountryModel> getFlyerBzCountry({
  @required BuildContext context,
  @required String countryID,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final CountryModel _country = await _zoneProvider.fetchCountryByID(
      context: context,
      countryID: countryID
  );

  return _country;
}
// -----------------------------------------------------------------------------
Future<CityModel> getFlyerBzCity({
  @required BuildContext context,
  @required String cityID,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final CityModel _city = await _zoneProvider.fetchCityByID(
      context: context,
      cityID: cityID
  );

  return _city;
}
// -----------------------------------------------------------------------------
// Future<void> _getFlyerBzCountryAndCity({
//   @required BuildContext context,
//   @required BzModel bzModel,
//   @required bool notify,
// }) async {
//
//   final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
//   await _activeFlyerProvider.getSetActiveFlyerBzCountryAndCity(
//     context: context,
//     countryID: bzModel.zone.countryID,
//     cityID: bzModel.zone.cityID,
//     notify: notify,
//   );
//
// }
// // -----------------------------------------------------------------------------
// void _setActiveFlyerID({
//   @required BuildContext context,
//   @required String flyerID,
//   @required bool notify,
// }) {
//   final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
//   _activeFlyerProvider.setActiveFlyerID(setTo: flyerID, notify: notify);
// }
// // -----------------------------------------------------------------------------
// void _setNumberOfStrips({
//   @required BuildContext context,
//   @required int numberOfStrips,
//   @required bool notify,
// }) {
//   final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
//   _activeFlyerProvider.setNumberOfStrips(setTo: numberOfStrips, notify: notify);
// }
// // -----------------------------------------------------------------------------
