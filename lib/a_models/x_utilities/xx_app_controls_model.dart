import 'package:flutter/material.dart';

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
  ///
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
  ///
  Map<String, dynamic> toMap(){
    return {
      'id': appControlsID,
      'showAllFlyersInHome' : showAllFlyersInHome,
    };
  }
  // --------------------
  ///
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
  ///
  static bool checkAppControlsModelsAreIdentical({
    @required AppControlsModel model1,
    @required AppControlsModel model2,
  }) {
    bool _output = false;

    if (model1 != null && model2 != null) {
      _output = model1.showAllFlyersInHome == model2.showAllFlyersInHome;
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
