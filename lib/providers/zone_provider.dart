import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/country_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/helpers/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:flutter/material.dart';

  // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// FETCHING ZONES
  Future<CountryModel> fetchCountryByID({@required BuildContext context, @required String countryID}) async {
    /// 1 - search in entire LDBs for this CountryModel
    /// 2 - if not found, search firebase
    ///   2.1 read firebase country ops
    ///   2.2 if found on firebase, store in ldb sessionCountries

    CountryModel _countryModel;

    /// 1 - search in sessionCountries in LDB for this CountryModel
    final Map<String, Object> _map = await LDBOps.searchMap(
      docName: LDBDoc.sessionCountries,
      fieldToSortBy: 'id',
      searchField: 'id',
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
          primaryKey: 'id',
        );

      }

    }

    return _countryModel;
  }
// -----------------------------------------------------------------------------
  Future<List<CountryModel>> fetchCountriesByIDs({@required BuildContext context, @required List<String> countriesIDs}) async {

    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.canLoopList(countriesIDs)){

      for (String id in countriesIDs){

        final CountryModel _country = await fetchCountryByID(context: context, countryID: id);

        _countries.add(_country);

      }

    }

    return _countries;
  }
// -----------------------------------------------------------------------------
  Future<CityModel> fetchCityByID({@required BuildContext context, @required String cityID}) async {
    /// 1 - search in entire LDBs for this CityModel
    /// 2 - if not found, search firebase
    ///   2.1 read firebase country ops
    ///   2.2 if found on firebase, store in ldb sessionCities

    CityModel _cityModel;

    /// 1 - search in sessionCountries in LDB for this CountryModel
    final Map<String, Object> _map = await LDBOps.searchMap(
      docName: LDBDoc.sessionCities,
      fieldToSortBy: 'cityID',
      searchField: 'cityID',
      searchValue: cityID,
    );
    if (_map != null && _map != {}){
      print('fetchCityByID : City found in local db : ${LDBDoc.sessionCities}');
      _cityModel = CityModel.decipherCityMap(map: _map, fromJSON: true);
    }

    /// 2 - if not found, search firebase
    if (_cityModel == null){
      print('fetchCityByID : City NOT found in local db');

      /// 2.1 read firebase country ops
      _cityModel = await CountryOps.readCityOps(
        context: context,
        cityID: cityID,
      );

      /// 2.2 if found on firebase, store in ldb sessionCountries
      if (_cityModel != null){
        print('fetchCityByID : city found in firestore db');

        await LDBOps.insertMap(
          input: _cityModel.toMap(toJSON: true),
          docName: LDBDoc.sessionCities,
          primaryKey: 'cityID',
        );

      }

    }

    return _cityModel;
  }
// -----------------------------------------------------------------------------
  Future<List<CityModel>> fetchCitiesByIDs({@required BuildContext context, @required List<String> citiesIDs}) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.canLoopList(citiesIDs)){

      for (String id in citiesIDs){

        final CityModel _city = await fetchCityByID(context: context, cityID: id);

        if (_city != null){

          _cities.add(_city);

        }

      }

    }

    return _cities;
  }
// -----------------------------------------------------------------------------
  Future<List<Continent>> fetchContinents({@required BuildContext context}) async {

    List<Continent> _continents;

    /// 1 - search in sessionCountries in LDB for this CountryModel
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.continents,
    );

    if (Mapper.canLoopList(_maps)){
      print('fetchCountryByID : country found in local db : ${LDBDoc.continents}');
      _continents = Continent.decipherContinents(_maps[0]);
    }

    /// 2 - if not found, search firebase
    if (_continents == null){
      print('fetchCountryByID : country NOT found in local db');

      /// 2.1 read firebase country ops
      _continents = await CountryOps.readContinentsOps(
        context: context,
      );

      /// 2.2 if found on firebase, store in ldb sessionCountries
      if (_continents != null){
        print('fetchCountryByID : country found in firestore db');

        await LDBOps.insertMap(
          input: Continent.cipherContinents(_continents),
          docName: LDBDoc.continents,
          primaryKey: 'name',
        );

      }

    }

    return _continents;

  }
// -----------------------------------------------------------------------------
  /// CONTINENTS
  Continent _currentContinent;
// -------------------------------------
  Continent get currentContinent{
    return _currentContinent;
  }
// -------------------------------------
  Future<void> getsetContinentByCountryID({@required BuildContext context, @required String countryID}) async {
    final List<Continent> _allContinents = await fetchContinents(context: context);
    final Continent _continent = Continent.getContinentFromContinentsByCountryID(continents: _allContinents, countryID: countryID);

    _currentContinent = _continent;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  Future<List<CountryModel>> getContinentActivatedCountries(BuildContext context) async {

    List<String> _countriesIDs = _currentContinent.activatedCountriesIDs;

    List<CountryModel> _countries = await fetchCountriesByIDs(context: context, countriesIDs: _countriesIDs);

    return _countries;
  }
// -----------------------------------------------------------------------------
  /// USER COUNTRY MODEL
  CountryModel _userCountyModel;
  CityModel _userCityModel;
// -------------------------------------
  CountryModel get userCountryModel{
    return _userCountyModel;
  }
  CityModel get userCityModel{
    return _userCityModel;
  }
// -------------------------------------
  Future<void> getsetUserCountryAndCity({@required BuildContext context, @required Zone zone}) async {

    final CountryModel _country = await fetchCountryByID(context: context, countryID: zone.countryID);
    final CityModel _city = await fetchCityByID(context: context, cityID: zone.cityID);

    _userCountyModel = _country;
    _userCityModel = _city;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// CURRENT ZONE & COUNTRY MODEL
  Zone _currentZone;
  CountryModel _currentCountryModel;
  CityModel _currentCityModel;
// -------------------------------------
  Zone get currentZone{return _currentZone;}
  CountryModel get currentCountry{return _currentCountryModel;}
  CityModel get currentCity{return _currentCityModel;}
// -------------------------------------
  Future<void> getsetCurrentZoneAndCountryAndCity({@required BuildContext context, @required Zone zone}) async {

    final CountryModel _country = await fetchCountryByID(context: context, countryID: zone.countryID);
    final CityModel _city = await fetchCityByID(context: context, cityID: zone.cityID);

    _currentZone = zone;
    _currentCountryModel = _country;
    _currentCityModel = _city;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// ZONES NAMES
  String getCurrentCountryNameByCurrentLingo(BuildContext context){
    final String _name = Name.getNameByCurrentLingoFromNames(context, _currentCountryModel.names);
    return _name;
  }
// -------------------------------------
  String getCityNameWithCurrentLingoIfPossible(BuildContext context, String cityID){

    final String _nameInCurrentLanguage = Name.getNameByCurrentLingoFromNames(context, _currentCityModel?.names);

    return _nameInCurrentLanguage == null ? cityID : _nameInCurrentLanguage;
  }

  /// TASK : ACTIVATED & GLOBAL COUNTRIES
}
