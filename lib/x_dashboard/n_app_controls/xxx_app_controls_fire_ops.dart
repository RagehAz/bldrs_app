import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/x_dashboard/n_app_controls/xx_app_controls_model.dart';
import 'package:flutter/cupertino.dart';

class AppControlsFireOps{
  // -----------------------------------------------------------------------------

  const AppControlsFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  static Future<AppControlsModel> readAppControls() async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      collName: FireColl.admin,
      docName: FireDoc.admin_appControls,
    );

    final AppControlsModel _model = AppControlsModel.decipherAppControlsModel(_map);

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  static Future<void> updateAppControls({
    @required AppControlsModel newAppControlsModel,
  }) async {

    await Fire.updateDoc(
      collName: FireColl.admin,
      docName: FireDoc.admin_appControls,
      input: newAppControlsModel.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
}
