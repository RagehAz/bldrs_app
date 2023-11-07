import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/a_models/x_secondary/feedback_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/feedback_protocols/real/app_feedback_real_ops.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class FlyerFireOps {
  // -----------------------------------------------------------------------------

  const FlyerFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> createEmptyFlyerDocToGetFlyerID({
    required String? bzID,
  }) async {

    blog('createFlyerDoc : START');

    final String? _flyerID = await Fire.createDoc(
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
  static Future<FlyerModel?> readFlyer({
    required String? flyerID,
  }) async {
    FlyerModel? _flyer;

    if (flyerID != null) {

      final dynamic _flyerMap = await Fire.readDoc(
          coll: FireColl.flyers,
          doc: flyerID
      );

      _flyer = FlyerModel.decipherFlyer(map: _flyerMap, fromJSON: false);
    }

    return _flyer;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> readBzFlyers({
    required BzModel? bzModel,
    required PublishState? publishState,
  }) async {
    final List<FlyerModel> _flyers = <FlyerModel>[];

    final List<String>? _allIDs = bzModel?.publication.getAllFlyersIDs();

    if (Mapper.checkCanLoopList(_allIDs) == true) {

      final List<String> _flyersIDs =
      publishState == null ?
      _allIDs!
          :
      PublicationModel.getFlyersIDsByState(
        pub: bzModel!.publication,
        state: publishState,
      );

      for (final String id in _flyersIDs) {
        final FlyerModel? _flyer = await readFlyer(
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
    required List<BzModel>? bzzModels,
    required PublishState publishState,
  }) async {
    final List<FlyerModel> _allFlyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(bzzModels) == true) {

      for (final BzModel bz in bzzModels!) {

        final List<FlyerModel> _bzFlyers = await FlyerFireOps.readBzFlyers(
          publishState: publishState,
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
  static Future<List<FlyerModel>?> readFlyersByQuery({
    required FireQueryModel queryModel,
    FlyerModel? startAfterFlyer,
  }) async {

    final List<Map<String, dynamic>>? _maps = await Fire.readColl(
      queryModel: queryModel,
      startAfter: startAfterFlyer?.docSnapshot,
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
  static Future<void> updateFlyerDoc(FlyerModel? finalFlyer) async {

    blog('_updateFlyerDoc : START');

    if (finalFlyer?.id != null){

      await Fire.updateDoc(
        coll: FireColl.flyers,
        doc: finalFlyer!.id!,
        input: finalFlyer.toMap(toJSON: false),
      );

    }

    blog('_updateFlyerDoc : END');

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFlyerDoc({
    required String? flyerID,
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
  /// TESTED : WORKS PERFECT
  static Future<void> onReportFlyer({
    required BuildContext context,
    required FlyerModel? flyer,
  }) async {

    String? _feedback;

    await BottomDialog.showButtonsBottomDialog(
        numberOfWidgets: 3,
        titleVerse: const Verse(
          id: 'phid_report_flyer',
          translate: true,
        ),
        builder: (_, __){

          return <Widget>[

            /// INAPPROPRIATE CONTENT
            BottomDialog.wideButton(
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
        modelID: flyer?.id,
      );

      final FeedbackModel? _docRef = await FeedbackRealOps.createFeedback(
        feedback: _model,
      );

      if (_docRef == null){
        await Dialogs.tryAgainDialog();
      }

      else {
        await Dialogs.weWillLookIntoItNotice();
      }

    }


  }
  // -----------------------------------------------------------------------------
}
