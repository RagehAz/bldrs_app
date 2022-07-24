

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class WipeAuthorProtocols {

  WipeAuthorProtocols();

// -----------------------------------------------------------------------------
  /*
  static Future<void> myBzGotDeletedAndIShouldDeleteAllMyBzRelatedData({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('WipeAuthorProtocols.myBzGotDeletedAndIShouldDeleteAllMyBzRelatedData : START');

    /// so I had this bzID in my bzIDs and I still have its old model
    /// scattered around in pro, ldb & fire

    /// DELETE LDB BZ MODEL

    /// DELETE LDB BZ FLYERS

    /// DELETE PRO BZ MODEL

    /// DELETE PRO BZ FLYERS

    /// DELETE MY AUTHOR PIC ON FIRE STORAGE

    /// DELETE BZID FROM MY BZZ IDS THEN UPDATE MY USER MODEL EVERY WHERE PROTOCOL
    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );
    final UserModel _updatedUserModel = UserModel.removeBzIDFromMyBzzIDs(
      userModel: _myUserModel,
      bzIDToRemove: bzID,
    );
    await UserProtocol.updateMyUserEverywhereProtocol(
      context: context,
      newUserModel: _updatedUserModel,
    );

    blog('WipeAuthorProtocols.myBzGotDeletedAndIShouldDeleteAllMyBzRelatedData : END');

  }
   */
// ----------------------------------
  static Future<void> deleteMyAuthorPicProtocol({
    @required BuildContext context,
    @required String bzID,
  }) async {
    blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : START');

    /// GET MY USER MODEL -------------------
    final UserModel _myUserModel = await UsersProvider.proFetchUserModel(
      context: context,
      userID: AuthFireOps.superUserID(),
    );

    /// GET THE BZ MODEL -------------------
    final BzModel _bzModel = await BzLDBOps.readBz(bzID);

    if (_bzModel != null){

      /// GET MY AUTHOR MODEL -------------------
      final AuthorModel _myAuthor = AuthorModel.getAuthorFromAuthorsByID(
        authors: _bzModel.authors,
        authorID: _myUserModel.id,
      );

      /// CHECK IF USER MODEL PIC IS AUTHOR MODEL PIC -------------------
      final bool _authorPicIsHisUserPic = await AuthorModel.checkUserImageIsAuthorImage(
        context: context,
        authorModel: _myAuthor,
        userModel: _myUserModel,
      );

      /// PROCEED IF NOT IDENTICAL -------------------
      if (_authorPicIsHisUserPic == false){
        await BzFireOps.deleteAuthorPic(
          context: context,
          bzID: bzID,
          authorID: _myUserModel.id,
        );
      }

    }

    blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : END');
  }
// -----------------------------------------------------------------------------

}
