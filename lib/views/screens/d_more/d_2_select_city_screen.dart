import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/helpers/map_model.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/d_more/d_3_select_area_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/list_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart' show Sky;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreen extends StatelessWidget {
  final CountryModel country;

  SelectCityScreen({
    this.country,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final String _countryName = Name.getNameByCurrentLingoFromNames(context, country?.names);
    final List<MapModel> _citiesMapModels = CityModel.getCitiesNamesMapModels(context: context, cities: country?.cities);
    final String _countryFlag = Flag.getFlagIconByCountryID(country?.countryID);
// -----------------------------------------------------------------------------

    return  ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: _countryName,
      icons: null,
      mapModels: _citiesMapModels,
      pageIcon: _countryFlag,
      pageIconVerse: _countryName,
      sky: Sky.Black,
      onItemTap: (value) async {

        final String _cityID = value;

         final CityModel _city = CityModel.getCityFromCities(
           cities: country.cities,
           cityID: _cityID,
         );

         if (Mapper.canLoopList(_city.districts)){

           await Nav.goToNewScreen(context,
               SelectAreaScreen(
                 city : _city,
               )
           );

         }

         else {

           final Zone _zone = Zone(
             countryID: _city.countryID,
             cityID: _city.cityID,
             districtID: null,
           );

           _zone.printZone(methodName: 'SELECTED ZONE');

           final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
           await _zoneProvider.getsetCurrentZoneAndCountry(context: context, zone: _zone);

           final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
           final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
           await _flyersProvider.getsetWallFlyersBySection(
               context: context,
               section: _generalProvider.currentSection
           );

           Nav.goBackToHomeScreen(context);

         }


      },
    );

  }
}
