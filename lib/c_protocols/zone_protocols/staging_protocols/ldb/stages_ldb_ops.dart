import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class StagingLDBOps {
  // -----------------------------------------------------------------------------

  const StagingLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE / UPDATE

  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<void> insertStaging({
    required StagingModel? staging,
  }) async {

    await LDBOps.insertMap(
      docName: LDBDoc.staging,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
      input: staging?.toMap(
        toLDB: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<StagingModel?> readStaging({
    required String? id,
  }) async {
    StagingModel? _output;

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      docName: LDBDoc.staging,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
      ids: id == null ? [] : <String>[id],
    );

    if (Lister.checkCanLoop(_maps) == true){

      _output = StagingModel.decipher(
        id: id,
        map: _maps.first,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<void> deleteStaging({
    required String id,
  }) async {

    await LDBOps.deleteMaps(
      docName: LDBDoc.staging,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
      ids: <String>[id],
    );

  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static Future<void> deleteStagings({
    required List<String> ids,
  }) async {

    if (Lister.checkCanLoop(ids) == true){

      await  LDBOps.deleteMaps(
        docName: LDBDoc.staging,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.staging),
        ids: ids,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
