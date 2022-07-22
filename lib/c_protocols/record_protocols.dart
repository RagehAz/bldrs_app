import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/record_ops.dart';
import 'package:bldrs/e_db/real/real.dart';
import 'package:flutter/material.dart';

class RecordProtocols {
// -----------------------------------------------------------------------------

  RecordProtocols();

// -----------------------------------------------------------------------------

  /// CREATE BZ RECORDS AND COUNTERS

// ----------------------------------
    /// TESTED : WORKS PERFECT
  static Future<void> followBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('RecordProtocols.followBz : START');

    final RecordModel _record = RecordModel.createFollowRecord(
        userID: AuthFireOps.superUserID(),
        bzID: bzID
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'follows',
        increaseOne: true,
      ),

    ]);


    blog('RecordProtocols.followBz : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unfollowBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('RecordProtocols.unfollowBz : START');

    final RecordModel _record = RecordModel.createUnfollowRecord(
        userID: AuthFireOps.superUserID(),
        bzID: bzID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'follows',
        increaseOne: false,
      ),

    ]);

    blog('RecordProtocols.unfollowBz : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> callBz({
    @required BuildContext context,
    @required String bzID,
    @required ContactModel contact,
  }) async {

    blog('RecordProtocols.callBz : START');

    final RecordModel _record = RecordModel.createCallRecord(
      userID: AuthFireOps.superUserID(),
      bzID: bzID,
      contact: contact,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
        context: context,
        record: _record,
      ),

      RecordRealOps.incrementBzCounter(
        context: context,
        bzID: bzID,
        field: 'calls',
        increaseOne: true,
      ),

    ]);

    blog('RecordProtocols.callBz : END');

  }
// -----------------------------------------------------------------------------

  /// CREATE FLYER RECORDS AND COUNTERS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> shareFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) async {

    blog('RecordProtocols.shareFlyer : START');

    final RecordModel _record = RecordModel.createShareRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
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



    blog('RecordProtocols.shareFlyer : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> viewFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required int index,
  }) async {

    /// TASK : CAUTION : THIS METHOD WILL DUPLICATE RECORAD IN REAL DB IF LDB VIEWS DOX IS WIPED OUT
    /// WE WEEN A MORE SOLID WAY TO CHECK IF THIS USER PREVIOUSLY VIEWED THE SLIDE TO CALL THIS
    /// OR,, CHANGE THE NODE ID IN

    blog('RecordProtocols.viewFlyer : START');

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

          RecordRealOps.createRecord(
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

    blog('RecordProtocols.viewFlyer : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {

    blog('RecordProtocols.saveFlyer : START');

    final RecordModel _record = RecordModel.createSaveRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
      slideIndex: slideIndex,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
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

    blog('RecordProtocols.saveFlyer : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unSaveFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {

    blog('RecordProtocols.unSaveFlyer : START');

    final RecordModel _record = RecordModel.createUnSaveRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
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

    blog('RecordProtocols.unSaveFlyer : END');

  }
// -----------------------------------------------------------------------------

  /// CREATE FLYER REVIEWS RECORDS AND COUNTERS

// ----------------------------------
  /// TESTED : ...
  static Future<void> createCreateReview({
    @required BuildContext context,
    @required String review,
    @required String flyerID,
    @required String bzID,
  }) async {

    blog('RecordProtocols.createCreateReview : START');

    final RecordModel _record = RecordModel.createCreateReviewRecord(
      userID: AuthFireOps.superUserID(),
      review: review,
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
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

    blog('RecordProtocols.createCreateReview : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createEditReview({
    @required BuildContext context,
    @required String reviewEdit,
    @required String flyerID,
  }) async {

    blog('RecordProtocols.createEditReview : START');

    final RecordModel _record = RecordModel.createEditReviewRecord(
      userID: AuthFireOps.superUserID(),
      reviewEdit: reviewEdit,
      flyerID: flyerID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createEditReview : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createDeleteReview({
    @required BuildContext context,
    @required String flyerID,
    @required String bzID,
  }) async {

    blog('RecordProtocols.createDeleteReview : START');

    final RecordModel _record = RecordModel.createDeleteReviewRecord(
      userID: AuthFireOps.superUserID(),
      flyerID: flyerID,
    );

    await Future.wait(<Future>[

      RecordRealOps.createRecord(
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

    blog('RecordProtocols.createDeleteReview : END');

  }
// -----------------------------------------------------------------------------

  /// CREATE QUESTIONS RECORDS AND COUNTERS

// ----------------------------------
  /// TESTED : ...
  static Future<void> createCreateQuestion({
    @required BuildContext context,
    @required String questionID,
  }) async {

    blog('RecordProtocols.createCreateQuestion : START');

    final RecordModel _record = RecordModel.createCreateQuestionRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createCreateQuestion : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createEditQuestion({
    @required BuildContext context,
    @required String questionID,
  }) async {

    blog('RecordProtocols.createEditQuestion : START');

    final RecordModel _record = RecordModel.createEditQuestionRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createEditQuestion : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createDeleteQuestion({
    @required BuildContext context,
    @required String questionID,
  }) async {

    blog('RecordProtocols.createDeleteQuestion : START');

    final RecordModel _record = RecordModel.createDeleteQuestionRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createDeleteQuestion : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createCreateAnswer({
    @required BuildContext context,
    @required String questionID,
    @required String answerID,
  }) async {

    blog('RecordProtocols.createCreateAnswer : START');

    final RecordModel _record = RecordModel.createCreateAnswerRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createCreateAnswer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createEditAnswer({
    @required BuildContext context,
    @required String questionID,
    @required String answerID,
  }) async {

    blog('RecordProtocols.createEditAnswer : START');

    final RecordModel _record = RecordModel.createEditAnswerRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createEditAnswer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createDeleteAnswer({
    @required BuildContext context,
    @required String questionID,
    @required String answerID,
  }) async {

    blog('RecordProtocols.createDeleteAnswer : START');

    final RecordModel _record = RecordModel.createDeleteAnswerRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createDeleteAnswer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createSearch({
    @required BuildContext context,
    @required String searchText,
  }) async {

    blog('RecordProtocols.createSearch : START');

    final RecordModel _record = RecordModel.createSearchRecord(
      userID: AuthFireOps.superUserID(),
      searchText: searchText,
    );

    await RecordRealOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createSearch : END');

  }
// -----------------------------------------------------------------------------

/// READ COUNTERS

// ----------------------------------
  static Future<BzCounterModel> readBzCounters({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final Map<String, dynamic> _map = await Real.readDocOnce(
      context: context,
      collName: 'bzzCounters',
      docName: bzID,
    );

    final BzCounterModel _bzCounters = BzCounterModel.decipherCounterMap(_map);

    return _bzCounters;
  }
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
// ----------------------------------

}
