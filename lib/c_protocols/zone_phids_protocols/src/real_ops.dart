// ignore_for_file: unused_element

part of zone_phids_protocols;

/// => TAMAM
class _ZonePhidsRealOps {
  // -----------------------------------------------------------------------------

  const _ZonePhidsRealOps();

  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<ZonePhidsModel?> readZonePhidsByZoneModel({
    required ZoneModel? zoneModel,
}) async {
    ZonePhidsModel? _output;

    if (zoneModel == null || zoneModel == ZoneModel.planetZone){
      _output = await _readPlanetPhids();
    }
    else {

      /// COUNTRY PHIDS
      if (zoneModel.cityID == null || zoneModel.cityID == Flag.allCitiesID){
        _output = await _readCountryPhids(
          countryID: zoneModel.countryID,
        );
      }

      /// CITY PHIDS
      else {
        _output = await _readCityPhids(
          cityID: zoneModel.cityID,
        );
      }

    }

    // zoneModel?.blogZone(
    //   invoker: 'readZonePhidsOfCurrentZone',
    // );
    //
    // _output?.blogZonePhidsModel(
    //   invoker: 'readZonePhidsOfCurrentZone',
    // );

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<ZonePhidsModel?> _readCityPhids({
    required String? cityID,
  }) async {
    ZonePhidsModel? _output;

    if (cityID != null){

      final Map<String, dynamic>? _map = await Real.readPathMap(
        path: RealPath.zonesPhids_countryID_cityID(
          countryID: CityModel.getCountryIDFromCityID(cityID)!,
          cityID: cityID,
        ),
      );

      if (_map != null){
        _output = ZonePhidsModel.decipherCityNodePhids(
          map: _map,
          cityID: _map['id'],
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<ZonePhidsModel?> _readCountryPhids({
    required String? countryID,
  }) async {
    ZonePhidsModel? _output;

    if (countryID != null){

      final Map<String, dynamic>? _map = await Real.readPathMap(
        path: RealPath.zonesPhids_countryID(
            countryID: countryID,
          ),
      );

      _output = ZonePhidsModel.decipherCountryNodeMap(map: _map);

    }

    return _output;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<ZonePhidsModel?> _readPlanetPhids() async {
    ZonePhidsModel? _output;

    final Map<String, dynamic>? _map = await Real.readPathMap(
      path: RealColl.zonesPhids,
    );

    if (_map != null){

      _output = ZonePhidsModel.decipherPlanetNodeMap(
          map: _map,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EDITOR

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<void> incrementFlyerCityPhids({
    required FlyerModel? flyerModel,
    required bool isIncrementing,
  }) async {

    if (flyerModel != null && flyerModel.zone?.countryID != null&& flyerModel.zone?.cityID != null){

      final ZonePhidsModel? _cityPhidsToAdd = ZonePhidsModel.createZonePhidModelFromFlyer(
        flyerModel: flyerModel,
      );

      await Real.incrementPathFields(
        path: RealPath.zonesPhids_countryID_cityID(
            countryID: flyerModel.zone!.countryID,
            cityID: flyerModel.zone!.cityID!,
        ),
        incrementationMap: _cityPhidsToAdd?.toMap(),
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

    if (Lister.checkCanLoop(flyersModels) == true){

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
    required FlyerModel? flyerModel,
    required FlyerModel? oldFlyer,
  }) async {

    if (flyerModel != null && oldFlyer != null){

      final List<String>? _oldPhids = oldFlyer.phids;
      final List<String>? _newPhids = flyerModel.phids;

      final bool _areIdentical = Lister.checkListsAreIdentical(
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
