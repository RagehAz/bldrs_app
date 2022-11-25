import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/cupertino.dart';

class PickerRealOps {
  // -----------------------------------------------------------------------------

  const PickerRealOps();

  // -----------------------------------------------------------------------------

  /// PATHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static  String _getPickerRealDocNameByFlyerType(FlyerType flyerType){
    return FlyerTyper.cipherFlyerType(flyerType);
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createPickers({
    @required List<PickerModel> pickers,
    @required FlyerType flyerType,
  }) async {

    await Real.createNamedDoc(
      collName: RealColl.pickers,
      docName: _getPickerRealDocNameByFlyerType(flyerType),
      map: PickerModel.cipherPickers(pickers),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PickerModel>> readPickers({
    @required FlyerType flyerType,
  }) async {
    List<PickerModel> _output = <PickerModel>[];

    if (flyerType != null){


      final Map<String, dynamic> _map = await Real.readDoc(
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
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updatePickers({
    @required FlyerType flyerType,
    @required List<PickerModel> updatedPickers,
  }) async {

    if (flyerType != null && Mapper.checkCanLoopList(updatedPickers) == true){

      await Real.updateDoc(
        collName: RealColl.pickers,
        docName: _getPickerRealDocNameByFlyerType(flyerType),
        map: PickerModel.cipherPickers(updatedPickers),
      );

    }


  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// I GUESS NO NEED
  // -----------------------------------------------------------------------------
}
