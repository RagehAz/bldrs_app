import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_model.dart';
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
  static Future<AppControlsModel> readAppControls(BuildContext context) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
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
    @required BuildContext context,
    @required AppControlsModel newAppControlsModel,
  }) async {

    await Fire.updateDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_appControls,
      input: newAppControlsModel.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
}
