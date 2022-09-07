import 'package:bldrs/e_db/fire/fire_models/query_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireQueryModel {
  /// --------------------------------------------------------------------------
  const FireQueryModel({
    @required this.collRef,
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
  // -----------------------------------------------------------------------------

  /// QueryParameter CREATOR

  // --------------------
  FireQueryModel copyWith({
    CollectionReference<Object> collRef,
    int limit,
    QueryOrderBy orderBy,
    List<FireFinder> finders,
    ValueChanged<List<Map<String, dynamic>>> onDataChanged,
    QueryDocumentSnapshot startAfter,
    List<Map<String, dynamic>> initialMaps,
  }){
    return FireQueryModel(
      collRef: collRef ?? this.collRef,
      limit: limit ?? this.limit,
      orderBy: orderBy ?? this.orderBy,
      finders: finders ?? this.finders,
      onDataChanged: onDataChanged ?? this.onDataChanged,
      startAfter: startAfter ?? this.startAfter,
      initialMaps: initialMaps ?? this.initialMaps,
    );
  }
  // --------------------
}
