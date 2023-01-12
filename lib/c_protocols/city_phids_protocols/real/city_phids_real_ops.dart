import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';
/// => TAMAM
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityPhidsModel> readCityPhidsOfCurrentZone({
    @required BuildContext context,
  }) async {
    CityPhidsModel _cityPhidCounters;

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: false,
    );

    if (_currentZone != null){

      _cityPhidCounters = await CityPhidsRealOps.readCityPhids(
        cityID: _currentZone.cityID,
      );

    }

    return _cityPhidCounters;
  }
  // -----------------------------------------------------------------------------

  /// EDITOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementFlyerCityPhids({
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
        incrementationMap: _cityPhidsToAdd.toMap(),
        isIncrementing: isIncrementing,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementFlyersCitiesPhids({
    @required BuildContext context,
    @required List<FlyerModel> flyersModels,
    @required bool isIncrementing,
  }) async {

    if (Mapper.checkCanLoopList(flyersModels) == true){

      await Future.wait(<Future>[

        ...List.generate(flyersModels.length, (index) => incrementFlyerCityPhids(
          context: context,
          flyerModel: flyersModels[index],
          isIncrementing: isIncrementing,
        )),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRenovateFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required FlyerModel oldFlyer,
  }) async {

    if (flyerModel != null && oldFlyer != null){

      final List<String> _oldPhids = oldFlyer.keywordsIDs;
      final List<String> _newPhids = flyerModel.keywordsIDs;

      final bool _areIdentical = Mapper.checkListsAreIdentical(
          list1: _oldPhids,
          list2: _newPhids,
      );

      final bool _zonesAreIdentical = ZoneModel.checkZonesIDsAreIdentical(
          zone1: flyerModel.zone,
          zone2: oldFlyer.zone,
      );

      if (_areIdentical == false || _zonesAreIdentical == false){

        /// DECREMENT OLD PHIDS
        await incrementFlyerCityPhids(
          context: context,
          flyerModel: oldFlyer,
          isIncrementing: false,
        );

        /// INCREMENT NEW PHIDS
        await incrementFlyerCityPhids(
          context: context,
          flyerModel: flyerModel,
          isIncrementing: true,
        );

        // /// GET REMOVED PHIDS
        // final List<String> _removedPhids = Stringer.getRemovedStrings(
        //     oldStrings: _oldPhids,
        //     newStrings: _newPhids
        // );
        //
        // /// GET NEW PHIDS
        // final List<String> _addedPhids = Stringer.getAddedStrings(
        //     oldStrings: _oldPhids,
        //     newStrings: _newPhids
        // );
        //
        // /// CREATE INCREMENTATION MAP
        // final Map<String, dynamic> _incrementationMap = CityPhidsModel.createIncrementationMap(
        //     removedPhids: _removedPhids,
        //     addedPhids: _addedPhids,
        // );
        //
        // /// INCREMENT VALUES OPS
        // await Real.incrementDocFields(
        //   context: context,
        //   collName: RealColl.citiesPhids,
        //   docName: flyerModel.zone.cityID,
        //   incrementationMap: _incrementationMap,
        //   isIncrementing: true,
        // );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
