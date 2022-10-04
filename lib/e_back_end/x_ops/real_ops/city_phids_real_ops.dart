import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
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
    @required BuildContext context,
    @required String cityID,
  }) async {
    CityPhidsModel _cityChain;

    if (cityID != null){

      final Map<String, dynamic> _map = await Real.readDoc(
        context: context,
        collName: RealColl.chainsUsage,
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
        collName: RealColl.chainsUsage,
        docName: flyerModel.zone.cityID,
        mapOfFieldsAndNumbers: _cityPhidsToAdd.toMap(),
        isIncrementing: isIncrementing,
      );

    }

  }
  // --------------------
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
  // -----------------------------------------------------------------------------
}
