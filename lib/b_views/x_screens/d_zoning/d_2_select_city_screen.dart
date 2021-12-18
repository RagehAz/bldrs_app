import 'dart:async';

import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/appbar/zone_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_2_select_city_screen_view.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/d_zoning_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SelectCityScreen({
    this.country,
    this.selectCountryAndCityOnly = false,
    this.setCurrentZone = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final bool selectCountryAndCityOnly;
  final bool setCurrentZone;
  /// --------------------------------------------------------------------------
  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();

  /// --------------------------------------------------------------------------
}

class _SelectCityScreenState extends State<SelectCityScreen> {
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(
          () async {

            await initializeSelectCityScreen(
                context: context,
                countryModel: widget.country,
            );

          }
      );

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _onCityTap(String cityID) async {

    await controlCityOnTap(
        context: context,
        selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
        cityID: cityID,
        setCurrentZone: widget.setCurrentZone
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchCity(String inputText) async {

    await controlCitySearch(
      context: context,
      searchText: inputText,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final List<CityModel> _selectedCountryCities = _zoneProvider.selectedCountryCities;

    final ZoneModel _appBarZone = ZoneModel(
      countryID: widget.country.id,
    );

      return MainLayout(
          skyType: SkyType.black,
          appBarType: AppBarType.search,
          historyButtonIsOn: false,
          sectionButtonIsOn: false,
          zoneButtonIsOn: false,

          onSearchSubmit: _onSearchCity,
          onSearchChanged: _onSearchCity,

          pageTitle: 'Select a City',
          pyramids: Iconz.dvBlankSVG,

          appBarRowWidgets: [

            const Expander(),

            ZoneButton(
              zoneOverride: _appBarZone,
              countryOverride: widget.country,

            ),

          ],

          layoutWidget: SelectCityScreenView(
            cities: _selectedCountryCities,
            onCityTap: _onCityTap,
          ),
      );

  }
}
