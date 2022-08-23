import 'package:bldrs/a_models/chain/spec_models/picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class PickerLDBOps{
// -----------------------------------------------------------------------------

  const PickerLDBOps();

// ---------------------------------------------------------------------------

  /// PATHS

// -----------------------------
  static  String _getPickerLDBDocNameByFlyerType(FlyerType flyerType){
    return FlyerTyper.cipherFlyerType(flyerType);
  }
// ---------------------------------------------------------------------------

/// INSERT

// -----------------------------
  static Future<void> insertPickers({
    @required List<PickerModel> pickers,
    @required FlyerType flyerType,
  }) async {

    if (Mapper.checkCanLoopList(pickers) == true){
      await LDBOps.insertMap(
        docName: _getPickerLDBDocNameByFlyerType(flyerType),
        input: PickerModel.cipherPickers(pickers),
      );
    }

  }
// ---------------------------------------------------------------------------

/// READ

// -----------------------------
  static Future<List<PickerModel>> readPickers({
    @required FlyerType flyerType,
}) async {

    List<PickerModel> _pickers = <PickerModel>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.readAllMaps(
      docName: _getPickerLDBDocNameByFlyerType(flyerType),
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      final Map<String, dynamic> _map = _maps.first;

      _pickers = PickerModel.decipherPickers(_map);

    }

    return _pickers;
  }
// ---------------------------------------------------------------------------

/// UPDATE

// -----------------------------
  static Future<void> updatePickers({
    @required List<PickerModel> pickers,
    @required FlyerType flyerType,
  }) async {

    if (Mapper.checkCanLoopList(pickers) == true){
      await LDBOps.insertMap(
        docName: _getPickerLDBDocNameByFlyerType(flyerType),
        input: PickerModel.cipherPickers(pickers),
      );
    }


  }
// ---------------------------------------------------------------------------

/// DELETE

// -----------------------------
  static Future<void> deletePickers({
    @required FlyerType flyerType,
  }) async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: _getPickerLDBDocNameByFlyerType(flyerType),
    );

  }
// ---------------------------------------------------------------------------
}
