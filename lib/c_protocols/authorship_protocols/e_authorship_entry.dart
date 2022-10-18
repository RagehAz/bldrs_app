import 'dart:io';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/storage.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/bz_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorshipEntryProtocols {
  // -----------------------------------------------------------------------------

  const AuthorshipEntryProtocols();

  // -----------------------------------------------------------------------------
  ///
  static Future<void> addMeToBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    assert(bzID != null, 'AuthorshipEntryProtocols.addMeToBz : bzID is null');

    blog('AuthorshipEntryProtocols.addMeToBz : START');

    final BzModel _oldBzModel = await BzProtocols.fetch(
      context: context,
      bzID: bzID,
    );

    /// GET AND MODIFY MY USER MODEL --------------------------
    // NOTE : modify user before bz to allow the user modify the bz in fire security rules
    final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );
    final UserModel _newUserModel = UserModel.addBzIDToUserBzz(
      userModel: _oldUserModel,
      bzIDToAdd: _oldBzModel.id,
    );

    /// UPDATE MY USER MODEL EVERY WHERE --------------------------
    final UserModel _uploadedUser = await UserProtocols.renovateMyUserModel(
      context: context,
      newUserModel: _newUserModel,
    );

    /// MODIFY BZ MODEL --------------------------
    final File _file = await Storage.getImageFileByURL(
      context: context,
      url: _uploadedUser.pic,
    );
    final BzModel _bzModelWithAuthorPicFile = BzModel.addNewUserAsAuthor(
      oldBzModel: _oldBzModel,
      userModel: _uploadedUser.copyWith(
        pic: _file,
      ),
    );
    final BzModel _newBzModel = await BzFireOps.updateAuthorPicIfChangedAndReturnNewBzModel(
      context: context,
      bzModel: _bzModelWithAuthorPicFile,
    );

    /// ADD BZ MODEL TO MY BZZ --------------------------
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.addBzToMyBzz(
      bzModel: _newBzModel,
      notify: false, // uploaded model will update it and notify listeners
    );

    /// UPDATE BZ EVERYWHERE PROTOCOL --------------------------
    final BzModel _uploadedBzModel = await BzProtocols.renovateBz(
      context: context,
      newBzModel: _newBzModel,
      oldBzModel: _oldBzModel,
      showWaitDialog: false,
      navigateToBzInfoPageOnEnd: false,
    );

    blog('AuthorshipEntryProtocols.addMeToBz : END');

    return _uploadedBzModel;
  }
// -----------------------------------------------------------------------------
}
