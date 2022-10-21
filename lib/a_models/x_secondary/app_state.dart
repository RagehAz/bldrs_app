import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

/// IS SUB USER MODEL THAT COMPARES STATE WITH GLOBAL DB STATE MODIFIED FROM DASHBOARD
/// OR AUTOMATICALLY WHEN CHANGING DATA THAT ARE SAVED ON LDB, IN ORDER TO RE FETCH THE DATA
@immutable
class AppState {
  // -----------------------------------------------------------------------------
  const AppState({
    @required this.chainsVersion,
    @required this.pickersVersion,
    @required this.phrasesVersion,
    @required this.appVersion,
    @required this.ldbVersion,
    @required this.appControlsVersion,

    @required this.id,

  });
  // -----------------------------------------------------------------------------
  /// chains
  final double chainsVersion;
  final double pickersVersion;

  /// phrases
  final double phrasesVersion;

  /// app update
  final String appVersion;
  final double ldbVersion; /// this used to wipe out all LDB docs and re fetch everything
  final double appControlsVersion;

  final String id; /// either global or user
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AppState copyWith({
    double chainsVersion,
    double pickersVersion,
    double phrasesVersion,
    String appVersion,
    double ldbVersion,
    double appControlsVersion,
    String id,
  }){
    return AppState(
      id: id ?? this.id,
      chainsVersion: chainsVersion ?? this.chainsVersion,
      pickersVersion: pickersVersion ?? this.pickersVersion,

      phrasesVersion: phrasesVersion ?? this.phrasesVersion,

      appVersion: appVersion ?? this.appVersion,
      ldbVersion: ldbVersion?? this.ldbVersion,
      appControlsVersion: appControlsVersion ?? this.appControlsVersion,
    );
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static AppState initialState() {
    return const AppState(
      id: null,
      chainsVersion : null,
      pickersVersion : null,
      phrasesVersion : null,
      appVersion : null,
      ldbVersion : null,
      appControlsVersion: null,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id' : id,
      'chainsVersion' : chainsVersion,
      'pickersVersion' : pickersVersion,
      'phrasesVersion' : phrasesVersion,
      'appVersion' : appVersion,
      'ldbVersion' : ldbVersion,
      'appControlsVersion': appControlsVersion,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AppState fromMap(Map<String, dynamic> map) {

    if (map == null) {
      return null;
    }

    else {

      return AppState(
        id: map['id'],
        chainsVersion : map['chainsVersion']?.toDouble(),
        pickersVersion : map['pickersVersion']?.toDouble(),
        phrasesVersion : map['phrasesVersion']?.toDouble(),
        appVersion : map['appVersion'],
        ldbVersion : map['ldbVersion']?.toDouble(),
        appControlsVersion: map['appControlsVersion']?.toDouble(),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool appStatesAreIdentical({
    @required AppState stateA,
    @required AppState stateB,
  }){
    bool _areIdentical = false;

    if (stateA != null && stateB != null){

      if (
      stateA.id == stateB.id
          &&
          stateA.appVersion == stateB.appVersion
          &&
          stateA.chainsVersion == stateB.chainsVersion
          &&
          stateA.ldbVersion == stateB.ldbVersion
          &&
          stateA.phrasesVersion == stateB.phrasesVersion
          &&
          stateA.pickersVersion == stateB.pickersVersion
          &&
          stateA.appControlsVersion == stateB.appControlsVersion
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static AppState dummyAppState(){
    return const AppState(
      id: 'dummy',
      chainsVersion: 0,
      pickersVersion: 0,
      phrasesVersion: 0,
      appVersion: '0.0.0',
      ldbVersion: 0,
      appControlsVersion: 0,
    );
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogAppState({String invoker = ''}){
    blog('AppState is $invoker : -------------------- START');
    blog('id : $id');
    blog('chainsVersion : $chainsVersion');
    blog('pickersVersion : $pickersVersion');
    blog('phrasesVersion : $phrasesVersion');
    blog('appVersion : $appVersion');
    blog('ldbVersion : $ldbVersion');
    blog('appControlsVersion : $appControlsVersion');
    blog('AppState ------------------------ END');
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAppStatesAreIdentical({
    @required AppState appState1,
    @required AppState appState2,
  }){
    bool _identical = false;

    if (appState1 != null && appState2 != null){

      if (
          appState1.chainsVersion == appState2.chainsVersion &&
          appState1.pickersVersion == appState2.pickersVersion &&
          appState1.phrasesVersion == appState2.phrasesVersion &&
          appState1.appVersion == appState2.appVersion &&
          appState1.ldbVersion == appState2.ldbVersion &&
          appState1.appControlsVersion == appState2.appControlsVersion &&
          appState1.id == appState2.id
      ){
        _identical = true;
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
    if (other is AppState){
      _areIdentical = checkAppStatesAreIdentical(
        appState1: this,
        appState2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      chainsVersion.hashCode^
      pickersVersion.hashCode^
      phrasesVersion.hashCode^
      appVersion.hashCode^
      ldbVersion.hashCode^
      appControlsVersion.hashCode^
      id.hashCode;
  // -----------------------------------------------------------------------------
}
