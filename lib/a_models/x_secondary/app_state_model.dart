import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
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
