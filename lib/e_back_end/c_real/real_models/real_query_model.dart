import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

enum RealOrderType {
  byChild,
  byValue,
  byPriority,
  byKey,
}

class RealQueryModel{
  // -----------------------------------------------------------------------------
  const RealQueryModel({
    @required this.path,
    this.keyField,
    this.limit = 5,
    this.limitToFirst = true,
    this.orderType,
    this.fieldNameToOrderBy,
  });
  // -----------------------------------------------------------------------------
  final String path;
  final int limit;
  final String keyField;
  final bool limitToFirst;
  final RealOrderType orderType;
  final String fieldNameToOrderBy;
  // -----------------------------------------------------------------------------

  /// QUERY CREATOR

  // --------------------

  static Query createQuery({
    @required RealQueryModel queryModel,
    Map<String, dynamic> startAfter,
  }){
    Query _query;

    if (queryModel != null){

      _query = Real.getRefByPath(path: queryModel.path);

      /// ORDER BY
      if (queryModel.orderType != null){

        /// BY CHILD
        if (queryModel.orderType == RealOrderType.byChild){
          assert(queryModel.fieldNameToOrderBy != null, 'queryModel.fieldNameToOrderBy can not be null');
          _query = _query.orderByChild(queryModel.fieldNameToOrderBy);
        }

        /// BY KEY
        if (queryModel.orderType == RealOrderType.byKey){
          _query = _query.orderByKey();
        }

        /// BY VALUE
        if (queryModel.orderType == RealOrderType.byValue){
          _query = _query.orderByValue();
        }

        /// BY PRIORITY
        if (queryModel.orderType == RealOrderType.byPriority){
          _query = _query.orderByPriority();
        }

      }


      /// LIMIT
      if (queryModel.limit != null){

        /// LIMIT TO FIRST
        if (queryModel.limitToFirst == true){
          _query = _query.limitToFirst(queryModel.limit);
        }

        /// LIMIT TO LAST
        else {
          _query = _query.limitToLast(queryModel.limit);
        }

      }

      /// START AFTER
      if (startAfter != null){
        _query = _query.startAfter(
          startAfter,
          key: queryModel.fieldNameToOrderBy ?? queryModel.keyField,
        );

      }

    }

    return _query;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------

  void blogModel(){
    blog('RealQueryModel ------------------------> START');
    blog('path               : $path');
    blog('keyField           : $keyField');
    blog('limit              : $limit');
    blog('limitToFirst       : $limitToFirst');
    blog('orderType          : $orderType');
    blog('fieldNameToOrderBy : $fieldNameToOrderBy');
    blog('RealQueryModel ------------------------> END');
  }
  // -----------------------------------------------------------------------------
}
