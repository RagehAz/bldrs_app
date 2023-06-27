import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:flutter/foundation.dart';

//
/// Bz account has limited amount of available slides, with each published slide,
/// credit decreases,
/// slides can be purchased or rewarded
/// int credit; <------
/// List<Map<String,Object>> bzProgressMaps = [
///   {'challenge' : 'completeAccount',     'progress' : 100 , 'claimed' : true},
///   {'challenge' : 'verifyAccount',       'progress' : 0   , 'claimed' : false},
///   {'challenge' : 'publish 10 flyers',   'progress' : 90  , 'claimed' : false},
///   {'challenge' : 'publish 100 flyers',  'progress' : 9   , 'claimed' : false},
/// ];
/// List<Map<String,Object>> progress; <------
//

@immutable
class Progress{
  /// --------------------------------------------------------------------------
  const Progress({
    required this.targetID,
    required this.objective,
    required this.current,
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
  /// TESTED : WORKS PERFECT
  static bool checkProgressesAreIdentical({
    required Progress progress1,
    required Progress progress2,
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
  // --------------------

  static Progress generateModelFromNoteProgress(NoteModel note){
    Progress _output;

    if (note != null){

      if (note.progress != null){

        if (note.progress != -1){

          _output = Progress(
            targetID: note.id,
            objective: 100,
            current: note.progress,
          );

        }

      }

    }

    return _output;
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
