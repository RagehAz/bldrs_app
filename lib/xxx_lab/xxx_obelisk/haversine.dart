import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/data_strip.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Haversine extends StatefulWidget {
  const Haversine({Key key}) : super(key: key);

  @override
  State<Haversine> createState() => _HaversineState();
}

class _HaversineState extends State<Haversine> {
  final String _theCountryID = 'are';

  ZoneProvider _zoneProvider;
  CityModel _selectedCity;
  CountryModel _country;
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
      _country = _countryModel;
      _countryCities = _cities;
    });
  }
// -----------------------------------------------------------------------------
  void _orderByNearestCityTo({@required CityModel city}){


    final List<MapModel> _mapModels = <MapModel>[];

    for (final CityModel _city in _countryCities){

        final double _distance = haversineGeoPoints(pointA: city.position, pointB: _city.position);

        final MapModel _maw = MapModel(
          value: _distance,
          key: _city.cityID,
        );

        _mapModels.add(_maw);

        // blog('${_city.cityID} is $_distance Km away from ${city.cityID}');

    }

    _mapModels.sort((MapModel modelA, MapModel modelB){
      return modelA.value.compareTo(modelB.value);
    });

    MapModel.blogMapModels(_mapModels);

  }
// -----------------------------------------------------------------------------
  void _orderTheSexyWay({CityModel city}){

      /// sorting
    _countryCities.sort((CityModel cityA, CityModel cityB){

      final double _distanceA = haversineGeoPoints(pointA: cityA.position, pointB: city.position);
      final double _distanceB = haversineGeoPoints(pointA: cityB.position, pointB: city.position);

      return _distanceA.compareTo(_distanceB);
    });

    /// blogger
    for (int i = 0; i < _countryCities.length; i++){
      final int _num = i+1;
      final CityModel _city = _countryCities[i];
      final double distance = haversineGeoPoints(pointA: _city.position, pointB: city.position);
      blog('$_num : ${_city.cityID} : $distance');
    }

    setState(() {

    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final Name _cityName = Name.getNameByCurrentLingoFromNames(context: context, names: _city?.names);

    return MainLayout(
      pageTitle: 'Pythagoras',
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
            final GeoPoint _point = _city.position;

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
