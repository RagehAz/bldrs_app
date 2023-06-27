import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/recorder_protocols/record_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
/// => TAMAM
class RecorderProtocols {
  // -----------------------------------------------------------------------------

  const RecorderProtocols();

  // -----------------------------------------------------------------------------

  /// CALLS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onCallBz({
    required String bzID,
    required ContactModel contact,
  }) async {

    if (bzID != null && contact != null) {

      final RecordModel _record = RecordModel.createCallRecord(
        userID: Authing.getUserID(),
        bzID: bzID,
        contact: contact,
      );

      await Future.wait(<Future>[
        /// CREATE CALL RECORD
        RecordersRealOps.createRecord(
          record: _record,
        ),

        /// INCREMENT CALLS COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID,
          ),
          incrementationMap: {
            'calls': 1,
          },
          isIncrementing: true,
        ),
      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FOLLOWS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onFollowBz({
    required String bzID,
  }) async {

    if (bzID != null) {

      final RecordModel _record = RecordModel.createFollowRecord(
        userID: Authing.getUserID(),
        bzID: bzID,
      );

      await Future.wait(<Future>[

        /// CREATE FOLLOW RECORD
        RecordersRealOps.createRecord(
          record: _record,
        ),

        /// INCREMENT FOLLOWS COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID,
          ),
          incrementationMap: {
            'follows': 1,
          },
          isIncrementing: true,
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUnfollowBz({
    required String bzID,
  }) async {

    if (bzID != null) {

      final RecordModel _record = RecordModel.createUnfollowRecord(
        userID: Authing.getUserID(),
        bzID: bzID,
      );

      await Future.wait(<Future>[
        /// CREATE UNFOLLOW RECORD
        RecordersRealOps.createRecord(
          record: _record,
        ),

        /// DECREMENT FOLLOWS COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID,
          ),
          incrementationMap: {
            'follows': 1,
          },
          isIncrementing: false,
        ),
      ]);

    }
  }
  // -----------------------------------------------------------------------------

  /// SAVES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSaveFlyer({
    required String flyerID,
    required String bzID,
    required int slideIndex,
  }) async {

    if (
        flyerID != null &&
        bzID != null &&
        slideIndex != null &&
        flyerID != DraftFlyer.newDraftID
    ){

      final RecordModel _record = RecordModel.createSaveRecord(
        userID: Authing.getUserID(),
        flyerID: flyerID,
        bzID: bzID,
        slideIndex: slideIndex,
      );

      await Future.wait(<Future>[

        /// CREATE SAVE RECORD
        RecordersRealOps.createRecord(
          record: _record,
        ),

        /// INCREMENT FLYER SAVES COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_flyers_bzID_flyerID_counter(
            bzID: bzID,
            flyerID: flyerID,
          ),
          incrementationMap: {
            'saves': 1,
          },
          isIncrementing: true,
        ),

        /// INCREMENT BZ ALL SAVES COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID,
          ),
          incrementationMap: {
            'allSaves': 1,
          },
          isIncrementing: true,
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUnSaveFlyer({
    required String flyerID,
    required String bzID,
    required int slideIndex,
  }) async {

    if (
        flyerID != null &&
        bzID != null &&
        slideIndex != null &&
        flyerID != DraftFlyer.newDraftID
    ) {

      final RecordModel _record = RecordModel.createUnSaveRecord(
        userID: Authing.getUserID(),
        flyerID: flyerID,
        bzID: bzID,
      );

      await Future.wait(<Future>[

        /// CREATE UN-SAVE RECORD
        RecordersRealOps.createRecord(
          record: _record,
        ),

        /// DECREMENT FLYER SAVES COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_flyers_bzID_flyerID_counter(
            bzID: bzID,
            flyerID: flyerID,
          ),
          incrementationMap: {
            'saves': 1,
          },
          isIncrementing: false,
        ),

        /// DECREMENT BZ ALL SAVES COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID,
          ),
          incrementationMap: {
            'allSaves': 1,
          },
          isIncrementing: false,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// SHARES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onShareFlyer({
    required String flyerID,
    required String bzID,
  }) async {

    if (
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null
    ){

      final RecordModel _record = RecordModel.createShareRecord(
        userID: Authing.getUserID(),
        flyerID: flyerID,
        bzID: bzID,
      );

      await Future.wait(<Future>[

        /// CREATE SHARE RECORD
        RecordersRealOps.createRecord(
          record: _record,
        ),

        /// INCREMENT FLYER SHARES COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_flyers_bzID_flyerID_counter(
            bzID: bzID,
            flyerID: flyerID,
          ),
          incrementationMap: {
            'shares': 1,
          },
          isIncrementing: true,
        ),

        /// INCREMENT BZ ALL SHARES COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(
              bzID: bzID
          ),
          incrementationMap: {
            'allShares': 1,
          },
          isIncrementing: true,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// VIEWS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onViewSlide({
    required String flyerID,
    required String bzID,
    required int index,
  }) async {

    /// WE NEED A WAY TO CHECK IF THIS USER PREVIOUSLY VIEWED THE SLIDE TO CALL THIS OR NOT

    if (
        Authing.userHasID() == true &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null &&
        index != null
    ){

        final RecordModel _record = RecordModel.createViewRecord(
          userID: Authing.getUserID(),
          flyerID: flyerID,
          bzID: bzID,
          slideIndex: index,
        );

        await Future.wait(<Future>[

          /// CREATE VIEW RECORD
          RecordersRealOps.createRecord(
            record: _record,
          ),

          /// INCREMENT FLYER VIEWS COUNTER
          Real.incrementPathFields(
            path: RealPath.recorders_flyers_bzID_flyerID_counter(
              bzID: bzID,
              flyerID: flyerID,
            ),
            incrementationMap: {
              'views': 1,
            },
            isIncrementing: true,
          ),

          /// INCREMENT BZ ALL VIEWS COUNTER
          Real.incrementPathFields(
            path: RealPath.recorders_bzz_bzID_counter(
                bzID: bzID
            ),
            incrementationMap: {
              'allViews': 1,
            },
            isIncrementing: true,
          ),

        ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// SLIDES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onComposeFlyer({
    required String bzID,
    required int numberOfSlides,
  }) async {

    if (
      bzID != null &&
      numberOfSlides != null &&
      numberOfSlides > 0
    ) {

      await Real.incrementPathFields(
        path: RealPath.recorders_bzz_bzID_counter(bzID: bzID),
        incrementationMap: {
          'allSlides': numberOfSlides,
        },
        isIncrementing: true,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRenovateFlyer({
    required String bzID,
    required int oldNumberOfSlides,
    required int newNumberOfSlides,
  }) async {

    if (
        bzID != null &&
        oldNumberOfSlides != null &&
        newNumberOfSlides != null &&
        oldNumberOfSlides != newNumberOfSlides
    ){

      await Real.incrementPathFields(
        path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID
        ),
        incrementationMap: {
          'allSlides': Numeric.modulus((newNumberOfSlides-oldNumberOfSlides).toDouble()).toInt(),
        },
        isIncrementing: newNumberOfSlides > oldNumberOfSlides,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeFlyer({
    required String flyerID,
    required String bzID,
    required int numberOfSlides,
  }) async {

    if (
        bzID != null &&
        numberOfSlides != null &&
        numberOfSlides > 0
    ){

      final FlyerCounterModel _flyerCounterModel = await readFlyerCounters(
        flyerID: flyerID,
        bzID: bzID,
      );

      await Future.wait(<Future>[

        /// DELETE FLYER RECORDS & COUNTER
        Real.deletePath(
          pathWithDocName: RealPath.recorders_flyers_bzID_flyerID(
            bzID: bzID,
            flyerID: flyerID,
          ),
        ),

        /// DECREMENT BZ ALL SLIDES COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(bzID: bzID),
          incrementationMap: {
            'allSlides': numberOfSlides,
            'allReviews': _flyerCounterModel?.reviews ?? 0,
            'allViews': _flyerCounterModel?.views ?? 0,
            'allShares': _flyerCounterModel?.shares ?? 0,
            'allSaves': _flyerCounterModel?.saves ?? 0,
          },
          isIncrementing: false,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// REVIEWS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onComposeReview({
    required String flyerID,
    required String bzID,
  }) async {

    if (
        Authing.userHasID() == true &&
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null
    ){

      await Future.wait(<Future>[

          /// INCREMENT FLYER REVIEWS COUNTER
          Real.incrementPathFields(
            path: RealPath.recorders_flyers_bzID_flyerID_counter(
              bzID: bzID,
              flyerID: flyerID,
            ),
            incrementationMap: {
              'reviews': 1,
            },
            isIncrementing: true,
          ),

          /// INCREMENT BZ ALL REVIEWS COUNTER
          Real.incrementPathFields(
            path: RealPath.recorders_bzz_bzID_counter(
                bzID: bzID
            ),
            incrementationMap: {
              'allReviews': 1,
            },
            isIncrementing: true,
          ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeReview({
    required String flyerID,
    required String bzID,
  }) async {

    if (
        Authing.userHasID() == true &&
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null
    ){

      await Future.wait(<Future>[

        /// DECREMENT FLYER REVIEWS COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_flyers_bzID_flyerID_counter(
            bzID: bzID,
            flyerID: flyerID,
          ),
          incrementationMap: {
            'reviews': 1,
          },
          isIncrementing: false,
        ),

        /// DECREMENT BZ ALL REVIEWS COUNTER
        Real.incrementPathFields(
          path: RealPath.recorders_bzz_bzID_counter(bzID: bzID),
          incrementationMap: {
            'allReviews': 1,
          },
          isIncrementing: false,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE BZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeBz({
    required String bzID,
  }) async {

    if (
    Authing.userHasID() == true &&
    bzID != null
    ){

      await Future.wait(<Future>[

        /// DELETE BZ RECORDS & COUNTER
        Real.deletePath(
          pathWithDocName: RealPath.recorders_bzz_bzID(
            bzID: bzID,
          ),
        ),

        /// DELETE BZ FLYERS RECORDS & COUNTER
        Real.deletePath(
          pathWithDocName: RealPath.recorders_flyers_bzID(
            bzID: bzID,
          ),
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// READ BZ COUNTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerCounterModel> readFlyerCounters({
    required String flyerID,
    required String bzID,
  }) async {
    FlyerCounterModel _flyerCounters;

    if (flyerID != null && bzID != null){

      final Map<String, dynamic> _map = await Real.readPathMap(
        path: RealPath.recorders_flyers_bzID_flyerID_counter(
          bzID: bzID,
          flyerID: flyerID,
        ),
      );

      _flyerCounters = FlyerCounterModel.decipherCounterMap(_map);

    }

    return _flyerCounters;
  }
  // -----------------------------------------------------------------------------

  /// READ FLYER COUNTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzCounterModel> readBzCounters({
    required String bzID,
  }) async {
    BzCounterModel _bzCounters;

    if (bzID != null) {

      final Map<String, dynamic> _map = await Real.readPathMap(
        path: RealPath.recorders_bzz_bzID_counter(
          bzID: bzID,
        ),
      );

      _bzCounters = BzCounterModel.decipherCounterMap(_map);

    }

    return _bzCounters;
  }
  // -----------------------------------------------------------------------------
}
