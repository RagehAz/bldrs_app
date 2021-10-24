import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
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

    List<UserModel> _allUserModels = <UserModel>[];

    List<dynamic> _ldbUsers = await LDBOps.readAllMaps(
      docName: LDBDoc.sessionUsers,
    );

    if (_ldbUsers.length < 4){

      final List<dynamic> _maps = await Fire.readCollectionDocs(
        limit: limit ?? 100,
        collName: FireColl.users,
        addDocSnapshotToEachMap: false,
        orderBy: 'userID',
      );

      _allUserModels = UserModel.decipherUsersMaps(
        maps: _maps,
        fromJSON: false,
      );

      for (var user in _allUserModels){

        await LDBOps.insertMap(
          docName: LDBDoc.sessionUsers,
          input: user.toMap(toJSON: true),
        );

      }

    }

    else {
      _allUserModels = UserModel.decipherUsersMaps(maps: _ldbUsers, fromJSON: true);
    }


    return _allUserModels;
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
      limit: 50, /// TASK : CHECK NOTI LIMIT WHILE READING THEM
      orderBy: 'id',
      addDocSnapshotToEachMap: false,

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
      collName: FireColl.bzz,
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
      collName: FireColl.feedbacks,
      addDocSnapshotToEachMap: false,
      addDocsIDs: true,
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
      collName: FireColl.flyers,
      addDocSnapshotToEachMap: false,
      addDocsIDs: false,
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
      limit: 250,
      orderBy: 'countryID',
      addDocSnapshotToEachMap: false,
    );

    final List<BigMac> _allBigMacs = BigMac.decipherBigMacs(_allMaps);

    return _allBigMacs;
  }
// -----------------------------------------------------------------------------
}