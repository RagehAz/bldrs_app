import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> goToCountrySelectionScreen({
  @required BuildContext context,
  @required ValueNotifier<ZoneModel> zone,
}) async {

  final ZoneModel _zone = await Nav.goToNewScreen(
      context: context,
      screen: const CountriesScreen(
        selectCountryIDOnly: true,
      ),
  );

  if (_zone != null){

    zone.value = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: _zone,
    );

  }

}
// --------------------------------------------
Future<void> goToCitySelectionScreen({
  @required BuildContext context,
  @required ValueNotifier<ZoneModel> zone,
  @required PageController pageController
}) async {

  final ZoneModel _zone = await Nav.goToNewScreen(
    context: context,
    screen: CitiesScreen(
      country: zone.value.countryModel,
      selectCountryAndCityOnly: true,
    ),
  );

  if (_zone != null){

    zone.value = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _zone,
    );

    await pageController.animateToPage(1,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutQuart,
    );

  }

}
// -----------------------------------------------------------------------------
