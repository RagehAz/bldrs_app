import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
/// => TAMAM
@immutable
class TriggerModel {
  /// --------------------------------------------------------------------------
  const TriggerModel({
    @required this.name,
    @required this.argument,
    @required this.done,
  });
  /// --------------------------------------------------------------------------
  final String name;
  final String argument;
  final List<String> done;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  TriggerModel copyWith({
    String name,
    String argument,
    List<String> done,
  }){
    return TriggerModel(
      name: name ?? this.name,
      argument: argument ?? this.argument,
      done: done ?? this.done,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'functionName': name,
      'argument': argument,
      'done': ChainPathConverter.combinePathNodes(done),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TriggerModel decipherTrigger(Map<String, dynamic> map){
    TriggerModel _trigger;

    if (map != null){
      _trigger = TriggerModel(
        name: map['functionName'],
        argument: map['argument'],
        done: ChainPathConverter.splitPathNodes(map['done']),
      );
    }

    return _trigger;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteModel addMeToTriggerDones({
    @required NoteModel noteModel,
  }){

    assert(noteModel != null, 'noteModel can not be null');
    assert(Authing.getUserID() != null, 'User is not authenticated');

    final List<String> _updatedDone = Stringer.addStringToListIfDoesNotContainIt(
      strings: noteModel.function.done,
      stringToAdd: Authing.getUserID(),
    );

    final TriggerModel _updatedTrigger = noteModel.function.copyWith(
      done: _updatedDone,
    );

    return noteModel.copyWith(
      function: _updatedTrigger,
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIFiredThisTrigger(TriggerModel trigger){

    assert(Authing.getUserID() != null, 'User is not authenticated');

    bool _fired = false;

    if (trigger != null){

      _fired = Stringer.checkStringsContainString(
          strings: trigger.done,
          string: Authing.getUserID(),
      );

    }

    return _fired;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogTrigger(){
    blog('Trigger : functionName : $name : argument : $argument : done : $done');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTriggersAreIdentical(TriggerModel trigger1, TriggerModel trigger2){
    bool _identical = false;

    if (trigger1 == null && trigger2 == null){
      _identical = true;
    }

    else {

      if (trigger1 != null && trigger2 != null){

        if (
          trigger1.name == trigger2.name &&
          trigger1.argument == trigger2.argument &&
          Mapper.checkListsAreIdentical(list1: trigger1.done, list2: trigger2.done)
        ){
          _identical = true;
        }

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
    if (other is TriggerModel){
      _areIdentical = checkTriggersAreIdentical(this, other);
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      name.hashCode^
      argument.hashCode;
  // -----------------------------------------------------------------------------
}
