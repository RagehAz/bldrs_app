part of zone_phids_protocols;


class _ZonePhidsLDBOps {
  // -----------------------------------------------------------------------------

  const _ZonePhidsLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Future<void> insert({
    required ZonePhidsModel? zonePhidsModel,
  }) async {

    if (zonePhidsModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.zonePhids,
        primaryKey: 'id',
        input: {
          'id': zonePhidsModel.zoneID,
          'map': zonePhidsModel.toMap(),
        },
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<ZonePhidsModel?> read({
    required String? zoneID,
  }) async {
    ZonePhidsModel? _output;

    if (zoneID != null){

      final Map<String, dynamic>? _ldbMap = await LDBOps.readMap(
          primaryKey: 'id',
          id: zoneID,
          docName: LDBDoc.zonePhids,
      );

      if (_ldbMap != null){

        _output = ZonePhidsModel(
            zoneID: zoneID,
            phidsMap: _ldbMap['map'],
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> delete({
    required String? zoneID,
  }) async {

    await LDBOps.deleteMap(
        objectID: zoneID,
        docName: LDBDoc.zonePhids,
        primaryKey: 'id',
    );

  }
  // -----------------------------------------------------------------------------

}
