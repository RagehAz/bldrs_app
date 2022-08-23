import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/cupertino.dart';

class PickerRealOps {
// -----------------------------------------------------------------------------

  const PickerRealOps();

// ---------------------------------------------------------------------------

/// CREATE

// -----------------------------
  static Future<void> createPickers({
    @required BuildContext context,
    @required List<PickerModel> pickers,
    @required String realDocName,
  }) async {

    await Real.createNamedDoc(
        context: context,
        collName: RealColl.pickers,
        docName: realDocName,
        map: PickerModel.cipherPickers(pickers),
    );

  }
// ---------------------------------------------------------------------------

/// READ

// -----------------------------
  static Future<List<PickerModel>> readPickers({
    @required BuildContext context,
    @required String realDocName,
  }) async {
    List<PickerModel> _output = <PickerModel>[];

    if (realDocName != null){

      final Map<String, dynamic> _map = await Real.readDoc(
          context: context,
          collName: RealColl.pickers,
          docName: realDocName,
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
  static Future<void> updatePickers({
    @required BuildContext context,
    @required String realDocName,
    @required List<PickerModel> updatedPickers,
  }) async {

    if (realDocName != null && Mapper.checkCanLoopList(updatedPickers) == true){

      await Real.updateDoc(
        context: context,
        collName: RealColl.pickers,
        docName: realDocName,
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
