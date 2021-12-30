import 'package:bldrs/a_models/flyer/records/record_model.dart';
import 'package:bldrs/a_models/secondary_models/search_result.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/record_ops.dart' as RecordOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
class SearchProvider extends ChangeNotifier {
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
// -----------------------------------------------------------------------------

  /// SEARCH RECORDS

// -------------------------------------
  List<RecordModel> _searchRecords = <RecordModel>[];
// -------------------------------------
  List<RecordModel> get searchRecords {
    return <RecordModel>[... _searchRecords];
  }
// -------------------------------------
  Future<List<RecordModel>> _fetchSearchRecords(BuildContext context) async{

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

    final List<RecordModel> _records = await RecordOps.readRecords(
      context: context,
      userID: superUserID(),
      activityType: ActivityType.search,
      limit: 5,
      addDocSnapshotToEachMap: true,
      startAfter: _lastRecordSnapshot,
    );


    return _records;
  }
// -------------------------------------
  Future<void> getSetSearchRecords(BuildContext context) async {
    final List<RecordModel> _fetchedRecords = await _fetchSearchRecords(context);

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
  void deleteSearchRecord(RecordModel record){

    final int index = _searchRecords.indexWhere((rec) => rec.recordID == record.recordID);

    if (index != -1){
      _searchRecords.removeAt(index);
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
  void emptySearchRecords(){
    _searchRecords = <RecordModel>[];
    notifyListeners();
  }
// -----------------------------------------------------------------------------

}
