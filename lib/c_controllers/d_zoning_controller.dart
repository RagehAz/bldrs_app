import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/screens/d_zoning/d_1_select_country_screen.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
Future<ZoneModel> selectCountryOnly(BuildContext context) async {

  final ZoneModel _zone = await goToNewScreen(context,
      const SelectCountryScreen(
        selectCountryIDOnly: true,
      )
  );

  return _zone;
}
// -----------------------------------------------------------------------------
Future<ZoneModel> selectCountryAndCityOnly(BuildContext context) async {

  final ZoneModel _zone = await goToNewScreen(context,
      const SelectCountryScreen(
        selectCountryAndDistrictOnly: true,
      )
  );

  return _zone;

}
// -----------------------------------------------------------------------------
