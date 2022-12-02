import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/a_country_editor/country_editor_screen.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> goToCountrySelectionScreen({
  @required BuildContext context,
  @required ZoneViewingEvent zoneViewingEvent,
}) async {

  final ZoneModel _zone = await Nav.goToNewScreen(
    context: context,
    screen: CountriesScreen(
      zoneViewingEvent: zoneViewingEvent,
      selectCountryIDOnly: true,
    ),
  );

  if (_zone != null){

    await Nav.goToNewScreen(
        context: context,
        screen: CountryEditorScreen(
          countryID: _zone.countryID,
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
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
