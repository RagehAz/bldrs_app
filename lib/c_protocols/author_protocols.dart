
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
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
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.removeAllNotesOfThisBzFromAllBzzUnseenReceivedNotes(
      bzID: streamedBzModel.id,
      notify: false,
    );
    _notesProvider.removeAllObeliskNoteNumbersRelatedToBzID(
        bzID: streamedBzModel.id,
        notify: true
    );

  }
// -----------------------------------------------------------------------------

}
