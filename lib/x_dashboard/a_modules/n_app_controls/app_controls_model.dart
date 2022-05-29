import 'package:flutter/material.dart';

class AppControlsModel {
  /// --------------------------------------------------------------------------
  AppControlsModel({
    @required this.showOnlyVerifiedFlyersInHomeWall,
});
  /// --------------------------------------------------------------------------
  final bool showOnlyVerifiedFlyersInHomeWall;
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  AppControlsModel copyWith({
    bool showOnlyVerifiedFlyersInHomeWall
  }){

    return AppControlsModel(
      showOnlyVerifiedFlyersInHomeWall: showOnlyVerifiedFlyersInHomeWall ?? this.showOnlyVerifiedFlyersInHomeWall,
    );

  }
// -----------------------------------------------------------------------------

/// CYPHER

// -------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'showOnlyVerifiedFlyersInHomeWall' : showOnlyVerifiedFlyersInHomeWall,
    };
  }
// -------------------------------------
  static AppControlsModel decipherAppControlsModel(Map<String, dynamic> map){

    AppControlsModel _model;

    if (map != null){
      _model = AppControlsModel(
          showOnlyVerifiedFlyersInHomeWall: map['showOnlyVerifiedFlyersInHomeWall'],
      );
    }

    return _model;
  }
// -----------------------------------------------------------------------------
}
