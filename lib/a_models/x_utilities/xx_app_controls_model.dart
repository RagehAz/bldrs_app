import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class AppControlsModel {
  /// --------------------------------------------------------------------------
  const AppControlsModel({
    @required this.id,
    @required this.showAllFlyersInHome,
  });
  /// --------------------------------------------------------------------------
  final bool showAllFlyersInHome;
  final String id;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String appControlsID = 'appControls';
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TAMAM : WORKS PERFECT
  AppControlsModel copyWith({
    bool showAllFlyersInHome,
    String id,
  }){

    return AppControlsModel(
      id: id ?? this.id,
      showAllFlyersInHome: showAllFlyersInHome ?? this.showAllFlyersInHome,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  /// TAMAM : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'id': appControlsID,
      'showAllFlyersInHome' : showAllFlyersInHome,
    };
  }
  // --------------------
  /// TAMAM : WORKS PERFECT
  static AppControlsModel decipherAppControlsModel(Map<String, dynamic> map){

    AppControlsModel _model;

    if (map != null){
      _model = AppControlsModel(
        id: appControlsID,
        showAllFlyersInHome: map['showAllFlyersInHome'],
      );
    }

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TAMAM : WORKS PERFECT
  static bool checkAppControlsModelsAreIdentical({
    @required AppControlsModel model1,
    @required AppControlsModel model2,
  }) {
    bool _output = false;

    if (model1 != null && model2 != null) {
      _output =
          model1.showAllFlyersInHome == model2.showAllFlyersInHome &&
          model1.id == model2.id;
    }

    return _output;
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
    if (other is AppControlsModel){
      _areIdentical = checkAppControlsModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      showAllFlyersInHome.hashCode;
  // -----------------------------------------------------------------------------
}
