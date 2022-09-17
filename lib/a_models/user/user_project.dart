import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
  static MissionModel createInitialMission({
    @required BuildContext context,
  @required ZoneModel userZone,
}){
    return MissionModel(
      missionType: null,
      scope: const [],
      zone: userZone ?? ZoneProvider.proGetCurrentZone(context: context, listen: false),
      position: null,
      description: '',
      flyerIDs: const [],
      bzzIDs: const [],
    );
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

  /// STANDARDS

  // --------------------
  static const List<MissionType> missionsTypes = <MissionType>[
    MissionType.seekProperty,
    MissionType.planConstruction,
    MissionType.finishConstruction,
    MissionType.furnish,
    MissionType.offerProperty,
  ];
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------

  static String getMissionTypePhid(MissionType type){
    switch (type) {
      case MissionType.seekProperty :       return 'phid_seekProperty'; break;
      case MissionType.planConstruction :   return 'phid_planConstruction'; break;
      case MissionType.finishConstruction : return 'phid_finishConstruction'; break;
      case MissionType.furnish :            return 'phid_furnish'; break;
      case MissionType.offerProperty :      return 'phid_offerProperty'; break;
      default:return null;
    }
  }
  // --------------------

  static List<Verse> getMissionTypesVerses({
    @required List<MissionType> missionsTypes,
    @required BuildContext context,
  }){
    final List<Verse> _output = <Verse>[];

    if (Mapper.checkCanLoopList(missionsTypes) == true){

      for (final MissionType type in missionsTypes){

        final Verse _verse = Verse(
          text: getMissionTypePhid(type),
          translate: true,
        );
        _output.add(_verse);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  ///
  static List<FlyerType> concludeFlyersTypesByMissionType(MissionType type){
    switch (type) {

      case MissionType.seekProperty :
        return <FlyerType>[FlyerType.property]; break;

      case MissionType.planConstruction :
        return <FlyerType>[FlyerType.design, FlyerType.product]; break;

      case MissionType.finishConstruction :
        return <FlyerType>[FlyerType.project, FlyerType.product, FlyerType.equipment, FlyerType.trade,]; break;

      case MissionType.furnish :
        return <FlyerType>[FlyerType.product, FlyerType.trade]; break;

      case MissionType.offerProperty :
        return <FlyerType>[FlyerType.property];break;

      default:return null;
    }
  }
  // --------------------
  ///
  static List<BzType> concludeBzzTypesByMissionType(MissionType type){
    switch (type) {

      case MissionType.seekProperty :
        return <BzType>[BzType.developer, BzType.broker]; break;

      case MissionType.planConstruction :
        return <BzType>[BzType.designer, BzType.contractor, BzType.supplier,]; break;

      case MissionType.finishConstruction :
        return <BzType>[BzType.designer, BzType.contractor, BzType.supplier, BzType.artisan,]; break;

      case MissionType.furnish :
        return <BzType>[BzType.supplier, BzType.contractor]; break;

      case MissionType.offerProperty :
        return <BzType>[BzType.broker];break;

      default:return null;
    }
  }

// -----------------------------------------------------------------------------
}
