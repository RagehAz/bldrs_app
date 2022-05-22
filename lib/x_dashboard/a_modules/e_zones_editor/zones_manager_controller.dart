
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/country_screen.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:provider/provider.dart';

Future<void> onCountryEditorTap({
  @required BuildContext context,
  @required String countryID,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final CountryModel _countryModel = await _zoneProvider.fetchCountryByID(
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
