import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireQueryModel {
  /// --------------------------------------------------------------------------
  const FireQueryModel({
    @required this.collName,
    @required this.onDataChanged,
    this.limit,
    this.orderBy,
    this.finders,
    this.startAfter,
    this.initialMaps,
  });
  /// --------------------------------------------------------------------------
  final String collName;
  final int limit;
  final Fire.QueryOrderBy orderBy;
  final List<FireFinder> finders;
  final ValueChanged<List<Map<String, dynamic>>> onDataChanged;
  final QueryDocumentSnapshot startAfter;
  final List<Map<String, dynamic>> initialMaps;
// -----------------------------------------------------------------------------

/// QueryParameter CREATOR

// -----------------------------------
  FireQueryModel copyWith({
    String collName,
    int limit,
    Fire.QueryOrderBy orderBy,
    List<FireFinder> finders,
    ValueChanged<List<Map<String, dynamic>>> onDataChanged,
    QueryDocumentSnapshot startAfter,
    List<Map<String, dynamic>> initialMaps,
}){
    return FireQueryModel(
      collName: collName ?? this.collName,
      limit: limit ?? this.limit,
      orderBy: orderBy ?? this.orderBy,
      finders: finders ?? this.finders,
      onDataChanged: onDataChanged ?? this.onDataChanged,
      startAfter: startAfter ?? this.startAfter,
      initialMaps: initialMaps ?? this.initialMaps,
    );
  }
// -----------------------------------
}
