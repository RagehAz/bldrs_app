import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class PickerLDBOps{
  // -----------------------------------------------------------------------------

  const PickerLDBOps();

  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPickers({
    @required List<PickerModel> pickers,
    @required FlyerType flyerType,
  }) async {

    if (Mapper.checkCanLoopList(pickers) == true){
      await LDBOps.insertMap(
        docName: LDBDoc.pickers,
        input: {
          'id' : PickerModel.getPickersIDByFlyerType(flyerType),
          'pickers' : PickerModel.cipherPickers(pickers),
        },
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PickerModel>> readPickers({
    @required FlyerType flyerType,
  }) async {

    List<PickerModel> _pickers = <PickerModel>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
        docName: LDBDoc.pickers,
        ids: <String>[PickerModel.getPickersIDByFlyerType(flyerType)]
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      final Map<String, dynamic> _map = _maps.first['pickers'];

      _pickers = PickerModel.decipherPickers(_map);

    }

    return _pickers;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updatePickers({
    @required List<PickerModel> pickers,
    @required FlyerType flyerType,
  }) async {

    if (Mapper.checkCanLoopList(pickers) == true){
      await LDBOps.insertMap(
        docName: LDBDoc.pickers,
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
    @required FlyerType flyerType,
  }) async {

    await LDBOps.deleteMap(
        docName: LDBDoc.pickers,
        objectID: PickerModel.getPickersIDByFlyerType(flyerType)
    );

  }
  // -----------------------------------------------------------------------------
}
