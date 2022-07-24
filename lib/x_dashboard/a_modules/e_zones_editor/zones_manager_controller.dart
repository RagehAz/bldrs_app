import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/country_screen.dart';
import 'package:flutter/material.dart';

Future<void> onCountryEditorTap({
  @required BuildContext context,
  @required String countryID,
}) async {

  final CountryModel _countryModel = await ZoneProtocols.fetchCountry(
      context: context,
      countryID: countryID,
  );

  await Nav.goToNewScreen(
      context: context,
      screen: CountryEditorScreen(
          country: _countryModel,
      ),
  );

}
