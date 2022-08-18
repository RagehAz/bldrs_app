import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/a_select_country_screen.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/b_select_city_screen.dart';
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
      screen: const SelectCountryScreen(
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
    screen: SelectCityScreen(
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
