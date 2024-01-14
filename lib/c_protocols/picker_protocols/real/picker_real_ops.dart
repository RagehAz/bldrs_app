import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';

class PickerRealOps {
  // -----------------------------------------------------------------------------

  const PickerRealOps();

  // -----------------------------------------------------------------------------

  /// PATHS

  // --------------------
  /// TESTED : WORKS PERFECT
  static  String? _getPickerRealDocNameByFlyerType(FlyerType? flyerType){
    return FlyerTyper.cipherFlyerType(flyerType);
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createPickers({
    required List<PickerModel> pickers,
    required FlyerType flyerType,
  }) async {

    await Real.createDoc(
      coll: RealColl.pickers,
      doc: _getPickerRealDocNameByFlyerType(flyerType),
      map: PickerModel.cipherPickers(pickers),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PickerModel>> readPickers({
    required FlyerType? flyerType,
  }) async {
    List<PickerModel> _output = <PickerModel>[];

    final String? _doc = _getPickerRealDocNameByFlyerType(flyerType);

    if (_doc != null){

      final Map<String, dynamic>? _map = await Real.readDoc(
        coll: RealColl.pickers,
        doc: _doc,
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
    required FlyerType? flyerType,
    required List<PickerModel>? updatedPickers,
  }) async {

    final String? _doc = _getPickerRealDocNameByFlyerType(flyerType);

    if (
        _doc != null
        &&
        Lister.checkCanLoop(updatedPickers) == true
    ){

      await Real.updateDoc(
        coll: RealColl.pickers,
        doc: _doc,
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
