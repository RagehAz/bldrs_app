import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/flyer_ops.dart';
import 'package:bldrs/db/firestore/search_ops.dart';
import 'package:bldrs/db/firestore/user_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// fetch : a method that returns searched value in LDB, then in firebase, and stores in LDB if found
/// get : a method that returns processed inputs with provider global variables
/// getset : a method that fetches a value then sets it in a provider global variable

  // final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
class FlyersProvider extends ChangeNotifier {
  /// FETCHING FLYERS
  /// 1 - search in entire LDBs for this flyerModel
  /// 2 - if not found, search firebase
  ///   2.1 read firebase flyer ops
  ///   2.2 if found on firebase, store in ldb sessionFlyers
  Future<FlyerModel> fetchFlyerByID({@required BuildContext context, @required  String flyerID}) async {

    FlyerModel _flyer;

    /// 1 - search in entire LDBs for this flyerModel
    for (String doc in LDBDoc.flyerModelsDocs){

      final Map<String, Object> _map = await LDBOps.searchMap(
        docName: doc,
        fieldToSortBy: 'flyerID',
        searchField: 'flyerID',
        searchValue: flyerID,
      );

      if (_map != null && _map != {}){
        print('fetchFlyerByID : flyer found in local db : ${doc}');
        _flyer = FlyerModel.decipherFlyer(map: _map, fromJSON: true);
        break;
      }

    }

    /// 2 - if not found, search firebase
    if (_flyer == null){
      print('fetchFlyerByID : flyer NOT found in local db');

      /// 2.1 read firebase flyer ops
      _flyer = await FlyerOps.readFlyerOps(
        context: context,
        flyerID: flyerID,
      );

      /// 2.2 if found on firebase, store in ldb sessionFlyers
      if (_flyer != null){
        print('fetchFlyerByID : flyer found in firestore db');

        await LDBOps.insertMap(
          input: _flyer.toMap(toJSON: true),
          docName: LDBDoc.sessionFlyers,
        );

      }

    }

    return _flyer;
  }
// -------------------------------------
  Future<List<FlyerModel>> fetchFlyersByIDs({@required BuildContext context, @required List<String> flyersIDs}) async {
    List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.canLoopList(flyersIDs)){

      for (String flyerID in flyersIDs){

        final FlyerModel _flyer = await fetchFlyerByID(context: context, flyerID: flyerID);

        if (_flyer != null){

          _flyers.add(_flyer);

        }

      }

    }

    return _flyers;
  }
// -------------------------------------
  Future<List<FlyerModel>> fetchAllBzFlyersByBzID({@required BuildContext context, @required String bzID}) async {
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(
        context, listen: false);
    final BzModel _activeBz = _bzzProvider.myActiveBz;
    final List<String> _bzFlyersIDs = _activeBz?.flyersIDs;

    List<FlyerModel> _flyers;

    if (Mapper.canLoopList(_bzFlyersIDs)) {
      _flyers =
      await fetchFlyersByIDs(context: context, flyersIDs: _bzFlyersIDs);
    }

    return _flyers;
  }
// -----------------------------------------------------------------------------
  /// SAVED FLYERS
  List<FlyerModel> _savedFlyers = <FlyerModel>[];
// -------------------------------------
  List<FlyerModel> get savedFlyers {
    return <FlyerModel>[..._savedFlyers];
  }
// -------------------------------------
  Future<void> getsetSavedFlyers(BuildContext context) async {

    /// 1 - get user saved flyers IDs
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final List<String> _savedFlyersIDs = _myUserModel?.savedFlyersIDs;

    if (Mapper.canLoopList(_savedFlyersIDs)){

      final List<FlyerModel> _flyers = await fetchFlyersByIDs(
        context: context,
        flyersIDs: _savedFlyersIDs,
      );

      _savedFlyers = _flyers;
      notifyListeners();

    }

  }
// -------------------------------------
  bool getAnkh(String flyerID){
    bool _ankhIsOn = false;

    final FlyerModel _flyer = _savedFlyers?.firstWhere((flyer) => flyer.flyerID == flyerID, orElse: () => null);

    if(_flyer == null){
      _ankhIsOn = false;
    } else {
      _ankhIsOn = true;
    }

    return _ankhIsOn;
  }
// -------------------------------------
  Future<void> saveOrUnSaveFlyer({@required BuildContext context, @required FlyerModel inputFlyer,}) async {

    final FlyerModel _savedFlyer =
    _savedFlyers.singleWhere((tf) => tf.flyerID == inputFlyer.flyerID, orElse: ()=> null);

    final List<String> _savedFlyersIDs = FlyerModel.getFlyersIDsFromFlyers(_savedFlyers);

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);


    if (_savedFlyer == null){
      /// so flyer is not already saved, so we save it
      _savedFlyers.add(inputFlyer);

      /// insert flyer in ldb
      await LDBOps.insertMap(
        docName: LDBDoc.mySavedFlyers,
        input: inputFlyer.toMap(toJSON: true),
      );

      /// updated saved flyers ids in firebase
      await UserOps.addFlyerIDToSavedFlyersIDs(
        context: context,
        userID: _usersProvider.myUserModel.userID,
        flyerID: inputFlyer.flyerID,
        savedFlyersIDs: _savedFlyersIDs,

      );

    } else {
      /// so flyer is already saved, so we remove it
      final int _savedFlyerIndex =
      _savedFlyers.indexWhere((tf) => tf.flyerID == inputFlyer.flyerID, );
      _savedFlyers.removeAt(_savedFlyerIndex);

      /// remove from ldb
      await LDBOps.deleteMap(
          docName: LDBDoc.mySavedFlyers,
          objectID: inputFlyer.flyerID,
      );

      /// remove from saved flyersIDs in firebase
      await UserOps.removeFlyerIDFromSavedFlyersIDs(
        context: context,
        userID: _usersProvider.myUserModel.userID,
        flyerID: inputFlyer.flyerID,
        savedFlyersIDs: _savedFlyersIDs,
      );

    }

    notifyListeners();
  }
// -------------------------------------
//   FlyerModel getSavedFlyerByFlyerID(String flyerID){
//     final FlyerModel  _flyer = FlyerModel.getFlyerFromFlyersByID(
//       flyers: _savedFlyers,
//       flyerID: flyerID,
//     );
//     return  _flyer;
//   }
// -----------------------------------------------------------------------------
  /// WALL FLYERS
  List<FlyerModel> _wallFlyers;
// -------------------------------------
  List<FlyerModel> get wallTinyFlyers {
    return <FlyerModel>[..._wallFlyers];
  }
// -------------------------------------
  Future<void> getsetWallFlyersBySection({@required BuildContext context, @required Section section}) async {
    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
    final Zone _currentZone = _zoneProvider.currentZone;
    //
    // // final String _zoneString = TextGenerator.zoneStringer(
    // //   context: context,
    // //   zone: _currentZone,
    // // );
    //
    //
    await tryAndCatch(
        context: context,
        methodName: 'fetchAndSetTinyFlyersBySectionType',
        functions: () async {

          final FlyerType _flyerType = FlyerTypeClass.getFlyerTypeBySection(section: section);

          // print('_flyerType is : ${_flyerType.toString()}');

          /// READ data from cloud Firestore flyers collection


          final List<FlyerModel> _foundFlyers = await FireSearch.flyersByZoneAndFlyerType(
            context: context,
            zone: _currentZone,
            flyerType: _flyerType,
          );


          // print('${(TinyFlyer.cipherTinyFlyers(_foundFlyers)).toString()}');

          _wallFlyers = _foundFlyers;

          notifyListeners();
          // print('_loadedTinyBzz :::: --------------- $_loadedTinyBzz');

        }
    );


  }
// -------------------------------------
  Future<void> getsetWallFlyersByFlyerType({@required BuildContext context, @required FlyerType flyerType}) async {

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
    final Zone _currentZone = _zoneProvider.currentZone;

    final List<FlyerModel> _flyers = await FireSearch.flyersByZoneAndFlyerType(
      context: context,
      zone: _currentZone,
      flyerType: flyerType,
    );

    _wallFlyers = _flyers;
    notifyListeners();
  }
// -------------------------------------
  List<FlyerModel> filterWallFlyersByFlyerType(FlyerType flyerType){

    final List<FlyerModel> _flyers = FlyerModel.filterFlyersByFlyerType(
      flyers: _wallFlyers,
      flyerType: flyerType,
    );

    return _flyers;
  }
// -----------------------------------------------------------------------------
  /// ACTIVE BZ FLYERS
  List<FlyerModel> _myActiveBzFlyers = <FlyerModel>[];
// -------------------------------------
  List<FlyerModel> get myActiveBzFlyer{
    return _myActiveBzFlyers;
  }
// -------------------------------------
  Future<void> getsetActiveBzFlyers({@required BuildContext context, @required String bzID}) async {

    final List<FlyerModel> _flyers = await fetchAllBzFlyersByBzID(context: context, bzID: bzID);

      _myActiveBzFlyers = _flyers;
      notifyListeners();

  }
// -----------------------------------------------------------------------------
}