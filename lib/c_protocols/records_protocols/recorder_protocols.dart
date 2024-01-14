import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/user_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/records/bz_call_model.dart';
import 'package:bldrs/a_models/g_statistics/records/bz_follow_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_save_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_share_model.dart';
import 'package:bldrs/a_models/g_statistics/records/flyer_view_model.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/a_models/g_statistics/records/user_record_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/records_protocols/records_real_ops/bz_records_real_ops.dart';
import 'package:bldrs/c_protocols/records_protocols/records_real_ops/flyer_records_real_ops.dart';
import 'package:bldrs/c_protocols/records_protocols/records_real_ops/user_records_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class RecorderProtocols {
  // -----------------------------------------------------------------------------

  const RecorderProtocols();

  // -----------------------------------------------------------------------------

  /// SESSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onStartSession() async {

    final String? _userID = Authing.getUserID();

    if (_userID != null && sessionStarted == false){

      final UserRecordModel _record = UserRecordModel.generatorsSessionRecord(
        userID: _userID,
      );

      await Future.wait(<Future>[

        /// CREATE SESSION RECORD
        UserRecordsRealOps.createUserRecord(
          record: _record,
        ),

        /// INCREMENT USER SESSIONS COUNTER
        UserRecordsRealOps.incrementUserCounter(
            userID: _userID,
            increment: 1,
            field: UserCounterModel.field_sessions,
        ),

      ]);

      sessionStarted = true;
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

    final String? _userID = Authing.getUserID();

    if (
        _userID != null &&
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null &&
        index != null
    ){

        final DateTime _now = DateTime.now();

        await Future.wait(<Future>[

          /// CREATE FLYER VIEW RECORD
          FlyerRecordsRealOps.createViewRecord(
              flyerID: flyerID,
              bzID: bzID,
              model: FlyerViewModel(
                  userID: _userID,
                  index: index,
                  time: _now,
              ),
          ),

          /// CREATE USER VIEW RECORD
          UserRecordsRealOps.createUserRecord(
              record: UserRecordModel(
                  id: null,
                  userID: _userID,
                  recordType: RecordType.view,
                  time: _now,
                  modelID: flyerID,
              ),
          ),

          /// INCREMENT USER VIEWS COUNTER
          UserRecordsRealOps.incrementUserCounter(
              userID: _userID,
              increment: 1,
              field: UserCounterModel.field_views,
          ),

          /// INCREMENT FLYER VIEWS COUNTER
          FlyerRecordsRealOps.incrementFlyerCounter(
              bzID: bzID,
              flyerID: flyerID,
              increment: 1,
              field: FlyerCounterModel.field_views,
          ),

          /// INCREMENT BZ ALL VIEWS COUNTER
          BzRecordsRealOps.incrementBzCounter(
              bzID: bzID,
              increment: 1,
              field: BzCounterModel.field_allViews,
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

    final String? _userID = Authing.getUserID();

    if (
        flyerID != null &&
        bzID != null &&
        slideIndex != null &&
        flyerID != DraftFlyer.newDraftID &&
        _userID != null
    ){

      final DateTime _time = DateTime.now();

      await Future.wait(<Future>[

        /// CREATE FLYER SAVE RECORD
        FlyerRecordsRealOps.createSaveRecord(
            model: FlyerSaveModel(
                time: _time,
                index: slideIndex,
                userID: _userID,
            ),
            flyerID: flyerID,
            bzID: bzID,
        ),

        /// CREATE USER SAVE RECORD
        UserRecordsRealOps.createUserRecord(
            record: UserRecordModel(
              id: 'x',
              time: _time,
              userID: _userID,
              modelID: flyerID,
              recordType: RecordType.save,
            ),
        ),

        /// INCREMENT USER SAVES COUNTER
        UserRecordsRealOps.incrementUserCounter(
            userID: _userID,
            increment: 1,
            field: UserCounterModel.field_saves,
        ),

        /// INCREMENT FLYER SAVES COUNTER
        FlyerRecordsRealOps.incrementFlyerCounter(
            bzID: bzID,
            flyerID: flyerID,
            increment: 1,
            field: FlyerCounterModel.field_saves,
        ),

        /// INCREMENT BZ ALL SAVES COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: 1,
            field: BzCounterModel.field_allSaves,
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

    final String? _userID = Authing.getUserID();

    if (
        flyerID != null &&
        bzID != null &&
        slideIndex != null &&
        flyerID != DraftFlyer.newDraftID &&
        _userID != null
    ) {

      final DateTime _time = DateTime.now();

      await Future.wait(<Future>[

        /// DELETE FLYER SAVE RECORD
        FlyerRecordsRealOps.deleteSaveRecord(
            flyerID: flyerID,
            bzID: bzID,
            userID: _userID
        ),

        /// CREATE USER UN-SAVE RECORD
        UserRecordsRealOps.createUserRecord(
            record: UserRecordModel(
              id: 'x',
              time: _time,
              userID: _userID,
              modelID: flyerID,
              recordType: RecordType.unSave,
            ),
        ),

        /// DECREMENT USER SAVES COUNTER
        // => will not decrement,, i want to keep track of all saves

        /// DECREMENT FLYER SAVES COUNTER
        FlyerRecordsRealOps.incrementFlyerCounter(
            bzID: bzID,
            flyerID: flyerID,
            increment: -1,
            field: FlyerCounterModel.field_saves,
        ),

        /// DECREMENT BZ ALL SAVES COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: -1,
            field: BzCounterModel.field_allSaves,
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

    final String? _userID = Authing.getUserID();

    if (
        _userID != null &&
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null
    ){

      final DateTime _time = DateTime.now();

      await Future.wait(<Future>[

        /// CREATE USER REVIEW RECORD
        UserRecordsRealOps.createUserRecord(
            record: UserRecordModel(
              id: 'x',
              time: _time,
              userID: _userID,
              modelID: flyerID,
              recordType: RecordType.review,
            ),
        ),

        /// INCREMENT USER REVIEWS COUNTER
        UserRecordsRealOps.incrementUserCounter(
            userID: _userID,
            increment: 1,
            field: UserCounterModel.field_reviews,
        ),

        /// INCREMENT FLYER REVIEWS COUNTER
        FlyerRecordsRealOps.incrementFlyerCounter(
            bzID: bzID,
            flyerID: flyerID,
            increment: 1,
            field: FlyerCounterModel.field_reviews,
        ),

        /// INCREMENT BZ ALL REVIEWS COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: 1,
            field: BzCounterModel.field_allReviews,
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

    final String? _userID = Authing.getUserID();

    if (
        _userID != null &&
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null
    ){

      await Future.wait(<Future>[

        /// CREATE USER REVIEW RECORD
        // => will not create,, no need

        /// DECREMENT USER REVIEWS COUNTER
        // => will not decrement,, i want to keep track of all reviews

        /// DECREMENT FLYER REVIEWS COUNTER
        FlyerRecordsRealOps.incrementFlyerCounter(
            bzID: bzID,
            flyerID: flyerID,
            increment: -1,
            field: FlyerCounterModel.field_reviews,
        ),

        /// DECREMENT BZ ALL REVIEWS COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: -1,
            field: BzCounterModel.field_allReviews,
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
    required int? slideIndex,
    required String? bzID,
  }) async {

    final String? _userID = Authing.getUserID();

    if (
        flyerID != null &&
        flyerID != DraftFlyer.newDraftID &&
        bzID != null &&
        slideIndex != null &&
        _userID != null
    ){

      final DateTime _time = DateTime.now();

      await Future.wait(<Future>[

        /// CREATE FLYER SHARE RECORD
        FlyerRecordsRealOps.createShareRecord(
            flyerID: flyerID,
            bzID: bzID,
            model: FlyerShareModel(
              id: 'x',
              userID: _userID,
              time: _time,
              index: slideIndex,
            ),
        ),

        /// CREATE USER SHARE RECORD
        UserRecordsRealOps.createUserRecord(
            record: UserRecordModel(
              id: 'x',
              time: _time,
              userID: _userID,
              modelID: flyerID,
              recordType: RecordType.share,
            ),
        ),

        /// INCREMENT USER SHARES COUNTER
        UserRecordsRealOps.incrementUserCounter(
            userID: _userID,
            increment: 1,
            field: UserCounterModel.field_shares,
        ),

        /// INCREMENT FLYER SHARES COUNTER
        FlyerRecordsRealOps.incrementFlyerCounter(
            bzID: bzID,
            flyerID: flyerID,
            increment: 1,
            field: FlyerCounterModel.field_shares,
        ),

        /// INCREMENT BZ ALL SHARES COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: 1,
            field: BzCounterModel.field_allShares,
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

    final String? _userID = Authing.getUserID();

    if (bzID != null && _userID != null) {

      final DateTime _time = DateTime.now();

      await Future.wait(<Future>[

        /// CREATE BZ FOLLOW RECORD
        BzRecordsRealOps.createFollowRecord(
            bzID: bzID,
            bzFollowModel: BzFollowModel(
                userID: _userID,
                time: _time,
            ),
        ),

        /// CREATE USER FOLLOW RECORD
        UserRecordsRealOps.createUserRecord(
            record: UserRecordModel(
              id: 'x',
              time: _time,
              userID: _userID,
              modelID: bzID,
              recordType: RecordType.follow,
            ),
        ),

        /// INCREMENT USER FOLLOWS COUNTER
        UserRecordsRealOps.incrementUserCounter(
            userID: _userID,
            increment: 1,
            field: UserCounterModel.field_follows,
        ),

        /// INCREMENT BZ FOLLOWS COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: 1,
            field: BzCounterModel.field_follows,
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUnfollowBz({
    required String? bzID,
  }) async {

    final String? _userID = Authing.getUserID();

    if (bzID != null && _userID != null) {

      final DateTime _time = DateTime.now();

      await Future.wait(<Future>[

        /// CREATE BZ UNFOLLOW RECORD
        BzRecordsRealOps.deleteFollow(
            userID: _userID,
            bzID: bzID
        ),

        /// CREATE USER UNFOLLOW RECORD
        UserRecordsRealOps.createUserRecord(
            record: UserRecordModel(
                id: 'x',
                userID: _userID,
                recordType: RecordType.unfollow,
                time: _time,
                modelID: bzID,
            ),
        ),

        /// DECREMENT USER FOLLOWS COUNTER
        // => will not decrement,, i want to keep track of all follows

        /// DECREMENT FOLLOWS COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: -1,
            field: BzCounterModel.field_follows,
        ),

      ]);

    }
  }
  // -----------------------------------------------------------------------------

  /// CALLS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onCallBz({
    required String? bzID,
    required String? authorID,
    required ContactModel? contact,
  }) async {

    final String? _userID = Authing.getUserID();

    if (_userID != null && bzID != null && contact != null) {

      final DateTime _time = DateTime.now();

      await Future.wait(<Future>[

        /// CREATE BZ CALL RECORD
        BzRecordsRealOps.createCallRecord(
            model: BzCallModel(
                id: 'x',
                userID: _userID,
                authorID: authorID,
                time: _time,
                contact: contact.value,
            ),
            bzID: bzID,
        ),

        /// CREATE USER CALL RECORD
        UserRecordsRealOps.createUserRecord(
            record: UserRecordModel(
                id: 'x',
                userID: _userID,
                recordType: RecordType.call,
                time: _time,
                modelID: bzID,
            ),
        ),

        /// INCREMENT USER CALLS COUNTER
        UserRecordsRealOps.incrementUserCounter(
            userID: _userID,
            increment: 1,
            field: UserCounterModel.field_calls,
        ),

        /// INCREMENT BZ CALLS COUNTER
        BzRecordsRealOps.incrementBzCounter(
            bzID: bzID,
            increment: 1,
            field: BzCounterModel.field_calls,
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

      await BzRecordsRealOps.incrementBzCounter(
          bzID: bzID,
          field: BzCounterModel.field_allSlides,
          increment: numberOfSlides,
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

        final int _factor = newNumberOfSlides > oldNumberOfSlides ? 1 : -1;

        await BzRecordsRealOps.incrementBzCounter(
          bzID: bzID,
          field: BzCounterModel.field_allSlides,
          increment: _allSlides * _factor,
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

      await Future.wait(<Future>[

        /// DELETE FLYER RECORDS & COUNTER
        FlyerRecordsRealOps.deleteAllFlyerRecords(
          bzID: bzID,
          flyerID: flyerID,
        ),

        /// DECREMENT BZ ALL SLIDES COUNTER
        BzRecordsRealOps.decrementsOnFlyerDeletion(
          bzID: bzID,
          numberOfSlides: numberOfSlides,
          flyerID: flyerID,
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
        BzRecordsRealOps.deleteAllBzRecords(bzID: bzID),

        /// DELETE BZ FLYERS RECORDS & COUNTER
        FlyerRecordsRealOps.deleteAllBzFlyersRecords(
          bzID: bzID,
        ),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// READ USER COUNTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserCounterModel?> fetchUserCounter({
    required String? userID,
    required bool forceRefetch,
  }) async {
    UserCounterModel? _output;

    if (userID != null){
      Map<String, dynamic>? _map;

      if (forceRefetch == false){

        _map = await LDBOps.readMap(
          docName: LDBDoc.usersCounters,
          primaryKey: LDBDoc.getPrimaryKey(LDBDoc.usersCounters),
          id: userID,
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
          path: RealPath.records_users_userID_counter(userID: userID),
        );

        if (_map != null){

          final Map<String, dynamic> _insertThis = Mapper.insertMapInMap(
            baseMap: _map,
            insert: {
              'timeStamp': Timers.cipherTime(time: DateTime.now(), toJSON: true),
              'userID': userID,
            },
          );

          await LDBOps.insertMap(
            docName: LDBDoc.usersCounters,
            primaryKey: LDBDoc.getPrimaryKey(LDBDoc.usersCounters),
            input: _insertThis,
            // allowDuplicateIDs: false,
          );

        }

      }

      _output = UserCounterModel.decipherUserCounter(
        map: _map,
        userID: userID,
      );
    }

    return _output;
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
          path: RealPath.records_flyers_bzID_flyerID_counter(
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

      _flyerCounters = FlyerCounterModel.decipherCounterMap(
        map: _map,
        flyerID: flyerID,
      );

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
          path: RealPath.records_bzz_bzID_counter(
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

      _bzCounters = BzCounterModel.decipherCounterMap(
        map: _map,
        bzID: bzID,
      );

    }

    return _bzCounters;
  }
  // -----------------------------------------------------------------------------
}
