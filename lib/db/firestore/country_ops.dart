import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:flutter/material.dart';


class CountryOps{

// -----------------------------------------------------------------------------
  static Future<CountryModel> readCountryOps({@required BuildContext context, @required String countryID}) async {

    final Map<String, dynamic> _map = await Fire.readSubDoc(
      context: context,
      collName: FireColl.zones,
      docName: 'countries',
      subCollName: 'countries',
      subDocName: countryID,
    );

    final CountryModel _countryModel = CountryModel.decipherCountryMap(map: _map, fromJSON: false);

    return _countryModel;
  }
// -----------------------------------------------------------------------------
  static Future<CityModel> readCityOps({@required BuildContext context, @required String cityID}) async {

    final Map<String, dynamic> _map = await Fire.readSubDoc(
      context: context,
      collName: FireColl.zones,
      docName: 'cities',
      subCollName: 'cities',
      subDocName: cityID,
    );

    final CityModel _cityModel = CityModel.decipherCityMap(map: _map, fromJSON: false);

    return _cityModel;
  }
// -----------------------------------------------------------------------------
  static Future<List<CityModel>> readCountryCitiesOps({@required BuildContext context, @required String countryID}) async {

    final CountryModel _country = await readCountryOps(context: context, countryID: countryID);

    List<CityModel> _cities = <CityModel>[];

    if (_country != null){

      final List<String> _citiesIDs = _country.citiesIDs;

      if (Mapper.canLoopList(_citiesIDs)){

        for (String id in _citiesIDs){

          final CityModel _city = await readCityOps(context: context, cityID: id);

          if (_city!= null){
            _cities.add(_city);
          }

        }

      }

    }

    return _cities;
  }
// -----------------------------------------------------------------------------
  static Future<List<Continent>> readContinentsOps({@required BuildContext context}) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: 'continents',
    );

    final List<Continent> _allContinents = Continent.decipherContinents(_map);

    return _allContinents;
  }
// -----------------------------------------------------------------------------
//   Future<void> updateCountryDoc() async {}
// // -----------------------------------------------------------------------------

}
