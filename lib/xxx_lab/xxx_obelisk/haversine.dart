import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/data_strip.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Haversine extends StatefulWidget {
  const Haversine({Key key}) : super(key: key);

  @override
  State<Haversine> createState() => _HaversineState();
}

class _HaversineState extends State<Haversine> {
  final String _theCountryID = 'afg';

  ZoneProvider _zoneProvider;
  CityModel _selectedCity;
  // CountryModel _country;
  List<CityModel> _countryCities;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  }
// -----------------------------------------------------------------------------
  Future<void> _fetchSetCountryAndCities() async {
    final CountryModel _countryModel = await _zoneProvider.fetchCountryByID(context: context, countryID: _theCountryID);
    List<CityModel> _cities;
    if (Mapper.canLoopList(_countryModel?.citiesIDs)){
      _cities = await _zoneProvider.fetchCitiesByIDs(context: context, citiesIDs: _countryModel.citiesIDs);
    }

    setState(() {
      _countryCities = _cities;
    });
  }
// -----------------------------------------------------------------------------
  void _orderTheSexyWay({CityModel city}){

    final List<CityModel> _orderedCities = CityModel.orderCitiesPerNearestToCity(
        city: city,
        cities: _countryCities,
    );

    setState(() {
      _countryCities = _orderedCities;
    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final Name _cityName = Name.getNameByCurrentLingoFromNames(context: context, names: _city?.names);

    return MainLayout(
      pageTitle: 'Haversine',
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          const Stratosphere(),

          /// get country
          WideButton(
            verse: 'fetch country And Cities of : $_theCountryID',
            icon: Flag.getFlagIconByCountryID(_theCountryID),
            onTap: _fetchSetCountryAndCities,
          ),

          /// show cities IDs
          if (Mapper.canLoopList(_countryCities))
          ...List.generate(_countryCities.length, (index){

            final CityModel _city = _countryCities[index];
            final String _cityName = Name.getNameByCurrentLingoFromNames(context: context, names: _city?.names)?.value;
            // final GeoPoint _point = _city.position;

            final double _distance = haversineGeoPoints(pointA: _selectedCity?.position, pointB: _city.position);

            final String _selectedCityName = Name.getNameByCurrentLingoFromNames(context: context, names: _selectedCity?.names)?.value;
            final double _roundedDistance = roundFractions(_distance, 2);

            return DataStrip(
              dataKey: '${index + 1} : $_cityName',
              dataValue: 'is $_roundedDistance Km away from $_selectedCityName',
              onTap: (){

                // _orderByNearestCityTo(city: _city);

                _orderTheSexyWay(city: _city);

                setState(() {
                  _selectedCity = _city;
                });

              },
            );

          }),

          const Horizon(heightFactor: 1.2,),

        ],
      ),
    );
  }
}
