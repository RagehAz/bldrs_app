part of fish_tank;

/// => TAMAM
bool fetchedAllFishes = false;
class FishProtocols {
  // -----------------------------------------------------------------------------

  const FishProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<FishModel?> compose({
    required FishModel fish,
  }) async {

    final FishModel? _fish = await FishFireOps.create(fish: fish);

    await FishLDBOps.insert(fish: _fish);

    return _fish;
  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<FishModel?> fetch({
    required String? id,
  }) async {
    FishModel? _output;

    if (id != null){

      _output = await FishLDBOps.read(id: id);

      if (_output == null){

        _output = await FishFireOps.read(id: id);

        if (_output != null){
          unawaited(FishLDBOps.insert(fish: _output));
        }

      }

    }

    return _output;
  }
  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FishModel>> fetchAll() async {
    List<FishModel> _all = [];

    _all = await FishLDBOps.readAll();

    if (Lister.checkCanLoop(_all) == false){
      _all = await FishFireOps.readAll();
      unawaited(FishLDBOps.insertFishes(fishes: _all));
    }

    return _all;
  }
  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FishModel>> refetchAll() async {
    fetchedAllFishes = false;
    await FishLDBOps.deleteAll();
    final List<FishModel> _fishes = await fetchAll();
    return _fishes;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovate({
    required FishModel? newFish,
  }) async {

    if (newFish != null){

      final FishModel? _oldFish = await fetch(id: newFish.id);

      if (FishModel.checkFishesAreIdentical(fish1: newFish, fish2: _oldFish) == false){

        await Future.wait(<Future>[

          FishFireOps.update(fish: newFish),

          FishLDBOps.insert(fish: newFish),

        ]);

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipe({
    required String? id,
  }) async {

    await Future.wait(<Future>[

      FishFireOps.delete(id: id),

      FishLDBOps.delete(id: id),

    ]);

  }
  // -----------------------------------------------------------------------------

  /// EXPORT TO GSHEET

  // -------------------
  static Future<void> exportTankToGSheet() async {



  }
  // -----------------------------------------------------------------------------
}
