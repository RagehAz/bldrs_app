import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/screens/d_more/d_3_select_area_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/listLayout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart' show Sky;
import 'package:flutter/material.dart';

class SelectCityScreen extends StatelessWidget {
  final Country country;

  SelectCityScreen({
    this.country,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final String _countryName = Name.getNameByCurrentLingoFromNames(context, country.names);
    final List<MapModel> _citiesMapModels = City.getCitiesNamesMapModels(context: context, cities: country.cities);
    final String _countryFlag = Flag.getFlagIconByCountryID(country.countryID);
// -----------------------------------------------------------------------------

    return  ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: _countryName,
      icons: null,
      mapModels: _citiesMapModels,
      pageIcon: _countryFlag,
      pageIconVerse: _countryName,
      sky: Sky.Black,
      onItemTap: (value){

        final String _cityID = value;

         final City _city = City.getCityFromCities(
           cities: country.cities,
           cityID: _cityID,
         );

        Nav.goToNewScreen(context,
            SelectAreaScreen(
              city : _city,
            )
        );

      },
    );

  }
}
