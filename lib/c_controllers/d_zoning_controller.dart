import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_1_select_country_screen.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// MAIN ZONING NAVIGATORS

// -------------------------------------
Future<ZoneModel> controlSelectCountryOnly(BuildContext context) async {

  final ZoneModel _zone = await goToNewScreen(context,
      const SelectCountryScreen(
        selectCountryIDOnly: true,
      )
  );

  return _zone;
}
// -----------------------------------------------------------------------------
Future<ZoneModel> controlSelectCountryAndCityOnly(BuildContext context) async {

  final ZoneModel _zone = await goToNewScreen(context,
      const SelectCountryScreen(
        selectCountryAndDistrictOnly: true,
      )
  );

  return _zone;
}
// -----------------------------------------------------------------------------
Future<ZoneModel> controlSelectZone(BuildContext context) async {

}
// -----------------------------------------------------------------------------

/// COUNTRY CONTROLLERS

// -------------------------------------
// Future<void> onSelectCountry({@required String countryID}) async {
//   blog('countryID is : $countryID');
//
//
//   if (widget.selectCountryIDOnly){
//
//     final ZoneModel _zone = ZoneModel(
//       countryID: countryID,
//     );
//
//     Nav.goBack(context, argument: _zone);
//
//   }
//   else {
//
//     if (widget.selectCountryAndDistrictOnly) {
//
//       final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: countryID);
//       final String _cityID = await Nav.goToNewScreen(context, SelectCityScreen(
//         country: _country,
//         selectCountryAndDistrictOnly: widget.selectCountryAndDistrictOnly,
//       ));
//
//       if (_cityID != null){
//
//         final ZoneModel _zone = ZoneModel(
//           countryID: countryID,
//           cityID: _cityID,
//         );
//
//         Nav.goBack(context, argument: _zone);
//
//       }
//
//     }
//
//     else {
//
//       final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: countryID);
//       await Nav.goToNewScreen(context, SelectCityScreen(country: _country));
//     }
//
//   }
//
// }
