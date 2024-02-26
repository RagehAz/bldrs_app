part of fish_tank;

/// =>TAMAM
class FishRealOps {
  // -----------------------------------------------------------------------------

  const FishRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FishModel?> create({
    required FishModel fish,
  }) async {

    final Map<String, dynamic>? _map = await Real.createDoc(
      coll: RealColl.fishes,
      doc: TextMod.idifyString(fish.id),
      map: fish.toMap(),
    );

    return FishModel.decipher(map: _map);
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
      final Map<String, dynamic>? _map = await Real.readDoc(
          coll: RealColl.fishes,
          doc: id,
      );

      return FishModel.decipher(map: _map);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FishModel>> readAll({
    int? limit = 1000,
  }) async {

    final List<Map<String, dynamic>> _map = await Real.readPathMaps(
        realQueryModel: RealQueryModel(
          path: RealColl.fishes,
          idFieldName: 'id',
          limit: limit,
        ),
    );

    return FishModel.decipherFishes(maps: _map);

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> update({
    required FishModel? fish,
  }) async {

    if (fish?.id != null){

      await Real.updateDoc(
          coll: RealColl.fishes,
          doc: fish!.id!,
          map: fish.toMap(),
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

      await Real.deleteDoc(
          coll: RealColl.fishes,
          doc: id,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
