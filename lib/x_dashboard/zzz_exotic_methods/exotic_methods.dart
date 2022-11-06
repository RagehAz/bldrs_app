import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/h_money/big_mac.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/continent_model.dart';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/region_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExoticMethods {
  // -----------------------------------------------------------------------------

  const ExoticMethods();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readAllCollectionDocs({
    @required String collName,
    QueryOrderBy orderBy,
    bool addDocsIDs = false,
    int limit = 1000,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      collName: collName,
      limit: limit,
      orderBy: orderBy,
      addDocsIDs: addDocsIDs,
    );

    return _maps;
  }
  // -----------------------------------------------------------------------------
  static Future<List<Map<String, dynamic>>> readAllSubCollectionDocs({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required QueryOrderBy orderBy,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readSubCollectionDocs(
      limit: 1000,
      collName: FireColl.zones,
      docName: docName,
      subCollName: subCollName,
      orderBy: orderBy,
    );

    return _maps;

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserModel>> readAllUserModels({
    @required int limit,
  }) async {
    // List<UserModel> _allUsers = await ExoticMethods.readAllUserModels(limit: limit);

    List<UserModel> _allUserModels = <UserModel>[];

    final List<dynamic> _ldbUsers = await LDBOps.readAllMaps(
      docName: LDBDoc.users,
    );

    if (_ldbUsers.length < 4) {
      final List<dynamic> _maps = await Fire.readCollectionDocs(
        limit: limit ?? 100,
        collName: FireColl.users,
        orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
      );

      _allUserModels = UserModel.decipherUsers(
        maps: _maps,
        fromJSON: false,
      );

      for (final UserModel user in _allUserModels) {
        await LDBOps.insertMap(
          docName: LDBDoc.users,
          input: user.toMap(toJSON: true),
        );
      }
    } else {
      _allUserModels = UserModel.decipherUsers(maps: _ldbUsers, fromJSON: true);
    }

    return _allUserModels;
  }
  // -----------------------------------------------------------------------------
  static Future<List<NoteModel>> readAllNoteModels({
    @required String userID,
  }) async {
    // List<NotiModel> _allNotiModels = await ExoticMethods.readAllNotiModels(context: context, userID: userID);

    final List<dynamic> _maps = await Fire.readSubCollectionDocs(
      collName: FireColl.users,
      docName: userID,
      subCollName: FireSubColl.noteReceiver_receiver_notes,
      addDocsIDs: true,
      limit: 50,

      /// TASK : CHECK NOTI LIMIT WHILE READING THEM
      orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
    );

    final List<NoteModel> _allModels = NoteModel.decipherNotes(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
  // -----------------------------------------------------------------------------
  static Future<List<BzModel>> readAllBzzModels({
    @required int limit,
  }) async {
    // List<BzModel> _allBzz = await ExoticMethods.readAllBzzModels(context: context, limit: limit);

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collName: FireColl.bzz,
      orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
    );

    final List<BzModel> _allModels = BzModel.decipherBzz(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
  // -----------------------------------------------------------------------------
//   static Future<List<FeedbackModel>> readAllFeedbacks({
//   @required BuildContext context,
//   @required int limit,
// }) async {
  // List<FeedbackModel> _allFeedbacks = await ExoticMethods.readAllFeedbacks(context: context, limit: limit);

  // final List<dynamic> _maps = await Real.readColl(
  //   context: context,
  //   limit: limit ?? 100,
  //   nodePath: RealColl.feedbacks,
  //   addDocsIDs: true,
  //   orderBy: const QueryOrderBy(fieldName: 'timeStamp', descending: true),
  // );
  //
  // final List<FeedbackModel> _allModels = FeedbackModel.decipherFeedbacks(_maps);

//   return _allModels;
// }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> readAllFlyers({
    @required int limit,
  }) async {
    // List<FlyerModel> _allFlyers = await ExoticMethods.readAllFlyers(context: context, limit: limit);

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collName: FireColl.flyers,
      orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
    );

    final List<FlyerModel> _allModels =
    FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

    return _allModels;
  }
  // -----------------------------------------------------------------------------
  static Future<List<CountryModel>> fetchAllCountryModels() async {

    final List<String> _allCountriesIDs = CountryModel.getAllCountriesIDs();

    final List<CountryModel> _countries = <CountryModel>[];

    for (final String id in _allCountriesIDs) {

      final CountryModel _country = await ZoneProtocols.fetchCountry(
        countryID: id,
      );

      if (_country != null) {
        _countries.add(_country);
      }
    }

    return _countries;
  }
  // -----------------------------------------------------------------------------
  static Future<void> createContinentsDocFromAllCountriesCollection() async {
    /// in case any (continent name) or (region name) or (countryID) has changed

    final List<CountryModel> _allCountries = await fetchAllCountryModels();

    final List<Continent> _continents = <Continent>[];

    for (final CountryModel country in _allCountries) {
      /// add continent
      final bool _continentIsAddedAlready = Continent.checkContinentsIncludeContinent(
        name: country.continent,
        continents: _continents,
      );

      if (_continentIsAddedAlready == false) {
        _continents.add(Continent(
          name: country.continent,
          regions: const <Region>[],
          globalCountriesIDs: const <String>[],
          activatedCountriesIDs: const <String>[],
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
          countriesIDs: const <String>[],
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
      collName: FireColl.admin,
      docName: 'continents',
      input: _contMaps,
    );

  }
  // -----------------------------------------------------------------------------
  static Future<List<BigMac>> readAllBigMacs() async {

    final List<dynamic> _allMaps = await Fire.readSubCollectionDocs(
      collName: 'admin',
      docName: 'bigMac',
      subCollName: 'bigMacs',
      limit: 250,
      orderBy: const QueryOrderBy(fieldName: 'countryID', descending: true),
    );

    final List<BigMac> _allBigMacs = BigMac.decipherBigMacs(_allMaps);

    return _allBigMacs;
  }
  // -----------------------------------------------------------------------------
  /// super dangerous method,, take care !!
  static Future<void> updateAFieldInAllCollDocs({
    @required String collName,
    @required String field,
    @required dynamic input
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      limit: 1000,
      collName: collName,
      addDocsIDs: true,
      orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
    );

    for (final Map<String, dynamic> map in _maps) {
      await Fire.updateDocField(
          collName: collName,
          docName: map['id'],
          field: field,
          input: input);
    }

    blog('Tamam with : ${_maps.length} flyers updated their [$field] field');
  }
  // -----------------------------------------------------------------------------
  static Future<void> takeOwnerShip({
    @required BuildContext context,
    @required String oldUserID, // '60a1SPzftGdH6rt15NF96m0j9Et2'
    @required String newUserID, // 'nM6NmPjhgwMKhPOsZVW4L1Jlg5N2'
  }) async {

    /// Auth => can only be done in firebase
    /// security level => can only be done in firebase

    final UserModel _oldUserModel = await UserProtocols.fetch(
      context: context,
      userID: oldUserID,
    );

    final List<String> _oldUserFlyersIDs = <String>[];

    for (final String bzID in _oldUserModel.myBzzIDs){
      final BzModel _bz = await BzProtocols.fetch(context: context, bzID: bzID);
      _oldUserFlyersIDs.addAll(_bz.flyersIDs);
      await _takeOverBz(context: context, oldUserID: oldUserID, newUserID: newUserID, bzModel: _bz);
    }

    await takeOverFlyers(
        newUserID: newUserID,
        flyersIDs: _oldUserFlyersIDs,
    );

  }
  // -----------------------------------------------------------------------------
  static Future<void> _takeOverBz({
    @required BuildContext context,
    @required String oldUserID,
    @required String newUserID,
    @required BzModel bzModel,
  }) async {

    if (bzModel != null && oldUserID != null && newUserID != null){

      final List<AuthorModel> _authors = bzModel.authors;

      final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(
        bz: bzModel,
        authorID: oldUserID,
      );

      if (_oldAuthor != null){

        final UserModel _newUserModel = await UserProtocols.fetch(
          context: context,
          userID: newUserID,
        );

        final AuthorModel _newAuthor = _oldAuthor.copyWith(
          userID: newUserID,
          picPath: _newUserModel.picPath,
        );

        final List<AuthorModel> _updatedAuthors = AuthorModel.replaceAuthorModelInAuthorsListByID(
          authors: _authors,
          authorToReplace: _newAuthor,
        );

        await Fire.updateDocField(
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
    @required String newUserID,
    @required List<String> flyersIDs,
  }) async {

    for (final String id in flyersIDs){

      await Fire.updateDocField(
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
    @required String userID,
    @required List<String> bzzIDs,
  }) async {

    await  Fire.updateDocField(
      collName: FireColl.users,
      docName: userID,
      field: 'myBzzIDs',
      input: bzzIDs,
    );

  }
  /// ----------------------------------------------------------------------------
  static Future<List<BzModel>> searchBzzByAuthorID({
    @required String authorID,
    @required QueryDocumentSnapshot<Object> startAfter,
    int limit = 10,
  }) async {

    final List<Map<String, dynamic>> _bzzMaps = await Fire.readCollectionDocs(
      collName: FireColl.bzz,
      limit: limit,
      startAfter: startAfter,
      addDocSnapshotToEachMap: true,
      finders: <FireFinder>[

        FireFinder(
          field: 'authors.$authorID.userID',
          comparison: FireComparison.equalTo,
          value: authorID,
        ),

      ],
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
  static Future<List<CountryModel>> readAllCountries() async {

    final List<Map<String, dynamic>> allMaps = await readAllSubCollectionDocs(
      collName: FireColl.zones,
      docName: FireDoc.zones_countries,
      subCollName: FireSubColl.zones_countries_countries,
      orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
    );

    final List<CountryModel> _countries = CountryModel.decipherCountriesMaps(
      maps: allMaps,
    );

    return _countries;
  }
  /// ----------------------------------------------------------------------------
  static Future<void> duplicateDoc({
    @required String fromCollName,
    @required String docName,
    @required String toCollName,
  }) async {

    final Map<String, dynamic> _doc = await Fire.readDoc(
      collName: fromCollName,
      docName: docName,
    );

    await Fire.createNamedDoc(
      collName: toCollName,
      docName: docName,
      input: _doc,
    );

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> changeDocFieldName({
    @required String collName,
    @required String docName,
    @required String oldFieldName,
    @required String newFieldName,
  }) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
        collName: collName,
        docName: docName
    );

    if (_map != null){

      await Fire.deleteDocField(
        collName: collName,
        docName: docName,
        field: oldFieldName,
      );


      await Fire.updateDocField(
        collName: collName,
        docName: docName,
        field: newFieldName,
        input: _map[oldFieldName],
      );

    }

  }
/// ----------------------------------------------------------------------------
}
