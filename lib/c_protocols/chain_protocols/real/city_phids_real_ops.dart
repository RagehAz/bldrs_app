import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class CityPhidsRealOps {
  // -----------------------------------------------------------------------------

  const CityPhidsRealOps();

  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityPhidsModel> readCityPhids({
    @required String cityID,
  }) async {
    CityPhidsModel _cityChain;

    if (cityID != null){

      final Map<String, dynamic> _map = await Real.readDoc(
        collName: RealColl.citiesPhids,
        docName: cityID,
      );

      if (_map != null){
        _cityChain = CityPhidsModel.decipherCityPhids(
          map: _map,
          cityID: _map['id'],
        );
      }

    }

    return _cityChain;
  }
  // -----------------------------------------------------------------------------

  /// EDITOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementFlyerCityChainUsage({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool isIncrementing,
  }) async {

    if (flyerModel != null){

      final CityPhidsModel _cityPhidsToAdd = CityPhidsModel.createCityPhidModelFromFlyer(
        flyerModel: flyerModel,
      );

      await Real.incrementDocFields(
        context: context,
        collName: RealColl.citiesPhids,
        docName: flyerModel.zone.cityID,
        mapOfFieldsAndNumbers: _cityPhidsToAdd.toMap(),
        isIncrementing: isIncrementing,
      );

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> incrementFlyersCityChainUsage({
    @required BuildContext context,
    @required List<FlyerModel> flyersModels,
    @required bool isIncrementing,
  }) async {

    if (Mapper.checkCanLoopList(flyersModels) == true){

      await Future.wait(<Future>[

        ...List.generate(flyersModels.length, (index) => incrementFlyerCityChainUsage(
          context: context,
          flyerModel: flyersModels[index],
          isIncrementing: isIncrementing,
        )),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> updateFlyerCityChainUsage({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required FlyerModel oldFlyer,
  }) async {

    if (flyerModel != null && oldFlyer != null){

      final List<SpecModel> _oldSpecs = SpecModel.getChainKSpecs(oldFlyer.specs);
      final List<SpecModel> _newSpecs = SpecModel.getChainKSpecs(flyerModel.specs);

      final bool _areIdentical = SpecModel.checkSpecsListsAreIdentical(_oldSpecs, _newSpecs);

      if (_areIdentical == false){

        /// GET REMOVED SPECS
        final List<SpecModel> _removedSpecs = <SpecModel>[];
        for (final SpecModel _oldSpec in _oldSpecs){
          final bool _isInNew = SpecModel.checkSpecsContainThisSpec(
              specs: _newSpecs,
              spec: _oldSpec,
          );

          /// STILL THERE IN THE NEW LIST => DO NOT DELETE
          if (_isInNew == true){
            // DO NOTHING
          }
          /// WAS IN OLD LIST BUT NOW REMOVED FROM NEW => SHOULD BE REMOVED
          else {
            _removedSpecs.add(_oldSpec);
          }

        }

        /// GET NEW SPECS
        final List<SpecModel> _addedSpecs = <SpecModel>[];
        for (final SpecModel _newSpec in _newSpecs){
          final bool _isInNew = SpecModel.checkSpecsContainThisSpec(
            specs: _oldSpecs,
            spec: _newSpec,
          );

          /// NEW SPEC IS IN OLD SPECS => ITS NOT A NEW
          if (_isInNew == true){
            // DO NOTHING
          }
          /// NEW SPEC WAS NOT IN OLD LIST => SHOULD BE ADDED
          else {
            _addedSpecs.add(_newSpec);
          }

        }

        /// CREATE UPDATED MAP
        Map<String, dynamic> _mapOfFieldsAndNumbers = {};

        /// ADD REMOVED SPECS WITH DECREMENT VALUES
        for (final SpecModel specToRemove in _removedSpecs){
          _mapOfFieldsAndNumbers = Mapper.insertPairInMap(
            map: _mapOfFieldsAndNumbers,
            key: specToRemove.value,
            value: _mapOfFieldsAndNumbers[specToRemove.value] == null ? -1 : _mapOfFieldsAndNumbers[specToRemove.value] -1,
            overrideExisting: true,
          );
        }

        /// ADD ADDED SPECS WITH INCREMENT VALUES
        for (final SpecModel specToRemove in _removedSpecs){
          _mapOfFieldsAndNumbers = Mapper.insertPairInMap(
            map: _mapOfFieldsAndNumbers,
            key: specToRemove.value,
            value: _mapOfFieldsAndNumbers[specToRemove.value] == null ? 1 : _mapOfFieldsAndNumbers[specToRemove.value] +1,
            overrideExisting: true,
          );
        }

        /// REMOVE POTENTIAL ZERO VALUES PAIRS
        final List<String> _keys = _mapOfFieldsAndNumbers.keys.toList();
        for (final String _key in _keys){
          if (_mapOfFieldsAndNumbers[_key] == 0){
            _mapOfFieldsAndNumbers[_key] = null;
          }
        }

        /// CLEAR POTENTIAL NULL VALUES
        _mapOfFieldsAndNumbers = Mapper.cleanNullPairs(_mapOfFieldsAndNumbers);

        /// INCREMENT VALUES OPS
        await Real.incrementDocFields(
          context: context,
          collName: RealColl.citiesPhids,
          docName: flyerModel.zone.cityID,
          mapOfFieldsAndNumbers: _mapOfFieldsAndNumbers,
          isIncrementing: true,
        );


      }

    }

  }
  // -----------------------------------------------------------------------------
}
