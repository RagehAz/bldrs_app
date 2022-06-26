
import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthorProtocol {

  AuthorProtocol();

// -----------------------------------------------------------------------------

/// CREATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> addMeAsNewAuthorToABzProtocol({
    @required BuildContext context,
    @required BzModel oldBzModel,
  }) async {

    /// GET AND MODIFY MY USER MODEL --------------------------
    // NOTE : modify user before bz to allow the user modify the bz in fire security rules
    final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );
    final UserModel _newUserModel = UserModel.addBzIDToUserModel(
      userModel: _oldUserModel,
      bzIDToAdd: oldBzModel.id,
    );

    /// UPDATE MY USER MODEL EVERY WHERE --------------------------
    final UserModel _uploadedUser = await UserProtocol.updateMyUserEverywhereProtocol(
        context: context,
        newUserModel: _newUserModel,
    );

    /// MODIFY BZ MODEL --------------------------
    final BzModel _newBzModel = BzModel.addNewUserAsAuthor(
      oldBzModel: oldBzModel,
      userModel: _uploadedUser,
    );

    /// ADD BZ MODEL TO MY BZZ --------------------------
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.addBzToMyBzz(
      bzModel: _newBzModel,
      notify: false, // uploaded model will update it and notify listeners
    );

    /// UPDATE BZ EVERYWHERE PROTOCOL --------------------------
    final BzModel _uploadedBzModel = await BzProtocol.updateMyBzEverywhereProtocol(
        context: context,
        newBzModel: _newBzModel,
        oldBzModel: oldBzModel
    );

    return _uploadedBzModel;
  }
// -----------------------------------------------------------------------------

/// UPDATE

// ----------------------------------
  static Future<BzModel> updateAuthorProtocol({
    @required BuildContext context,
    @required BzModel oldBzModel,
    @required AuthorModel newAuthorModel,
  }) async {

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

    return _uploadedBzModel;
  }
// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------
  static Future<void> removeMeFromBzProtocol({
    @required BuildContext context,
    @required BzModel streamedBzModel,
  }) async {

    // description
    // when the streamedBzModel does not include my ID
    // should update this bz in LDB
    // remove this bz from my bzz ids
    // update my model everywhere

    /// REMOVE ME FROM PRO MY BZZ
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.removeBzFromMyBzz(
      bzID: streamedBzModel.id,
      notify: true,
    );
    /// UPDATE BZ IN LDB
    await BzLDBOps.updateBzOps(
      bzModel: streamedBzModel,
    );

    /// MODIFY MY USER MODEL
    final UserModel _myOldUserModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );
    final UserModel _newUserModel = UserModel.removeBzIDFromMyBzzIDs(
        bzIDToRemove: streamedBzModel.id,
        userModel: _myOldUserModel
    );

    /// UPDATE MY USER MODEL EVERYWHERE
    await UserProtocol.updateMyUserEverywhereProtocol(
        context: context,
        newUserModel: _newUserModel,
    );

    /// 10 - REMOVE ALL NOTES FROM ALL-MY-BZZ-NOTES AND OBELISK NOTES NUMBERS
    NotesProvider.proAuthorResignationNotesRemovalOps(
      context: context,
      bzIDResigned: streamedBzModel.id,
    );

  }
// ----------------------------------
  static Future<void> removeFlyerlessAuthorProtocol({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel author,
  }) async {

    /// REMOVE AUTHOR MODEL FROM BZ MODEL
    final BzModel _updatedBzModel = BzModel.removeAuthor(
      bzModel: bzModel,
      authorID: author.userID,
    );

    /// UPDATE BZ ON FIREBASE
    await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: bzModel,
        authorPicFile: null
    );

    /// NOTE : no need to update bz locally here as bz stream listener does the job

  }
// -----------------------------------------------------------------------------

}