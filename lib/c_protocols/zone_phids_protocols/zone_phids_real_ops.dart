import 'package:bldrs/a_models/c_chain/b_zone_phids_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';

class ZonePhidsRealOps {
  // -----------------------------------------------------------------------------

  const ZonePhidsRealOps();

  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<ZonePhidsModel> readZonePhidsOfCurrentZone() async {
    ZonePhidsModel _output;

    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
      context: getMainContext(),
      listen: false,
    );

    if (_currentZone != null && _currentZone.countryID != null){

      /// COUNTRY PHIDS
      if (_currentZone.cityID == null){
        _output = await _readCountryPhids(
          countryID: _currentZone.countryID,
        );
      }

      /// CITY PHIDS
      else {
        _output = await _readCityPhids(
          cityID: _currentZone.cityID,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<ZonePhidsModel> _readCityPhids({
    required String cityID,
  }) async {
    ZonePhidsModel _output;

    if (cityID != null){

      final Map<String, dynamic>? _map = await Real.readPathMap(
        path: RealPath.zonesPhids_countryID_cityID(
          countryID: CityModel.getCountryIDFromCityID(cityID),
          cityID: cityID,
        ),
      );

      if (_map != null){
        _output = ZonePhidsModel.decipherZonePhids(
          map: _map,
          cityID: _map['id'],
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<ZonePhidsModel> _readCountryPhids({
    required String countryID,
  }) async {
    ZonePhidsModel _output;

    if (countryID != null){

      // final List<CityModel> _cities = await ZoneProtocols.fetchCitiesOfCountry(
      //   countryID: countryID,
      // );
      //
      // if (Mapper.checkCanLoopList(_cities) == true){
      //
      //   final List<String> _citiesIDs = CityModel.getCitiesIDs(_cities);
      //
      //   await Future.wait(<Future>[
      //
      //     ...List.generate(_citiesIDs.length, (index){
      //
      //       final String _cityID = _citiesIDs[index];
      //
      //       return _readCityPhids(cityID: _cityID).then((ZonePhidsModel model){
      //
      //         _output = ZonePhidsModel.combineModels(
      //           zoneID: countryID,
      //           base: _output,
      //           add: model,
      //         );
      //
      //         blog('readCountryPhids : ${_output?.phidsMaps?.length} phids');
      //
      //       });
      //
      //     }),
      //
      //   ]);
      //
      // }

      final Map<String, dynamic>? _map = await Real.readPathMap(
        path: RealPath.zonesPhids_countryID(
            countryID: countryID,
          ),
      );

      if (_map != null){

        final List<String> _citiesIDs = _map.keys.toList();
        _citiesIDs?.remove('id');

        if (Mapper.checkCanLoopList(_citiesIDs) == true){

          for (final String cityID in _citiesIDs){

            final Map<String, dynamic> _cityPhids = _map[cityID];

            final ZonePhidsModel _model = ZonePhidsModel.decipherZonePhids(
              map: _cityPhids,
              cityID: cityID,
            );

            _output = ZonePhidsModel.combineModels(
              zoneID: countryID,
              base: _output,
              add: _model,
            );

          }

        }


      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EDITOR

  // --------------------
  /// TASK : TEST ME
  static Future<void> incrementFlyerCityPhids({
    required FlyerModel flyerModel,
    required bool isIncrementing,
  }) async {

    if (flyerModel != null){

      final ZonePhidsModel _cityPhidsToAdd = ZonePhidsModel.createZonePhidModelFromFlyer(
        flyerModel: flyerModel,
      );

      await Real.incrementPathFields(
        path: RealPath.zonesPhids_countryID_cityID(
            countryID: flyerModel.zone?.countryID,
            cityID: flyerModel.zone?.cityID,
        ),
        incrementationMap: _cityPhidsToAdd.toMap(),
        isIncrementing: isIncrementing,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> incrementFlyersCitiesPhids({
    required List<FlyerModel> flyersModels,
    required bool isIncrementing,
  }) async {

    if (Mapper.checkCanLoopList(flyersModels) == true){

      await Future.wait(<Future>[

        ...List.generate(flyersModels.length, (index) => incrementFlyerCityPhids(
          flyerModel: flyersModels[index],
          isIncrementing: isIncrementing,
        )),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRenovateFlyer({
    required FlyerModel flyerModel,
    required FlyerModel oldFlyer,
  }) async {

    if (flyerModel != null && oldFlyer != null){

      final List<String> _oldPhids = oldFlyer.phids;
      final List<String> _newPhids = flyerModel.phids;

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
          flyerModel: oldFlyer,
          isIncrementing: false,
        );

        /// INCREMENT NEW PHIDS
        await incrementFlyerCityPhids(
          flyerModel: flyerModel,
          isIncrementing: true,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
}
