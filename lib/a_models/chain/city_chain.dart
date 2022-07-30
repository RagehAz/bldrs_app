import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class CityChain {
/// --------------------------------------------------------------------------
  CityChain({
    @required this.cityID,
    @required this.keywordsIDsUsage,
});
  /// --------------------------------------------------------------------------
  final String cityID;
  final List<MapModel> keywordsIDsUsage;
// -----------------------------------------------------------------------------

/// CYPHERS

// --------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    final Map<String, dynamic> _map = MapModel.cipherMapModels(keywordsIDsUsage);
    return _map;
  }
// --------------------------------
  /// TESTED : WORKS PERFECT
  static CityChain decipherCityChain({
    @required Map<String, dynamic> map,
    @required String cityID,
  }){

    CityChain _cityChain;

    if (Map != null && cityID != null){
      _cityChain = CityChain(
        cityID: cityID,
        keywordsIDsUsage: MapModel.decipherMapModels(map),
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
  static CityChain createCityChainFromFlyer({
    @required FlyerModel flyerModel,
  }){
    CityChain _cityChain;

    if (flyerModel != null){

      _cityChain = CityChain(
          cityID: flyerModel.zone.cityID,
          keywordsIDsUsage: createKeywordsIDsUsageMapsFromSpecs(
            specs: flyerModel.specs,
          ),
      );

    }

    return _cityChain;
  }
// -----------------------------
}
