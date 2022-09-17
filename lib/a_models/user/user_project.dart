import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum MissionType {
  seekProperty,
  planConstruction,
  finishConstruction,
  furnish,
  offerProperty,
}

@immutable
class MissionModel {
  /// --------------------------------------------------------------------------
  const MissionModel({
    @required this.missionType,
    @required this.scope,
    @required this.zone,
    @required this.position,
    @required this.description,
    @required this.flyerIDs,
    @required this.bzzIDs,
  });
  /// --------------------------------------------------------------------------
  final MissionType missionType;
  final List<String> scope;
  final ZoneModel zone;
  final GeoPoint position;
  final String description;
  final List<String> flyerIDs;
  final List<String> bzzIDs;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  static MissionModel createInitialMission(){
    return null;
  }
  // --------------------
  ///
  static Future<MissionModel> prepareMissionForEditing({
    @required BuildContext context,
    @required MissionModel mission,
  }) async {

    return mission.copyWith(
      zone: await ZoneModel.prepareZoneForEditing(
          context: context,
          zoneModel: mission.zone,
      ),
    );

  }
  // --------------------
  ///
  static MissionModel bakeEditorVariablesToUpload({
    @required BuildContext context,
    @required MissionModel oldMission,
    @required MissionModel tempMission,
  }){

    return tempMission;

  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  MissionModel copyWith({
    MissionType missionType,
    List<String> scope,
    ZoneModel zone,
    GeoPoint position,
    String description,
    List<String> flyerIDs,
    List<String> bzzIDs,
  }){
    return MissionModel(
      missionType: missionType ?? this.missionType,
      scope: scope ?? this.scope,
      zone: zone ?? this.zone,
      position: position ?? this.position,
      description: description ?? this.description,
      flyerIDs: flyerIDs ?? this.flyerIDs,
      bzzIDs: bzzIDs ?? this.bzzIDs,
    );
  }
  // --------------------
  ///
  MissionModel nullifyField({
    bool missionType = false,
    bool scope = false,
    bool zone = false,
    bool position = false,
    bool description = false,
    bool flyerIDs = false,
    bool bzzIDs = false,
  }){
    return MissionModel(
      missionType: missionType == true ? null : this.missionType,
      scope: scope == true ? null : this.scope,
      zone: zone == true ? null : this.zone,
      position: position == true ? null : this.position,
      description: description == true ? null : this.description,
      flyerIDs: flyerIDs == true ? null : this.flyerIDs,
      bzzIDs: bzzIDs == true ? null : this.bzzIDs,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return {
      'missionType': cipherMissionType(missionType),
      'scope': scope,
      'zone': zone?.toMap(),
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'description': description,
      'flyerIDs': flyerIDs,
      'bzzIDs': bzzIDs,
    };
  }
  // --------------------
  ///
  static MissionModel decipherMission({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }){
    MissionModel _mission;

    if (map != null){
      _mission = MissionModel(
        missionType: decipherMissionType(map['missionType']),
        scope: Stringer.getStringsFromDynamics(dynamics: map['scope']),
        zone: ZoneModel.decipherZone(map['zone']),
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        description: map['description'],
        flyerIDs: Stringer.getStringsFromDynamics(dynamics: map['flyerIDs']),
        bzzIDs: Stringer.getStringsFromDynamics(dynamics: map['bzzIDs']),
      );
    }

    return _mission;
  }
  // -----------------------------------------------------------------------------

  /// MISSION TYPE CYPHERS

  // --------------------
  ///
  static String cipherMissionType(MissionType type){
    switch (type) {
      case MissionType.seekProperty :       return 'seekProperty'; break;
      case MissionType.planConstruction :   return 'planConstruction'; break;
      case MissionType.finishConstruction : return 'finishConstruction'; break;
      case MissionType.furnish :            return 'furnish'; break;
      case MissionType.offerProperty :      return 'offerProperty'; break;
      default:return null;
    }
  }
  // --------------------
  ///
  static MissionType decipherMissionType(String type){
    switch (type) {
      case 'seekProperty' :       return  MissionType.seekProperty; break;
      case 'planConstruction' :   return  MissionType.planConstruction; break;
      case 'finishConstruction' : return  MissionType.finishConstruction; break;
      case 'furnish' :            return  MissionType.furnish; break;
      case 'offerProperty' :      return  MissionType.offerProperty; break;
      default:return null;
    }
  }
// -----------------------------------------------------------------------------
}
