import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;

class RenovateAuthorProtocols {
// -----------------------------------------------------------------------------

  RenovateAuthorProtocols();

// -----------------------------------------------------------------------------
  static Future<BzModel> updateAuthorProtocol({
    @required BuildContext context,
    @required BzModel oldBzModel,
    @required AuthorModel newAuthorModel,
  }) async {

    blog('RenovateAuthorProtocols.updateAuthorProtocol : START');

    final BzModel _updatedBzModel = BzModel.replaceAuthor(
      updatedAuthor: newAuthorModel,
      bzModel: oldBzModel,
    );

    final BzModel _uploadedBzModel =  await BzFireOps.updateBz(
      context: context,
      newBzModel: _updatedBzModel,
      oldBzModel: oldBzModel,
      authorPicFile: ObjectChecker.objectIsFile(newAuthorModel.pic) == true ? newAuthorModel.pic : null,
    );

    /// no need to do that as stream listener does it
    // await myActiveBzLocalUpdateProtocol(
    //   context: context,
    //   newBzModel: _uploadedModel,
    //   oldBzModel: _bzModel,
    // );

    blog('RenovateAuthorProtocols.updateAuthorProtocol : END');

    return _uploadedBzModel;
  }
// -----------------------------------------------------------------------------
}
