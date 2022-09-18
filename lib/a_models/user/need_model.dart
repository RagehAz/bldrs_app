import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum NeedType {
  seekProperty,
  planConstruction,
  finishConstruction,
  furnish,
  offerProperty,
}

@immutable
class NeedModel {
  /// --------------------------------------------------------------------------
  const NeedModel({
    @required this.needType,
    @required this.scope,
    @required this.zone,
    @required this.position,
    @required this.description,
    @required this.flyerIDs,
    @required this.bzzIDs,
  });
  /// --------------------------------------------------------------------------
  final NeedType needType;
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
  static NeedModel createInitialNeed({
    @required BuildContext context,
    @required ZoneModel userZone,
  }){
    return NeedModel(
      needType: null,
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
  static Future<NeedModel> prepareNeedForEditing({
    @required BuildContext context,
    @required NeedModel need,
  }) async {

    return need.copyWith(
      zone: await ZoneModel.prepareZoneForEditing(
          context: context,
          zoneModel: need.zone,
      ),
    );

  }
  // --------------------
  ///
  static NeedModel bakeEditorVariablesToUpload({
    @required BuildContext context,
    @required NeedModel oldNeed,
    @required NeedModel tempNeed,
  }){

    return tempNeed;

  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  NeedModel copyWith({
    NeedType needType,
    List<String> scope,
    ZoneModel zone,
    GeoPoint position,
    String description,
    List<String> flyerIDs,
    List<String> bzzIDs,
  }){
    return NeedModel(
      needType: needType ?? this.needType,
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
  NeedModel nullifyField({
    bool needType = false,
    bool scope = false,
    bool zone = false,
    bool position = false,
    bool description = false,
    bool flyerIDs = false,
    bool bzzIDs = false,
  }){
    return NeedModel(
      needType: needType == true ? null : this.needType,
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
      'needType': cipherNeedType(needType),
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
  static NeedModel decipherNeed({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }){
    NeedModel _need;

    if (map != null){
      _need = NeedModel(
        needType: decipherNeedType(map['needType']),
        scope: Stringer.getStringsFromDynamics(dynamics: map['scope']),
        zone: ZoneModel.decipherZone(map['zone']),
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        description: map['description'],
        flyerIDs: Stringer.getStringsFromDynamics(dynamics: map['flyerIDs']),
        bzzIDs: Stringer.getStringsFromDynamics(dynamics: map['bzzIDs']),
      );
    }

    return _need;
  }
  // -----------------------------------------------------------------------------

  /// NEED TYPE CYPHERS

  // --------------------
  ///
  static String cipherNeedType(NeedType type){
    switch (type) {
      case NeedType.seekProperty :       return 'seekProperty'; break;
      case NeedType.planConstruction :   return 'planConstruction'; break;
      case NeedType.finishConstruction : return 'finishConstruction'; break;
      case NeedType.furnish :            return 'furnish'; break;
      case NeedType.offerProperty :      return 'offerProperty'; break;
      default:return null;
    }
  }
  // --------------------
  ///
  static NeedType decipherNeedType(String type){
    switch (type) {
      case 'seekProperty' :       return  NeedType.seekProperty; break;
      case 'planConstruction' :   return  NeedType.planConstruction; break;
      case 'finishConstruction' : return  NeedType.finishConstruction; break;
      case 'furnish' :            return  NeedType.furnish; break;
      case 'offerProperty' :      return  NeedType.offerProperty; break;
      default:return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// STANDARDS

  // --------------------
  static const List<NeedType> needsType = <NeedType>[
    NeedType.seekProperty,
    NeedType.planConstruction,
    NeedType.finishConstruction,
    NeedType.furnish,
    NeedType.offerProperty,
  ];
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------

  static String getNeedTypePhid(NeedType type){
    switch (type) {
      case NeedType.seekProperty :       return 'phid_seekProperty'; break;
      case NeedType.planConstruction :   return 'phid_planConstruction'; break;
      case NeedType.finishConstruction : return 'phid_finishConstruction'; break;
      case NeedType.furnish :            return 'phid_furnish'; break;
      case NeedType.offerProperty :      return 'phid_offerProperty'; break;
      default:return null;
    }
  }
  // --------------------

  static List<Verse> getNeedsTypesVerses({
    @required List<NeedType> needsTypes,
    @required BuildContext context,
  }){
    final List<Verse> _output = <Verse>[];

    if (Mapper.checkCanLoopList(needsTypes) == true){

      for (final NeedType type in needsTypes){

        final Verse _verse = Verse(
          text: getNeedTypePhid(type),
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
  static List<FlyerType> concludeFlyersTypesByNeedType(NeedType type){
    switch (type) {

      case NeedType.seekProperty :
        return <FlyerType>[FlyerType.property]; break;

      case NeedType.planConstruction :
        return <FlyerType>[FlyerType.design, FlyerType.product]; break;

      case NeedType.finishConstruction :
        return <FlyerType>[FlyerType.project, FlyerType.product, FlyerType.equipment, FlyerType.trade,]; break;

      case NeedType.furnish :
        return <FlyerType>[FlyerType.product, FlyerType.trade]; break;

      case NeedType.offerProperty :
        return <FlyerType>[FlyerType.property];break;

      default:return null;
    }
  }
  // --------------------
  ///
  static List<BzType> concludeBzzTypesByNeedType(NeedType type){
    switch (type) {

      case NeedType.seekProperty :
        return <BzType>[BzType.developer, BzType.broker]; break;

      case NeedType.planConstruction :
        return <BzType>[BzType.designer, BzType.contractor, BzType.supplier,]; break;

      case NeedType.finishConstruction :
        return <BzType>[BzType.designer, BzType.contractor, BzType.supplier, BzType.artisan,]; break;

      case NeedType.furnish :
        return <BzType>[BzType.supplier, BzType.contractor]; break;

      case NeedType.offerProperty :
        return <BzType>[BzType.broker];break;

      default:return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  static NeedModel dummyNeed(BuildContext context){

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

    return NeedModel(
      needType: NeedType.finishConstruction,
      description: 'This is a need description, and my need is to reach all countries',
      zone: ZoneModel.dummyZone(),
      scope: SpecModel.getSpecsIDs(SpecModel.dummySpecs()),
      bzzIDs: _userModel.followedBzzIDs,
      flyerIDs: _userModel.savedFlyersIDs,
      position: Atlas.dummyLocation(),
    );

  }
// -----------------------------------------------------------------------------
}
