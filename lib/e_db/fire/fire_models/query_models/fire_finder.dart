import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum FireComparison {
  greaterThan,
  greaterOrEqualThan,
  lessThan,
  lessOrEqualThan,
  equalTo,
  notEqualTo,
  nullValue,
  whereIn,
  whereNotIn,
  arrayContains,
  arrayContainsAny,
}

class FireFinder {
  /// --------------------------------------------------------------------------
  const FireFinder({
    @required this.field,
    @required this.comparison,
    @required this.value,
  });
  /// --------------------------------------------------------------------------
  final String field; /// fire field name
  final FireComparison comparison; /// fire equality comparison type
  final dynamic value; /// search value
// -----------------------------------------------------------------------------

  /// QUERY CREATOR

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Query<Map<String, dynamic>> createQueryByFinder({
    @required Query<Map<String, dynamic>> query,
    @required FireFinder finder,
  }){

    Query<Map<String, dynamic>> _output = query;

    /// IF EQUAL TO
    if (finder.comparison == FireComparison.equalTo) {
      _output = _output.where(finder.field, isEqualTo: finder.value);
    }

    /// IF GREATER THAN
    if (finder.comparison == FireComparison.greaterThan) {
      _output = _output.where(finder.field, isGreaterThan: finder.value);
    }

    /// IF GREATER THAN OR EQUAL
    if (finder.comparison == FireComparison.greaterOrEqualThan) {
      _output = _output.where(finder.field, isGreaterThanOrEqualTo: finder.value);
    }

    /// IF LESS THAN
    if (finder.comparison == FireComparison.lessThan) {
      _output = _output.where(finder.field, isLessThan: finder.value);
    }

    /// IF LESS THAN OR EQUAL
    if (finder.comparison == FireComparison.lessOrEqualThan) {
      _output = _output.where(finder.field, isLessThanOrEqualTo: finder.value);
    }

    /// IF IS NOT EQUAL TO
    if (finder.comparison == FireComparison.notEqualTo) {
      _output = _output.where(finder.field, isNotEqualTo: finder.value);
    }

    /// IF IS NULL
    if (finder.comparison == FireComparison.nullValue) {
      _output = _output.where(finder.field, isNull: finder.value);

    }

    /// IF whereIn
    if (finder.comparison == FireComparison.whereIn) {
      _output = _output.where(finder.field, whereIn: finder.value);
    }

    /// IF whereNotIn
    if (finder.comparison == FireComparison.whereNotIn) {
      _output = _output.where(finder.field, whereNotIn: finder.value);
    }

    /// IF array contains
    if (finder.comparison == FireComparison.arrayContains) {
      _output = _output.where(finder.field, arrayContains: finder.value);
    }

    /// IF array contains any
    if (finder.comparison == FireComparison.arrayContainsAny) {
      _output = _output.where(finder.field, arrayContainsAny: finder.value);
    }

    return _output;
  }
// -----------------------------------
  /// TESTED : WORKS PERFECT
  static Query<Map<String, dynamic>> createCompositeQueryByFinders({
    @required Query<Map<String, dynamic>> query,
    @required List<FireFinder> finders,
}){

    Query<Map<String, dynamic>> _output = query;

    if (Mapper.checkCanLoopList(finders) == true){

      for (final FireFinder finder in finders){
        _output = createQueryByFinder(
          query: _output,
          finder: finder,
        );
      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
