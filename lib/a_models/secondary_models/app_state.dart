import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

/// IS SUB USER MODEL THAT COMPARES STATE WITH GLOBAL DB STATE MODIFIED FROM DASHBOARD
/// OR AUTOMATICALLY WHEN CHANGING DATA THAT ARE SAVED ON LDB, IN ORDER TO RE FETCH THE DATA
@immutable
class AppState {
// -----------------------------------------------------------------------------
  const AppState({
    @required this.keywordsChainVersion,
    @required this.specsChainVersion,
    @required this.specPickersVersion,

    @required this.phrasesVersion,

    @required this.appVersion,
    @required this.ldbVersion,
    @required this.appControlsVersion,

    @required this.id,

  });
// -----------------------------------------------------------------------------
  /// chains
  final double keywordsChainVersion;
  final double specsChainVersion;
  final double specPickersVersion;

  /// phrases
  final double phrasesVersion;

  /// app update
  final String appVersion;
  final double ldbVersion; /// this used to wipe out all LDB docs and re fetch everything
  final double appControlsVersion;

  final String id; /// either global or user
// -----------------------------------------------------------------------------

  /// CLONING

// -----------------------------------
  /// TESTED : WORKS PERFECT
  AppState copyWith({
    double keywordsChainVersion,
    double specsChainVersion,
    double specPickersVersion,
    double phrasesVersion,
    String appVersion,
    double ldbVersion,
    double appControlsVersion,
    String id,
}){
    return AppState(
      id: id ?? this.id,
      keywordsChainVersion: keywordsChainVersion ?? this.keywordsChainVersion,
      specPickersVersion: specPickersVersion ?? this.specPickersVersion,
      specsChainVersion: specsChainVersion ?? this.specsChainVersion,

      phrasesVersion: phrasesVersion ?? this.phrasesVersion,

      appVersion: appVersion ?? this.appVersion,
      ldbVersion: ldbVersion?? this.ldbVersion,
      appControlsVersion: appControlsVersion ?? this.appControlsVersion,
    );
}
// -----------------------------------------------------------------------------

  /// INITIALIZATION

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static AppState initialState() {
    return const AppState(
      id: null,
      keywordsChainVersion : null,
      specsChainVersion : null,
      specPickersVersion : null,
      phrasesVersion : null,
      appVersion : null,
      ldbVersion : null,
      appControlsVersion: null,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// -----------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id' : id,
      'keywordsChainVersion' : keywordsChainVersion,
      'specsChainVersion' : specsChainVersion,
      'specPickersVersion' : specPickersVersion,
      'phrasesVersion' : phrasesVersion,
      'appVersion' : appVersion,
      'ldbVersion' : ldbVersion,
      'appControlsVersion': appControlsVersion,
    };
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static AppState fromMap(Map<String, dynamic> map) {

    if (map == null) {
      return null;
    }

    else {
      return AppState(
        id: map['id'],
        keywordsChainVersion : map['keywordsChainVersion']?.toDouble(),
        specsChainVersion : map['specsChainVersion']?.toDouble(),
        specPickersVersion : map['specPickersVersion']?.toDouble(),
        phrasesVersion : map['phrasesVersion']?.toDouble(),
        appVersion : map['appVersion'],
        ldbVersion : map['ldbVersion']?.toDouble(),
        appControlsVersion: map['appControlsVersion']?.toDouble(),
      );
    }

  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static bool appStatesAreTheSame({
    @required AppState stateA,
    @required AppState stateB,
}){
    bool _areTheSame = false;

    if (stateA != null && stateB != null){

      if (
      stateA.id == stateB.id
      &&
      stateA.appVersion == stateB.appVersion
      &&
          stateA.keywordsChainVersion == stateB.keywordsChainVersion
      &&
          stateA.ldbVersion == stateB.ldbVersion
      &&
          stateA.phrasesVersion == stateB.phrasesVersion
      &&
          stateA.specPickersVersion == stateB.specPickersVersion
      &&
          stateA.specsChainVersion == stateB.specsChainVersion
      &&
        stateA.appControlsVersion == stateB.appControlsVersion
      ){
        _areTheSame = true;
      }

    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static AppState dummyAppState(){
    return const AppState(
      id: 'dummy',
      keywordsChainVersion: 0,
      specsChainVersion: 0,
      specPickersVersion: 0,
      phrasesVersion: 0,
      appVersion: '0.0.0',
      ldbVersion: 0,
      appControlsVersion: 0,
    );
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// -----------------------------------
  /// TESTED : WORKS PERFECT
  void blogAppState(){
    blog('AppState is : -------------------- START');
    blog('id : $id');
    blog('keywordsChainVersion : $keywordsChainVersion');
    blog('specsChainVersion : $specsChainVersion');
    blog('specPickersVersion : $specPickersVersion');
    blog('phrasesVersion : $phrasesVersion');
    blog('appVersion : $appVersion');
    blog('ldbVersion : $ldbVersion');
    blog('appControlsVersion : $appControlsVersion');
    blog('AppState ------------------------ END');
  }
// -----------------------------------------------------------------------------
}
