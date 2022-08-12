import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/a_select_country_screen.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------------------------------
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

// -----------------------------------------------------------------------------
