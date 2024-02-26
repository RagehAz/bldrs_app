part of fish_tank;

/// => TAMAM+
class FishLDBOps {
  // -----------------------------------------------------------------------------

  const FishLDBOps();

  // -----------------------------------------------------------------------------
  static const String ldbDoc = 'fishes';
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insert({
    required FishModel? fish,
  }) async {

    await LDBOps.insertMap(
        docName: ldbDoc,
        primaryKey: 'id',
        input: fish?.toMap(),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertFishes({
    required List<FishModel> fishes,
  }) async {

    await LDBOps.insertMaps(
        docName: ldbDoc,
        primaryKey: 'id',
        inputs: FishModel.cipherFishes(
          fishes: fishes,
        ),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FishModel?> read({
    required String id,
  }) async {

    final Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: ldbDoc,
        id: id,
        primaryKey: 'id',
    );

    return FishModel.decipher(map: _map);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FishModel>> readAll() async {

    final List<Map<String, dynamic>> _map = await LDBOps.readAllMaps(
        docName: ldbDoc,
    );

    return FishModel.decipherFishes(maps: _map);
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> delete({
    required String? id,
  }) async {

    await LDBOps.deleteMap(
        objectID: id,
        docName: ldbDoc,
        primaryKey: 'id',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAll() async {
    await LDBOps.deleteAllMapsAtOnce(docName: ldbDoc);
  }
  // -----------------------------------------------------------------------------
}
