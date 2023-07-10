import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_real_ops.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class AppStateModel {
  // -----------------------------------------------------------------------------
  /// IS SUB USER MODEL THAT COMPARES STATE WITH GLOBAL DB STATE MODIFIED FROM DASHBOARD
  /// OR AUTOMATICALLY WHEN CHANGING DATA THAT ARE SAVED ON LDB, IN ORDER TO RE FETCH THE DATA
  // -----------------------------------------------------------------------------
  const AppStateModel({
    required this.appVersion,
    required this.ldbVersion,
  });
  // -----------------------------------------------------------------------------
  final String? appVersion;
  final int? ldbVersion;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AppStateModel copyWith({
    String? appVersion,
    int? ldbVersion,
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
  static Future<AppStateModel> createInitialModel() async {

    final String _detectedAppVersion = await AppVersionBuilder.detectAppVersion();
    final AppStateModel? _globalState = await AppStateRealOps.readGlobalAppState();

    return AppStateModel(
      appVersion : _detectedAppVersion,
      ldbVersion : _globalState?.ldbVersion ?? 0,
    );

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
  static AppStateModel? fromMap(Map<String, dynamic>? map) {

    if (map == null) {
      return null;
    }

    else {

      return AppStateModel(
        appVersion : map['appVersion'],
        ldbVersion : map['ldbVersion']?.toInt(),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// VERSION DIVISIONS

  // --------------------
  /*
  /// TESTED : WORKS PERFECTLY
  static bool appVersionIsInSync({
    required String globalVersion,
    required String userVersion,
    required String detectedVersion,
  }){
    return
        globalVersion == userVersion &&
        globalVersion == detectedVersion &&
        userVersion == detectedVersion;
  }

    static List<int> fixVersionDivisions(List<int> divs){
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
  // --------------------
  /// AI TESTED
  static int? getAppVersionNumbered(String version){
    int? _output;

    final bool _appVersionIsValid = appVersionIsValid(version);

    if (_appVersionIsValid == true){


      final String _removedBuildNumber = TextMod.removeTextAfterLastSpecialCharacter(
        text: version,
          specialCharacter: '+',
      )!;

      final List<String> _strings = _removedBuildNumber.split('.');

      final String _rejoined = '${_strings[0]}${_strings[1]}${_strings[2]}';
      _output = Numeric.transformStringToInt(_rejoined);

    }

    return _output;
  }
  // --------------------
  /// TASK TEST ME
  static bool userNeedToUpdateApp({
    required String? globalVersion,
    required String? localVersion,
  }){

    /// THEY COME IN THIS FORM 0.0.0
    /// AND ONLY NEED TO UPDATE IF GLOBAL IS BIGGER THAN THE SMALLER

    bool _shouldUpdate = false;

    final bool _globalVersionIsValid = appVersionIsValid(globalVersion);
    final bool _localVersionIsValid = appVersionIsValid(localVersion);

    if (_globalVersionIsValid == true && _localVersionIsValid == true){

      final int _global = getAppVersionNumbered(globalVersion!)!;
      final int _local = getAppVersionNumbered(localVersion!)!;

      _shouldUpdate = _global > _local;

    }


    return _shouldUpdate;
  }
  // --------------------
  /// AI TESTED
static bool appVersionIsValid(String? version) {
  if (version == null) {
    return false;
  } else {
    const pattern = r'^\d+\.\d+\.\d+(\+\d+)?$';
    final regex = RegExp(pattern);
    return regex.hasMatch(version);
  }
}
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
    required AppStateModel? state1,
    required AppStateModel? state2,
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
