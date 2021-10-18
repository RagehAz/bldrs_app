import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/helpers/big_mac.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/secondary_models/feedback_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/region_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ExoticMethods{
// -----------------------------------------------------------------------------
  static Future<List<UserModel>> readAllUserModels({@required int limit}) async {
    // List<UserModel> _allUsers = await ExoticMethods.readAllUserModels(limit: limit);

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireColl.users,
      addDocSnapshotToEachMap: false,
      orderBy: 'userID',
    );

    final List<UserModel> _allModels = UserModel.decipherUsersMaps(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<NotiModel>> readAllNotiModels({@required BuildContext context, @required String userID,}) async {
    // List<NotiModel> _allNotiModels = await ExoticMethods.readAllNotiModels(context: context, userID: userID);

    final List<dynamic> _maps = await Fire.readSubCollectionDocs(
      context: context,
      collName: FireColl.users,
      docName: userID,
      subCollName: FireColl.users_user_notifications,
      addDocsIDs: true,
    );

    final List<NotiModel> _allModels = NotiModel.decipherNotiModels(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<BzModel>> readAllBzzModels({@required BuildContext context, @required int limit,}) async {
    // List<BzModel> _allBzz = await ExoticMethods.readAllBzzModels(context: context, limit: limit);

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireColl.bzz,
      addDocSnapshotToEachMap: false,
      orderBy: 'bzID',
    );

    final List<BzModel> _allModels = BzModel.decipherBzzMaps(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<FeedbackModel>> readAllFeedbacks({@required BuildContext context, @required int limit,}) async {
    // List<FeedbackModel> _allFeedbacks = await ExoticMethods.readAllFeedbacks(context: context, limit: limit);


    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireColl.feedbacks,
      addDocSnapshotToEachMap: false,
      addDocID: true,
      orderBy: 'timeStamp',
    );

    final List<FeedbackModel> _allModels = FeedbackModel.decipherFeedbacks(_maps);

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> readAllFlyers({@required BuildContext context, @required int limit,}) async {
    // List<FlyerModel> _allFlyers = await ExoticMethods.readAllFlyers(context: context, limit: limit);

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireColl.flyers,
      addDocSnapshotToEachMap: false,
      addDocID: false,
      orderBy: 'flyerID',
    );

    final List<FlyerModel> _allModels = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<CountryModel>> fetchAllCountryModels({@required BuildContext context, }) async {

    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    List<String> _allCountriesIDs = CountryModel.getAllCountriesIDs();

    List<CountryModel> _countries = <CountryModel>[];

    for (var id in _allCountriesIDs){

      CountryModel _country = await zoneProvider.fetchCountryByID(context: context, countryID: id);

      if (_country != null){
        _countries.add(_country);
      }

    }

    return _countries;
  }
// -----------------------------------------------------------------------------
  static Future<void> createContinentsDocFromAllCountriesCollection(BuildContext context) async {
    /// in case any (continent name) or (region name) or (countryID) has changed

    final List<CountryModel> _allCountries = await ExoticMethods.fetchAllCountryModels(context: context);

    final List<Continent> _continents = <Continent>[];

    for (CountryModel country in _allCountries){

      /// add continent
      final bool _continentIsAddedAlready = Continent.continentsIncludeContinent(
        name: country.continent,
        continents: _continents,
      );
      if (_continentIsAddedAlready == false){
        _continents.add(Continent(
          name: country.continent,
          regions: [],
          globalCountriesIDs: [],
          activatedCountriesIDs: [],
        ));
      }


      /// add region to continent
      final int _continentIndex = _continents.indexWhere((continent) => continent.name == country.continent);
      final bool _regionIsAddedAlready = Region.regionsIncludeRegion(
        name: country.region,
        regions: _continents[_continentIndex].regions,
      );
      if (_regionIsAddedAlready == false){
        _continents[_continentIndex].regions.add(Region(
          continent: _continents[_continentIndex].name,
          name: country.region,
          countriesIDs: [],
        ));
      }


      /// add country to region
      final int _regionIndex = _continents[_continentIndex].regions.indexWhere((region) => region.name == country.region);
      final bool _countryIsAddedAlready = CountryModel.countriesIDsIncludeCountryID(
        countryID: country.countryID,
        countriesIDs:  _continents[_continentIndex].regions[_regionIndex].countriesIDs,
      );
      if (_countryIsAddedAlready == false){
        _continents[_continentIndex].regions[_regionIndex].countriesIDs.add(country.countryID);
      }

      print('XXXXXXXXXXXXXXXXXXXXXXX ---> done with ${country.names[0].value}');

    }

    Map<String, dynamic> _contMaps = Continent.cipherContinents(_continents);

    await Fire.createNamedDoc(
      context: context,
      collName: FireColl.admin,
      docName: 'continents',
      input: _contMaps,
    );

  }
// -----------------------------------------------------------------------------
  static Future<List<BigMac>> readAllBigMacs(BuildContext context) async {

    final List<dynamic> _allMaps = await Fire.readSubCollectionDocs(
      context: context,
      addDocsIDs: false,
      collName: 'admin',
      docName: 'bigMac',
      subCollName: 'bigMacs',
    );

    final List<BigMac> _allBigMacs = BigMac.decipherBigMacs(_allMaps);

    return _allBigMacs;
  }
// -----------------------------------------------------------------------------
}