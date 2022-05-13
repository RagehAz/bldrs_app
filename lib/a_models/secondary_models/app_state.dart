import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

/// IS SUB USER MODEL THAT COMPARES STATE WITH GLOBAL DB STATE MODIFIED FROM DASHBOARD
/// OR AUTOMATICALLY WHEN CHANGING DATA THAT ARE SAVED ON LDB, IN ORDER TO RE FETCH THE DATA
class AppState {
// -----------------------------------------------------------------------------
  AppState({
    @required this.keywordsChainVersion,
    @required this.specsChainVersion,
    @required this.specPickersVersion,

    @required this.phrasesVersion,

    @required this.appVersion,
    @required this.ldbVersion,

  });
// -----------------------------------------------------------------------------
  /// chains
  final double keywordsChainVersion;
  final double specsChainVersion;
  final double specPickersVersion;

  /// phrases
  final double phrasesVersion;

  /// app update
  final double appVersion;
  final double ldbVersion; /// this used to wipe out all LDB docs and re fetch everything

// -----------------------------------------------------------------------------

  /// CLONING

// -----------------------------------
  /// TESTED : WORKS PERFECT
  AppState copyWith({
    double keywordsChainVersion,
    double specsChainVersion,
    double specPickersVersion,
    double phrasesVersion,
    double appVersion,
    double ldbVersion,
}){
    return AppState(
      keywordsChainVersion: keywordsChainVersion ?? this.keywordsChainVersion,
      specPickersVersion: specPickersVersion ?? this.specPickersVersion,
      specsChainVersion: specsChainVersion ?? this.specsChainVersion,

      phrasesVersion: phrasesVersion ?? this.phrasesVersion,

      appVersion: appVersion ?? this.appVersion,
      ldbVersion: ldbVersion?? this.ldbVersion,

    );
}
// -----------------------------------------------------------------------------

  /// INITIALIZATION

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static AppState initialState() {
    return AppState(
      keywordsChainVersion : null,
      specsChainVersion : null,
      specPickersVersion : null,
      phrasesVersion : null,
      appVersion : null,
      ldbVersion : null,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// -----------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keywordsChainVersion' : keywordsChainVersion,
      'specsChainVersion' : specsChainVersion,
      'specPickersVersion' : specPickersVersion,
      'phrasesVersion' : phrasesVersion,
      'appVersion' : appVersion,
      'ldbVersion' : ldbVersion,
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
        keywordsChainVersion : map['keywordsChainVersion'],
        specsChainVersion : map['specsChainVersion'],
        specPickersVersion : map['specPickersVersion'],
        phrasesVersion : map['phrasesVersion'],
        appVersion : map['appVersion'],
        ldbVersion : map['ldbVersion'],
      );
    }

  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// -----------------------------------
  /// TESTED : WORKS PERFECT
  static AppState dummyAppState(){
    return AppState(
      keywordsChainVersion: 0,
      specsChainVersion: 0,
      specPickersVersion: 0,
      phrasesVersion: 0,
      appVersion: 0,
      ldbVersion: 0,
    );
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// -----------------------------------
  /// TESTED : WORKS PERFECT
  void blogAppState(){
    blog('AppState is : -------------------- START');
    blog('keywordsChainVersion : $keywordsChainVersion');
    blog('specsChainVersion : $specsChainVersion');
    blog('specPickersVersion : $specPickersVersion');
    blog('phrasesVersion : $phrasesVersion');
    blog('appVersion : $appVersion');
    blog('ldbVersion : $ldbVersion');
    blog('AppState ------------------------ END');
  }
// -----------------------------------------------------------------------------
}
