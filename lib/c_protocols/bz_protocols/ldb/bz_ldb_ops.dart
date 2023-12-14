import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/draft/draft_bz.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class BzLDBOps {
  // -----------------------------------------------------------------------------

  const BzLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBz(BzModel? bzModel) async {

    await LDBOps.insertMap(
      docName: LDBDoc.bzz,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzz),
      input: bzModel?.toMap(toJSON: true),
      // allowDuplicateIDs: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBzz({
    required List<BzModel>? bzz,
  }) async {

    await LDBOps.insertMaps(
      docName: LDBDoc.bzz,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzz),
      inputs: BzModel.cipherBzz(
        bzz: bzz,
        toJSON: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> readBz(String? bzID) async {

    final Map<String, dynamic>? _bzMap = await LDBOps.searchFirstMap(
      sortFieldName: 'id',
      searchFieldName: 'id',
      searchValue: bzID,
      docName: LDBDoc.bzz,
    );

    BzModel? _bzModel;

    if (_bzMap != null){
      _bzModel = BzModel.decipherBz(
        map: _bzMap,
        fromJSON: true,
      );
    }

    return _bzModel;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<BzModel>> readAll() async {

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.bzz,
    );

    final List<BzModel> _bzzModels = BzModel.decipherBzz(
      maps: _maps,
      fromJSON: true,
    );

    return _bzzModels;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBzOps({
    required BzModel? bzModel,
  }) async {

    await LDBOps.insertMap(
      docName: LDBDoc.bzz,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzz),
      input: bzModel?.toMap(toJSON: true),
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteBzOps({
    required String? bzID,
  }) async {

    await LDBOps.deleteMap(
      docName: LDBDoc.bzz,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzz),
      objectID: bzID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOut() async {
    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bzz);
  }
  // -----------------------------------------------------------------------------

  /// BZ EDITOR SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveBzEditorSession({
    required DraftBz? draft,
  }) async {

    if (draft != null){

      await LDBOps.insertMap(
        docName: LDBDoc.bzEditor,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzEditor),
        input: draft.toLDB(),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftBz?> loadBzEditorSession({
    required BuildContext context,
    required String? bzID,
  }) async {
    DraftBz? _draft;

    if (bzID != null) {

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: <String>[bzID],
        docName: LDBDoc.bzEditor,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzEditor),
      );

      if (Lister.checkCanLoop(_maps) == true) {
        _draft = DraftBz.fromLDB(
          map: _maps.first,
          context: context,
        );
      }

    }

    return _draft;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteBzEditorSession(String? bzID) async {

    await LDBOps.deleteMap(
      objectID: bzID,
      docName: LDBDoc.bzEditor,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzEditor),
    );

  }
  // -----------------------------------------------------------------------------

  /// AUTHOR EDITOR SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveAuthorEditorSession({
    required AuthorModel? authorModel,
  }) async {

    if (authorModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.authorEditor,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.authorEditor),
        input: authorModel.toMap(includePicModel: true),
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthorModel?> loadAuthorEditorSession({
    required String? authorID,
  }) async {
    AuthorModel? _author;

    if (authorID != null){

      final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        ids: <String>[authorID],
        docName: LDBDoc.authorEditor,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.authorEditor),
      );

      if (Lister.checkCanLoop(_maps) == true){
        _author = AuthorModel.decipherAuthor(_maps.first);
      }

    }


    return _author;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAuthorEditorSession(String? authorID) async {

    await LDBOps.deleteMap(
      objectID: authorID,
      docName: LDBDoc.authorEditor,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.authorEditor),
    );
  }
  // -----------------------------------------------------------------------------
}
