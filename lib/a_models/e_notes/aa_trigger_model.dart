import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

@immutable
class TriggerModel {
  /// --------------------------------------------------------------------------
  const TriggerModel({
    @required this.name,
    @required this.argument,
  });
  /// --------------------------------------------------------------------------
  final String name;
  final String argument;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  TriggerModel copyWith({
    String functionName,
    String argument,
  }){
    return TriggerModel(
      name: functionName ?? this.name,
      argument: argument ?? this.argument,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap(){
    return {
      'functionName': name,
      'argument': argument,
    };
  }
  // --------------------
  static TriggerModel decipherTrigger(Map<String, dynamic> map){
    TriggerModel _trigger;

    if (map != null){
      _trigger = TriggerModel(
        name: map['functionName'],
        argument: map['argument'],
      );
    }

    return _trigger;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkTriggersAreIdentical(TriggerModel trigger1, TriggerModel trigger2){
    bool _identical;

    if (trigger1 == null && trigger2 == null){
      _identical = true;
    }
    else {

      if (trigger1 != null && trigger2 != null){

        if (

        trigger1.name == trigger2.name &&
        trigger2.argument == trigger2.argument

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
  void blogTrigger(){
    blog('Trigger : functionName : $name : argument : $argument');
  }
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String updateFlyer = 'updateFlyer';
  static const String bzDeletion = 'bzDeletion';
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  static TriggerModel createFlyerUpdateTrigger({ /// re-fetch flyer
    @required String flyerID,
  }){
    return TriggerModel(
      name: updateFlyer,
      argument: flyerID,
    );
  }
  // --------------------
  static TriggerModel createAuthorshipAcceptanceTrigger(){
    return null;
  }
  // --------------------
  static TriggerModel createBzDeletionTrigger({
    @required String bzID,
  }){
    return TriggerModel(
      name: 'bzDeletion',
      argument: bzID,
    );
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
