import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';

class PickerLDBOps{
  // -----------------------------------------------------------------------------

  const PickerLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPickers({
    required List<PickerModel> pickers,
    required FlyerType? flyerType,
  }) async {

    if (Lister.checkCanLoopList(pickers) == true) {
      await LDBOps.insertMap(
        docName: LDBDoc.pickers,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pickers),
        input: {
          'id': PickerModel.getPickersIDByFlyerType(flyerType),
          'pickers': PickerModel.cipherPickers(pickers),
        },
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PickerModel>> readPickers({
    required FlyerType? flyerType,
  }) async {

    List<PickerModel> _pickers = <PickerModel>[];

    final String? _pickersID = PickerModel.getPickersIDByFlyerType(flyerType);

    if (_pickersID != null){

          final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        docName: LDBDoc.pickers,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pickers),
        ids: <String>[_pickersID]
    );

    if (Lister.checkCanLoopList(_maps) == true){

      final Map<String, dynamic> _map = _maps.first['pickers'];

      _pickers = PickerModel.decipherPickers(_map);

    }

    }

    return _pickers;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updatePickers({
    required List<PickerModel> pickers,
    required FlyerType flyerType,
  }) async {

    if (Lister.checkCanLoopList(pickers) == true){
      await LDBOps.insertMap(
        docName: LDBDoc.pickers,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pickers),
        input: {
          'id' : PickerModel.getPickersIDByFlyerType(flyerType),
          'pickers' : PickerModel.cipherPickers(pickers),
        },
      );
    }


  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deletePickers({
    required FlyerType flyerType,
  }) async {

    await LDBOps.deleteMap(
        docName: LDBDoc.pickers,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pickers),
        objectID: PickerModel.getPickersIDByFlyerType(flyerType)
    );

  }
  // -----------------------------------------------------------------------------
}
