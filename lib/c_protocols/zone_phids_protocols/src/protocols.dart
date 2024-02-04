part of zone_phids_protocols;

class ZonePhidsProtocols {
  // -----------------------------------------------------------------------------

  const ZonePhidsProtocols();

  // -----------------------------------------------------------------------------

  /// ON FLYER COMPOSE

  // --------------------
  ///
  static Future<void> onComposeFlyer({
    required FlyerModel flyerModel,
  }) async {

    await _ZonePhidsRealOps.incrementFlyerCityPhids(
        flyerModel: flyerModel,
        isIncrementing: true
    );


    await _refetchAndResetProviderIfCurrentZoneIsThis(
      zoneModel: flyerModel.zone,
    );

  }
  // -----------------------------------------------------------------------------

  /// ON FLYER WIPE

  // --------------------
  ///
  static Future<void> onWipeFlyer({
    required FlyerModel flyerModel,
  }) async {

    await _ZonePhidsRealOps.incrementFlyerCityPhids(
      flyerModel: flyerModel,
      isIncrementing: false,
    );

    await _refetchAndResetProviderIfCurrentZoneIsThis(
      zoneModel: flyerModel.zone,
    );

  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  static Future<ZonePhidsModel?> fetch({
    required ZoneModel? zoneModel,
  }) async {
    ZonePhidsModel? _output;

   final String? zoneID = _getZoneIDByZoneModel(zoneModel: zoneModel);

      _output = await _ZonePhidsLDBOps.read(zoneID: zoneID);

      if (_output == null){

        _output = await _ZonePhidsRealOps.readZonePhidsByZoneModel(
          zoneModel: zoneModel,
        );

        if (_output != null){
          await _ZonePhidsLDBOps.insert(zonePhidsModel: _output);
        }

      }

    return _output;
  }
  // --------------------
  ///
  static Future<ZonePhidsModel?> refetch({
    required ZoneModel? zoneModel,
  }) async {

    final String? zoneID = _getZoneIDByZoneModel(zoneModel: zoneModel);

    await _ZonePhidsLDBOps.delete(zoneID: zoneID);

    final ZonePhidsModel? _zonePhidsModel = await fetch(zoneModel: zoneModel);

    return _zonePhidsModel;
  }
  // -----------------------------------------------------------------------------

  /// ZONE ID BY ZONE MODEL

  // --------------------
  static String? _getZoneIDByZoneModel({
    required ZoneModel? zoneModel,
  }) {

    if (zoneModel == null || zoneModel == ZoneModel.planetZone){
      return ZoneModel.planetZone.countryID;
    }
    else {

      /// COUNTRY PHIDS
      if (zoneModel.cityID == null || zoneModel.cityID == Flag.allCitiesID){
        return zoneModel.countryID;
      }

      /// CITY PHIDS
      else {
        return zoneModel.cityID;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// REFETCH + PROVIDER

  // --------------------
  static Future<void> _refetchAndResetProviderIfCurrentZoneIsThis({
    required ZoneModel? zoneModel,
  }) async {

    await refetch(zoneModel: zoneModel);

    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(context: getMainContext(), listen: false);
    if (ZoneModel.checkZonesIDsAreIdentical(zone1: _currentZone, zone2: zoneModel) == true){
      await ZoneProvider.proSetCurrentZone(zone: zoneModel);
    }

  }
  // -----------------------------------------------------------------------------
}
