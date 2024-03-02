part of fish_tank;

/// =>TAMAM
class FishFireOps {
  // -----------------------------------------------------------------------------

  const FishFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FishModel?> create({
    required FishModel fish,
  }) async {

    Map<String, dynamic>? _map = fish.toMap();

    final String? _id = await Fire.createDoc(
      coll: FireColl.fishes,
      doc: TextMod.idifyString(fish.id),
      input: _map,
    );

    if (_id == null){
      return null;
    }

    else {

      _map = Mapper.insertPairInMap(
          map: _map,
          key: 'id',
          value: _id,
          overrideExisting: true,
      );

      return FishModel.decipher(map: _map);
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FishModel?> read({
    required String? id,
  }) async {

    if (id == null){
      return null;
    }
    else {
      final Map<String, dynamic>? _map = await Fire.readDoc(
          coll: FireColl.fishes,
          doc: id,
      );

      return FishModel.decipher(map: _map);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FishModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await Fire.readAllColl(
      coll: FireColl.fishes,
    );

    return FishModel.decipherFishes(maps: _maps);

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> update({
    required FishModel? fish,
  }) async {

    if (fish?.id != null){

      await Fire.updateDoc(
          coll: FireColl.fishes,
          doc: fish!.id!,
          input: fish.toMap(),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> delete({
    required String? id,
  }) async {

    if (id != null){

      await Fire.deleteDoc(
          coll: FireColl.fishes,
          doc: id,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
