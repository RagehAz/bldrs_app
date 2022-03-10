import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/a_models/secondary_models/search_result.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/record_ops.dart' as RecordOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
class SearchProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// --- IS SEARCHING

// -------------------------------------
  bool _isSearchingCountry = false;
  bool _isSearchingCity = false;
  bool _isSearchingDistrict = false;
  bool _isSearchingFlyersAndBzz = false;
// -------------------------------------
  bool get isSearchingCountry => _isSearchingCountry;
  bool get isSearchingCity => _isSearchingCity;
  bool get isSearchingDistrict => _isSearchingDistrict;
  bool get isSearchingFlyersAndBzz => _isSearchingFlyersAndBzz;
// -------------------------------------
  void triggerIsSearching({
    @required SearchingModel searchingModel,
    @required bool setIsSearchingTo,
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

    notifyListeners();
  }
// -------------------------------------
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
        );
      }

    }

    /// CAUTION : [triggerIsSearching] method has notifyListeners();
  }
// -------------------------------------
  void closeAllZoneSearches(){

    _isSearchingCountry = false;
    _isSearchingCity = false;
    _isSearchingDistrict = false;

    notifyListeners();

  }
// -----------------------------------------------------------------------------

  /// SEARCH RESULT

// -------------------------------------
  List<SearchResult> _searchResult = <SearchResult>[];
// -------------------------------------
  List<SearchResult> get searchResult {
    return [..._searchResult];
  }
// -------------------------------------
  void setSearchResult (List<SearchResult> result){

    _searchResult = result;
    notifyListeners();

  }
// -------------------------------------
  void clearSearchResult(){
    setSearchResult(<SearchResult>[]);
  }
// -----------------------------------------------------------------------------

  /// SEARCH RECORDS

// -------------------------------------
  List<RecordModel> _searchRecords = <RecordModel>[];
// -------------------------------------
  List<RecordModel> get searchRecords {
    return <RecordModel>[... _searchRecords];
  }
// -------------------------------------
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

    if (Mapper.canLoopList(_searchRecords)){
      final int _length = _searchRecords.length;
      final RecordModel _lastRecord = _searchRecords[_length - 1];
      _lastRecordSnapshot = _lastRecord.docSnapshot;
    }

    final List<RecordModel> _records = await RecordOps.paginateRecords(
      context: context,
      userID: FireAuthOps.superUserID(),
      activityType: ActivityType.search,
      limit: 5,
      startAfter: _lastRecordSnapshot,
    );


    return _records;
  }
// -------------------------------------
  Future<void> getSetSearchRecords(BuildContext context) async {
    final List<RecordModel> _fetchedRecords = await _paginateSearchRecords(context);

    final List<RecordModel> _updatedList = RecordModel.insertRecordsToRecords(originalRecords: _searchRecords, addRecords: _fetchedRecords);
    _searchRecords = _updatedList;
    notifyListeners();
  }
// -------------------------------------
  void addToSearchRecords(RecordModel record){

    final List<RecordModel> _recs = RecordModel.insertRecordToRecords(records: _searchRecords, record: record);
    _searchRecords = _recs;
    notifyListeners();

  }
// -----------------------------------------------------------------------------
  void deleteASearchRecord(RecordModel record){

    final int index = _searchRecords.indexWhere((rec) => rec.recordID == record.recordID);

    if (index != -1){
      _searchRecords.removeAt(index);
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
  void clearSearchRecords(){
    _searchRecords = <RecordModel>[];
    notifyListeners();
  }
// -----------------------------------------------------------------------------

}
