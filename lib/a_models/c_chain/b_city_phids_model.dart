import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

@immutable
class CityPhidsModel {
  /// --------------------------------------------------------------------------
  const CityPhidsModel({
    @required this.cityID,
    @required this.phidsMapModels,
  });
  /// --------------------------------------------------------------------------
  final String cityID;
  final List<MapModel> phidsMapModels;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    final Map<String, dynamic> _map = MapModel.cipherMapModels(phidsMapModels);
    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CityPhidsModel decipherCityPhids({
    @required Map<String, dynamic> map,
    @required String cityID,
  }){

    CityPhidsModel _cityPhids;

    if (Map != null && cityID != null){
      _cityPhids = CityPhidsModel(
        cityID: cityID,
        phidsMapModels: MapModel.decipherMapModels(map),
      );
    }

    return _cityPhids;
  }
  // -----------------------------------------------------------------------------

  /// CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<MapModel> createPhidsMapModelsFromSpecs({
    @required List<SpecModel> specs,
  }){
    List<MapModel> _maps = <MapModel>[];

    if (Mapper.checkCanLoopList(specs) == true){

      for (final SpecModel spec in specs){

        final bool _specIsKeywordID = SpecModel.checkSpecIsFromChainK(
          spec: spec,
        );

        if (_specIsKeywordID == true){

          final MapModel _existingMapWithThisKey = MapModel.getModelByKey(
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
  static List<MapModel> createPhidsMapModelsFromKeywords({
    @required List<String> keywords,
  }){
    List<MapModel> _maps = <MapModel>[];

    if (Mapper.checkCanLoopList(keywords) == true){

      for (final String phid in keywords){

        final MapModel _existingMapWithThisKey = MapModel.getModelByKey(
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
  static CityPhidsModel createCityPhidModelFromFlyer({
    @required FlyerModel flyerModel,
  }){
    CityPhidsModel _cityChain;

    if (flyerModel != null){

      _cityChain = CityPhidsModel(
        cityID: flyerModel.zone.cityID,
        phidsMapModels: createPhidsMapModelsFromKeywords(
          keywords: flyerModel.keywordsIDs,
        ),
      );

    }

    return _cityChain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createIncrementationMap({
    @required List<String> removedPhids,
    @required List<String> addedPhids,
  }){
    Map<String, dynamic> _incrementationMap = {};

      /// ADD REMOVED SPECS WITH DECREMENT VALUES
    if (Mapper.checkCanLoopList(removedPhids) == true){
      for (final String phidToRemove in removedPhids){
        _incrementationMap = Mapper.insertPairInMap(
          map: _incrementationMap,
          key: phidToRemove,
          value: _incrementationMap[phidToRemove] == null ? -1 : _incrementationMap[phidToRemove] -1,
          overrideExisting: true,
        );
      }
    }

    /// ADD ADDED SPECS WITH INCREMENT VALUES
    if (Mapper.checkCanLoopList(addedPhids) == true){
      for (final String phidToAdd in addedPhids){
        _incrementationMap = Mapper.insertPairInMap(
          map: _incrementationMap,
          key: phidToAdd,
          value: _incrementationMap[phidToAdd] == null ? 1 : _incrementationMap[phidToAdd] +1,
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
  void blogCityPhidsModel({
    String invoker = '',
  }){
    MapModel.blogMapModels(
      mapModels: phidsMapModels,
      invoker: 'blogCityPhidsModel : $invoker : ($cityID)',
    );
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPhidsFromCityPhidsModel({
    @required CityPhidsModel cityPhidsModel,
  }){
    List<String> _output = <String>[];

    if (cityPhidsModel != null){
      final CityPhidsModel _cleanedCityChain = _cleanZeroValuesPhids(cityPhidsModel);
      final List<dynamic> _values = MapModel.getKeysFromMapModels(_cleanedCityChain.phidsMapModels);
      _output = Stringer.getStringsFromDynamics(dynamics: _values);
      _output.removeWhere((element) => element == 'id');
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> getFlyerTypesByCityPhids({
    @required CityPhidsModel cityPhidsModel,
    @required List<Chain> bldrsChains,
  }){
    final List<FlyerType> _output = <FlyerType>[];

    if (Mapper.checkCanLoopList(bldrsChains) == true){

      final List<String> _phids = getPhidsFromCityPhidsModel(
        cityPhidsModel: cityPhidsModel,
      );

      if (Mapper.checkCanLoopList(_phids) == true){

        for (final String phid in _phids){

          final bool _isPhidK = Phider.checkIsPhidK(phid);

          if (_isPhidK == true){

            final FlyerType _flyerType = getFlyerTypeByPhid(
              phid: phid,
              bldrsChains: bldrsChains,
            );

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
  static FlyerType getFlyerTypeByPhid({
    @required String phid,
    @required List<Chain> bldrsChains,
  }){
    FlyerType _output;

    if (phid != null && bldrsChains != null){

      final String _rootChainID = Chain.getRootChainIDOfPhid(
          allChains: bldrsChains,
          phid: phid
      );

      _output = FlyerTyper.concludeFlyerTypeByChainID(
        chainID: _rootChainID,
      );

      blog('root chain id is ($_rootChainID) : flyerType : ($_output) : for this phid ($phid)');

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static CityPhidsModel _cleanZeroValuesPhids(CityPhidsModel cityPhidsModel){

    CityPhidsModel _output;

    if (cityPhidsModel != null){

      final List<MapModel> _cleanedKeywords = <MapModel>[];

      for (final MapModel mapModel in cityPhidsModel.phidsMapModels){

        if (mapModel.value is int){
          /// ONLY GET USAGE VALUES BIGGER THAN 0
          if (mapModel.value > 0){
            _cleanedKeywords.add(mapModel);
          }
        }

      }

      _output = CityPhidsModel(
        cityID: cityPhidsModel.cityID,
        phidsMapModels: _cleanedKeywords,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Chain> removeUnusedPhidsFromBldrsChainsForThisCity({
    @required List<Chain> bldrsChains,
    @required CityPhidsModel currentCityPhidsModel,
  }) {

    final List<String> _usedPhids = CityPhidsModel.getPhidsFromCityPhidsModel(
      cityPhidsModel: currentCityPhidsModel,
    );

    final List<Chain> _refined = Chain.removeAllPhidsNotUsedInThisList(
      chains: bldrsChains,
      usedPhids: _usedPhids,
    );

    return _refined;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TASK : TEST ME
  static bool checkCityPhidsAreIdentical({
    @required CityPhidsModel cityPhids1,
    @required CityPhidsModel cityPhids2,
  }){
    bool _identical = false;

    if (cityPhids1 == null && cityPhids2 == null){
      _identical = true;
    }
    else if (cityPhids1 != null && cityPhids2 != null){

      if (
          cityPhids1.cityID == cityPhids2.cityID &&
          MapModel.checkMapModelsListsAreIdentical(
            models1: cityPhids1.phidsMapModels,
            models2: cityPhids2.phidsMapModels,
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
    if (other is CityPhidsModel){
      _areIdentical = checkCityPhidsAreIdentical(
        cityPhids1: this,
        cityPhids2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      cityID.hashCode^
      phidsMapModels.hashCode;
// -----------------------------------------------------------------------------
}
