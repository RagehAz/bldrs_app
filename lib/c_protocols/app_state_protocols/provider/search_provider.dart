import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/a_models/x_secondary/search_result.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/record_protocols/real/record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
class SearchProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// --- IS SEARCHING

  // --------------------
  bool _isSearchingCountry = false;
  bool _isSearchingCity = false;
  bool _isSearchingDistrict = false;
  bool _isSearchingFlyersAndBzz = false;
  // --------------------
  bool get isSearchingCountry => _isSearchingCountry;
  bool get isSearchingCity => _isSearchingCity;
  bool get isSearchingDistrict => _isSearchingDistrict;
  bool get isSearchingFlyersAndBzz => _isSearchingFlyersAndBzz;
  // --------------------
  void triggerIsSearching({
    @required SearchingModel searchingModel,
    @required bool setIsSearchingTo,
    @required bool notify,
  }){

    if (searchingModel == SearchingModel.country){
      _isSearchingCountry = setIsSearchingTo;
    }

    else if (searchingModel == SearchingModel.city){
      _isSearchingCity = setIsSearchingTo;
    }

    else if (searchingModel == SearchingModel.district){
      _isSearchingDistrict = setIsSearchingTo;
    }

    else if (searchingModel == SearchingModel.flyersAndBzz){
      _isSearchingFlyersAndBzz = setIsSearchingTo;
    }

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void triggerIsSearchingAfterMaxTextLength({
    @required String text,
    @required SearchingModel searchModel,
    @required bool isSearching,
    @required bool setIsSearchingTo,
    int maxTextLength = 3,
  }){

    // blog('triggerIsSearchingAfterTextLengthIsAt receives : text : $text : Length ${text.length}: _isSearching : $_isSearching');

    /// A - not searching
    if (isSearching == false) {
      /// A.1 starts searching
      if (text.length >= maxTextLength) {
        triggerIsSearching(
          searchingModel: searchModel,
          setIsSearchingTo: true,
          notify: true,
        );
      }
    }

    /// B - while searching
    else {
      /// B.1 ends searching
      if (text.length < maxTextLength) {
        triggerIsSearching(
          searchingModel: searchModel,
          setIsSearchingTo: false,
          notify: true,
        );
      }

    }

    /// CAUTION : [triggerIsSearching] method has notifyListeners();
  }
  // --------------------
  void closeAllZoneSearches({
    @required bool notify,
  }){

    _isSearchingCountry = false;
    _isSearchingCity = false;
    _isSearchingDistrict = false;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void closeAllSearches({
    @required bool notify,
  }){

    _isSearchingFlyersAndBzz = false;
    closeAllZoneSearches(
      notify: notify,
    );


  }
  // -----------------------------------------------------------------------------

  /// SEARCH RESULT

  // --------------------
  List<SearchResult> _searchResult = <SearchResult>[];
  // --------------------
  List<SearchResult> get searchResult {
    return [..._searchResult];
  }
  // --------------------
  void setSearchResult ({
    @required List<SearchResult> result,
    @required bool notify,
  }){

    _searchResult = result;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void clearSearchResult({
    @required bool notify,
  }){
    setSearchResult(
      result: <SearchResult>[],
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------

  /// SEARCH RECORDS

  // --------------------
  List<RecordModel> _searchRecords = <RecordModel>[];
  // --------------------
  List<RecordModel> get searchRecords {
    return <RecordModel>[... _searchRecords];
  }
  // --------------------
  Future<List<RecordModel>> _paginateSearchRecords(BuildContext context) async{

    // List<RecordModel> _searchRecords = <RecordModel>[];

    // /// 1 - search  LDB for all searches
    // final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(docName: LDBDoc.searches);
    //
    // /// 2 - if not found in LDB, search firebase
    // if (Mapper.canLoopList(_maps) == false){
    //   blog('fetchSearchRecords : NO search records found in LDB');
    //
    //   /// 2.1 read firebase record ops
    //   _searchRecords = await RecordOps.readRecords(
    //       context: context,
    //       userID: superUserID(),
    //       activityType: ActivityType.search,
    //       limit: 10,
    //       addDocSnapshotToEachMap: true,
    //   );
    //
    //   /// 2.2 if found on firebase, store in ldb sessionFlyers
    //   if (Mapper.canLoopList(_searchRecords)){
    //     blog('fetchSearchRecords : found search records firestore db');
    //
    //     await LDBOps.insertMaps(
    //         primaryKey: 'recordID',
    //         docName: LDBDoc.searches,
    //         inputs: RecordModel.cipherRecords(records: _searchRecords, toJSON: true),
    //     );
    //
    //   }
    //
    //   /// 2.3 if no records found in firestore
    //   else {
    //     blog('fetchSearchRecords : no search record found on firestore db');
    //   }
    //
    // }
    //
    // /// 3 - if found in LDB
    // else {
    //   blog('fetchSearchRecords : found search records in LDB');
    //   final List<RecordModel> _records = RecordModel.decipherRecords(maps: _maps, fromJSON: true);
    //   _searchRecords = _records;
    // }

    DocumentSnapshot<Object> _lastRecordSnapshot;

    if (Mapper.checkCanLoopList(_searchRecords)){
      final int _length = _searchRecords.length;
      final RecordModel _lastRecord = _searchRecords[_length - 1];
      _lastRecordSnapshot = _lastRecord.docSnapshot;
    }

    final List<RecordModel> _records = await RecordRealOps.paginateRecords(
      context: context,
      userID: AuthFireOps.superUserID(),
      activityType: RecordType.search,
      limit: 5,
      startAfter: _lastRecordSnapshot,
    );


    return _records;
  }
  // --------------------
  Future<void> paginateSetSearchRecords({
    @required BuildContext context,
    @required bool notify,
  }) async {
    final List<RecordModel> _fetchedRecords = await _paginateSearchRecords(context);

    final List<RecordModel> _updatedList = RecordModel.insertRecordsToRecords(originalRecords: _searchRecords, addRecords: _fetchedRecords);
    _searchRecords = _updatedList;
    notifyListeners();
  }
  // --------------------
  void addToSearchRecords({
    @required RecordModel record,
    @required bool notify,
  }){

    final List<RecordModel> _recs = RecordModel.insertRecordToRecords(
        records: _searchRecords,
        record: record,
    );
    _searchRecords = _recs;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void deleteASearchRecord({
    @required RecordModel record,
    @required bool notify,
  }){

    final int index = _searchRecords.indexWhere((rec) => rec.recordID == record.recordID);

    if (index != -1){
      _searchRecords.removeAt(index);
      if (notify == true){
        notifyListeners();
      }
    }

  }
  // --------------------
  void clearSearchRecords({
    @required bool notify,
  }){
    _searchRecords = <RecordModel>[];
    if (notify == true){
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

    /// _isSearchingCountry - _isSearchingCity - _isSearchingDistrict - _isSearchingFlyersAndBzz
    _searchProvider.closeAllSearches(notify: false);

    /// _searchResult
    _searchProvider.clearSearchResult(notify: false);

    /// _searchRecords
    _searchProvider.clearSearchRecords(notify: notify);

  }
  // -----------------------------------------------------------------------------
}
