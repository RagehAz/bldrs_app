import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/country_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:flutter/material.dart';

// final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// FETCHING ZONES
  Future<Country> fetchCountryByID({@required BuildContext context, @required String countryID}) async {
    /// 1 - search in entire LDBs for this CountryModel
    /// 2 - if not found, search firebase
    ///   2.1 read firebase country ops
    ///   2.2 if found on firebase, store in ldb sessionCountries

    Country _countryModel;

    /// 1 - search in sessionCountries in LDB for this CountryModel
    final Map<String, Object> _map = await LDBOps.searchMap(
      docName: LDBDoc.sessionCountries,
      fieldToSortBy: 'countryID',
      searchField: 'countryID',
      searchValue: countryID,
    );
    if (_map != null && _map != {}){
      print('fetchCountryByID : country found in local db : ${LDBDoc.sessionCountries}');
      _countryModel = Country.decipherCountryMap(map: _map, fromJSON: true);
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
  Future<List<Country>> fetchCountriesByIDs({@required BuildContext context, @required List<String> countriesIDs}) async {

    final List<Country> _countries = <Country>[];

    if (Mapper.canLoopList(countriesIDs)){

      for (String id in countriesIDs){

        final Country _country = await fetchCountryByID(context: context, countryID: id);

        _countries.add(_country);

      }

    }

    return _countries;
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
  Future<List<Country>> getContinentActivatedCountries(BuildContext context) async {

    List<String> _countriesIDs = _currentContinent.activatedCountriesIDs;

    List<Country> _countries = await fetchCountriesByIDs(context: context, countriesIDs: _countriesIDs);

    return _countries;
  }
// -----------------------------------------------------------------------------
  /// USER COUNTRY MODEL
  Country _userCountyModel;
// -------------------------------------
  Country get userCountryModel{
    return _userCountyModel;
  }
// -------------------------------------
  Future<void> getsetUserCountry({@required BuildContext context, @required Zone zone}) async {

    final Country _country = await fetchCountryByID(context: context, countryID: zone.countryID);

    _userCountyModel = _country;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// CURRENT ZONE & COUNTRY MODEL
  Zone _currentZone;
  Country _currentCountryModel;
// -------------------------------------
  Zone get currentZone{return _currentZone;}
  Country get currentCountry{return _currentCountryModel;}
// -------------------------------------
  Future<void> getsetCurrentZoneAndCountry({@required BuildContext context, @required Zone zone}) async {

    final Country _country = await fetchCountryByID(context: context, countryID: zone.countryID);

    _currentZone = zone;
    _currentCountryModel = _country;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// ZONES NAMES
  String getCurrentCountryNameByCurrentLingo(BuildContext context){
    final String _name = Name.getNameByCurrentLingoFromNames(context, _currentCountryModel.names);
    return _name;
  }
// -------------------------------------

// -------------------------------------
  String getCityNameWithCurrentLingoIfPossible(BuildContext context, String cityID){
    final City _city = currentCountry.cities.firstWhere((city) => city.cityID == cityID, orElse: ()=> null);

    final String _nameInCurrentLanguage = Name.getNameByCurrentLingoFromNames(context, _city?.names);

    return _nameInCurrentLanguage == null ? cityID : _nameInCurrentLanguage;
  }

}
