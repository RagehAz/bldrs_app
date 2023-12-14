import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class ZonePhidsModel {
  /// --------------------------------------------------------------------------
  const ZonePhidsModel({
    required this.zoneID,
    required this.phidsMaps,
  });
  /// --------------------------------------------------------------------------
  final String? zoneID;
  final List<MapModel>? phidsMaps;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ZonePhidsModel copyWith({
    String? zoneID,
    List<MapModel>? phidsMaps,
  }){
    return ZonePhidsModel(
        zoneID: zoneID ?? this.zoneID,
        phidsMaps: phidsMaps ?? this.phidsMaps,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, int> toMap(){
    final Map<String, int> _map = MapModel.cipherIntsMapModels(phidsMaps);
    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZonePhidsModel? decipherCityNodePhids({
    required Map<String, dynamic>? map,
    required String? cityID,
  }){
    ZonePhidsModel? _zonePhids;

    if (map != null && cityID != null){
      _zonePhids = ZonePhidsModel(
        zoneID: cityID,
        phidsMaps: MapModel.decipherMapModels(map),
      );
    }

    return _zonePhids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static List<MapModel> createPhidsMapModelsFromSpecs({
    required List<SpecModel> specs,
  }){
    List<MapModel> _maps = <MapModel>[];

    if (Lister.checkCanLoop(specs) == true){

      for (final SpecModel spec in specs){

        final bool _specIsKeywordID = SpecModel.checkSpecIsFromChainK(
          spec: spec,
        );

        if (_specIsKeywordID == true){

          final MapModel? _existingMapWithThisKey = MapModel.getModelByKey(
            models: _maps,
            key: spec.value,
          );


          /// THIS KEY IS NEW : ADD NEW MAP MODEL TO THE LIST
          if (_existingMapWithThisKey == null){

            final MapModel _mapModel = MapModel(
              key: spec.value,
              value: 1,
            );

            _maps.add(_mapModel);

          }

          /// KEY EXISTS ALREADY : INCREMENT VALUE
          else {

            final MapModel _updatedMap = _existingMapWithThisKey.copyWith(
              value: _existingMapWithThisKey.value + 1,
            );

            _maps = MapModel.replaceMapModel(
              mapModels: _maps,
              mapModel: _updatedMap,
            );

          }

        }

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<MapModel> createPhidsMapModelsFromFlyerPhids({
    required List<String>? phids,
  }){
    List<MapModel> _maps = <MapModel>[];

    if (Lister.checkCanLoop(phids) == true){

      for (final String phid in phids!){

        final MapModel? _existingMapWithThisKey = MapModel.getModelByKey(
          models: _maps,
          key: phid,
        );

        /// THIS KEY IS NEW : ADD NEW MAP MODEL TO THE LIST
        if (_existingMapWithThisKey == null){

          final MapModel _mapModel = MapModel(
            key: phid,
            value: 1,
          );

          _maps.add(_mapModel);

        }

        /// KEY EXISTS ALREADY : INCREMENT VALUE
        else {

          final MapModel _updatedMap = _existingMapWithThisKey.copyWith(
            value: _existingMapWithThisKey.value + 1,
          );

          _maps = MapModel.replaceMapModel(
            mapModels: _maps,
            mapModel: _updatedMap,
          );

        }

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZonePhidsModel? createZonePhidModelFromFlyer({
    required FlyerModel? flyerModel,
  }){
    ZonePhidsModel? _zonePhids;

    if (flyerModel != null){

      _zonePhids = ZonePhidsModel(
        zoneID: flyerModel.zone?.cityID,
        phidsMaps: createPhidsMapModelsFromFlyerPhids(
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
    MapModel.blogMapModels(
      phidsMaps: phidsMaps,
      invoker: 'blogZonePhidsModel : $invoker : ($zoneID)',
    );
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPhidsFromZonePhidsModel({
    required ZonePhidsModel? zonePhidsModel,
  }){
    List<String> _output = <String>[];

    if (zonePhidsModel != null){
      final ZonePhidsModel? _cleanedZonePhids = _cleanZeroValuesPhids(zonePhidsModel);
      final List<dynamic> _values = MapModel.getKeysFromMapModels(_cleanedZonePhids?.phidsMaps);
      _output = Stringer.getStringsFromDynamics(_values);
      _output.removeWhere((element) => element == 'id');
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> getFlyerTypesByZonePhids({
    required ZonePhidsModel? zonePhidsModel,
    required List<Chain>? bldrsChains,
  }){
    final List<FlyerType> _output = <FlyerType>[];

    if (Lister.checkCanLoop(bldrsChains) == true){

      final List<String> _phids = getPhidsFromZonePhidsModel(
        zonePhidsModel: zonePhidsModel,
      );

      if (Lister.checkCanLoop(_phids) == true){

        for (final String phid in _phids){

          final bool _isPhidK = Phider.checkIsPhidK(phid);

          if (_isPhidK == true){

            final FlyerType? _flyerType = getFlyerTypeByPhid(
              phid: phid,
              bldrsChains: bldrsChains,
            );

            // blog('phid => $phid =>> _isPhidK : $_isPhidK : _flyerType : $_flyerType');

            if (_flyerType != null && _output.contains(_flyerType) == false){
              _output.add(_flyerType);
            }

          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerType? getFlyerTypeByPhid({
    required String? phid,
    required List<Chain>? bldrsChains,
  }){
    FlyerType? _output;

    if (phid != null && bldrsChains != null){

      final String? _rootChainID = Chain.getRootChainIDOfPhid(
          allChains: bldrsChains,
          phid: phid
      );

      _output = FlyerTyper.concludeFlyerTypeByChainID(
        chainID: _rootChainID,
      );

      // blog('root chain id is ($_rootChainID) : flyerType : ($_output) : for this phid ($phid)');

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static ZonePhidsModel? _cleanZeroValuesPhids(ZonePhidsModel? zonePhids){

    ZonePhidsModel? _output = zonePhids;

    // blog('_cleanZeroValuesPhids START : ${zonePhids?.phidsMaps?.length} KEYS for (${zonePhids?.zoneID}');

    if (zonePhids != null && zonePhids.phidsMaps != null){

      final List<MapModel> _cleanedKeywords = <MapModel>[];

      for (final MapModel mapModel in zonePhids.phidsMaps!){

        if (mapModel.value is int){
          /// ONLY GET USAGE VALUES BIGGER THAN 0
          if (mapModel.value > 0){
            _cleanedKeywords.add(mapModel);
          }
        }

      }

      _output = ZonePhidsModel(
        zoneID: zonePhids.zoneID,
        phidsMaps: _cleanedKeywords,
      );

    }

    // blog('_cleanZeroValuesPhids START : ${_output?.phidsMaps?.length} KEYS for (${zonePhids?.zoneID}');

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> removeUnusedPhidsFromBldrsChainsForThisZone({
    required List<Chain>? bldrsChains,
    required ZonePhidsModel? currentZonePhidsModel,
  }) {

    final List<String> _usedPhids = ZonePhidsModel.getPhidsFromZonePhidsModel(
      zonePhidsModel: currentZonePhidsModel,
    );

    final List<Chain>? _refined = Chain.removeAllPhidsNotUsedInThisList(
      chains: bldrsChains,
      usedPhids: _usedPhids,
    );

    return _refined ?? [];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZonePhidsModel? combineModels({
    required String? zoneID,
    required ZonePhidsModel? base,
    required ZonePhidsModel? add,
  }){
    ZonePhidsModel? _output;

    // blog('combineModels START : base : ${base?.phidsMaps?.length} KEYS for (${base?.zoneID})');
    // blog('combineModels START : add : ${add?.phidsMaps?.length} KEYS for (${add?.zoneID})');

    if (zoneID != null){

      _output = ZonePhidsModel(
        zoneID: zoneID,
        phidsMaps: <MapModel>[...?base?.phidsMaps],
      );

      if (Lister.checkCanLoop(add?.phidsMaps) == true){

        List<MapModel> _combined = <MapModel>[...?base?.phidsMaps];

        for (final MapModel mapModel in add!.phidsMaps!){

          final MapModel? _existing = MapModel.getModelByKey(
            models: _combined,
            key: mapModel.key,
          );

          /// FOUND
          if (_existing != null){
            // blog('FOUND => ${mapModel.key}');
            _combined = MapModel.replaceMapModel(
                mapModels: _combined,
                mapModel: MapModel(
                  key: mapModel.key,
                  value: _existing.value + mapModel.value,
                )
            );

          }
          else {
            // blog('NOT FOUND =======> ${mapModel.key}');
            _combined.add(mapModel);
          }

        }

        if (Lister.checkCanLoop(_combined) == true){

          _output = ZonePhidsModel(
            zoneID: zoneID,
            phidsMaps: _combined,
          );

        }

      }


    }

    // blog('a77a combineModels END : _output : ${_output?.phidsMaps?.length} KEYS for (${_output?.zoneID}');

    return _cleanZeroValuesPhids(_output);
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
          MapModel.checkMapModelsListsAreIdentical(
            models1: model1.phidsMaps,
            models2: model2.phidsMaps,
          ) == true
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
      phidsMaps.hashCode;
// -----------------------------------------------------------------------------
}
