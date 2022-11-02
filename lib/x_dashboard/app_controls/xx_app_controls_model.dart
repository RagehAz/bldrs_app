import 'package:flutter/material.dart';

class AppControlsModel {
  /// --------------------------------------------------------------------------
  const AppControlsModel({
    @required this.id,
    @required this.showOnlyVerifiedFlyersInHomeWall, /// fakes maloosh lazma khalas, we always show only verified flyers
  });
  /// --------------------------------------------------------------------------
  final bool showOnlyVerifiedFlyersInHomeWall;
  final String id;

  static const String appControlsID = 'appControls';
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  AppControlsModel copyWith({
    bool showOnlyVerifiedFlyersInHomeWall,
    String id,
  }){

    return AppControlsModel(
      id: id ?? this.id,
      showOnlyVerifiedFlyersInHomeWall: showOnlyVerifiedFlyersInHomeWall ?? this.showOnlyVerifiedFlyersInHomeWall,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  Map<String, dynamic> toMap(){
    return {
      'id': appControlsID,
      'showOnlyVerifiedFlyersInHomeWall' : showOnlyVerifiedFlyersInHomeWall,
    };
  }
  // --------------------
  static AppControlsModel decipherAppControlsModel(Map<String, dynamic> map){

    AppControlsModel _model;

    if (map != null){
      _model = AppControlsModel(
        id: appControlsID,
        showOnlyVerifiedFlyersInHomeWall: map['showOnlyVerifiedFlyersInHomeWall'],
      );
    }

    return _model;
  }
  // -----------------------------------------------------------------------------
}
