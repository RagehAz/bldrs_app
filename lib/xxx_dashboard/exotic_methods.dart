import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/big_mac.dart';
import 'package:bldrs/a_models/secondary_models/feedback_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/region_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as FireSearch;
import 'package:bldrs/e_db/fire/search/fire_search.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/notification_model/noti_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExoticMethods {

  const ExoticMethods({
   @required this.bitch,
});

  final dynamic bitch;
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAllCollectionDocs({
    @required String collName,
    String orderBy,
    bool addDocsIDs = false,
    int limit = 1000,
  }) async {

    final List<Map<String, dynamic>> _maps = await readCollectionDocs(
      collName: collName,
      limit: limit,
      orderBy: orderBy,
      addDocsIDs: addDocsIDs,
    );

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, dynamic>>> readAllSubCollectionDocs({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String orderBy,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readSubCollectionDocs(
      context: context,
      limit: 1000,
      collName: FireColl.zones,
      docName: docName,
      subCollName: subCollName,
      orderBy: orderBy,
    );

    return _maps;

  }
// -----------------------------------------------------------------------------
  static Future<List<UserModel>> readAllUserModels({@required int limit}) async {
  // List<UserModel> _allUsers = await ExoticMethods.readAllUserModels(limit: limit);

  List<UserModel> _allUserModels = <UserModel>[];

  final List<dynamic> _ldbUsers = await LDBOps.readAllMaps(
    docName: LDBDoc.users,
  );

  if (_ldbUsers.length < 4) {
    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collName: FireColl.users,
      orderBy: 'id',
    );

    _allUserModels = UserModel.decipherUsersMaps(
      maps: _maps,
      fromJSON: false,
    );

    for (final UserModel user in _allUserModels) {
      await LDBOps.insertMap(
        docName: LDBDoc.users,
        input: user.toMap(toJSON: true),
        primaryKey: 'id',
      );
    }
  } else {
    _allUserModels =
        UserModel.decipherUsersMaps(maps: _ldbUsers, fromJSON: true);
  }

  return _allUserModels;
}
// -----------------------------------------------------------------------------
  static Future<List<NotiModel>> readAllNotiModels({
  @required BuildContext context,
  @required String userID,
}) async {
  // List<NotiModel> _allNotiModels = await ExoticMethods.readAllNotiModels(context: context, userID: userID);

  final List<dynamic> _maps = await Fire.readSubCollectionDocs(
    context: context,
    collName: FireColl.users,
    docName: userID,
    subCollName: FireSubColl.users_user_notifications,
    addDocsIDs: true,
    limit: 50,

    /// TASK : CHECK NOTI LIMIT WHILE READING THEM
    orderBy: 'id',
  );

  final List<NotiModel> _allModels = NotiModel.decipherNotiModels(
    maps: _maps,
    fromJSON: false,
  );

  return _allModels;
}
// -----------------------------------------------------------------------------
  static Future<List<BzModel>> readAllBzzModels({
  @required BuildContext context,
  @required int limit,
}) async {
  // List<BzModel> _allBzz = await ExoticMethods.readAllBzzModels(context: context, limit: limit);

  final List<dynamic> _maps = await Fire.readCollectionDocs(
    limit: limit ?? 100,
    collName: FireColl.bzz,
    orderBy: 'id',
  );

  final List<BzModel> _allModels = BzModel.decipherBzz(
    maps: _maps,
    fromJSON: false,
  );

  return _allModels;
}
// -----------------------------------------------------------------------------
  static Future<List<FeedbackModel>> readAllFeedbacks({
  @required BuildContext context,
  @required int limit,
}) async {
  // List<FeedbackModel> _allFeedbacks = await ExoticMethods.readAllFeedbacks(context: context, limit: limit);

  final List<dynamic> _maps = await Fire.readCollectionDocs(
    limit: limit ?? 100,
    collName: FireColl.feedbacks,
    addDocsIDs: true,
    orderBy: 'timeStamp',
  );

  final List<FeedbackModel> _allModels = FeedbackModel.decipherFeedbacks(_maps);

  return _allModels;
}
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> readAllFlyers({
  @required BuildContext context,
  @required int limit,
}) async {
  // List<FlyerModel> _allFlyers = await ExoticMethods.readAllFlyers(context: context, limit: limit);

  final List<dynamic> _maps = await Fire.readCollectionDocs(
    limit: limit ?? 100,
    collName: FireColl.flyers,
    orderBy: 'id',
  );

  final List<FlyerModel> _allModels =
      FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

  return _allModels;
}
// -----------------------------------------------------------------------------
  static Future<List<CountryModel>> fetchAllCountryModels({
  @required BuildContext context,
}) async {
  final ZoneProvider zoneProvider =
      Provider.of<ZoneProvider>(context, listen: false);

  final List<String> _allCountriesIDs = CountryModel.getAllCountriesIDs();

  final List<CountryModel> _countries = <CountryModel>[];

  for (final String id in _allCountriesIDs) {

    final CountryModel _country = await zoneProvider.fetchCountryByID(
        context: context,
        countryID: id,
    );

    if (_country != null) {
      _countries.add(_country);
    }
  }

  return _countries;
}
// -----------------------------------------------------------------------------
  static Future<void> createContinentsDocFromAllCountriesCollection(BuildContext context) async {
  /// in case any (continent name) or (region name) or (countryID) has changed

  final List<CountryModel> _allCountries = await fetchAllCountryModels(context: context);

  final List<Continent> _continents = <Continent>[];

  for (final CountryModel country in _allCountries) {
    /// add continent
    final bool _continentIsAddedAlready = Continent.continentsIncludeContinent(
      name: country.continent,
      continents: _continents,
    );

    if (_continentIsAddedAlready == false) {
      _continents.add(Continent(
        name: country.continent,
        regions: <Region>[],
        globalCountriesIDs: <String>[],
        activatedCountriesIDs: <String>[],
      ));
    }

    /// add region to continent
    final int _continentIndex = _continents.indexWhere((Continent continent) => continent.name == country.continent);

    final bool _regionIsAddedAlready = Region.regionsIncludeRegion(
      name: country.region,
      regions: _continents[_continentIndex].regions,
    );

    if (_regionIsAddedAlready == false) {
      _continents[_continentIndex].regions.add(Region(
            continent: _continents[_continentIndex].name,
            name: country.region,
            countriesIDs: <String>[],
          ));
    }

    /// add country to region
    final int _regionIndex = _continents[_continentIndex]
        .regions
        .indexWhere((Region region) => region.name == country.region);

    final bool _countryIsAddedAlready = CountryModel.countriesIDsIncludeCountryID(
      countryID: country.id,
      countriesIDs: _continents[_continentIndex].regions[_regionIndex].countriesIDs,
    );

    if (_countryIsAddedAlready == false) {
      _continents[_continentIndex]
          .regions[_regionIndex]
          .countriesIDs
          .add(country.id);
    }

    blog('XXXXXXXXXXXXXXXXXXXXXXX ---> done with ${country.id}');
  }

  final Map<String, dynamic> _contMaps = Continent.cipherContinents(_continents);

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
    collName: 'admin',
    docName: 'bigMac',
    subCollName: 'bigMacs',
    limit: 250,
    orderBy: 'countryID',
  );

  final List<BigMac> _allBigMacs = BigMac.decipherBigMacs(_allMaps);

  return _allBigMacs;
}
// -----------------------------------------------------------------------------
/// super dangerous method,, take care !!
  static Future<void> updateAFieldInAllCollDocs({
  @required BuildContext context,
  @required String collName,
  @required String field,
  @required dynamic input
}) async {

  final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
    limit: 1000,
    collName: collName,
    addDocsIDs: true,
    orderBy: 'id',
  );

  for (final Map<String, dynamic> map in _maps) {
    await Fire.updateDocField(
        context: context,
        collName: collName,
        docName: map['id'],
        field: field,
        input: input);
  }

  blog('Tamam with : ${_maps.length} flyers updated their [$field] field');
}
// -----------------------------------------------------------------------------
  static Future<void> changeFieldName({
  @required BuildContext context,
}) async {
  blog('LET THE GAMES BEGIN');

  //   final List<CountryModel> _allModels = await ExoticMethods.fetchAllCountryModels(context: context);
  //   final String collName = FireColl.zones;
  //   final String newField = 'id';
  //   final String oldField = 'countryID';
  //
  //   for (var model in _allModels){
  //
  //     String oldID = model.countryID;
  //     dynamic input = oldID;
  //
  //     /// update
  //     await Fire.updateSubDocField(
  //       context: context,
  //       collName: collName,
  //       docName: 'countries',
  //       subCollName: 'countries',
  //       subDocName: oldID,
  //       field: newField,
  //       input: input,
  //     );
  //
  //
  //     /// delete
  //     await Fire.deleteSubDocField(
  //       context: context,
  //       collName: collName,
  //       docName: 'countries',
  //       subCollName: 'countries',
  //       subDocName: oldID,
  //       field: oldField,
  //     );
  //
  //
  // }
}
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static Future<void> takeOwnerShip({
  @required BuildContext context,
  @required String oldUserID, // '60a1SPzftGdH6rt15NF96m0j9Et2'
  @required String newUserID, // 'nM6NmPjhgwMKhPOsZVW4L1Jlg5N2'
}) async {

  /// Auth => can only be done in firebase
  /// security level => can only be done in firebase

  final BzzProvider _bzProvider = Provider.of<BzzProvider>(context, listen: false);
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _oldUserModel = await _usersProvider.fetchUserByID(context: context, userID: oldUserID);

  final List<String> _oldUserFlyersIDs = <String>[];

  for (final String bzID in _oldUserModel.myBzzIDs){
    final BzModel _bz = await _bzProvider.fetchBzModel(context: context, bzID: bzID);
    _oldUserFlyersIDs.addAll(_bz.flyersIDs);
    await _takeOverBz(context: context, oldUserID: oldUserID, newUserID: newUserID, bzModel: _bz);
  }

  await takeOverFlyers(context: context, newUserID: newUserID, flyersIDs: _oldUserFlyersIDs);

}
// -----------------------------------------------------------------------------
  static Future<void> _takeOverBz({
  @required BuildContext context,
  @required String oldUserID, // '60a1SPzftGdH6rt15NF96m0j9Et2'
  @required String newUserID, // 'nM6NmPjhgwMKhPOsZVW4L1Jlg5N2'
  @required BzModel bzModel,
}) async {

  if (bzModel != null && oldUserID != null && newUserID != null){

    final List<AuthorModel> _authors = bzModel.authors;

    final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(bzModel, oldUserID);

    if (_oldAuthor != null){

      final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
      final UserModel _newUserModel = await _usersProvider.fetchUserByID(
        context: context,
        userID: newUserID,
      );

      final AuthorModel _newAuthor = AuthorModel(
        userID: newUserID,
        title: _oldAuthor.title,
        contacts: _oldAuthor.contacts,
        name: _oldAuthor.name,
        isMaster: _oldAuthor.isMaster,
        pic: _newUserModel.pic,
      );

      final List<AuthorModel> _updatedAuthors = AuthorModel.replaceAuthorModelInAuthorsList(
        originalAuthors: _authors,
        oldAuthor: _oldAuthor,
        newAuthor: _newAuthor,
      );

      await Fire.updateDocField(
        context: context,
        collName: FireColl.bzz,
        docName: bzModel.id,
        field: 'authors',
        input: AuthorModel.cipherAuthors(_updatedAuthors),
      );

    }


  }

}
// -----------------------------------------------------------------------------
  static Future<void> takeOverFlyers({
  @required BuildContext context,
  @required String newUserID,
  @required List<String> flyersIDs,
}) async {

  for (final String id in flyersIDs){

    await Fire.updateDocField(
        context: context,
        collName: FireColl.flyers,
        docName: id,
        field: 'authorID',
        input: newUserID,
    );

    blog('flyer $id finished');

  }

}
/// ----------------------------------------------------------------------------
  static Future<void> assignBzzOwnership({
  @required BuildContext context,
  @required String userID,
  @required List<String> bzzIDs,
}) async {

  await  Fire.updateDocField(
      context: context,
      collName: FireColl.users,
      docName: userID,
      field: 'myBzzIDs',
      input: bzzIDs,
  );

}
/// ----------------------------------------------------------------------------
  static Future<List<BzModel>> searchBzzByAuthorID({
  @required BuildContext context,
  @required String authorID,
}) async {

  final List<Map<String, dynamic>> _bzzMaps = await FireSearch.mapsByFieldValue(
    context: context,
    collName: FireColl.bzz,
    field: 'authors.$authorID.userID',
    compareValue: authorID,
    valueIs: ValueIs.equalTo,
    limit: 100,
  );

  final List<BzModel> _foundBzz = BzModel.decipherBzz(maps: _bzzMaps, fromJSON: false);

  return _foundBzz;
}
/// ----------------------------------------------------------------------------
  // Future<List<CurrencyModel>> getCurrenciesFromCountries({@required BuildContext context}) async {
  //
  //   final List<CurrencyModel> _currencies = <CurrencyModel>[];
  //
  //   List<CountryModel> _countries = await fetchAllCountryModels(context: context);
  //
  //   for (var country in _countries){
  //
  //     final bool _currenciesContainCurrency = CurrencyModel.currenciesContainCurrency(
  //       currencyCode: country.currency,
  //       currencies: _currencies,
  //     );
  //
  //     /// add country to currency
  //     if (_currenciesContainCurrency == true){
  //
  //       final int _currencyIndex = _currencies.indexWhere((curr) => curr.code == country.currency);
  //       _currencies[_currencyIndex].countriesIDs.add(country.id);
  //
  //     }
  //
  //     /// add currency
  //     else {
  //
  //       final CurrencyModel _newCurrency = CurrencyModel(
  //         code: country.currency,
  //         countriesIDs: [country.id],
  //         names: [],
  //         symbol: null,
  //         digits: null,
  //         nativeSymbol: null,
  //       );
  //       _currencies.add(_newCurrency);
  //     }
  //
  //   }
  //
  //   return _currencies;
  // }
/// ----------------------------------------------------------------------------
  static Future<List<CountryModel>> readAllCountries({
    @required BuildContext context,
  }) async {

    final List<Map<String, dynamic>> allMaps = await readAllSubCollectionDocs(
      context: context,
      collName: FireColl.zones,
      docName: FireDoc.zones_countries,
      subCollName: FireSubColl.zones_countries_countries,
      orderBy: 'id',
    );

    final List<CountryModel> _countries = CountryModel.decipherCountriesMaps(
        maps: allMaps,
        fromJSON: false
    );

    return _countries;
  }
/// ----------------------------------------------------------------------------
  static Future<void> duplicateDoc({
  @required BuildContext context,
    @required String fromCollName,
    @required String docName,
    @required String toCollName,
}) async {

    final Map<String, dynamic> _doc = await Fire.readDoc(
      context: context,
      collName: fromCollName,
      docName: docName,
    );

    await Fire.createNamedDoc(
        context: context,
        collName: toCollName,
        docName: docName,
        input: _doc,
    );

  }
/// ----------------------------------------------------------------------------
}
