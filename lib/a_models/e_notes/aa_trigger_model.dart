import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
    String name,
    String argument,
  }){
    return TriggerModel(
      name: name ?? this.name,
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
  /// -> fires refetch flyer protocol
  static const String refetchFlyer = 'refetchFlyer';
  // --------------------
  /// -> fires delete bz locally protocol
  static const String deleteBzLocally = 'deleteBzLocally';
  // --------------------
  /// -> shows note buttons + allows [ add Me To Bz Protocol ] + allows [ decline authorship protocol ]
  static const String authorshipInvitation = 'authorshipInvitation';
  // --------------------
  /// -> fires refetchBZ
  static const String refetchBz = 'refetchBz';
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  static TriggerModel createFlyerRefetchTrigger({ /// re-fetch flyer
    @required String flyerID,
  }){
    return TriggerModel(
      name: refetchFlyer,
      argument: flyerID,
    );
  }
  // --------------------
  static TriggerModel createAuthorshipAcceptanceTrigger(){
    return null;
  }
  // --------------------
  static TriggerModel createDeleteBzLocallyTrigger({
    @required String bzID,
  }){
    return TriggerModel(
      name: deleteBzLocally,
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
