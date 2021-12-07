import 'dart:async';

import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/secondary_models/map_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/d_more/d_3_select_area_screen.dart';
import 'package:bldrs/views/widgets/general/layouts/list_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SelectCityScreen({
    this.country,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  /// --------------------------------------------------------------------------
  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
  /// --------------------------------------------------------------------------
}

class _SelectCityScreenState extends State<SelectCityScreen> {

  List<CityModel> _cities = <CityModel>[];

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
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
      _triggerLoading().then((_) async{

        /// do Futures here
        final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
        final List<CityModel> _fetchedCities = await _zoneProvider.fetchCitiesByIDs(
          context: context,
          citiesIDs: widget.country.citiesIDs,
        );

        unawaited(
            _triggerLoading(
                function: (){
                  _cities = _fetchedCities;
                }
            )
        );

      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final String _countryName = Name.getNameByCurrentLingoFromNames(context, widget.country?.names);
    final List<MapModel> _citiesMapModels = CityModel.getCitiesNamesMapModels(context: context, cities: _cities);
    final String _countryFlag = Flag.getFlagIconByCountryID(widget.country?.id);
// -----------------------------------------------------------------------------

    return  ListLayout(
      pyramids: Iconz.pyramidzYellow,
      pageTitle: _countryName,
      mapModels: _citiesMapModels,
      pageIcon: _countryFlag,
      pageIconVerse: _countryName,
      sky: SkyType.black,
      onItemTap: (String value) async {

        final String _cityID = value;

         final CityModel _city = CityModel.getCityFromCities(
           cities: _cities,
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

           final ZoneModel _zone = ZoneModel(
             countryID: _city.countryID,
             cityID: _city.cityID,
           );

           _zone.printZone(methodName: 'SELECTED ZONE');

           final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
           await _zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _zone);

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
