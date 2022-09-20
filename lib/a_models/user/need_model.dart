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
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
    @required this.zone,
    @required this.notes,
    @required this.flyerIDs,
    @required this.bzzIDs,
    @required this.scope,
    @required this.location,
  });
  /// --------------------------------------------------------------------------
  final NeedType needType;
  final List<String> scope;
  final ZoneModel zone;
  final GeoPoint location;
  final String notes;
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
      location: null,
      notes: '',
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
  /// TESTED : WORKS PERFECT
  NeedModel copyWith({
    NeedType needType,
    List<String> scope,
    ZoneModel zone,
    GeoPoint location,
    String notes,
    List<String> flyerIDs,
    List<String> bzzIDs,
  }){
    return NeedModel(
      needType: needType ?? this.needType,
      scope: scope ?? this.scope,
      zone: zone ?? this.zone,
      location: location ?? this.location,
      notes: notes ?? this.notes,
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
    bool location = false,
    bool notes = false,
    bool flyerIDs = false,
    bool bzzIDs = false,
  }){
    return NeedModel(
      needType: needType == true ? null : this.needType,
      scope: scope == true ? null : this.scope,
      zone: zone == true ? null : this.zone,
      location: location == true ? null : this.location,
      notes: notes == true ? null : this.notes,
      flyerIDs: flyerIDs == true ? null : this.flyerIDs,
      bzzIDs: bzzIDs == true ? null : this.bzzIDs,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return {
      'needType': cipherNeedType(needType),
      'scope': scope,
      'zone': zone?.toMap(),
      'location': Atlas.cipherGeoPoint(point: location, toJSON: toJSON),
      'notes': notes,
      'flyerIDs': flyerIDs,
      'bzzIDs': bzzIDs,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
        location: Atlas.decipherGeoPoint(point: map['location'], fromJSON: fromJSON),
        notes: map['notes'],
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
  static const List<NeedType> needsTypes = <NeedType>[
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
    Casing casing = Casing.non,
  }){
    final List<Verse> _output = <Verse>[];

    if (Mapper.checkCanLoopList(needsTypes) == true){

      for (final NeedType type in needsTypes){

        final Verse _verse = Verse(
          text: getNeedTypePhid(type),
          translate: true,
          casing: casing,
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

  /// CHECKERS

  // --------------------
  static bool checkNeedsAreIdentical(NeedModel need1, NeedModel need2){
    bool _identical = false;

    if (need1 == null && need2 == null){
      _identical = true;
    }

    else if (need1 != null && need2 != null){

      if (
          need1.needType == need2.needType &&
          ZoneModel.checkZonesAreIdentical(zone1: need1.zone, zone2: need2.zone) == true &&
          need1.notes == need2.notes &&
          Mapper.checkListsAreIdentical(list1: need1.flyerIDs , list2: need2.flyerIDs) == true &&
          Mapper.checkListsAreIdentical(list1: need1.bzzIDs , list2: need2.bzzIDs) == true &&
          Mapper.checkListsAreIdentical(list1: need1.scope , list2: need2.scope) == true &&
          Atlas.checkPointsAreIdentical(point1: need1.location, point2: need2.location) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  /// TESTED : WORKS PERFECT
  static NeedModel dummyNeed(BuildContext context){

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

    return NeedModel(
      needType: NeedType.finishConstruction,
      notes: 'This is a need description, and my need is to reach all countries',
      zone: ZoneModel.dummyZone(),
      scope: SpecModel.getSpecsIDs(SpecModel.dummySpecs()),
      bzzIDs: _userModel.followedBzzIDs,
      flyerIDs: _userModel.savedFlyersIDs,
      location: Atlas.dummyLocation(),
    );

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogNeed(){
    blog('needType : $needType');
    blog('zone : $zone');
    blog('description : $notes');
    blog('flyerIDs : $flyerIDs');
    blog('bzzIDs : $bzzIDs');
    blog('scope : $scope');
    blog('position : $location');
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
    if (other is NeedModel){
      _areIdentical = checkNeedsAreIdentical(this, other,);
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      needType.hashCode^
      zone.hashCode^
      notes.hashCode^
      flyerIDs.hashCode^
      bzzIDs.hashCode^
      scope.hashCode^
      location.hashCode;
  // -----------------------------------------------------------------------------
}
