import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/db/fire/ops/search_ops.dart';
import 'package:bldrs/db/fire/ops/zone_ops.dart';
import 'package:bldrs/db/ldb/ldb_ops.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

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
    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.countries,
      fieldToSortBy: 'id',
      searchField: 'id',
      searchValue: countryID,
    );
    if (_map != null && _map != {}){
      print('fetchCountryByID : country found in local db : ${LDBDoc.countries}');
      _countryModel = CountryModel.decipherCountryMap(map: _map, fromJSON: true);
    }

    /// 2 - if not found, search firebase
    if (_countryModel == null){
      print('fetchCountryByID : country NOT found in local db');

      /// 2.1 read firebase country ops
      _countryModel = await ZoneOps.readCountryOps(
        context: context,
        countryID: countryID,
      );

      /// 2.2 if found on firebase, store in ldb sessionCountries
      if (_countryModel != null){
        print('fetchCountryByID : country found in firestore db');

        await LDBOps.insertMap(
          input: _countryModel.toMap(toJSON: true),
          docName: LDBDoc.countries,
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

    if (cityID != null && cityID != ''){

      /// 1 - search in sessionCountries in LDB for this CountryModel
      final Map<String, Object> _map = await LDBOps.searchFirstMap(
        docName: LDBDoc.cities,
        fieldToSortBy: 'cityID',
        searchField: 'cityID',
        searchValue: cityID,
      );
      if (_map != null && _map != {}){
        print('fetchCityByID : City found in local db : ${LDBDoc.cities}');
        _cityModel = CityModel.decipherCityMap(map: _map, fromJSON: true);
      }

      /// 2 - if not found, search firebase
      if (_cityModel == null){
        print('fetchCityByID : City NOT found in local db');

        /// 2.1 read firebase country ops
        _cityModel = await ZoneOps.readCityOps(
          context: context,
          cityID: cityID,
        );

        /// 2.2 if found on firebase, store in ldb sessionCountries
        if (_cityModel != null){
          print('fetchCityByID : city found in firestore db');

          await LDBOps.insertMap(
            input: _cityModel.toMap(toJSON: true),
            docName: LDBDoc.cities,
            primaryKey: 'cityID',
          );

        }

      }

    }

    return _cityModel;
  }
// -----------------------------------------------------------------------------
  Future<CityModel> fetchCityByName({
    @required BuildContext context,
    String countryID,
    @required String cityName,
    @required String lingoCode,
  }) async {

    CityModel _city;

    if (TextChecker.stringIsNotEmpty(cityName) == true){

      /// A - trial 1 : search by generated cityID
      if (countryID != null){
        String _cityIDA = CityModel.createCityID(countryID: countryID, cityEnName: cityName);
        _city = await fetchCityByID(context: context, cityID: _cityIDA);
      }

      /// B - when trial 1 fails
      if (_city == null){

        List<CityModel> _foundCities;

        /// B-1 - trial 2 search ldb
        List<Map<String, dynamic>> _ldbCitiesMaps = await LDBOps.searchTrigram(
          searchValue: cityName,
          docName: LDBDoc.cities,
          lingoCode: lingoCode,
        );
        /// B-2 - if found results in ldb
        if (Mapper.canLoopList(_ldbCitiesMaps)){
          _foundCities = CityModel.decipherCitiesMaps(maps: _ldbCitiesMaps, fromJSON: true);
        }

        /// C - trial 3 search firebase if no result found in LDB
        if (Mapper.canLoopList(_foundCities) == false){

          /// C-1 - trial 3 if countryID is not available
          if (countryID == null){
            _foundCities = await FireSearch.citiesByCityName(
              context: context,
              cityName: cityName,
              lingoCode: lingoCode,
            );
          }

          /// C-1 - trial 3 if countryID is available
          else {
            _foundCities = await FireSearch.citiesByCityNameAndCountryID(
              context: context,
              cityName: cityName,
              countryID: countryID,
              lingoCode: lingoCode,
            );
          }

          /// C-2 - if firebase returned results
          if (Mapper.canLoopList(_foundCities) == true){

            /// insert all cities in ldb
            for (var city in _foundCities){
              await LDBOps.insertMap(
                input: city.toMap(toJSON: true),
                docName: LDBDoc.cities,
                primaryKey: 'cityID',
              );
            }

          }

        }

        /// D - if firebase or LDB found any cities
        if (Mapper.canLoopList(_foundCities) == true){

          print('aho fetchCityByName : _foundCities.length\ = ${_foundCities.length}');

          /// D-1 if only one city found
          if (_foundCities.length == 1){
            _city = _foundCities[0];
          }

          /// D-2 if multiple cities found
          else {

            CityModel _selectedCity = await Dialogz.confirmCityDialog(
              context: context,
              cities: _foundCities,
            );

            if (_selectedCity != null){
              _city = _selectedCity;
            }

          }

        }

      }

    }

    return _city;
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
      _continents = await ZoneOps.readContinentsOps(
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
  Future<void> getsetUserCountryAndCity({@required BuildContext context, @required ZoneModel zone}) async {

    final CountryModel _country = await fetchCountryByID(context: context, countryID: zone.countryID);
    final CityModel _city = await fetchCityByID(context: context, cityID: zone.cityID);

    _userCountyModel = _country;
    _userCityModel = _city;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// CURRENT ZONE & COUNTRY MODEL
  ZoneModel _currentZone;
  CountryModel _currentCountryModel;
  CityModel _currentCityModel;
// -------------------------------------
  ZoneModel get currentZone{return _currentZone;}
  CountryModel get currentCountry{return _currentCountryModel;}
  CityModel get currentCity{return _currentCityModel;}
// -------------------------------------
  Future<void> getsetCurrentZoneAndCountryAndCity({@required BuildContext context, @required ZoneModel zone}) async {

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
// -----------------------------------------------------------------------------
  Future<ZoneModel> getZoneModelByGeoPoint({@required BuildContext context, @required GeoPoint geoPoint}) async {

    ZoneModel _zoneModel;

    if (geoPoint != null){

      final List<Placemark> _marks = await ZoneOps.getAddressFromPosition(geoPoint: geoPoint);

      print('_getCountryData : got place marks : ${_marks.length}');

      if (Mapper.canLoopList(_marks)){

        final Placemark _mark = _marks[0];

        print('mark is : ${_mark}');

        final String _countryIso = _mark.isoCountryCode;
        final String _countryID = CountryIso.getCountryIDByIso(_countryIso);

        /// try by sub admin area
        final String _subAdministrativeArea = _mark.subAdministrativeArea;
        CityModel _foundCity = await fetchCityByName(context: context, countryID: _countryID, cityName: _subAdministrativeArea, lingoCode: 'en');

        /// try by admin area
        if (_foundCity == null){
          final String _administrativeArea = _mark.administrativeArea;
          _foundCity = await fetchCityByName(context: context, countryID: _countryID, cityName: _administrativeArea, lingoCode: 'en');
        }

        /// try by locality
        if (_foundCity == null){
          final String _locality = _mark.locality;
          _foundCity = await fetchCityByName(context: context, countryID: _countryID, cityName: _locality, lingoCode: 'en');
        }

        _zoneModel = ZoneModel(
          countryID: _countryID,
          cityID: _foundCity?.cityID,
          districtID: null,
        );

      }

    }

    return _zoneModel;
  }
// -----------------------------------------------------------------------------
  /// TASK : ACTIVATED & GLOBAL COUNTRIES
}
