import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

class AuthLDBOps {
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
        input: authModel.toMap(toJSON: true),
      );

      blog('AuthLDBOps : insertAuthModel : inserted AuthModel of uid : ${authModel?.uid}');

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

    if (Mapper.checkCanLoopList(_list) == true){

      _authModel = AuthModel.decipherAuthModel(
        map: _list.first,
        fromJSON: true,
      );

      blog('AuthLDBOps : readAuthModel : got AuthModel from LDB for uid : ${_authModel?.uid}');

    }

    else {
      blog('AuthLDBOps : readAuthModel : no AuthModel found on LDB');
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
        input: newAuthModel.toMap(toJSON: true),
      );

      blog('AuthLDBOps : updateAuthModel : updated AuthModel on LDB of uid : ${newAuthModel?.uid}');

    }

    else {
      blog('AuthLDBOps : updateAuthModel : input AuthModel to update is null');
    }

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
      );

      blog('AuthLDBOps : deleteAuthModel : deleted AuthModel of uid : $uid');
    }

    else {
      blog('AuthLDBOps : deleteAuthModel : did not delete auth model : given uid is null');
    }

  }
  // -----------------------------------------------------------------------------
}
