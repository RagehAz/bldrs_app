import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/maps/mapper_si.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class ZonePhidsModel {
  /// --------------------------------------------------------------------------
  const ZonePhidsModel({
    required this.zoneID,
    required this.phidsMap,
  });
  /// --------------------------------------------------------------------------
  final String? zoneID;
  final Map<String, int>? phidsMap;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ZonePhidsModel copyWith({
    String? zoneID,
    Map<String, int>? phidsMap,
  }){
    return ZonePhidsModel(
        zoneID: zoneID ?? this.zoneID,
        phidsMap: phidsMap ?? this.phidsMap,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// AI TESTED
  Map<String, int> toMap(){
    final Map<String, int> _map = phidsMap ?? {};
    return _map;
  }
  // --------------------
  /// AI TESTED
  static ZonePhidsModel? decipherCityNodePhids({
    required Map<String, dynamic>? map,
    required String? cityID,
  }){
    ZonePhidsModel? _zonePhids;

    if (map != null && cityID != null){
      _zonePhids = ZonePhidsModel(
        zoneID: cityID,
        phidsMap: MapperSI.convertDynamicMap(
          originalMap: map,
          transformDoubles: true,
        ),
      );
    }

    return _zonePhids;
  }
  // --------------------
  /// AI TESTED
  static ZonePhidsModel? decipherCountryNodeMap({
    required Map<String, dynamic>? map,
  }) {
    ZonePhidsModel? _output;

    if (map != null) {

      final List<String>? _citiesIDs = map.keys.toList();
      final String? countryID = map['id'];
      _citiesIDs?.remove('id');

      if (countryID != null && Lister.checkCanLoop(_citiesIDs) == true) {

        for (final String cityID in _citiesIDs!) {

          Map<String, dynamic> _cityPhids = map[cityID];
          _cityPhids = Mapper.insertPairInMap(
            map: _cityPhids,
            key: 'id',
            value: cityID,
            overrideExisting: true,
          );

          final ZonePhidsModel? _model = ZonePhidsModel.decipherCityNodePhids(
            map: _cityPhids,
            cityID: cityID,
          );

          // _model?.blogZonePhidsModel(invoker: 'decipherCountryNodeMap : $cityID');

          _output = ZonePhidsModel.combineModels(
            zoneID: countryID,
            base: _output,
            add: _model,
          );

        }
      }
    }

    // _output?.blogZonePhidsModel(invoker: 'decipherCountryNodeMap : countryID');

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static ZonePhidsModel? decipherPlanetNodeMap({
    required Map<String, dynamic>? map,
  }){
    ZonePhidsModel? _output;

    // blog('decipherPlanetNodeMap : START -------------------------------->');

    if (map != null) {

      final List<String> _countriesIDs = map.keys.toList();
      _countriesIDs.remove('id'); // this is the folder name in REAL DB : zonesPhids

      // Mapper.blogMap(map, invoker: 'decipherPlanetNodeMap input map');

      if (Lister.checkCanLoop(_countriesIDs) == true) {

        // blog('decipherPlanetNodeMap here we start : _countriesIDs : $_countriesIDs');

        for (final String countryID in _countriesIDs){

          Map<String, dynamic> _countryPhidsMap = map[countryID];
          _countryPhidsMap = Mapper.insertPairInMap(
              map: _countryPhidsMap,
              key: 'id',
              value: countryID,
              overrideExisting: true,
          );

          // Mapper.blogMap(_countryPhidsMap, invoker: '_countryPhidsMap');

          // blog('1. decipherPlanetNodeMap : $countryID : has ${_countryPhidsMap.keys} maps before cipher');

          final ZonePhidsModel? _model = ZonePhidsModel.decipherCountryNodeMap(
            map: _countryPhidsMap,
          );

          // blog('2. decipherPlanetNodeMap : $countryID : is null ? : ${_model == null}');
          // _model?.blogZonePhidsModel(invoker: 'decipherPlanetNodeMap : $countryID');

          _output = ZonePhidsModel.combineModels(
            zoneID: Flag.planetID,
            base: _output,
            add: _model,
          );

        }

      }
    }

    // _output?.blogZonePhidsModel(invoker: 'decipherPlanetNodeMap : ALL');
    // blog('decipherPlanetNodeMap : END -------------------------------->');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CREATOR


  // --------------------
  /// AI TESTED
  static Map<String, int> createPhidsMapFromFlyerPhids({
    required List<String>? phids,
  }){
    final Map<String, int> _map = {};

    if (Lister.checkCanLoop(phids) == true){

      for (final String phid in phids!){

        final int? _existingValueWithThisKey = _map[phid];

        /// THIS KEY IS NEW : ADD NEW MAP MODEL TO THE LIST
        if (_existingValueWithThisKey == null){

          _map[phid] = 1;

        }

        /// KEY EXISTS ALREADY : INCREMENT VALUE
        else {

          final int _newValue = _existingValueWithThisKey + 1;

          _map[phid] = _newValue;

        }

      }

    }

    return _map;
  }
  // --------------------
  /// AI TESTED
  static ZonePhidsModel? createZonePhidModelFromFlyer({
    required FlyerModel? flyerModel,
  }){
    ZonePhidsModel? _zonePhids;

    if (flyerModel != null){

      _zonePhids = ZonePhidsModel(
        zoneID: flyerModel.zone?.cityID,
        phidsMap: createPhidsMapFromFlyerPhids(
          phids: flyerModel.phids,
        ),
      );

    }

    return _zonePhids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? createIncrementationMap({
    required List<String> removedPhids,
    required List<String> addedPhids,
  }){
    Map<String, dynamic>? _incrementationMap = {};

      /// ADD REMOVED SPECS WITH DECREMENT VALUES
    if (Lister.checkCanLoop(removedPhids) == true){
      for (final String phidToRemove in removedPhids){
        _incrementationMap = Mapper.insertPairInMap(
          map: _incrementationMap,
          key: phidToRemove,
          value: _incrementationMap![phidToRemove] == null ? -1 : _incrementationMap[phidToRemove] -1,
          overrideExisting: true,
        );
      }
    }

    /// ADD ADDED SPECS WITH INCREMENT VALUES
    if (Lister.checkCanLoop(addedPhids) == true){
      for (final String phidToAdd in addedPhids){
        _incrementationMap = Mapper.insertPairInMap(
          map: _incrementationMap,
          key: phidToAdd,
          value: _incrementationMap![phidToAdd] == null ? 1 : _incrementationMap[phidToAdd] +1,
          overrideExisting: true,
        );
      }
    }

    /// REMOVE POTENTIAL ZERO VALUES PAIRS
    _incrementationMap = Mapper.cleanZeroValuesPairs(map: _incrementationMap,);

    /// CLEAR POTENTIAL NULL VALUES
    _incrementationMap = Mapper.cleanNullPairs(map: _incrementationMap,);

    return _incrementationMap;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogZonePhidsModel({
    String invoker = '',
  }){
    blog('id : $zoneID');
    blog('theMap : $phidsMap');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// AI TESTED
  static List<String> getPhidsFromZonePhidsModel({
    required ZonePhidsModel? zonePhidsModel,
  }){
    List<String> _output = <String>[];

    if (zonePhidsModel != null){
      final ZonePhidsModel? _cleanedZonePhids = cleanZeroValuesPhids(zonePhidsModel);
      _output = _cleanedZonePhids?.phidsMap?.keys.toList() ?? [];
      _output.removeWhere((element) => element == 'id');
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getPhidCount({
    required ZonePhidsModel? zonePhidsModel,
    required String? phid,
  }){
    int _output = 0;

    if (zonePhidsModel != null && phid != null){

      _output = zonePhidsModel.phidsMap?[phid] ?? 0;

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getPhidsCount({
    required ZonePhidsModel? zonePhidsModel,
    required List<String> phids,
  }){
    int _output = 0;

    if (zonePhidsModel != null && Lister.checkCanLoop(phids) == true){

      for (final String phid in phids){
        _output = _output + getPhidCount(phid: phid, zonePhidsModel: zonePhidsModel);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// AI TESTED
  static ZonePhidsModel? cleanZeroValuesPhids(ZonePhidsModel? zonePhids){

    ZonePhidsModel? _output = zonePhids;

    final List<String> _keys = zonePhids?.phidsMap?.keys.toList() ?? [];

    if (Lister.checkCanLoop(_keys) == true){

      final Map<String, int> _cleanedMap = {};

      for (final String key in _keys){

        final int _value = zonePhids!.phidsMap![key] ?? 0;

          /// ONLY GET USAGE VALUES BIGGER THAN 0
          if (_value > 0){
            _cleanedMap[key] = _value;
          }

      }

      _output = ZonePhidsModel(
        zoneID: zonePhids!.zoneID,
        phidsMap: _cleanedMap,
      );

    }


    return _output;
  }
  // --------------------
  /// AI TESTED
  static ZonePhidsModel? combineModels({
    required String? zoneID,
    required ZonePhidsModel? base,
    required ZonePhidsModel? add,
  }){
    ZonePhidsModel? _output;

    if (zoneID != null){

      _output = ZonePhidsModel(
        zoneID: zoneID,
        phidsMap: MapperSI.combineMaps(
          map1: base?.phidsMap,
          map2: add?.phidsMap,
        ),
      );

    }

    return cleanZeroValuesPhids(_output);
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkZonePhidsAreIdentical({
    required ZonePhidsModel? model1,
    required ZonePhidsModel? model2,
  }){
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }
    else if (model1 != null && model2 != null){

      if (
          model1.zoneID == model2.zoneID &&
          MapperSI.checkMapsAreIdentical(map1: model1.phidsMap, map2: model2.phidsMap) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is ZonePhidsModel){
      _areIdentical = checkZonePhidsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      zoneID.hashCode^
      phidsMap.hashCode;
// -----------------------------------------------------------------------------
}
