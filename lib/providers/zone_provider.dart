import 'package:bldrs/db/firestore/country_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:flutter/material.dart';

// final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
  /// FETCHING ZONES
  /// 1 - search in entire LDBs for this CountryModel
  /// 2 - if not found, search firebase
  ///   2.1 read firebase country ops
  ///   2.2 if found on firebase, store in ldb sessionCountries
  Future<CountryModel> fetchCountryByID({BuildContext context, String countryID}) async {

    CountryModel _countryModel;

    /// 1 - search in sessionCountries in LDB for this CountryModel
    final Map<String, Object> _map = await LDBOps.searchMap(
      docName: LDBDoc.sessionCountries,
      fieldToSortBy: 'countryID',
      searchField: 'countryID',
      searchValue: countryID,
    );
    if (_map != null && _map != {}){
      print('fetchCountryByID : country found in local db : ${LDBDoc.sessionCountries}');
      _countryModel = CountryModel.decipherCountryMap(map: _map, fromJSON: true);
    }

    /// 2 - if not found, search firebase
    if (_countryModel == null){
      print('fetchCountryByID : country NOT found in local db');

      /// 2.1 read firebase country ops
      _countryModel = await CountryOps.readCountryOps(
        context: context,
        countryID: countryID,
      );

      /// 2.2 if found on firebase, store in ldb sessionCountries
      if (_countryModel != null){
        print('fetchCountryByID : country found in firestore db');

        await LDBOps.insertMap(
          input: _countryModel.toMap(toJSON: true),
          docName: LDBDoc.sessionCountries,
        );

      }

    }

    return _countryModel;
  }
// -----------------------------------------------------------------------------
  /// CURRENT ZONE & COUNTRY MODEL
  Zone _currentZone;
  CountryModel _currentCountryModel;
// -------------------------------------
  Zone get currentZone{return _currentZone;}
  CountryModel get currentCountryModel{return _currentCountryModel;}
// -------------------------------------
  Future<void> getsetZoneAndCountry({@required BuildContext context, @required Zone zone}) async {

    final CountryModel _country = await fetchCountryByID(context: context, countryID: zone.countryID);

    _currentZone = zone;
    _currentCountryModel = _country;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  String getCurrentCountryNameByCurrentLingo(BuildContext context){
    final String _name = Name.getNameByCurrentLingoFromNames(context, _currentCountryModel.names);
    return _name;
  }
// -----------------------------------------------------------------------------
  List<Map<String,String>> getCurrentCountryCitiesNamesIDValuesMapsByCurrentLingo(BuildContext context){

    final List<Map<String,String>> _citiesNames = <Map<String,String>>[];

    _currentCountryModel.cities.forEach((city) {

      _citiesNames.add(
          {
            'id': city.cityID,
            'value': Name.getNameByCurrentLingoFromNames(context, city.names),
          }
      );


    }
    );

    return _citiesNames;
  }
// -----------------------------------------------------------------------------
  /// get available countries
  List<String> getCountriesIDsByContinent({BuildContext context,String continent}){
    final List<String> _countriesIDs = <String>[];

    // _countries.forEach((co) {
    //   if (
    //   // co.isActivated == true &&
    //   co.continent == continent) {
    //     _countriesIDs.add(co.countryID);
    //   }
    // });

    return _countriesIDs;
  }

}
