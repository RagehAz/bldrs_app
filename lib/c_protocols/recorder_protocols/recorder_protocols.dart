import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/recorder_protocols/record_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';
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
    required String? bzID,
    required ContactModel? contact,
  }) async {

    if (Authing.getUserID() != null && bzID != null && contact != null) {

      final RecordModel _record = RecordModel.createCallRecord(
        userID: Authing.getUserID()!,
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
    required String? bzID,
  }) async {

    if (bzID != null && Authing.getUserID() != null) {

      final RecordModel _record = RecordModel.createFollowRecord(
        userID: Authing.getUserID()!,
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
    required String? bzID,
  }) async {

    if (bzID != null && Authing.getUserID() != null) {

      final RecordModel _record = RecordModel.createUnfollowRecord(
        userID: Authing.getUserID()!,
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
    required String? flyerID,
    required String? bzID,
    required int? slideIndex,
  }) async {

    if (
        flyerID != null &&
        bzID != null &&
        slideIndex != null &&
        flyerID != DraftFlyer.newDraftID &&
        Authing.getUserID() != null
    ){

      final RecordModel _record = RecordModel.createSaveRecord(
        userID: Authing.getUserID()!,
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
    required String? flyerID,
    required String? bzID,
    required int? slideIndex,
  }) async {

    if (
        flyerID != null &&
        bzID != null &&
        slideIndex != null &&
        flyerID != DraftFlyer.newDraftID &&
        Authing.getUserID() != null
    ) {

      final RecordModel _record = RecordModel.createUnSaveRecord(
        userID: Authing.getUserID()!,
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
    required String? flyerID,
    required String? bzID,
  }) async {

    if (
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null &&
        Authing.getUserID() != null
    ){

      final RecordModel _record = RecordModel.createShareRecord(
        userID: Authing.getUserID()!,
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
    required String? flyerID,
    required String? bzID,
    required int? index,
  }) async {

    /// WE NEED A WAY TO CHECK IF THIS USER PREVIOUSLY VIEWED THE SLIDE TO CALL THIS OR NOT

    if (
        Authing.getUserID() != null &&
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null &&
        index != null
    ){

        final RecordModel _record = RecordModel.createViewRecord(
          userID: Authing.getUserID()!,
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
    required String? bzID,
    required int? numberOfSlides,
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
    required String? bzID,
    required int? oldNumberOfSlides,
    required int? newNumberOfSlides,
  }) async {

    if (
        bzID != null &&
        oldNumberOfSlides != null &&
        newNumberOfSlides != null &&
        oldNumberOfSlides != newNumberOfSlides
    ){

      final int? _allSlides = Numeric.modulus((newNumberOfSlides-oldNumberOfSlides).toDouble())?.toInt();

      if (_allSlides != null){

        await Real.incrementPathFields(
        path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID
        ),
        incrementationMap: {
          'allSlides': _allSlides,
        },
        isIncrementing: newNumberOfSlides > oldNumberOfSlides,
      );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeFlyer({
    required String? flyerID,
    required String? bzID,
    required int? numberOfSlides,
  }) async {

    if (
        bzID != null &&
        flyerID != null &&
        numberOfSlides != null &&
        numberOfSlides > 0
    ){

      final FlyerCounterModel? _flyerCounterModel = await fetchFlyerCounters(
        flyerID: flyerID,
        bzID: bzID,
        forceRefetch: true,
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
    required String? flyerID,
    required String? bzID,
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
    required String? flyerID,
    required String? bzID,
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
    required String? bzID,
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
  static Future<FlyerCounterModel?> fetchFlyerCounters({
    required String? flyerID,
    required String? bzID,
    required bool forceRefetch,
  }) async {
    FlyerCounterModel? _flyerCounters;

    if (flyerID != null && bzID != null){
      Map<String, dynamic>? _map;

      if (forceRefetch == false){

        _map = await LDBOps.readMap(
          docName: LDBDoc.flyersCounters,
          primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyersCounters),
          id: flyerID,
        );

        /// IF FOUND IN LDB
        if (_map != null){
          final DateTime? _time = Timers.decipherTime(time: _map['timeStamp'], fromJSON: true);
          final bool _isOld = Timers.checkTimeDifferenceIsBiggerThan(
            time1: _time,
            time2: DateTime.now(),
            maxDifferenceInMinutes: Standards.countersRefreshTimeDurationInMinutes,
          );

          if (_isOld == true){
            _map = null;
          }

        }

      }

      /// IF SHOULD READ FROM REAL
      if (_map == null){

        /// READ FROM REAL
        _map = await Real.readPathMap(
          path: RealPath.recorders_flyers_bzID_flyerID_counter(
            bzID: bzID,
            flyerID: flyerID,
          ),
        );

        if (_map != null){

          final Map<String, dynamic> _insertThis = Mapper.insertMapInMap(
            baseMap: _map,
            insert: {
              'timeStamp': Timers.cipherTime(time: DateTime.now(), toJSON: true),
              'flyerID': flyerID,
              'bzID': bzID,
            },
          );

          await LDBOps.insertMap(
            docName: LDBDoc.flyersCounters,
            primaryKey: LDBDoc.getPrimaryKey(LDBDoc.flyersCounters),
            input: _insertThis,
            // allowDuplicateIDs: false,
          );

        }

      }

      _flyerCounters = FlyerCounterModel.decipherCounterMap(_map);

    }

    return _flyerCounters;
  }
  // -----------------------------------------------------------------------------

  /// READ FLYER COUNTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzCounterModel?> fetchBzCounters({
    required String? bzID,
    required bool forceRefetch,
  }) async {
    BzCounterModel? _bzCounters;

    if (bzID != null) {
      Map<String, dynamic>? _map;

      if (forceRefetch == false){

        _map = await LDBOps.readMap(
            docName: LDBDoc.bzzCounters,
            primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzzCounters),
            id: bzID,
        );

        /// IF FOUND IN LDB
        if (_map != null){

          final DateTime? _time = Timers.decipherTime(time: _map['timeStamp'], fromJSON: true);
          final bool _isOld = Timers.checkTimeDifferenceIsBiggerThan(
              time1: _time,
              time2: DateTime.now(),
              maxDifferenceInMinutes: Standards.countersRefreshTimeDurationInMinutes,
          );
          if (_isOld == true){
            _map = null;
          }

        }

      }

      /// IF SHOULD READ FROM REAL
      if (_map == null){

        /// READ FROM REAL
        _map = await Real.readPathMap(
          path: RealPath.recorders_bzz_bzID_counter(
            bzID: bzID,
          ),
        );

        if (_map != null){

          final Map<String, dynamic> _insertThis = Mapper.insertMapInMap(
              baseMap: _map,
              insert: {
                'timeStamp': Timers.cipherTime(time: DateTime.now(), toJSON: true),
                'bzID': bzID,
              },
          );

          await LDBOps.insertMap(
            docName: LDBDoc.bzzCounters,
            primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bzzCounters),
            input: _insertThis,
            // allowDuplicateIDs: false,
          );

        }

      }

      _bzCounters = BzCounterModel.decipherCounterMap(_map);

    }

    return _bzCounters;
  }
  // -----------------------------------------------------------------------------
}
