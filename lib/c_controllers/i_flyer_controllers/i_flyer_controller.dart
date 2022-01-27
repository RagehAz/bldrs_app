import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
