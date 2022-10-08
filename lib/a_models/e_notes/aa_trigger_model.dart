import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

@immutable
class TriggerModel {
  /// --------------------------------------------------------------------------
  const TriggerModel({
    @required this.functionName,
    @required this.argument,
  });
  /// --------------------------------------------------------------------------
  final String functionName;
  final String argument;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  TriggerModel copyWith({
    String functionName,
    String argument,
  }){
    return TriggerModel(
      functionName: functionName ?? this.functionName,
      argument: argument ?? this.argument,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap(){
    return {
      'functionName': functionName,
      'argument': argument,
    };
  }
  // --------------------
  static TriggerModel decipherTrigger(Map<String, dynamic> map){
    TriggerModel _trigger;

    if (map != null){
      _trigger = TriggerModel(
        functionName: map['functionName'],
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

        trigger1.functionName == trigger2.functionName &&
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
    blog('Trigger : functionName : $functionName : argument : $argument');
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
      functionName: updateFlyer,
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
      functionName: 'bzDeletion',
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
      functionName.hashCode^
      argument.hashCode;
  // -----------------------------------------------------------------------------
}
