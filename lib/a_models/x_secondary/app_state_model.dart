import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
/// => TAMAM
@immutable
class AppStateModel {
  // -----------------------------------------------------------------------------
  /// IS SUB USER MODEL THAT COMPARES STATE WITH GLOBAL DB STATE MODIFIED FROM DASHBOARD
  /// OR AUTOMATICALLY WHEN CHANGING DATA THAT ARE SAVED ON LDB, IN ORDER TO RE FETCH THE DATA
  // -----------------------------------------------------------------------------
  const AppStateModel({
    @required this.appVersion,
    @required this.ldbVersion,
  });
  // -----------------------------------------------------------------------------
  final String appVersion;
  final int ldbVersion;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AppStateModel copyWith({
    String appVersion,
    int ldbVersion,
  }){
    return AppStateModel(
      appVersion: appVersion ?? this.appVersion,
      ldbVersion: ldbVersion?? this.ldbVersion,
    );
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static AppStateModel initialState() {
    return const AppStateModel(
      appVersion : null,
      ldbVersion : null,
    );
  }
  // -----------------------------------------------------------------------------

  /// APP VERSION

  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<String> detectAppVersion() async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    if (DeviceChecker.deviceIsAndroid() == true){
      return _packageInfo.version;
    }
    else if (DeviceChecker.deviceIsIOS() == true){
      return _packageInfo.buildNumber;
    }
    else {
      return _packageInfo.version;
    }
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appVersion' : appVersion,
      'ldbVersion' : ldbVersion,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AppStateModel fromMap(Map<String, dynamic> map) {

    if (map == null) {
      return null;
    }

    else {

      return AppStateModel(
        appVersion : map['appVersion'],
        ldbVersion : map['ldbVersion'],
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// VERSION DIVISIONS

  // --------------------
  /*
  /// TESTED : WORKS PERFECTLY
  static bool appVersionIsInSync({
    @required String globalVersion,
    @required String userVersion,
    @required String detectedVersion,
  }){
    return
        globalVersion == userVersion &&
        globalVersion == detectedVersion &&
        userVersion == detectedVersion;
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECTLY
  static List<int> _getAppVersionDivisions(String version){
    final List<int> _divisions = <int>[];

    // blog('_getAppVersionDivisions : version : $version');

    if (version != null){
      final String _removedBuildNumber = TextMod.removeTextAfterLastSpecialCharacter(version, '+');

      final List<String> _strings = _removedBuildNumber.split('.');

      for (final String string in _strings){

        final int _int = Numeric.transformStringToInt(string);

        _divisions.add(_int);
      }
    }

    return _fixDivisions(_divisions);
  }
   */
  // --------------------
  /*
  static List<int> _fixDivisions(List<int> divs){
    List<int> _output = <int>[];

    if (Mapper.checkCanLoopList(divs) == true){

      if (divs.length == 3){
        _output = divs;
      }
      else if (divs.length > 3){
        _output = [divs[0], divs[1], divs[2]];
      }
      else {
        _output = <int>[0,0,0];
        for (int i = 0; i < divs.length; i++){
          _output.removeAt(i);
          _output.insert(i, divs[i]);
        }
      }

    }
    else {
      _output = [0,0,0];
    }

    return _output;
  }
   */
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static AppStateModel dummyAppState(){
    return const AppStateModel(
      appVersion: '0.0.0',
      ldbVersion: 0,
    );
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogAppState({String invoker = ''}){
    blog('APP STATE : appVersion : $appVersion : ldbVersion : $ldbVersion');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAppStatesAreIdentical({
    @required AppStateModel state1,
    @required AppStateModel state2,
  }){
    bool _identical = false;

    if (state1 == null && state2 == null){
      _identical = true;
    }

    else if (state1 != null && state2 != null){

      if (
          state1.appVersion == state2.appVersion &&
          state1.ldbVersion == state2.ldbVersion
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => 'APP STATE : appVersion : $appVersion : ldbVersion : $ldbVersion';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is AppStateModel){
      _areIdentical = checkAppStatesAreIdentical(
        state1: this,
        state2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      appVersion.hashCode^
      ldbVersion.hashCode;
  // -----------------------------------------------------------------------------
}
