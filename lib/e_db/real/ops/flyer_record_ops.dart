import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/ops/record_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FlyerRecordOps {
// -----------------------------------------------------------------------------

  FlyerRecordOps();

// -----------------------------------------------------------------------------

  /// CREATION

// ----------------------------------
  /// SHARES CREATION
// -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> shareFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) async {
    blog('FlyerRecordOps.shareFlyer : START');

    final RecordModel _record = RecordModel.createShareRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementFlyerCounter(
        context: context,
        flyerID: flyerID,
        field: 'shares',
        increaseOne: true,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'allShares',
        increaseOne: true,
      ),

    ]);

    blog('FlyerRecordOps.shareFlyer : END');
  }
// ----------------------------------
  /// VIEWS CREATION
// -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> viewFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required int index,
  }) async {
    blog('FlyerRecordOps.viewFlyer : START');

    /// TASK : CAUTION : THIS METHOD WILL DUPLICATE RECORDS IN REAL DB IF LDB VIEWS DOX IS WIPED OUT
    /// WE WEEN A MORE SOLID WAY TO CHECK IF THIS USER PREVIOUSLY VIEWED THE SLIDE TO CALL THIS
    /// OR,, CHANGE THE NODE ID IN

    final int _numberOfSlides = flyerModel?.slides?.length;

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
        userID: AuthFireOps.superUserID(),
        flyerID: flyerModel.id,
        slideIndex: index,
      );

      // await Future.wait(<Future>[]);

      await Future.wait(<Future>[

        RecordRealOps.createARecord(
          context: context,
          record: _record,
        ),

        RecordRealOps.incrementFlyerCounter(
          context: context,
          flyerID: flyerModel.id,
          field: 'views',
          increaseOne: true,
        ),

        RecordRealOps.incrementBzCounter(
          context: context,
          bzID: flyerModel.bzID,
          field: 'allViews',
          increaseOne: true,
        ),

      ]);

    }

    blog('FlyerRecordOps.viewFlyer : END');
  }
// ----------------------------------
  /// SAVES CREATION
// -------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {
    blog('FlyerRecordOps.saveFlyer : START');

    final RecordModel _record = RecordModel.createSaveRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
      slideIndex: slideIndex,
    );

    await Future.wait(<Future>[

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementFlyerCounter(
        context: context,
        flyerID: flyerID,
        field: 'saves',
        increaseOne: true,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'allSaves',
        increaseOne: true,
      ),

    ]);

    blog('FlyerRecordOps.saveFlyer : END');
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unSaveFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {
    blog('FlyerRecordOps.unSaveFlyer : START');

    final RecordModel _record = RecordModel.createUnSaveRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementFlyerCounter(
        context: context,
        flyerID: flyerID,
        field: 'saves',
        increaseOne: false,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'allSaves',
        increaseOne: false,
      ),

    ]);

    blog('FlyerRecordOps.unSaveFlyer : END');
  }
// ----------------------------------
  /// REVIEWS CREATION
// -------------------
  /// TESTED : ...
  static Future<void> createCreateReview({
    @required BuildContext context,
    @required String review,
    @required String flyerID,
    @required String bzID,
  }) async {
    blog('FlyerRecordOps.createCreateReview : START');

    final RecordModel _record = RecordModel.createCreateReviewRecord(
      userID: AuthFireOps.superUserID(),
      review: review,
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementFlyerCounter(
        context: context,
        flyerID: flyerID,
        field: 'reviews',
        increaseOne: true,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'allReviews',
        increaseOne: true,
      ),

    ]);

    blog('FlyerRecordOps.createCreateReview : END');
  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createEditReview({
    @required BuildContext context,
    @required String reviewEdit,
    @required String flyerID,
  }) async {
    blog('FlyerRecordOps.createEditReview : START');

    final RecordModel _record = RecordModel.createEditReviewRecord(
      userID: AuthFireOps.superUserID(),
      reviewEdit: reviewEdit,
      flyerID: flyerID,
    );

    await RecordRealOps.createARecord(
      context: context,
      record: _record,
    );

    blog('FlyerRecordOps.createEditReview : END');
  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createDeleteReview({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) async {
    blog('FlyerRecordOps.createDeleteReview : START');

    final RecordModel _record = RecordModel.createDeleteReviewRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createARecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementFlyerCounter(
        context: context,
        flyerID: flyerID,
        field: 'reviews',
        increaseOne: false,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'allReviews',
        increaseOne: false,
      ),

    ]);

    blog('FlyerRecordOps.createDeleteReview : END');
  }
// -----------------------------------------------------------------------------

/// READ COUNTERS

// ----------------------------------
  static Future<FlyerCounterModel> readFlyerCounters({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    final Map<String, dynamic> _map = await Real.readDocOnce(
      context: context,
      collName: 'flyersCounters',
      docName: flyerID,
    );

    final FlyerCounterModel _flyerCounters = FlyerCounterModel.decipherCounterMap(_map);

    return _flyerCounters;
  }
// -----------------------------------------------------------------------------
}
