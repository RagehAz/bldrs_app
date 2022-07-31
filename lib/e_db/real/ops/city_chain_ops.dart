import 'package:bldrs/a_models/chain/city_chain.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class CityChainOps {
/// --------------------------------------------------------------------------

  CityChainOps();

// -----------------------------------------------------------------------------

  /// READ

// --------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CityChain> readCityChain({
    @required BuildContext context,
    @required String cityID,
}) async {
    CityChain _cityChain;

    if (cityID != null){

      final Map<String, dynamic> _map = await Real.readDoc(
        context: context,
        collName: RealColl.chainsUsage,
        docName: 'egy_cairo',
      );

      if (_map != null){
        _cityChain = CityChain.decipherCityChain(
          map: _map,
          cityID: _map['id'],
        );
      }

    }

    return _cityChain;
  }
// -----------------------------------------------------------------------------

/// EDITOR

// --------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementFlyerCityChainUsage({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool isIncrementing,
  }) async {

    if (flyerModel != null){

      final CityChain _cityChainToAdd = CityChain.createCityChainFromFlyer(
        flyerModel: flyerModel,
      );

      await Real.incrementDocFields(
        context: context,
        collName: RealColl.chainsUsage,
        docName: flyerModel.zone.cityID,
        mapOfFieldsAndNumbers: _cityChainToAdd.toMap(),
        isIncrementing: isIncrementing,
      );

    }

  }
// --------------------------------

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