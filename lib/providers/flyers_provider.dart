import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/flyer_ops.dart';
import 'package:bldrs/db/firestore/search_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/providers/zones/old_zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
class FlyersProvider extends ChangeNotifier {
  /// FETCHING FLYERS
  /// 1 - search in entire LDBs for this flyerModel
  /// 2 - if not found, search firebase
  ///   2.1 read firebase flyer ops
  ///   2.2 if found on firebase, store in ldb sessionFlyers
  Future<FlyerModel> fetchFlyerByID({BuildContext context, String flyerID}) async {

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
      _flyer = await FlyerOps().readFlyerOps(
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
  Future<List<FlyerModel>> fetchFlyersByIDs({BuildContext context, List<String> flyersIDs}) async {
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
// -----------------------------------------------------------------------------
  /// SAVED FLYERS
  List<TinyFlyer> _savedFlyers = <TinyFlyer>[];
// -------------------------------------
  List<TinyFlyer> get savedTinyFlyers {
    return <TinyFlyer>[..._savedFlyers];
  }
// -------------------------------------
  Future<void> fetchSavedFlyers(BuildContext context) async {

    /// 1 - get user saved flyers IDs
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final List<String> _savedFlyersIDs = _myUserModel?.savedFlyersIDs;

    if (Mapper.canLoopList(_savedFlyersIDs)){

      final List<FlyerModel> _flyers = await fetchFlyersByIDs(
        context: context,
        flyersIDs: _savedFlyersIDs,
      );

      final List<TinyFlyer> _tinyFlyers = TinyFlyer.getTinyFlyersFromFlyersModels(_flyers);

      _savedFlyers = _tinyFlyers;
      notifyListeners();

    }

  }
// -------------------------------------
  bool checkAnkh(String flyerID){
    bool _ankhIsOn = false;

    final TinyFlyer _tinyFlyer = _savedFlyers?.firstWhere((flyer) => flyer.flyerID == flyerID, orElse: () => null);

    if(_tinyFlyer == null){
      _ankhIsOn = false;
    } else {
      _ankhIsOn = true;
    }

    return _ankhIsOn;
  }
// -------------------------------------
  void addOrDeleteTinyFlyerInLocalSavedTinyFlyers(TinyFlyer _inputTinyFlyer){

    final TinyFlyer _savedTinyFlyer =
    _savedFlyers.singleWhere((tf) => tf.flyerID == _inputTinyFlyer.flyerID, orElse: ()=> null);

    if (_savedTinyFlyer == null){
      /// so flyer is not already saved, so we save it
      _savedFlyers.add(_inputTinyFlyer);
    } else {
      /// so flyer is already saved, so we remove it
      final int _savedTinyFlyerIndex =
      _savedFlyers.indexWhere((tf) => tf.flyerID == _inputTinyFlyer.flyerID, );

      _savedFlyers.removeAt(_savedTinyFlyerIndex);
    }

    notifyListeners();
  }
// -------------------------------------
  TinyFlyer getSavedTinyFlyerByFlyerID(String flyerID){
    final TinyFlyer _tinyFlyer = TinyFlyer.getTinyFlyerFromTinyFlyers(
      tinyFlyers: _savedFlyers,
      flyerID: flyerID,
    );
    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
  /// WALL FLYERS
  List<TinyFlyer> _wallTinyFlyers;
// -------------------------------------
  List<TinyFlyer> get wallTinyFlyers {
    return <TinyFlyer>[..._wallTinyFlyers];
  }
// -------------------------------------
  Future<void> fetchFlyersBySection({BuildContext context, Section section}) async {
    final OldCountryProvider _countryPro =  Provider.of<OldCountryProvider>(context, listen: false);
    final Zone _currentZone = _countryPro.currentZone;
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


          final List<TinyFlyer> _foundTinyFlyers = await FireSearch.flyersByZoneAndFlyerType(
            context: context,
            zone: _currentZone,
            flyerType: _flyerType,
          );


          // print('${(TinyFlyer.cipherTinyFlyers(_foundTinyFlyers)).toString()}');

          _wallTinyFlyers = _foundTinyFlyers;

          notifyListeners();
          // print('_loadedTinyBzz :::: --------------- $_loadedTinyBzz');

        }
    );


  }
// -----------------------------------------------------------------------------
  /// ACTIVE BZ FLYERS
  List<TinyFlyer> _activeBzTinyFlyers = <TinyFlyer>[];
// -------------------------------------
  List<TinyFlyer> get activeBzFlyer{
    return _activeBzTinyFlyers;
  }
// -------------------------------------
  Future<void> fetchActiveBzFlyers({BuildContext context, String bzID}) async {
    List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final BzModel _activeBz = _bzzProvider.activeBz;
    final List<String> _activeBzFlyers = _activeBz.flyersIDs;

    if (Mapper.canLoopList(_activeBzFlyers)){

      final List<FlyerModel> _flyers = await fetchFlyersByIDs(context: context, flyersIDs: _activeBzFlyers);

      if (Mapper.canLoopList(_flyers)){
        _tinyFlyers = TinyFlyer.getTinyFlyersFromFlyersModels(_flyers);
      }

    }

    _activeBzTinyFlyers = _tinyFlyers;
    notifyListeners();
  }
// -------------------------------------
}