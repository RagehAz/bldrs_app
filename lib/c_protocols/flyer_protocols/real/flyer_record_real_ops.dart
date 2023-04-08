import 'package:authing/authing.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/record_protocols/real/record_real_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:filers/filers.dart';
import 'package:firebase_database/firebase_database.dart' as fireDB;
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:real/real.dart';

class FlyerRecordRealOps {
  // -----------------------------------------------------------------------------

  const FlyerRecordRealOps();

  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// SHARES CREATION
  // -------
  /// TESTED : WORKS PERFECT
  static Future<void> shareFlyer({
    @required String flyerID,
    @required String bzID,
  }) async {
    blog('FlyerRecordOps.shareFlyer : START');

    if (Authing.userIsSignedIn() == true && flyerID != DraftFlyer.newDraftID){

      final RecordModel _record = RecordModel.createShareRecord(
        userID: Authing.getUserID(),
        flyerID: flyerID,
      );

      await Future.wait(<Future>[

        RecordRealOps.createRecord(
          record: _record,
        ),

        incrementFlyerCounter(
          flyerID: flyerID,
          field: 'shares',
          increaseOne: true,
        ),

        BzRecordRealOps.incrementBzCounter(
          bzID: bzID,
          field: 'allShares',
          increaseOne: true,
        ),

      ]);

    }


    blog('FlyerRecordOps.shareFlyer : END');
  }
  // --------------------
  /// VIEWS CREATION
  // -------
  /// TESTED : WORKS PERFECT
  static Future<void> viewFlyer({
    @required FlyerModel flyerModel,
    @required int index,
  }) async {
    // blog('FlyerRecordOps.viewFlyer : START');

    /// TASK : CAUTION : THIS METHOD WILL DUPLICATE RECORDS IN REAL DB IF LDB VIEWS DOX IS WIPED OUT
    /// WE WEEN A MORE SOLID WAY TO CHECK IF THIS USER PREVIOUSLY VIEWED THE SLIDE TO CALL THIS
    /// OR,, CHANGE THE NODE ID IN
    if (
        Authing.userIsSignedIn() == true &&
        flyerModel?.id != DraftFlyer.newDraftID &&
        flyerModel != null &&
        index != null
    ){

      final int _numberOfSlides = flyerModel?.slides?.length ?? 0;

      if (index < _numberOfSlides){

        // final List<Map<String, dynamic>> _maps = await LDBOps.searchAllMaps(
        //   fieldToSortBy: 'recordDetails',
        //   searchField: 'modelID',
        //   fieldIsList: false,
        //   searchValue: flyerModel.id,
        //   docName: LDBDoc.views,
        // );
        // bool _slideSeenAlready = false;
        //
        // blog('_maps are fuck : ${_maps.length} maps');
        //
        // /// IF RECORD IS FOUND IN LDB
        // if (Mapper.checkCanLoopList(_maps) == true){
        //
        //   const String key = 'recordDetails';
        //   final int searchValue = index;
        //
        //   for (final Map<String, dynamic> map in _maps){
        //
        //     blog('the thing is : key : $key : value : ${map[key]} : valueType : ${map[key].runtimeType} : index : $index');
        //
        //     if (map[key] == searchValue){
        //       _slideSeenAlready = true;
        //       break;
        //     }
        //   }
        //
        // }
        //
        // if (_slideSeenAlready == true){
        //   blog('RecordProtocols.viewFlyer : VIEW RECORD ALREADY EXISTS');
        // }
        // else {

        final RecordModel _record = RecordModel.createViewRecord(
          userID: Authing.getUserID(),
          flyerID: flyerModel.id,
          slideIndex: index,
        );

        // await Future.wait(<Future>[]);

        await Future.wait(<Future>[

          RecordRealOps.createRecord(
            record: _record,
          ),

          incrementFlyerCounter(
            flyerID: flyerModel.id,
            field: 'views',
            increaseOne: true,
          ),

          BzRecordRealOps.incrementBzCounter(
            bzID: flyerModel.bzID,
            field: 'allViews',
            increaseOne: true,
          ),

        ]);

      }

    }


    // blog('FlyerRecordOps.viewFlyer : END');
  }
  // --------------------
  /// SAVES CREATION
  // -------
  /// TESTED : WORKS PERFECT
  static Future<void> saveFlyer({
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {
    // blog('FlyerRecordOps.saveFlyer : START');

    if (Authing.userIsSignedIn() == true && flyerID != DraftFlyer.newDraftID){

      final RecordModel _record = RecordModel.createSaveRecord(
        userID: Authing.getUserID(),
        flyerID: flyerID,
        slideIndex: slideIndex,
      );

      await Future.wait(<Future>[

        RecordRealOps.createRecord(
          record: _record,
        ),

        incrementFlyerCounter(
          flyerID: flyerID,
          field: 'saves',
          increaseOne: true,
        ),

        BzRecordRealOps.incrementBzCounter(
          bzID: bzID,
          field: 'allSaves',
          increaseOne: true,
        ),

      ]);

    }



    // blog('FlyerRecordOps.saveFlyer : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unSaveFlyer({
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {
    // blog('FlyerRecordOps.unSaveFlyer : START');

    if (Authing.userIsSignedIn() == true && flyerID != DraftFlyer.newDraftID){

      final RecordModel _record = RecordModel.createUnSaveRecord(
        userID: Authing.getUserID(),
        flyerID: flyerID,
      );

      await Future.wait(<Future>[

        RecordRealOps.createRecord(
          record: _record,
        ),

        incrementFlyerCounter(
          flyerID: flyerID,
          field: 'saves',
          increaseOne: false,
        ),

        BzRecordRealOps.incrementBzCounter(
          bzID: bzID,
          field: 'allSaves',
          increaseOne: false,
        ),

      ]);

    }


    // blog('FlyerRecordOps.unSaveFlyer : END');
  }
  // --------------------
  /// REVIEWS CREATION
  // -------
  /// TESTED : WORKS PERFECT
  static Future<void> reviewCreation({
    @required ReviewModel reviewModel,
    @required String bzID,
  }) async {

    assert(reviewModel != null, 'review is null');
    assert(reviewModel.flyerID != null, 'review.flyerID is null');

    blog('FlyerRecordOps.createCreateReview : START');

    if (Authing.userIsSignedIn() == true && reviewModel.flyerID != DraftFlyer.newDraftID){

      // final RecordModel _record = RecordModel.createCreateReviewRecord(
      //   userID: Authing.getUserID(),
      //   text: review,
      //   flyerID: flyerID,
      // );

      await Future.wait(<Future>[

        // RecordRealOps.createRecord(
        //   context: context,
        //   record: _record,
        // ),

        incrementFlyerCounter(
          flyerID: reviewModel.flyerID,
          field: 'reviews',
          increaseOne: true,
        ),

        BzRecordRealOps.incrementBzCounter(
          bzID: bzID,
          field: 'allReviews',
          increaseOne: true,
        ),

      ]);

    }

    blog('FlyerRecordOps.createCreateReview : END');
  }
  // --------------------
  /// NO NEED
  /*
  /// TESTED : ...
  static Future<void> createEditReview({
    @required BuildContext context,
    @required String reviewEdit,
    @required String flyerID,
  }) async {
    blog('FlyerRecordOps.createEditReview : START');

    final RecordModel _record = RecordModel.createEditReviewRecord(
      userID: Authing.getUserID(),
      reviewEdit: reviewEdit,
      flyerID: flyerID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('FlyerRecordOps.createEditReview : END');
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> reviewDeletion({
    @required String flyerID,
    @required String bzID,
  }) async {
    blog('FlyerRecordOps.reviewDeletion : START');

    // final RecordModel _record = RecordModel.createDeleteReviewRecord(
    //   userID: Authing.getUserID(),
    //   flyerID: flyerID,
    // );

    await Future.wait(<Future>[

      // RecordRealOps.createRecord(
      //   context: context,
      //   record: _record,
      // ),

      incrementFlyerCounter(
        flyerID: flyerID,
        field: 'reviews',
        increaseOne: false,
      ),

      BzRecordRealOps.incrementBzCounter(
        bzID: bzID,
        field: 'allReviews',
        increaseOne: false,
      ),

    ]);

    blog('FlyerRecordOps.reviewDeletion : END');
  }
  // -----------------------------------------------------------------------------

  /// FLYER COUNTERS

  // --------------------
  /// COUNTER CREATION - UPDATING
  // -------
  /// TESTED : WORKS PERFECT
  static Future<FlyerCounterModel> incrementFlyerCounter({
    @required String flyerID,
    @required String field,
    bool increaseOne, // or decrease one
    int incrementThis,
  }) async {
    // blog('FlyerRecordOps.incrementFlyerCounter : START');

    assert (
    increaseOne != null || incrementThis != null,
    'incrementFlyerCounter :YOU FORGOT TO ASSIGN INCREMENTATION VALUE MAN',
    );

    int _value;
    if (incrementThis == null){
      _value = increaseOne == true ? 1 : -1;
    }
    else {
      _value = incrementThis;
    }

    await Real.updateDocField(
      collName: RealColl.countingFlyers,
      docName: flyerID,
      fieldName: field,
      value: fireDB.ServerValue.increment(_value),
    );

    Map<String, dynamic> _map = await Real.readDocOnce(
      collName: RealColl.countingFlyers,
      docName: flyerID,
    );

    _map = Mapper.insertPairInMap(
      map: _map,
      key: 'flyerID',
      value: flyerID,
    );

    final FlyerCounterModel _model = FlyerCounterModel.decipherCounterMap(_map);

    // blog('FlyerRecordOps.incrementFlyerCounter : END');
    return _model;
  }
  // --------------------
  /// COUNTER READING
  // -------
  static Future<FlyerCounterModel> readFlyerCounters({
    @required String flyerID,
  }) async {

    final Map<String, dynamic> _map = await Real.readDocOnce(
      collName: RealColl.countingFlyers,
      docName: flyerID,
    );

    final FlyerCounterModel _flyerCounters = FlyerCounterModel.decipherCounterMap(_map);

    return _flyerCounters;
  }
  // --------------------
  /// COUNTER DELETION
  // -------
  /// TESTED : WORKS PERFECT : TASK : NEED CLOUD FUNCTION
  static Future<void> deleteAllFlyerCountersAndRecords({
    @required String flyerID,
  }) async {

    await Future.wait(<Future>[

      /// SHARES
      Real.deleteDoc(
        collName: RealColl.recordingShares,
        docName: flyerID,
      ),

      /// VIEWS
      Real.deleteDoc(
        collName: RealColl.recordingViews,
        docName: flyerID,
      ),

      /// SAVES
      Real.deleteDoc(
        collName: RealColl.recordingSaves,
        docName: flyerID,
      ),

      // /// REVIEWS
      // Real.deleteDoc(
      //   context: context,
      //   collName: RealColl.recordingReviews,
      //   docName: flyerID,
      // ),

      /// FLYERS COUNTER
      Real.deleteDoc(
        collName: RealColl.countingFlyers,
        docName: flyerID,
      ),

    ]);

  }
  // -------
  /// TESTED : WORKS PERFECT : TASK : NEED CLOUD FUNCTION
  static Future<void> deleteMultipleFlyersCountersAndRecords({
    @required List<String> flyersIDs,
  }) async {

    if (Mapper.checkCanLoopList(flyersIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(flyersIDs.length, (index) => deleteAllFlyerCountersAndRecords(
          flyerID: flyersIDs[index],
        )),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
