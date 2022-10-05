import 'package:flutter/foundation.dart';

@immutable
class Progress{
  /// --------------------------------------------------------------------------
  const Progress({
    @required this.targetID,
    @required this.objective,
    @required this.current,
  });
  /// --------------------------------------------------------------------------
  final String targetID;
  final int objective;
  final int current;
  /// --------------------------------------------------------------------------
  Progress copyWith({
    String targetID,
    int objective,
    int current,
  }){
    return Progress(
      targetID: targetID ?? this.targetID,
      objective: objective ?? this.objective,
      current: current ?? this.current,
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  static bool checkProgressesAreIdentical({
    @required Progress progress1,
    @required Progress progress2,
  }){
    bool _areIdentical = false;

    if (progress1 == null && progress2 == null){
      _areIdentical = true;
    }
    else if (progress1 != null && progress2 != null){

      if (
          progress1.targetID == progress2.targetID &&
          progress1.objective == progress2.objective &&
          progress1.current == progress2.current
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
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
    if (other is Progress){
      _areIdentical = checkProgressesAreIdentical(
        progress1: this,
        progress2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      targetID.hashCode^
      objective.hashCode^
      current.hashCode;
  // -----------------------------------------------------------------------------
}
