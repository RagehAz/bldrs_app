import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/a_models/x_secondary/feedback_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/feedback_protocols/real/app_feedback_real_ops.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:layouts/layouts.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class FlyerFireOps {
  // -----------------------------------------------------------------------------

  const FlyerFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> createEmptyFlyerDocToGetFlyerID({
    @required String bzID,
  }) async {

    blog('createFlyerDoc : START');

    final String _flyerID = await Fire.createDoc(
      coll: FireColl.flyers,
      input: {
        /// temp id will be overridden
        'id': 'x',
        ///  Super important : to allow user through security rules to continue compose flyer ops and renovate it
        'bzID': bzID,
      },
    );

    blog('createFlyerDoc : END');

    return _flyerID;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> readFlyer({
    @required String flyerID,
  }) async {

    final dynamic _flyerMap = await Fire.readDoc(
        coll: FireColl.flyers,
        doc: flyerID
    );

    final FlyerModel _flyer = FlyerModel.decipherFlyer(
        map: _flyerMap,
        fromJSON: false
    );

    return _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> readBzFlyers({
    @required BzModel bzModel
  }) async {
    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(bzModel?.flyersIDs)) {
      for (final String id in bzModel.flyersIDs) {
        final FlyerModel _flyer = await readFlyer(
          flyerID: id,
        );

        if (_flyer != null) {
          _flyers.add(_flyer);
        }
      }
    }

    return _flyers;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> readBzzFlyers({
    @required List<BzModel> bzzModels,
  }) async {
    final List<FlyerModel> _allFlyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(bzzModels)) {

      for (final BzModel bz in bzzModels) {
        final List<FlyerModel> _bzFlyers = await FlyerFireOps.readBzFlyers(
          bzModel: bz,
        );

        if (Mapper.checkCanLoopList(_bzFlyers)) {
          _allFlyers.addAll(_bzFlyers);
        }
      }
    }

    return _allFlyers;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> readFlyersByQuery({
    @required FireQueryModel queryModel,
    FlyerModel startAfterFlyer,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readColl(
      queryModel: queryModel,
      startAfter: startAfterFlyer?.docSnapshot,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    return FlyerModel.decipherFlyers(
        maps: _maps,
        fromJSON: false,
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyerDoc(FlyerModel finalFlyer) async {

    blog('_updateFlyerDoc : START');

    await Fire.updateDoc(
      coll: FireColl.flyers,
      doc: finalFlyer.id,
      input: finalFlyer.toMap(toJSON: false),
    );

    blog('_updateFlyerDoc : END');

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyerDoc({
    @required String flyerID,
  }) async {

    blog('_deleteFlyerDoc : START');

    if (flyerID != null){
      await Fire.deleteDoc(
        coll: FireColl.flyers,
        doc: flyerID,
      );
    }

    blog('_deleteFlyerDoc : END');

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<BzModel> deleteMultipleBzFlyers({
    @required BuildContext context,
    @required List<FlyerModel> flyersToDelete,
    @required BzModel bzModel,
    @required bool updateBzFireOps,
  }) async {

    blog('deleteMultipleBzFlyers : start');

    /// NOTE : just in case, this filters flyers IDs and only delete those already in the bzModel.flyersIDs
    BzModel _bzModel = bzModel.copyWith();

    if (Mapper.checkCanLoopList(flyersToDelete) == true && bzModel != null){

      List<AuthorModel> _bzAuthors = <AuthorModel>[..._bzModel.authors];
      List<String> _bzFlyersIDs = <String>[..._bzModel.flyersIDs];

      await Future.wait(<Future>[

        ...List.generate(flyersToDelete.length, (index) async {

          final FlyerModel flyerModel = flyersToDelete[index];

          blog('deleteMultipleBzFlyers : deleting flyer : ${flyerModel.id}');

          final bool _canDelete = Stringer.checkStringsContainString(
            strings: bzModel.flyersIDs,
            string: flyerModel.id,
          );

          blog('deleteMultipleBzFlyers : deleting flyer : ${flyerModel.id} : can delete : $_canDelete');

          if (_canDelete == true){

            await Future.wait(<Future>[

            /// DELETE FLYER STORAGE IMAGES
              _deleteFlyerStorageImagesAndPDF(
                flyerModel: flyerModel,
              ),

            /// I - delete firestore/flyers/flyerID
              deleteFlyerDoc(
                flyerID: flyerModel.id,
              )

            ]);

            _bzFlyersIDs = Stringer.removeStringsFromStrings(
              removeFrom: _bzFlyersIDs,
              removeThis: <String>[flyerModel.id],
            );

            _bzAuthors = AuthorModel.removeFlyerIDFromAuthors(
              authors: _bzAuthors,
              flyerID: flyerModel.id,
            );

          }


        }),

      ]);

      _bzModel = bzModel.copyWith(
        authors: _bzAuthors,
        flyersIDs: _bzFlyersIDs,
      );

      if (updateBzFireOps == true){
        _bzModel = await BzFireOps.updateBz(
          context: context,
          newBzModel: _bzModel,
          oldBzModel: bzModel,
          authorPicFile: null,
        );
      }

    }

    blog('deleteMultipleBzFlyers : end : updateBzFireOps : $updateBzFireOps');

    return _bzModel;
  }
   */
  // -----------------------------------------------------------------------------

  /// FLYER PROMOTIONS

  // --------------------
  ///
  static Future<void> promoteFlyerInCity({
    @required FlyerPromotion flyerPromotion,
  }) async {

    final Error _error = ArgumentError('promoteFlyerInCity : COULD NOT PROMOTE FLYER [${flyerPromotion?.flyerID ?? '-'} IN CITY [${flyerPromotion?.cityID ?? '-'}]');

    if (flyerPromotion != null){

      await tryAndCatch(
          invoker: 'promoteFlyerInCity',
          functions: () async {

            await Fire.createDoc(
              coll: FireColl.flyersPromotions,
              doc: flyerPromotion.flyerID,
              input: flyerPromotion.toMap(
                toJSON: true,
              ),);

            },
          onError: (String error){
            throw _error;
          });
    }

    else {
      throw _error;
    }

  }
  // --------------------
  /*
// Future<void> demoteFlyerInCity({
//   @required BuildContext context,
//   @required CityModel cityModel,
//   @required String flyerID,
// }) async {
//
//   if (cityModel != null && flyerID != null){
//
//     cityModel.promotedFlyersIDs.remove(flyerID);
//
//     await Fire.updateSubDocField(
//       context: context,
//       collName: FireColl.zones,
//       docName: FireDoc.zones_cities,
//       subCollName: FireSubColl.zones_cities_cities,
//       subDocName: cityModel.cityID,
//       field: 'promotedFlyersIDs',
//       input: cityModel.promotedFlyersIDs,
//     );
//
//   }
//
// }
 */
  // --------------------
  ///
  static Future<void> onReportFlyer({
    @required BuildContext context,
    @required FlyerModel flyer,
  }) async {

    String _feedback;

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: 3,
        titleVerse: const Verse(
          id: 'phid_report_flyer',
          translate: true,
        ),
        builder: (_){

          return <Widget>[

            /// INAPPROPRIATE CONTENT
            BottomDialog.wideButton(
                context: context,
                verse: const Verse(
                  id: 'phid_flyer_has_inapp_content',
                  translate: true,
                  pseudo: 'Inappropriate content',
                ),
                onTap: () async {
                  _feedback = 'Inappropriate content';
                  await Nav.goBack(
                      context: context,
                      invoker: 'onReportFlyer.Inappropriate'
                  );
                }
            ),

            /// CONTENT IS NOT RELEVANT TO BLDRS
            BottomDialog.wideButton(
                context: context,
                verse: const Verse(
                  pseudo: 'Flyer content is not relevant to Bldrs.net',
                  id: 'phid_flyer_has_irrelevant_content',
                  translate: true,
                ),
                onTap: () async {
                  _feedback = 'Flyer content is not relevant to Bldrs.net';
                  await Nav.goBack(
                      context: context,
                      invoker: 'onReportFlyer.not relevant'
                  );
                }
            ),

            /// COPY RIGHTS
            BottomDialog.wideButton(
                context: context,
                verse: const Verse(
                  pseudo: 'content violates copyrights',
                  id: 'phid_flyer_has_copyright_violation',
                  translate: true,
                ),
                onTap: () async {
                  _feedback = 'content violates copyrights';
                  await Nav.goBack(
                      context: context,
                      invoker: 'onReportFlyer.copyrights'
                  );
                }
            ),

          ];

        }
    );

    if (_feedback != null){

      final FeedbackModel _model =  FeedbackModel(
        userID: Authing.getUserID(),
        timeStamp: DateTime.now(),
        feedback: _feedback,
        modelType: ModelType.flyer,
        modelID: flyer.id,
      );

      final FeedbackModel _docRef = await FeedbackRealOps.createFeedback(
        feedback: _model,
      );

      if (_docRef == null){
        await Dialogs.tryAgainDialog(context);
      }

      else {
        await Dialogs.weWillLookIntoItNotice(context);
      }

    }


  }
  // -----------------------------------------------------------------------------
}
