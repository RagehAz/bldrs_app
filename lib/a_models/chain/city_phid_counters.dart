import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/material.dart';

class CityPhidCounters {
/// --------------------------------------------------------------------------
  const CityPhidCounters({
    @required this.cityID,
    @required this.phidsCounters,
});
  /// --------------------------------------------------------------------------
  final String cityID;
  final List<MapModel> phidsCounters;
// -----------------------------------------------------------------------------

/// CYPHERS

// --------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    final Map<String, dynamic> _map = MapModel.cipherMapModels(phidsCounters);
    return _map;
  }
// --------------------------------
  /// TESTED : WORKS PERFECT
  static CityPhidCounters decipherCityChain({
    @required Map<String, dynamic> map,
    @required String cityID,
  }){

    CityPhidCounters _cityChain;

    if (Map != null && cityID != null){
      _cityChain = CityPhidCounters(
        cityID: cityID,
        phidsCounters: MapModel.decipherMapModels(map),
      );
    }

    return _cityChain;
  }
// -----------------------------------------------------------------------------

/// CREATOR

// --------------------------------
  /// TESTED : WORKS PERFECT
  static List<MapModel> createKeywordsIDsUsageMapsFromSpecs({
  @required List<SpecModel> specs,
}){
    List<MapModel> _maps = <MapModel>[];

    if (Mapper.checkCanLoopList(specs) == true){

      for (final SpecModel spec in specs){

        final bool _specIsKeywordID = SpecModel.checkSpecIsFromKeywords(
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
// --------------------------------
  /// TESTED : WORKS PERFECT
  static CityPhidCounters createCityChainFromFlyer({
    @required FlyerModel flyerModel,
  }){
    CityPhidCounters _cityChain;

    if (flyerModel != null){

      _cityChain = CityPhidCounters(
          cityID: flyerModel.zone.cityID,
          phidsCounters: createKeywordsIDsUsageMapsFromSpecs(
            specs: flyerModel.specs,
          ),
      );

    }

    return _cityChain;
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// --------------------------------
  /// TESTED : WORKS PERFECT
  void blogCityChain({
    String methodName = '',
  }){
    MapModel.blogMapModels(
      mapModels: phidsCounters,
      methodName: 'blogCityChain : $methodName : ($cityID)',
    );
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// --------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getKeywordsIDsFromCityChain({
    @required CityPhidCounters cityChain,
  }){
    List<String> _output = <String>[];

    if (cityChain != null){
      final CityPhidCounters _cleanedCityChain = _cleanZeroValuesKeywords(cityChain);
      final List<dynamic> _values = MapModel.getKeysFromMapModels(_cleanedCityChain.phidsCounters);
      _output = Stringer.getStringsFromDynamics(dynamics: _values);
      _output.removeWhere((element) => element == 'id');
    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// --------------------------------
  /// TESTED : WORKS PERFECT
  static CityPhidCounters _cleanZeroValuesKeywords(CityPhidCounters cityChain){

    CityPhidCounters _output;

    if (cityChain != null){

      final List<MapModel> _cleanedKeywords = <MapModel>[];

      for (final MapModel mapModel in cityChain.phidsCounters){

        if (mapModel.value is int){
          /// ONLY GET USAGE VALUES BIGGER THAN 0
          if (mapModel.value > 0){
            _cleanedKeywords.add(mapModel);
          }
        }

      }

      _output = CityPhidCounters(
        cityID: cityChain.cityID,
        phidsCounters: _cleanedKeywords,
      );

    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain removeUnusedKeywordsFromChainForThisCity({
    @required Chain chain,
    @required CityPhidCounters currentCityChain,
  }) {

    final List<String> _usedKeywordsIDs = CityPhidCounters.getKeywordsIDsFromCityChain(
      cityChain: currentCityChain,
    );

    final Chain _refined = Chain.removeAllKeywordsNotUsedInThisList(
      chain: chain,
      usedKeywordsIDs: _usedKeywordsIDs,
    );

    return _refined;
  }
// -----------------------------------------------------------------------------
}
