import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
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
    required this.minVersion,
    required this.ldbVersion,
    required this.bldrsIsOnline,
  });
  // -----------------------------------------------------------------------------
  final String? appVersion;
  final String? minVersion;
  final int? ldbVersion;
  final bool bldrsIsOnline;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AppStateModel copyWith({
    String? appVersion,
    String? minVersion,
    int? ldbVersion,
    bool? bldrsIsOnline,
  }){
    return AppStateModel(
      appVersion: appVersion ?? this.appVersion,
      minVersion: minVersion ?? this.minVersion,
      ldbVersion: ldbVersion?? this.ldbVersion,
      bldrsIsOnline: bldrsIsOnline ?? this.bldrsIsOnline,
    );
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AppStateModel> createInitialModel() async {

    final String _detectedAppVersion = await AppVersionBuilder.detectAppVersion();
    final AppStateModel? _globalState = await AppStateFireOps.readGlobalAppState();

    return AppStateModel(
      appVersion : _detectedAppVersion,
      minVersion: '0.0.0',
      ldbVersion : _globalState?.ldbVersion ?? 0,
      bldrsIsOnline: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    required bool toUserModel,
  }) {

    /// BASIC USER MODEL MAP
    Map<String, dynamic> _map = <String, dynamic>{
      'appVersion' : appVersion,
      'ldbVersion' : ldbVersion,
    };


    if (toUserModel == false){
      _map = Mapper.insertMapInMap(
        baseMap: _map,
        insert: <String, dynamic>{
          'minVersion': minVersion,
          'bldrsIsOnline' : bldrsIsOnline,
        },
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AppStateModel? fromMap({
    required Map<String, dynamic>? map,
  }) {

    if (map == null) {
      return null;
    }

    else {

      final AppStateModel _model = AppStateModel(
        appVersion : map['appVersion'],
        minVersion: map['minVersion'],
        ldbVersion : map['ldbVersion']?.toInt(),
        bldrsIsOnline : map['bldrsIsOnline'] ?? true,
      );

      return _model;
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
  /// AI TESTED
  static bool versionIsBigger({
    required String? thisIsBigger,
    required String? thanThis,
  }){

    /// THEY COME IN THIS FORM 0.0.0
    /// AND ONLY NEED TO UPDATE IF GLOBAL IS BIGGER THAN THE SMALLER

    bool _isBigger = false;

    final bool _globalVersionIsValid = appVersionIsValid(thisIsBigger);
    final bool _localVersionIsValid = appVersionIsValid(thanThis);

    if (_globalVersionIsValid == true && _localVersionIsValid == true){

      final int _bigger = getAppVersionNumbered(thisIsBigger!)!;
      final int _thanThis = getAppVersionNumbered(thanThis!)!;

      _isBigger = _bigger > _thanThis;

    }


    return _isBigger;
  }
  // --------------------
  /// AI TESTED
  static bool appVersionIsValid(String? version) {

    if (version == null) {
      return false;
    }

    else {
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
      appVersion: '4.2.3',
      minVersion: '0.1.5',
      ldbVersion: 0,
      bldrsIsOnline: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogAppState({String invoker = ''}){
    blog('APP STATE : appVersion : $appVersion : minVersion : $minVersion : ldbVersion : $ldbVersion : bldrsIsOnline : $bldrsIsOnline');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAppStatesAreIdentical({
    required AppStateModel? state1,
    required AppStateModel? state2,
    required bool isInUserModel,
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

        if (isInUserModel == true){
          _identical = true;
        }

        else if (
            state1.minVersion == state2.minVersion &&
            state1.bldrsIsOnline == state2.bldrsIsOnline
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
   @override
   String toString() =>
       '''
       AppStateModel(
          appVersion : $appVersion,
          ldbVersion : $ldbVersion,
          bldrsIsOnline : $bldrsIsOnline,
          minVersion : $minVersion,
       )  
       ''';
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
        isInUserModel: false,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      appVersion.hashCode^
      bldrsIsOnline.hashCode^
      minVersion.hashCode^
      ldbVersion.hashCode;
  // -----------------------------------------------------------------------------
}
