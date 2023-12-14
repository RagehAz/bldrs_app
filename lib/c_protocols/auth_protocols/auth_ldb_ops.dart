
/// => TAMAM
class AuthLDBOps {
  /*
  // -----------------------------------------------------------------------------

  const AuthLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAuthModel(AuthModel authModel) async {

    if (authModel != null){
      await LDBOps.insertMap(
        docName: LDBDoc.authModel,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.authModel),
        input: authModel.toMap(),
        // allowDuplicateIDs: false,
      );

      blog('AuthLDBOps : insertAuthModel : inserted AuthModel of uid : ${authModel?.id}');

    }

    else {
      blog('AuthLDBOps : insertAuthModel : authModel is null');
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthModel> readAuthModel() async {

    AuthModel _authModel;

    final List<Map<String, dynamic>> _list = await LDBOps.readAllMaps(
      docName: LDBDoc.authModel,
    );

    if (Lister.checkCanLoop(_list) == true){

      _authModel = AuthModel.decipher(
        map: _list.first,
      );

      // blog('AuthLDBOps : readAuthModel : got AuthModel from LDB for uid : ${_authModel?.id}');

    }

    else {
      // blog('AuthLDBOps : readAuthModel : no AuthModel found on LDB');
    }

    return _authModel;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateAuthModel(AuthModel newAuthModel) async {

    if (newAuthModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.authModel,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.authModel),
        input: newAuthModel.toMap(),
      );

      // blog('AuthLDBOps : updateAuthModel : updated AuthModel on LDB of uid : ${newAuthModel?.uid}');

    }

    // else {
      // blog('AuthLDBOps : updateAuthModel : input AuthModel to update is null');
    // }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAuthModel(String uid) async {

    if (uid != null){

      await LDBOps.deleteMap(
        objectID: uid,
        docName: LDBDoc.authModel,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.authModel),
      );

      blog('AuthLDBOps : deleteAuthModel : deleted AuthModel of uid : $uid');
    }

    else {
      blog('AuthLDBOps : deleteAuthModel : did not delete auth model : given uid is null');
    }

  }
  // -----------------------------------------------------------------------------
   */
}
