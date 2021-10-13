import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------
/// this provides tiny flyers and tiny bzz
class OldFlyersProvider with ChangeNotifier {

  List<FlyerModel> _loadedFlyers;
  List<FlyerModel> _wallFlyers;
  List<BzModel> _loadedBzz;
  List<FlyerModel> _bzDeactivatedFlyers;

  BzModel _myCurrentBzModel;
  List<FlyerModel> _bzFlyers;
// -----------------------------------------------------------------------------
  BzModel get myCurrentBzModel {
    return _myCurrentBzModel;
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> get currentBzTinyFlyers{
    return _bzFlyers;
  }
// -----------------------------------------------------------------------------
  void setCurrentBzFlyers(List<FlyerModel> flyers){
    _bzFlyers = flyers;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void setCurrentBzModel(BzModel bzModel) {
    _myCurrentBzModel = bzModel;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> get getAllFlyers {
    return <FlyerModel>[..._loadedFlyers];
  }
// -----------------------------------------------------------------------------
  List<BzModel> get getAllBzz {
    return <BzModel>[..._loadedBzz];
  }
// -----------------------------------------------------------------------------
//   List<TinyBz> get getAllTinyBzz {
//     return <TinyBz>[..._loadedTinyBzz];
//   }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  List<FlyerModel> get getBzDeactivatedFlyers{
    return <FlyerModel>[..._bzDeactivatedFlyers];
  }
// -----------------------------------------------------------------------------
  /// READs all TinyBzz in firebase realtime database
  /// SUPER EXPENSIVE METHOD
  // Future<void> fetchAndSetAllTinyBzzAndAllTinyFlyers(BuildContext context) async {
  //
  //   await tryAndCatch(
  //       context: context,
  //       methodName: 'fetchAndSetTinyBzzAndTinyFlyers',
  //       functions: () async {
  //
  //         /// READ data from cloud Firestore bzz collection
  //         List<dynamic> _fireStoreTinyBzzMaps = await Fire.readCollectionDocs(FireCollection.tinyBzz);
  //         final List<TinyBz> _fireStoreTinyBzzModels = TinyBz.decipherTinyBzzMaps(_fireStoreTinyBzzMaps);
  //
  //         /// TASK : BOOMMM : should be _loadedTinyBzz = _fireStoreTinyBzzModels,, but this bom bom crash crash
  //         // _loadedTinyBzz.addAll(_fireStoreTinyBzzModels);
  //         _loadedTinyBzz = _fireStoreTinyBzzModels;
  //
  //         /// READ data from cloud Firestore flyers collection
  //         List<dynamic> _fireStoreTinyFlyersMaps = await Fire.readCollectionDocs(FireCollection.tinyFlyers);
  //         final List<TinyFlyer> _fireStoreTinyFlyersModels = TinyFlyer.decipherTinyFlyersMaps(_fireStoreTinyFlyersMaps);
  //
  //         /// TASK : after migrating local flyers to firestore, _loadedTinyFlyers = _fireStoreTinyFlyersModels;;
  //         // _loadedTinyFlyers.addAll(_fireStoreTinyFlyersModels);
  //         _loadedTinyFlyers = _fireStoreTinyFlyersModels;
  //
  //         notifyListeners();
  //         print('_loadedTinyBzz :::: --------------- $_loadedTinyBzz');
  //
  //       }
  //   );
  //
  // }
// -----------------------------------------------------------------------------
//   /// READs all TinyBzz in firebase realtime database
//   Future<void> fetchAndSetBzDeactivatedFlyers(BuildContext context, BzModel bzModel) async {
//
//     /// get all flyers from db/flyer/{where flyer.tinyBz.bzID == bzID}
//
//     final CollectionReference _flyersColl = Fire.getCollectionRef(FireCollection.flyers);
//
//     final List<dynamic> maps = await FireSearch.mapsByTwoValuesEqualTo(
//       context: context,
//       addDocsIDs: false,
//       collRef: _flyersColl,
//       fieldA: 'tinyBz',
//       valueA: bzModel.toMap(toJSON: false),
//       fieldB: 'flyerState',
//       valueB: FlyerModel.cipherFlyerState(FlyerState.unpublished),
//     );
//
//     final List<FlyerModel> _deactivatedFlyers = FlyerModel.decipherFlyers(maps: maps, fromJSON: false);
//
//     _bzDeactivatedFlyers = _deactivatedFlyers;
//     notifyListeners();
//
//     // _flyersColl.get([GetOptions()])
//     //
//     // Future<List<DocumentSnapshot>> getSuggestion(String suggestion) =>
//     //     Firestore.instance
//     //         .collection('your-collection')
//     //         .orderBy('your-document')
//     //         .startAt([searchkey])
//     //         .endAt([searchkey + '\uf8ff'])
//     //         .getDocuments()
//     //         .then((snapshot) {
//     //       return snapshot.documents;
//     //     });
//
//   }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  void removeTinyFlyerFromLocalList(String flyerID){
    final int _index = _wallFlyers.indexWhere((tinyFlyer) => tinyFlyer.flyerID == flyerID);
    _wallFlyers.removeAt(_index);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void removeBzFromLocalList(String bzID){
    if (_loadedBzz != null){
      final int _index = _loadedBzz.indexWhere((tinyBz) => tinyBz.bzID == bzID,);
      _loadedBzz.removeAt(_index);
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------
  FlyerModel getFlyerByFlyerID (String flyerID){
    final FlyerModel _flyer = _loadedFlyers?.firstWhere((x) => x.flyerID == flyerID, orElse: ()=>null);
    return _flyer;
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyersIDs(List<dynamic> flyersIDs){
    final List<FlyerModel> flyers = <FlyerModel>[];
    flyersIDs?.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
    return flyers;
  }
// -----------------------------------------------------------------------------
  List<String> getFlyersIDsByFlyerType(FlyerType flyerType){
    final List<String> flyersIDs = <String>[];
    _wallFlyers?.forEach((fl) {
      if(fl.flyerType == flyerType){flyersIDs.add(fl.flyerID);}
    });
    return flyersIDs;
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyerType(FlyerType flyerType){
    final List<FlyerModel> _flyers = <FlyerModel>[];
    final List<String> _flyersIDs = getFlyersIDsByFlyerType(flyerType);
    _flyersIDs.forEach((fID) {
      _flyers.add(getFlyerByFlyerID(fID));
    });
    return _flyers;
  }
// -----------------------------------------------------------------------------
//   List<FlyerModel> getSavedFlyersFromFlyersList (List<FlyerModel> inputList, String userID){
//     List<FlyerModel> savedFlyers = [];
//     List<FlyerModel> _inputList = inputList.isEmpty || inputList == null ? [] : inputList;
//     _inputList.forEach((flyer) {
//       if (getAnkhByFlyerID(flyer.flyerID, userID) == true){savedFlyers.add(flyer);}
//     });
//     return savedFlyers;
//   }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByAuthorID(String authorID){
    final List<FlyerModel> authorFlyers = <FlyerModel>[];
    for (FlyerModel fl in _loadedFlyers){
      if (fl.authorID == authorID){
        authorFlyers.add(fl);
      }
    }
    return authorFlyers;
  }
// ############################################################################
//   List<FlyerModel> getFlyersByBzModel(BzModel bz){
//     List<dynamic> bzFlyersIDs = [];
//     bz?.bzAuthors?.forEach((au) {
//       List<dynamic> _publishedFlyersIDs = [];
//       if(au?.publishedFlyersIDs == null || _publishedFlyersIDs == [])
//       {_publishedFlyersIDs = [];}
//       else {_publishedFlyersIDs = au?.publishedFlyersIDs;}
//       bzFlyersIDs.addAll(_publishedFlyersIDs);
//     });
//     List<FlyerModel> flyers = [];
//     print('bzFlyersIDs = $bzFlyersIDs');
//     bzFlyersIDs?.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
//     return flyers;
//   }
// -----------------------------------------------------------------------------
  BzModel getBzByBzID(String bzID){
    final BzModel bz = _loadedBzz?.firstWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
    return bz;
  }

  // Future<BzModel> getBzByBzID(String bzID) async {
  //   // BzModel bz = _loadedBzz?.firstWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
  //   BzModel bz = await BzOps.readBzOps(bzID: bzID);
  //   return bz;
  // }


// -----------------------------------------------------------------------------
  List<BzModel> getBzzOfFlyers(List<FlyerModel> flyersList){
    final List<BzModel> _bzz = <BzModel>[];
    flyersList.forEach((fl) {
      _bzz.add(getBzByBzID(fl.bzID));
    });
    return _bzz;
}
// -----------------------------------------------------------------------------
  List<BzModel> getBzzByBzzIDs(List<String> bzzIDs){
    final List<BzModel> bzz = <BzModel>[];
    bzzIDs.forEach((bzID) {bzz.add(getBzByBzID(bzID));});
    return bzz;
}
// -----------------------------------------------------------------------------
  /// add Bz to local list
  void addBzToLocalList(BzModel bz){
    _loadedBzz.add(bz);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void updateBzInLocalList(BzModel modifiedBz){

    if (_loadedBzz != null){
      final int _indexOfOldTinyBz = _loadedBzz.indexWhere((bz) => modifiedBz.bzID == bz.bzID);
      _loadedBzz.removeAt(_indexOfOldTinyBz);
      _loadedBzz.insert(_indexOfOldTinyBz, modifiedBz);
    notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
  /// add flyer to local list
  void addFlyerModelToLocalList(FlyerModel flyer){
    _loadedFlyers.add(flyer);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void replaceFlyerInLocalList(FlyerModel flyer){
    // int _tinyFlyerIndex = _loadedTinyFlyers.indexWhere((t) => t.flyerID == tinyFlyer.flyerID);
    // _loadedTinyFlyers.removeAt(_tinyFlyerIndex);
    // _loadedTinyFlyers.insert(_tinyFlyerIndex, tinyFlyer);
    notifyListeners();
  }
// ############################################################################
// === === === === === === === === === === === === === === === === === === ===
  /// super expensive method
//   Future<void> fetchAndSetBzz(BuildContext context) async {
//
//     await tryAndCatch(
//         context: context,
//         methodName: 'fetchAndSetBzz',
//         functions: () async {
//
//           /// READ data from cloud Firestore bzz collection
//           List<QueryDocumentSnapshot> _fireStoreBzzMaps = await Fire.readCollectionDocs(FireCollection.bzz);
//           final List<BzModel> _fireStoreBzzModels = BzModel.decipherBzzMapsFromFireStore(_fireStoreBzzMaps);
//
//           /// TASK : BOOMMM : should be _loadedBzz = _loadedBzzFromDB,, but this bom bom crash crash
//           // _loadedBzz.addAll(_fireStoreBzzModels);
//           _loadedBzz = _fireStoreBzzModels;
//
//           /// READ data from cloud Firestore flyers collection
//           List<QueryDocumentSnapshot> _fireStoreFlyersMaps = await Fire.readCollectionDocs(FireCollection.flyers);
//           final List<FlyerModel> _fireStoreFlyersModels = FlyerModel.decipherFlyersMaps(_fireStoreFlyersMaps);
//
//          /// TASK : after migrating local flyers to firestore, _loadedFlyers should = _fireStoreFlyersModels;
//          //  _loadedFlyers.addAll(_fireStoreFlyersModels);
//           _loadedFlyers = _fireStoreFlyersModels;
//
//           notifyListeners();
//           print('_loadedBzz :::: --------------- $_loadedBzz');
//
//         }
//     );
//
//   }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------


}
