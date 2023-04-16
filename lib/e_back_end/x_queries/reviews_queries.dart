import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

  /// REVIEWS PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel reviewsPaginationQuery({
  @required String flyerID,
}){

  return FireQueryModel(
    collRef: OfficialFire.getSuperCollRef(
      aCollName: FireColl.flyers,
      bDocName: flyerID,
      cSubCollName: FireSubColl.flyers_flyer_reviews,
    ),
    limit: 5,
    orderBy: const QueryOrderBy(
      fieldName: 'time',
      descending: false,
    ),
  );

}
// -----------------------------------------------------------------------------

/// REVIEWS STREAMING

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel reviewsStreamQuery({
  @required BuildContext context,
  @required String flyerID,
}){

  final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  if (_myUserModel == null){
    return null;
  }
  else {

    //
    // final bool _imAuthorInThisBz = AuthorModel.checkUserIsAuthorInThisBz(
    //     bzID: widget.flyerModel.bzID,
    //     userModel: _myUserModel
    // );
    //
    // if (_imAuthorInThisBz == true){
    //   return null;
    // }
    // else {
    return FireQueryModel(
      collRef: OfficialFire.getSuperCollRef(
        aCollName: FireColl.flyers,
        bDocName: flyerID,
        cSubCollName: FireSubColl.flyers_flyer_reviews,
      ),
      limit: 10,
      orderBy: const QueryOrderBy(
        fieldName: 'time',
        descending: false,
      ),
      finders: <FireFinder>[

        const FireFinder(
          field: 'reply',
          comparison: FireComparison.nullValue,
          value: true,
        ),

        FireFinder(
          field: 'userID',
          comparison: FireComparison.equalTo,
          value: _myUserModel.id,
        ),

      ],
    );
    // }

  }

}
// -----------------------------------------------------------------------------
