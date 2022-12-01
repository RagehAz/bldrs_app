import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/x_dashboard/app_controls/xx_app_controls_model.dart';
import 'package:flutter/cupertino.dart';

class AppControlsRealOps{
  // -----------------------------------------------------------------------------

  const AppControlsRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<AppControlsModel> readAppControls() async {

    final Map<String, dynamic> _map = await Real.readDoc(
      collName: RealColl.app,
      docName: RealDoc.app_appControls,
    );

    final AppControlsModel _model = AppControlsModel.decipherAppControlsModel(_map);

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> updateAppControls({
    @required AppControlsModel newAppControlsModel,
  }) async {

    await Real.updateDoc(
      collName: RealColl.app,
      docName: RealDoc.app_appControls,
      map: newAppControlsModel.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------

  // -----------------------------------------------------------------------------
}
