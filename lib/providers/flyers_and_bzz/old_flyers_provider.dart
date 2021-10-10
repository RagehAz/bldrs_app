import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/db/firestore/auth_ops.dart';
import 'package:bldrs/db/firestore/bz_ops.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/db/firestore/search_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/zones/old_zone_provider.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
/// this provides tiny flyers and tiny bzz
class OldFlyersProvider with ChangeNotifier {
  List<TinyBz> _sponsors;

  Section _currentSection;
  List<Group> _sectionGroups;

  List<TinyBz> _userTinyBzz;
  List<FlyerModel> _loadedFlyers;
  List<TinyFlyer> _wallTinyFlyers;
  List<BzModel> _loadedBzz;
  List<TinyBz> _loadedTinyBzz;
  List<TinyFlyer> _loadedSavedTinyFlyers;
  List<String> _loadedFollows;
  List<FlyerModel> _bzDeactivatedFlyers;

  BzModel _myCurrentBzModel;
  List<TinyFlyer> _bzTinyFlyers;
// -----------------------------------------------------------------------------
  BzModel get myCurrentBzModel {
    return _myCurrentBzModel;
  }
// -----------------------------------------------------------------------------
  List<TinyFlyer> get currentBzTinyFlyers{
    return _bzTinyFlyers;
  }
// -----------------------------------------------------------------------------
  void setCurrentBzTinyFlyers(List<TinyFlyer> tinyFlyers){
    _bzTinyFlyers = tinyFlyers;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void setCurrentBzModel(BzModel bzModel) {
    _myCurrentBzModel = bzModel;
    notifyListeners();
  }

  List<TinyBz> get getSponsors {
    return <TinyBz> [..._sponsors];
  }
// -----------------------------------------------------------------------------
  Section get getCurrentSection {
    return _currentSection ?? Section.NewProperties;
  }

  List<Group> get getSectionFilters {
    return <Group>[..._sectionGroups];
  }

// -----------------------------------------------------------------------------
  List<TinyBz> get getUserTinyBzz {
    // print('getting user tiny bzz');
    return <TinyBz> [..._userTinyBzz];
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> get getAllFlyers {
    return <FlyerModel>[..._loadedFlyers];
  }
// -----------------------------------------------------------------------------
  List<TinyFlyer> get getAllTinyFlyers {
    return <TinyFlyer>[..._wallTinyFlyers];
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
  List<TinyFlyer> get getSavedTinyFlyers {
    return <TinyFlyer>[..._loadedSavedTinyFlyers];
  }
// -----------------------------------------------------------------------------
  List<String> get getFollows{
    return <String>[..._loadedFollows];
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> get getBzDeactivatedFlyers{
    return <FlyerModel>[..._bzDeactivatedFlyers];
  }
// -----------------------------------------------------------------------------
  /// this sets app sponsors if any
  /// TASK : sponsors tiny bzz should depend on which city
  Future<void> fetchAndSetSponsors(BuildContext context) async {

    print('fetching sponsors');

    /// 1 - get sponsors map from db/admin/sponsors
    final Map<String, dynamic> _sponsorsIDsMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.admin,
      docName: FireCollection.admin_sponsors,
    );

    /// 2 - transform sponsors map into list<String>
    final List<String> _sponsorsIDs = TextMod.getValuesFromValueAndTrueMap(_sponsorsIDsMap);

    /// 3- get tinyBz for each id
    final List<TinyBz> _sponsorsTinyBzz = <TinyBz>[];
    for (var id in _sponsorsIDs){
      final TinyBz _tinyBz = await BzOps.readTinyBzOps(context: context, bzID: id);
      _sponsorsTinyBzz.add(_tinyBz);
    }

    _sponsors = _sponsorsTinyBzz;
    print('Bldrs ${_sponsors.length} Sponsors are ${_sponsors.toString()}');
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  Future<void> changeSection(BuildContext context, Section section) async {
    print('Changing section to $section');
    _currentSection = section;

    _setSectionFilters();

    await fetchAndSetTinyFlyersBySection(context, section);

    // notifyListeners();
  }
// -----------------------------------------------------------------------------
  void _setSectionFilters(){

    final List<Group> _filtersBySection = Group.getGroupBySection(
        section: _currentSection,
    );

    _sectionGroups = _filtersBySection;
  }
// -----------------------------------------------------------------------------
  /// if a user is an Author, this READs & sets user tiny bzz form db/users/userID['myBzzIDs']
  Future<void> fetchAndSetUserTinyBzz(BuildContext context) async {
    final String _userID = superUserID();

    final Map<String, dynamic> _userMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.users,
      docName: _userID,
    );

    final UserModel _userModel = UserModel.decipherUserMap(_userMap);

    final List<dynamic> _userBzzIDs = _userModel.myBzzIDs;

    final List<TinyBz> _userTinyBzzList = <TinyBz>[];

    for (var id in _userBzzIDs){
      final dynamic _tinyBzMap = await Fire.readDoc(
        context: context,
        collName: FireCollection.tinyBzz,
        docName: id,
      );

      if (_tinyBzMap != null){
        final TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_tinyBzMap);
        _userTinyBzzList.add(_tinyBz);
      }

    }

    _userTinyBzz = _userTinyBzzList;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// READs and sets  db/users/userID/saves/flyers document
  Future<void> fetchAndSetSavedFlyers(BuildContext context) async {

    // /// read user's saves doc
    // final List<SaveModel> _userSaveModels = await RecordOps.readUserSavesOps(context);

    /// from saveModels, get a list of saved tinyFlyers
    final List<TinyFlyer> _savedTinyFlyers = <TinyFlyer>[];

    // if (_userSaveModels != null || _userSaveModels?.length != 0){
    //   for (var saveModel in _userSaveModels){
    //     if (saveModel.saveState == SaveState.Saved) {
    //       final TinyFlyer _tinyFlyer = await FlyerOps().readTinyFlyerOps(context: context, flyerID: saveModel.flyerID);
    //
    //       if (_tinyFlyer != null){
    //         _savedTinyFlyers.add(_tinyFlyer);
    //       }
    //
    //     }
    //   }
    // }

    /// assign the value to local variable
    _loadedSavedTinyFlyers = _savedTinyFlyers;

    notifyListeners();
    print('_loadedSavedFlyers :::: --------------- ${_loadedSavedTinyFlyers.toString()}');

  }
// -----------------------------------------------------------------------------
  /// READs and sets db/users/userID/saves/bzz document
  Future<void> fetchAndSetFollows(BuildContext context) async {

    // /// read user's follows list
    // final List<String> _follows = await RecordOps.readUserFollowsOps(context);

    _loadedFollows =
        // _follows ??
        <String>[];

    print('_loadedFollows = $_loadedFollows');
    notifyListeners();
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
  /// READs all TinyBzz in firebase realtime database
  Future<void> fetchAndSetBzDeactivatedFlyers(BuildContext context, BzModel bzModel) async {

    final TinyBz _tinyBz = TinyBz.getTinyBzFromBzModel(bzModel);
    /// get all flyers from db/flyer/{where flyer.tinyBz.bzID == bzID}

    final CollectionReference _flyersColl = Fire.getCollectionRef(FireCollection.flyers);

    final List<dynamic> maps = await FireSearch.mapsByTwoValuesEqualTo(
      context: context,
      addDocsIDs: false,
      collRef: _flyersColl,
      fieldA: 'tinyBz',
      valueA: _tinyBz.toMap(),
      fieldB: 'flyerState',
      valueB: FlyerModel.cipherFlyerState(FlyerState.Unpublished),
    );

    final List<FlyerModel> _deactivatedFlyers = FlyerModel.decipherFlyersMaps(maps);

    _bzDeactivatedFlyers = _deactivatedFlyers;
    notifyListeners();

    // _flyersColl.get([GetOptions()])
    //
    // Future<List<DocumentSnapshot>> getSuggestion(String suggestion) =>
    //     Firestore.instance
    //         .collection('your-collection')
    //         .orderBy('your-document')
    //         .startAt([searchkey])
    //         .endAt([searchkey + '\uf8ff'])
    //         .getDocuments()
    //         .then((snapshot) {
    //       return snapshot.documents;
    //     });

  }
// -----------------------------------------------------------------------------
  Future<void> fetchAndSetTinyFlyersBySection(BuildContext context, Section section) async {
    final OldCountryProvider _countryPro =  Provider.of<OldCountryProvider>(context, listen: false);
    final Zone _currentZone = _countryPro.currentZone;

    final String _zoneString = TextGenerator.zoneStringer(
      context: context,
      zone: _currentZone,
    );

    print('current zone is : $_zoneString');

    await tryAndCatch(
        context: context,
        methodName: 'fetchAndSetTinyFlyersBySectionType',
        functions: () async {

          final FlyerType _flyerType = FlyerTypeClass.getFlyerTypeBySection(section: section);

          // print('_flyerType is : ${_flyerType.toString()}');

          /// READ data from cloud Firestore flyers collection


          final List<TinyFlyer> _foundTinyFlyers = await FireSearch.flyersByZoneAndFlyerType(
              context: context,
              zone: _currentZone,
              flyerType: _flyerType,
            );


          // print('${(TinyFlyer.cipherTinyFlyers(_foundTinyFlyers)).toString()}');

          _wallTinyFlyers = _foundTinyFlyers;

          notifyListeners();
          print('_loadedTinyBzz :::: --------------- $_loadedTinyBzz');

        }
    );


  }
// -----------------------------------------------------------------------------
  void removeTinyFlyerFromLocalList(String flyerID){
    final int _index = _wallTinyFlyers.indexWhere((tinyFlyer) => tinyFlyer.flyerID == flyerID);
    _wallTinyFlyers.removeAt(_index);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void removeTinyBzFromLocalList(String bzID){
    if (_loadedTinyBzz != null){
      final int _index = _loadedTinyBzz.indexWhere((tinyBz) => tinyBz.bzID == bzID,);
      _loadedTinyBzz.removeAt(_index);
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------
  void removeTinyBzFromLocalUserTinyBzz(String bzID){
    if (_loadedTinyBzz != null){
      final int _index = _userTinyBzz.indexWhere((tinyBz) => tinyBz.bzID == bzID);
      _userTinyBzz.removeAt(_index);
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------
  FlyerModel getFlyerByFlyerID (String flyerID){
    final FlyerModel _flyer = _loadedFlyers?.firstWhere((x) => x.flyerID == flyerID, orElse: ()=>null);
    return _flyer;
  }
// -----------------------------------------------------------------------------
  TinyFlyer getTinyFlyerByFlyerID (String flyerID){
    final TinyFlyer _tinyFlyer = _wallTinyFlyers?.firstWhere((x) => x.flyerID == flyerID, orElse: ()=>null);

    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyersIDs(List<dynamic> flyersIDs){
    final List<FlyerModel> flyers = <FlyerModel>[];
    flyersIDs?.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
    return flyers;
  }
// -----------------------------------------------------------------------------
  List<String> getTinyFlyersIDsByFlyerType(FlyerType flyerType){
    final List<String> flyersIDs = <String>[];
    _wallTinyFlyers?.forEach((fl) {
      if(fl.flyerType == flyerType){flyersIDs.add(fl.flyerID);}
    });
    return flyersIDs;
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyerType(FlyerType flyerType){
    final List<FlyerModel> _flyers = <FlyerModel>[];
    final List<String> _flyersIDs = getTinyFlyersIDsByFlyerType(flyerType);
    _flyersIDs.forEach((fID) {
      _flyers.add(getFlyerByFlyerID(fID));
    });
    return _flyers;
  }
// -----------------------------------------------------------------------------
  List<TinyFlyer> getTinyFlyersByFlyerType(FlyerType flyerType){
    final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];
    final List<String> _flyersIDs = getTinyFlyersIDsByFlyerType(flyerType);
    _flyersIDs.forEach((fID) {
      _tinyFlyers.add(getTinyFlyerByFlyerID(fID));
    });
    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
  bool checkAnkh(String flyerID){
    bool _ankhIsOn = false;

    final TinyFlyer _tinyFlyer = _loadedSavedTinyFlyers?.firstWhere((flyer) => flyer.flyerID == flyerID, orElse: () => null);

      if(_tinyFlyer == null){
        _ankhIsOn = false;
      } else {
        _ankhIsOn = true;
      }

    return _ankhIsOn;
  }
// -----------------------------------------------------------------------------
  bool checkFollow(String bzID){
    bool _followIsOn = false;

    final String _id = _loadedFollows?.firstWhere((id) => id == bzID, orElse: () => null);

    if(_id == null){
      _followIsOn = false;
    } else {
      _followIsOn = true;
    }
    // print('_followIsOn = $_followIsOn');

    return _followIsOn;
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
      if (fl.tinyAuthor.userID == authorID){
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
  TinyBz getTinyBzByBzID(String bzID){
    final TinyBz _tinyBz = _loadedTinyBzz?.firstWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
    return _tinyBz;
  }
// -----------------------------------------------------------------------------

  List<BzModel> getBzzOfFlyersList(List<FlyerModel> flyersList){
    final List<BzModel> _bzz = <BzModel>[];
    flyersList.forEach((fl) {
      _bzz.add(getBzByBzID(fl.tinyBz.bzID));
    });
    return _bzz;
}
// -----------------------------------------------------------------------------
  List<TinyBz> getTinyBzzOfTinyFlyersList(List<TinyFlyer> tinyFlyersList){
    final List<TinyBz> _tinyBzz = <TinyBz>[];
    tinyFlyersList.forEach((fl) {
      _tinyBzz.add(getTinyBzByBzID(fl?.tinyBz?.bzID));
    });
    return _tinyBzz;
  }
// -----------------------------------------------------------------------------
  List<BzModel> getBzzByBzzIDs(List<String> bzzIDs){
    final List<BzModel> bzz = <BzModel>[];
    bzzIDs.forEach((bzID) {bzz.add(getBzByBzID(bzID));});
    return bzz;
}
// ############################################################################
//   /// add bz to local list
//   void addBzModelToLocalList(BzModel bzModel){
//     _loadedBzz.add(bzModel);
//     notifyListeners();
//   }
// ############################################################################
  /// add TinyBz to local list
  void addTinyBzToLocalList(TinyBz tinyBz){
    _loadedTinyBzz.add(tinyBz);
    notifyListeners();
  }
// ############################################################################
  void addTinyBzToUserTinyBzz(TinyBz tinyBz){
    _userTinyBzz.add(tinyBz);
    notifyListeners();
  }
// ############################################################################
  void updateTinyBzInLocalList(TinyBz modifiedTinyBz){

    if (_loadedTinyBzz != null){
      final int _indexOfOldTinyBz = _loadedTinyBzz.indexWhere((bz) => modifiedTinyBz.bzID == bz.bzID);
    _loadedTinyBzz.removeAt(_indexOfOldTinyBz);
    _loadedTinyBzz.insert(_indexOfOldTinyBz, modifiedTinyBz);
    notifyListeners();
    }

  }
// ############################################################################
  void updateTinyBzInUserTinyBzz(TinyBz modifiedTinyBz){
    final int _indexOfOldTinyBz = _userTinyBzz.indexWhere((bz) => modifiedTinyBz.bzID == bz.bzID);
    _userTinyBzz.removeAt(_indexOfOldTinyBz);
    _userTinyBzz.insert(_indexOfOldTinyBz, modifiedTinyBz);
    notifyListeners();
  }
// ############################################################################
  /// add flyer to local list
  void addFlyerModelToLocalList(FlyerModel flyer){
    _loadedFlyers.add(flyer);
    notifyListeners();
  }
// ############################################################################
  void addTinyFlyerToLocalList(TinyFlyer tinyFlyer){
    _wallTinyFlyers.add(tinyFlyer);
    notifyListeners();
  }
// ############################################################################
  void updateTineFlyerInBzTinyFlyers(TinyFlyer tinyFlyer){

    print('TASK HERE TO ADD THIS updateTineFlyerInBzTinyFlyers');

    // _bzTinyFlyers.indexWhere
  }
// ############################################################################
  void addOrDeleteTinyFlyerInLocalSavedTinyFlyers(TinyFlyer _inputTinyFlyer){

    final TinyFlyer _savedTinyFlyer =
    _loadedSavedTinyFlyers.singleWhere((tf) => tf.flyerID == _inputTinyFlyer.flyerID, orElse: ()=> null);

    if (_savedTinyFlyer == null){
      /// so flyer is not already saved, so we save it
      _loadedSavedTinyFlyers.add(_inputTinyFlyer);
    } else {
      /// so flyer is already saved, so we remove it
      final int _savedTinyFlyerIndex =
      _loadedSavedTinyFlyers.indexWhere((tf) => tf.flyerID == _inputTinyFlyer.flyerID, );

      _loadedSavedTinyFlyers.removeAt(_savedTinyFlyerIndex);
    }

    notifyListeners();
  }
// ############################################################################
  void updatedFollowsInLocalList(List<String> updatedFollows){
    _loadedFollows = updatedFollows;
    notifyListeners();
  }
// ############################################################################
  void replaceTinyFlyerInLocalList(TinyFlyer tinyFlyer){
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
  TinyFlyer getSavedTinyFlyerByFlyerID(String flyerID){
    final TinyFlyer _tinyFlyer = TinyFlyer.getTinyFlyerFromTinyFlyers(
      tinyFlyers: _loadedSavedTinyFlyers,
      flyerID: flyerID,
    );
    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------

  String _inceptionInFlyer;
  String get inception{
    return _inceptionInFlyer;
  }

  void setInception({BuildContext context, String input}){

    if (input != null){
      _inceptionInFlyer = input;
    }

    else {

      final GreatPlaces _pro = Provider.of<GreatPlaces>(context, listen: false);
      final String _fromSecondPro = _pro.inception;
      _inceptionInFlyer = _fromSecondPro;
    }

    notifyListeners();

  }

}
