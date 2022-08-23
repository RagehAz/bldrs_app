import 'package:bldrs/a_models/chain/spec_models/picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/cupertino.dart';

class PickerRealOps {
// -----------------------------------------------------------------------------

  const PickerRealOps();

// ---------------------------------------------------------------------------

  /// PATHS

// -----------------------------
  /// TESTED : WORKS PERFECT
  static  String _getPickerRealDocNameByFlyerType(FlyerType flyerType){
    return FlyerTyper.cipherFlyerType(flyerType);
  }
// ---------------------------------------------------------------------------

/// CREATE

// -----------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createPickers({
    @required BuildContext context,
    @required List<PickerModel> pickers,
    @required FlyerType flyerType,
  }) async {

    await Real.createNamedDoc(
        context: context,
        collName: RealColl.pickers,
        docName: _getPickerRealDocNameByFlyerType(flyerType),
        map: PickerModel.cipherPickers(pickers),
    );

  }
// ---------------------------------------------------------------------------

/// READ

// -----------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PickerModel>> readPickers({
    @required BuildContext context,
    @required FlyerType flyerType,
  }) async {
    List<PickerModel> _output = <PickerModel>[];

    if (flyerType != null){


      final Map<String, dynamic> _map = await Real.readDoc(
        context: context,
        collName: RealColl.pickers,
        docName: _getPickerRealDocNameByFlyerType(flyerType),
        addDocID: false,
      );

      if (_map != null){

        _output = PickerModel.decipherPickers(_map);

      }

    }

    return _output;
  }
// ---------------------------------------------------------------------------

/// UPDATE

// -----------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updatePickers({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required List<PickerModel> updatedPickers,
  }) async {

    if (flyerType != null && Mapper.checkCanLoopList(updatedPickers) == true){

      await Real.updateDoc(
        context: context,
        collName: RealColl.pickers,
        docName: _getPickerRealDocNameByFlyerType(flyerType),
        map: PickerModel.cipherPickers(updatedPickers),
      );

    }


  }
// ---------------------------------------------------------------------------

/// DELETE

// -----------------------------
  /// I GUESS NO NEED
// ---------------------------------------------------------------------------
}
