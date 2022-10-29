import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

  /// REVIEWS PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel reviewsPaginationQuery({
  @required String flyerID,
}){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
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
      collRef: Fire.getSuperCollRef(
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
