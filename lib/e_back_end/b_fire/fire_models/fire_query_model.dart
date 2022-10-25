import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class FireQueryModel {
  /// --------------------------------------------------------------------------
  const FireQueryModel({
    @required this.collRef,
    @required this.idFieldName,
    this.onDataChanged,
    this.limit,
    this.orderBy,
    this.finders,
    this.startAfter,
    this.initialMaps,
  });
  /// --------------------------------------------------------------------------
  final CollectionReference<Object> collRef;
  final int limit;
  final QueryOrderBy orderBy;
  final List<FireFinder> finders;
  final ValueChanged<List<Map<String, dynamic>>> onDataChanged;
  final QueryDocumentSnapshot startAfter;
  final List<Map<String, dynamic>> initialMaps;
  final String idFieldName;
  // -----------------------------------------------------------------------------

  /// QueryParameter CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  FireQueryModel copyWith({
    CollectionReference<Object> collRef,
    int limit,
    QueryOrderBy orderBy,
    List<FireFinder> finders,
    ValueChanged<List<Map<String, dynamic>>> onDataChanged,
    QueryDocumentSnapshot startAfter,
    List<Map<String, dynamic>> initialMaps,
    String idFieldName,
  }){
    return FireQueryModel(
      collRef: collRef ?? this.collRef,
      limit: limit ?? this.limit,
      orderBy: orderBy ?? this.orderBy,
      finders: finders ?? this.finders,
      onDataChanged: onDataChanged ?? this.onDataChanged,
      startAfter: startAfter ?? this.startAfter,
      initialMaps: initialMaps ?? this.initialMaps,
      idFieldName: idFieldName ?? this.idFieldName,
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkQueriesHaveNotChanged({
    @required FireQueryModel model1,
    @required FireQueryModel model2,
  }){
  bool _identical = false;

  if (model1 == null && model2 == null){
    _identical = true;
  }

  else if (model1 != null && model2 != null){

    if (
    model1.collRef?.path == model2.collRef?.path &&
    model1.limit == model2.limit &&
    model1.orderBy?.descending == model2.orderBy?.descending &&
    model1.orderBy?.fieldName == model2.orderBy?.fieldName &&
    FireFinder.checkFindersListsAreIdentical(model1.finders, model2.finders) == true &&
    model1.idFieldName == model2.idFieldName
    // model1.onDataChanged == model2.onDataChanged &&
    // model1.startAfter == model2.startAfter &&
    // model1.initialMaps == model2.initialMaps &&
    ){
      _identical = true;
    }

  }


  return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FireQueryModel){
      _areIdentical = checkQueriesHaveNotChanged(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      collRef.hashCode^
      onDataChanged.hashCode^
      limit.hashCode^
      orderBy.hashCode^
      finders.hashCode^
      startAfter.hashCode^
      idFieldName.hashCode^
      initialMaps.hashCode;
// -----------------------------------------------------------------------------
}
