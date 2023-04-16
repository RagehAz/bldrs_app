part of super_fire;

class NativeStorage {
  // -----------------------------------------------------------------------------

  /// NativeStorage SINGLETON

  // --------------------
  NativeStorage.singleton();
  static final NativeStorage _singleton = NativeStorage.singleton();
  static NativeStorage get instance => _singleton;
  // -----------------------------------------------------------------------------
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<void> create() async {}
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> readPath({
    @required String picPath,
  }) async {
    Uint8List _output;

    if (picPath != null) {
      await tryAndCatch(
        functions: () async {
          _output = await NativeFirebase.getStorage().ref(picPath).getData();
        },
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  static Future<void> update() async {}
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> delete() async {}
  // -----------------------------------------------------------------------------
}
