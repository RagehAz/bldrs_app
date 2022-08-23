import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/material.dart';

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

// --------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    final Map<String, dynamic> _map = MapModel.cipherMapModels(phidsMapModels);
    return _map;
  }
// --------------------------------
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

// --------------------------------
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
// --------------------------------
  /// TESTED : WORKS PERFECT
  static CityPhidsModel createCityPhidModelFromFlyer({
    @required FlyerModel flyerModel,
  }){
    CityPhidsModel _cityChain;

    if (flyerModel != null){

      _cityChain = CityPhidsModel(
          cityID: flyerModel.zone.cityID,
          phidsMapModels: createPhidsMapModelsFromSpecs(
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
  void blogCityPhidsModel({
    String methodName = '',
  }){
    MapModel.blogMapModels(
      mapModels: phidsMapModels,
      methodName: 'blogCityPhidsModel : $methodName : ($cityID)',
    );
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// --------------------------------
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
// -----------------------------------------------------------------------------

  /// MODIFIERS

// --------------------------------
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
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain removeUnusedPhidsFromChainKForThisCity({
    @required Chain bigChainK,
    @required CityPhidsModel currentCityPhidsModel,
  }) {

    final List<String> _usedPhids = CityPhidsModel.getPhidsFromCityPhidsModel(
      cityPhidsModel: currentCityPhidsModel,
    );

    final Chain _refined = Chain.removeAllPhidsNotUsedInThisList(
      chain: bigChainK,
      usedPhids: _usedPhids,
    );

    return _refined;
  }
// -----------------------------------------------------------------------------
}
