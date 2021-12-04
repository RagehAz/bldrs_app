import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/secondary_models/app_updates.dart';
import 'package:bldrs/models/secondary_models/big_mac.dart';
import 'package:bldrs/models/secondary_models/feedback_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/region_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

  Future<List<UserModel>> readAllUserModels({@required int limit}) async {
    // List<UserModel> _allUsers = await ExoticMethods.readAllUserModels(limit: limit);

    List<UserModel> _allUserModels = <UserModel>[];

    List<dynamic> _ldbUsers = await LDBOps.readAllMaps(
      docName: LDBDoc.users,
    );

    if (_ldbUsers.length < 4){

      final List<dynamic> _maps = await Fire.readCollectionDocs(
        limit: limit ?? 100,
        collName: FireColl.users,
        addDocSnapshotToEachMap: false,
        orderBy: 'id',
      );

      _allUserModels = UserModel.decipherUsersMaps(
        maps: _maps,
        fromJSON: false,
      );

      for (UserModel user in _allUserModels){

        await LDBOps.insertMap(
          docName: LDBDoc.users,
          input: user.toMap(toJSON: true),
          primaryKey: 'id',
        );

      }

    }

    else {
      _allUserModels = UserModel.decipherUsersMaps(maps: _ldbUsers, fromJSON: true);
    }


    return _allUserModels;
  }
// -----------------------------------------------------------------------------
  Future<List<NotiModel>> readAllNotiModels({@required BuildContext context, @required String userID,}) async {
    // List<NotiModel> _allNotiModels = await ExoticMethods.readAllNotiModels(context: context, userID: userID);

    final List<dynamic> _maps = await Fire.readSubCollectionDocs(
      context: context,
      collName: FireColl.users,
      docName: userID,
      subCollName: FireSubColl.users_user_notifications,
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
  Future<List<BzModel>> readAllBzzModels({@required BuildContext context, @required int limit,}) async {
    // List<BzModel> _allBzz = await ExoticMethods.readAllBzzModels(context: context, limit: limit);

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collName: FireColl.bzz,
      addDocSnapshotToEachMap: false,
      orderBy: 'id',
    );

    final List<BzModel> _allModels = BzModel.decipherBzz(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
// -----------------------------------------------------------------------------
  Future<List<FeedbackModel>> readAllFeedbacks({@required BuildContext context, @required int limit,}) async {
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
  Future<List<FlyerModel>> readAllFlyers({@required BuildContext context, @required int limit,}) async {
    // List<FlyerModel> _allFlyers = await ExoticMethods.readAllFlyers(context: context, limit: limit);

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collName: FireColl.flyers,
      addDocSnapshotToEachMap: false,
      addDocsIDs: false,
      orderBy: 'id',
    );

    final List<FlyerModel> _allModels = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

    return _allModels;
  }
// -----------------------------------------------------------------------------
  Future<List<CountryModel>> fetchAllCountryModels({@required BuildContext context, }) async {

    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    List<String> _allCountriesIDs = CountryModel.getAllCountriesIDs();

    List<CountryModel> _countries = <CountryModel>[];

    for (String id in _allCountriesIDs){

      CountryModel _country = await zoneProvider.fetchCountryByID(context: context, countryID: id);

      if (_country != null){
        _countries.add(_country);
      }

    }

    return _countries;
  }
// -----------------------------------------------------------------------------
  Future<void> createContinentsDocFromAllCountriesCollection(BuildContext context) async {
    /// in case any (continent name) or (region name) or (countryID) has changed

    final List<CountryModel> _allCountries = await fetchAllCountryModels(context: context);

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
      if (_regionIsAddedAlready == false){
        _continents[_continentIndex].regions.add(Region(
          continent: _continents[_continentIndex].name,
          name: country.region,
          countriesIDs: <String>[],
        ));
      }


      /// add country to region
      final int _regionIndex = _continents[_continentIndex].regions.indexWhere((Region region) => region.name == country.region);
      final bool _countryIsAddedAlready = CountryModel.countriesIDsIncludeCountryID(
        countryID: country.id,
        countriesIDs:  _continents[_continentIndex].regions[_regionIndex].countriesIDs,
      );
      if (_countryIsAddedAlready == false){
        _continents[_continentIndex].regions[_regionIndex].countriesIDs.add(country.id);
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
  Future<List<BigMac>> readAllBigMacs(BuildContext context) async {

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
  /// super dangerous method,, take care !!
  Future<void> updateAFieldInAllCollDocs({@required BuildContext context, @required String collName, @required String field, @required dynamic input}) async {

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      limit: 1000,
      collName: collName,
      addDocSnapshotToEachMap: false,
      addDocsIDs: true,
      orderBy: 'id',
    );

    for (Map<String, dynamic> map in _maps){

      await Fire.updateDocField(
          context: context,
          collName: collName,
          docName: map['id'],
          field: field,
          input: input
      );

    }

    print('Tamam with : ${_maps.length} flyers updated their [${field}] field');

  }
// -----------------------------------------------------------------------------
  Future<void> changeFieldName({@required BuildContext context,}) async {

      print('LET THE GAMES BEGIN');

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
  Future<void> uploadChainKeywords({@required BuildContext context, @required Chain chain, @required String docName,}) async {

    Map<String, dynamic> _keywordsMap = <String, dynamic>{};

    List<KW> _allKeywords = KW.getKeywordsFromChain(chain);

    // int numberOfKeyword = 0;

    for (KW keyword in _allKeywords){

      // numberOfKeyword++;

      _keywordsMap = Mapper.insertPairInMap(
          map: _keywordsMap,
          key: keyword.id,
          value: keyword.toMap(toJSON: false),
      );

      print('added keywordID : ${keyword.id}');

    }

    await Fire.createNamedDoc(
        context: context,
        collName: FireColl.keys,
        docName: docName,
        input: _keywordsMap,
    );

    // await Fire.createNamedDoc(
    //     context: context,
    //     collName: FireColl.keys,
    //     docName: FireColl.keys_stats,
    //     input:
    //     {
    //       'numberOfKeywords' : numberOfKeyword,
    //     }
    //
    // );

  }
// -----------------------------------------------------------------------------

// abstract class RagehMethods{
// -----------------------------------------------------------------------------
  Future<void> updateNumberOfKeywords(BuildContext context, List<KW> allKeywords) async {
    if (FireAuthOps.superUserID() == '60a1SPzftGdH6rt15NF96m0j9Et2'){

      if (Mapper.canLoopList(allKeywords)){

        final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
        final AppState _appState = _generalProvider.appState;
        if(_appState.numberOfKeywords != allKeywords.length){
          await Fire.updateDocField(context: context, collName: FireColl.admin, docName: FireDoc.admin_appState, field: 'numberOfKeywords', input: allKeywords.length);
        }

      }

    }

  }
// -----------------------------------------------------------------------------

/// -----------------------------------------------------------------------------
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
