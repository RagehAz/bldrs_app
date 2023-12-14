import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class AccountLDBOps {
  // -----------------------------------------------------------------------------

  const AccountLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAccount({
    required AccountModel? account,
  }) async {
    if (
        account != null
        &&
        account.id != null
        &&
        account.email != null
    ) {
      await LDBOps.insertMap(
        docName: LDBDoc.accounts,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.accounts),
        input: account.toMap(),
        // allowDuplicateIDs: false,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertUserModels({
    required List<UserModel> users,
  }) async {

    if (Lister.checkCanLoopList(users) == true){

      final List<AccountModel> _accounts = [];
      for (final UserModel user in users){

        final String? _email = UserModel.getUserEmail(user);

        if (_email != null){

          final AccountModel _account = AccountModel(
            id: user.id,
            email: _email,
            password: null,
            signInMethod: user.signInMethod,
          );

          _accounts.add(_account);

        }


      }

      if (Lister.checkCanLoopList(_accounts) == true){

        final List<Map<String, dynamic>> _maps = AccountModel.cipherAccounts(
          accounts: _accounts,
        );

        await LDBOps.insertMaps(
          docName: LDBDoc.accounts,
          primaryKey: LDBDoc.getPrimaryKey(LDBDoc.accounts),
          inputs: _maps,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AccountModel?> readAccount({
    required String? id,
  }) async {

    final Map<String, dynamic>? _map = await LDBOps.readMap(
      docName: LDBDoc.accounts,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.accounts),
      id: id,
    );

    return AccountModel.decipher(_map);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AccountModel>> readAllAccounts() async {
    final List<AccountModel> _output = <AccountModel>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.accounts,
    );

    if (Lister.checkCanLoopList(_maps) == true){
      for (final Map<String, dynamic> _map in _maps){
        final AccountModel? _model = AccountModel.decipher(_map);
        if (_model != null){
          _output.add(_model);
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AccountModel?> readAnonymousAccount() async {
    AccountModel? _output;

    final List<AccountModel> _all = await readAllAccounts();

    if (Lister.checkCanLoopList(_all) == true){

      for (final AccountModel account in _all){

        final bool _isAnonymousEMail = UserModel.checkIsAnonymousEmail(
            email: account.email,
        );

        if (_isAnonymousEMail == true){
          _output = account;
          break;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAccount({
    required String? id,
  }) async {
    if (id != null) {
      await LDBOps.deleteMap(
        docName: LDBDoc.accounts,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.accounts),
        objectID: id,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllAccounts() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.accounts,
    );

  }
  // -----------------------------------------------------------------------------
}
