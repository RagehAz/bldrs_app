import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:ldb/ldb.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class AccountLDBOps {
  // -----------------------------------------------------------------------------

  const AccountLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAccount({
    @required AccountModel account,
  }) async {
    if (account != null && account.id != null) {
      await LDBOps.insertMap(
        docName: LDBDoc.accounts,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.accounts),
        input: account.toMap(),
      );
    }
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AccountModel> readAccount({
    @required String id,
  }) async {

    final Map<String, dynamic> _map = await LDBOps.readMap(
      docName: LDBDoc.accounts,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.accounts),
      id: id,
    );

    return AccountModel.decipher(_map);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AccountModel>> realAllAccounts() async {
    final List<AccountModel> _output = <AccountModel>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.accounts,
    );

    if (Mapper.checkCanLoopList(_maps) == true){
      for (final Map<String, dynamic> _map in _maps){
        _output.add(AccountModel.decipher(_map));
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteAccount({
    @required String id,
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
  /// TASK : TEST ME
  static Future<void> deleteAllAccounts() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.accounts,
    );

  }
  // -----------------------------------------------------------------------------
}
