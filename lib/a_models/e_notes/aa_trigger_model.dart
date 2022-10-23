import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

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
  final bool done;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  TriggerModel copyWith({
    String name,
    String argument,
    bool done,
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
      'done': done,
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
        done: map['done'],
      );
    }

    return _trigger;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTriggersAreIdentical(TriggerModel trigger1, TriggerModel trigger2){
    bool _identical;

    if (trigger1 == null && trigger2 == null){
      _identical = true;
    }
    else {

      if (trigger1 != null && trigger2 != null){

        if (

        trigger1.name == trigger2.name &&
        trigger1.argument == trigger2.argument &&
        trigger1.done == trigger2.done
        ){
          _identical = true;
        }

      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogTrigger(){
    blog('Trigger : functionName : $name : argument : $argument : done : $done');
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
