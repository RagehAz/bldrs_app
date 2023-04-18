part of super_fire;

class Real {
  // -----------------------------------------------------------------------------

  const Real();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TASK : TEST
  static Future<Map<String, dynamic>> createColl({
    @required String coll,
    @required Map<String, dynamic> map,
  }) async {
    Map<String, dynamic> _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.createColl(
        coll: coll,
        map: map,
      );
    }
    else {
      _output = await _NativeReal.createColl(
        coll: coll,
        map: map,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST
  static Future<Map<String, dynamic>> createDoc({
    @required String coll,
    @required Map<String, dynamic> map,
    @required bool addDocIDToOutput,
  }) async {

    Map<String, dynamic> _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.createDoc(
        coll: coll,
        map: map,
        addDocIDToOutput: addDocIDToOutput,
      );
    }
    else {
      _output = await _NativeReal.createDoc(
        coll: coll,
        map: map,
        addDocIDToOutput: addDocIDToOutput,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST
  static Future<void> createNamedDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> map,
    bool pushNodeOneStepDeepWithUniqueID = false,
    bool isUpdating = false,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.createNamedDoc(
        coll: coll,
        doc: doc,
        map: map,
        pushNodeOneStepDeepWithUniqueID: pushNodeOneStepDeepWithUniqueID,
        isUpdating: isUpdating,
      );
    }
    else {
      await _NativeReal.createNamedDoc(
        coll: coll,
        doc: doc,
        map: map,
        pushNodeOneStepDeepWithUniqueID: pushNodeOneStepDeepWithUniqueID,
        isUpdating: isUpdating,
      );
    }

  }
  // --------------------
  /// TASK : TEST
  static Future<Map<String, dynamic>> createDocInPath({
    @required String pathWithoutDocName,
    @required bool addDocIDToOutput,
    @required Map<String, dynamic> map,
    /// random id is assigned as docName if this parameter is not assigned
    String docName,
  }) async {
    Map<String, dynamic> _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.createDocInPath(
        pathWithoutDocName: pathWithoutDocName,
        addDocIDToOutput: addDocIDToOutput,
        map: map,
        docName: docName,
      );
    }
    else {
      _output = await _NativeReal.createDocInPath(
        pathWithoutDocName: pathWithoutDocName,
        addDocIDToOutput: addDocIDToOutput,
        map: map,
        docName: docName,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST
  static Future<List<Map<String, dynamic>>> readPathMaps({
    @required RealQueryModel realQueryModel,
    Map<String, dynamic> startAfter,
    bool addDocIDToEachMap = true,
  }) async {

    List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.readPathMaps(
        realQueryModel: realQueryModel,
        startAfter: startAfter,
        addDocIDToEachMap: addDocIDToEachMap,
      );
    }
    else {
      _output = await _NativeReal.readPathMaps(
        realQueryModel: realQueryModel,
        startAfter: startAfter,
        addDocIDToEachMap: addDocIDToEachMap,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST
  static Future<Map<String, dynamic>> readPathMap({
    @required String path,
  }) async {

    Map<String, dynamic> _output = {};

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.readPathMap(
        path: path,
      );
    }
    else {
      _output = await _NativeReal.readPathMap(
        path: path,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST
  static Future<dynamic> readPath({
    /// looks like : 'collName/docName/...'
    @required String path,
  }) async {

    dynamic _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.readPath(
        path: path,
      );
    }
    else {
      _output = await _NativeReal.readPath(
        path: path,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST
  static Future<Map<String, dynamic>> readDoc({
    @required String coll,
    @required String doc,
    bool addDocID = true,
  }) async {

    Map<String, dynamic> _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.readDoc(
        coll: coll,
        doc: doc,
        addDocID: addDocID,
      );
    }
    else {
      _output = await _NativeReal.readDoc(
        coll: coll,
        doc: doc,
        addDocID: addDocID,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST
  static Future<Map<String, dynamic>> readDocOnce({
    @required String coll,
    @required String doc,
    bool addDocID = true,
  }) async {
    Map<String, dynamic> _output;

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      _output = await _OfficialReal.readDocOnce(
        coll: coll,
        doc: doc,
        addDocID: addDocID,
      );
    }
    else {
      _output = await _NativeReal.readDocOnce(
        coll: coll,
        doc: doc,
        addDocID: addDocID,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST
  static Future<void> updateColl({
    @required String coll,
    @required Map<String, dynamic> map,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.updateColl(
        coll: coll,
        map: map,
      );
    }
    else {
      await _NativeReal.updateColl(
        coll: coll,
        map: map,
      );
    }

  }
  // --------------------
  /// TASK : TEST
  static Future<void> updateDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> map,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.updateDoc(
        coll: coll,
        doc: doc,
        map: map,
      );
    }
    else {
      await _NativeReal.updateDoc(
        coll: coll,
        doc: doc,
        map: map,
      );
    }

  }
  // --------------------
  /// TASK : TEST
  static Future<void> updatePath({
    @required String path,
    @required Map<String, dynamic> map,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.updatePath(
        path: path,
        map: map,
      );
    }
    else {
      await _NativeReal.updatePath(
        path: path,
        map: map,
      );
    }


  }
  // --------------------
  /// TASK : TEST
  static Future<void> updateDocField({
    @required String coll,
    @required String doc,
    @required String field,
    @required dynamic value,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.updateDocField(
        coll: coll,
        doc: doc,
        field: field,
        value: value,
      );
    }
    else {
      await _NativeReal.updateDocField(
        coll: coll,
        doc: doc,
        field: field,
        value: value,
      );
    }

  }
  // --------------------
  /// TASK : TEST
  static Future<void> incrementDocFields({
    @required BuildContext context,
    @required String coll,
    @required String doc,
    @required Map<String, int> incrementationMap,
    @required bool isIncrementing,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.incrementDocFields(
        context: context,
        coll: coll,
        doc: doc,
        incrementationMap: incrementationMap,
        isIncrementing: isIncrementing,
      );
    }
    else {
      await _NativeReal.incrementDocFields(
        context: context,
        coll: coll,
        doc: doc,
        incrementationMap: incrementationMap,
        isIncrementing: isIncrementing,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST
  static Future<void> deleteDoc({
    @required String coll,
    @required String doc,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.deleteDoc(
        coll: coll,
        doc: doc,
      );
    }
    else {
      await _NativeReal.deleteDoc(
        coll: coll,
        doc: doc,
      );
    }

  }
  // --------------------
  /// TASK : TEST
  static Future<void> deleteField({
    @required String coll,
    @required String doc,
    @required String field,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.deleteField(
        coll: coll,
        doc: doc,
        field: field,
      );
    }
    else {
      await _NativeReal.deleteField(
        coll: coll,
        doc: doc,
        field: field,
      );
    }

  }
  // --------------------
  /// TASK : TEST
  static Future<void> deletePath({
    @required String pathWithDocName,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.deletePath(
        pathWithDocName: pathWithDocName,
      );
    }
    else {
      await _NativeReal.deletePath(
        pathWithDocName: pathWithDocName,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CLONE

  // --------------------
  /// TASK : TEST
  static Future<void> cloneColl({
    @required String oldColl, // coll/doc/node/mapName
    @required String newColl, // newColl
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.cloneColl(
        oldColl: oldColl,
        newColl: newColl,
      );
    }
    else {
      await _NativeReal.cloneColl(
        oldColl: oldColl,
        newColl: newColl,
      );
    }

  }
  // --------------------
  /// TASK : TEST
  static Future<void> clonePath({
    @required String oldPath,
    @required String newPath,
  }) async {

    if (FirebaseInitializer.isUsingOfficialPackages() == true){
      await _OfficialReal.clonePath(
        oldPath: oldPath,
        newPath: newPath,
      );
    }
    else {
      await _NativeReal.clonePath(
        oldPath: oldPath,
        newPath: newPath,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
