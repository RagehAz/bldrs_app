import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
// --------------------------------------------------------------------------

/// NOTES:-

// --------------------
/// ZONE :
///   - Either Country - City - District
///
/// ACTIVE ZONE
///   - is a zone that has certain amount of flyers and bzz to be visible to users
///
/// PUBLIC ZONE
///   - is a zone that reached a stage that can be visible to other zones
///
/// ACTIVE CITY
///   - is a city that has certain amount of flyers and bzz to be visible to users
///
/// ACTIVE COUNTRY
///   - is a country that has atleast 1 active city
///
/// PUBLIC CITY
///   - is a city that reached a stage that can be visible to other cities
///
/// PUBLIC COUNTRY
///   - is a country that has atleast 1 public city
///
/// BZ ZONING POLICY
///  - ( Existence ) : Bz can only be in one zone at a time
///  - ( Creation )  : Bz can be created in any zone
///  - ( Viewing )   : Bz Author can only view his zone + other public zones
///  - ( Viewing )   : Bz Author can only view Public zones bzz
///  - Bz can publish flyers in his zone + other public zones
///
/// FLYER ZONING POLICY
///  - ( Existence ) : Flyer can only be published in one zone
///  - ( Creation )  : Flyer can be published in his BzZone + other public zones
///  - Flyer can have extra publishing zones as boost (PAID FEATURE)
///
/// USER ZONING POLICY
///   - ( Existence ) : User can only be in one zone at a time
///   - ( Creation )  : User can be created in any zone
///   - ( Viewing )   : User can only view Public zones flyers
///   - ( Viewing )   : User can only view Active zones bzz
///   - User zone and User Need Zone are the same
// --------------------------------------------------------------------------

enum StageType {
  /// LVL 1 - SWITCHED OFF - CAN NOT BE USED - IS HIDDEN,
  hidden,

  /// LVL 2 - INACTIVE - NOT YET USED - HAS NO FLYERS
  inactive,

  /// LVL 3 - ACTIVE - USED - HAS FLYERS
  active,

  /// LVL 4 - PUBLIC - CAN BE USED BY ANYONE
  public,
}

/// ZONE VIEWING EVENT TYPE
enum ZoneViewingEvent {
  homeView,
  userEditor,
  bzEditor,
  flyerEditor,
}

// --------------------------------------------------------------------------

/// => TAMAM
@immutable
class ZoneStages {
  // --------------------------------------------------------------------------
  const ZoneStages({
    @required this.hidden,
    @required this.inactive,
    @required this.active,
    @required this.public,
  });
  // --------------------------------------------------------------------------
  final List<String> hidden;
  final List<String> inactive;
  final List<String> active;
  final List<String> public;
  // --------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const List<StageType> zoneStagesList = <StageType>[
    StageType.hidden,
    StageType.inactive,
    StageType.active,
    StageType.public,
  ];
  // --------------------------------------------------------------------------

    /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
    'hidden': hidden,
    'inactive': inactive,
    'active': active,
    'public': public,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneStages decipher(Map<String, dynamic> map){
    ZoneStages _output;

    if (map != null){

      _output = ZoneStages(
        hidden: Stringer.getStringsFromDynamics(dynamics: map['hidden']),
        inactive: Stringer.getStringsFromDynamics(dynamics: map['inactive']),
        active: Stringer.getStringsFromDynamics(dynamics: map['active']),
        public: Stringer.getStringsFromDynamics(dynamics: map['public']),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherStageType(StageType type){

    switch (type) {
      case StageType.hidden:    return 'hidden';    break;
      case StageType.inactive:  return 'inactive';  break;
      case StageType.active:    return 'active';    break;
      case StageType.public:    return 'public';    break;
      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StageType decipherStageType(String type){

      switch (type) {
        case 'hidden':    return StageType.hidden;    break;
        case 'inactive':  return StageType.inactive;  break;
        case 'active':    return StageType.active;    break;
        case 'public':    return StageType.public;    break;
        default: return null;
      }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  ZoneStages copyWith({
    List<String> hidden,
    List<String> inactive,
    List<String> active,
    List<String> public,
  }) {
    return ZoneStages(
      hidden: hidden ?? this.hidden,
      inactive: inactive ?? this.inactive,
      active: active ?? this.active,
      public: public ?? this.public,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  ZoneStages copyListWith({
    @required List<String> newList,
    @required StageType type,
  }){
    ZoneStages _output = this;

    if (this != null && newList != null && type != null){

      _output = _output.copyWith(
        hidden:    type == StageType.hidden    ? newList : _output.hidden,
        inactive:  type == StageType.inactive  ? newList : _output.inactive,
        active:    type == StageType.active    ? newList : _output.active,
        public:    type == StageType.public    ? newList : _output.public,
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> getAllIDs(){
    return <String>[
      ...?hidden,
      ...?inactive,
      ...?active,
      ...?public,
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> getIDsByStage(StageType stageType){
    switch (stageType) {
      case StageType.hidden:    return hidden;    break;
      case StageType.inactive:  return inactive;  break;
      case StageType.active:    return active;    break;
      case StageType.public:    return public;    break;
      default: return getAllIDs();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  StageType getStageTypeByID(String id){

    if (checkHasID(id: id, zoneStageType: StageType.hidden) == true){
      return StageType.hidden;
    }
    else if (checkHasID(id: id, zoneStageType: StageType.inactive) == true){
      return StageType.inactive;
    }
    else if (checkHasID(id: id, zoneStageType: StageType.active) == true){
      return StageType.active;
    }
    else if (checkHasID(id: id, zoneStageType: StageType.public) == true){
      return StageType.public;
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static StageType concludeLowestZoneStageOnViewingEvent({
    @required ZoneViewingEvent event,
    @required bool isAuthor,
  }){

    /// AUTHOR
    if (isAuthor == true){

      switch(event){
        case ZoneViewingEvent.homeView    : return StageType.active;    break; /// = if active : will show bzz : if public : will show flyers
        case ZoneViewingEvent.userEditor  : return StageType.inactive;  break;
        case ZoneViewingEvent.bzEditor    : return StageType.inactive;  break;
        case ZoneViewingEvent.flyerEditor : return StageType.active;    break; /// WHEN BZ IS CREATED, ZONE GETS ACTIVE
        default: return null; break;
      }

    }

    /// USER
    else {

      switch(event){
        case ZoneViewingEvent.homeView    : return StageType.active;    break; /// = if active : will show bzz : if public : will show flyers
        case ZoneViewingEvent.userEditor  : return StageType.inactive;  break;
        case ZoneViewingEvent.bzEditor    : return StageType.inactive;  break;
        case ZoneViewingEvent.flyerEditor : return null;                break; /// USER DOES NOT PUBLISH FLYERS
        default: return null; break;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneStages removeIDFromZoneStage({
    @required String id,
    @required ZoneStages zoneStages,
  }){
    ZoneStages _output = zoneStages;

    if (zoneStages != null && id != null){

      final bool _idExists = zoneStages.checkHasID(id: id);

      if (_idExists == true){

        final StageType _type = zoneStages.getStageTypeByID(id);
        final List<String> _oldList = zoneStages.getIDsByStage(_type);

        final List<String> _newList = Stringer.removeStringsFromStrings(
            removeFrom: _oldList,
            removeThis: [id],
        );

        _output = _output.copyListWith(
            newList: _newList,
            type: _type,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneStages insertIDToZoneStages({
    @required String id,
    @required StageType newType,
    @required ZoneStages zoneStages,
  }){
    ZoneStages _output = zoneStages;

    if (zoneStages != null && id != null){


      final bool _idExists = zoneStages.checkHasID(id: id);


      if (_idExists == true){

        // print('5 _output : $_output');

        _output = removeIDFromZoneStage(
          id: id,
          zoneStages: _output,
        );

        // print('6 _output : $_output');

      }


      final List<String> _oldList = zoneStages.getIDsByStage(newType);

      final List<String> _newList = Stringer.addStringToListIfDoesNotContainIt(
          strings: _oldList,
          stringToAdd: id,
      );

      _output = _output.copyListWith(
        newList: _newList,
        type: newType,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // ---------------------
  /// TESTED : WORKS PERFECT
  bool checkHasID({
    @required String id,
    StageType zoneStageType,
  }){

    /// CHECK ALL
    if (zoneStageType == null){
      return Stringer.checkStringsContainString(
          strings: getAllIDs(),
          string: id
      );
    }

    /// CHECK SPECIFIC STAGE
    else {
      return Stringer.checkStringsContainString(
          strings: getIDsByStage(zoneStageType),
          string: id
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkStagesAreIdentical(ZoneStages stage1, ZoneStages stage2){
    bool _identical = false;

    if (stage1 == null && stage2 == null){
      _identical = true;
    }

    else if (stage1 != null && stage2 != null) {
      if (
          Mapper.checkListsAreIdentical(list1: stage1.hidden, list2: stage2.hidden) == true &&
          Mapper.checkListsAreIdentical(list1: stage1.inactive, list2: stage2.inactive) == true &&
          Mapper.checkListsAreIdentical(list1: stage1.active, list2: stage2.active) == true &&
          Mapper.checkListsAreIdentical(list1: stage1.public, list2: stage2.public) == true
      ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogStages(){
    blog('hidden : ${hidden.length} : $hidden');
    blog('inactive : ${inactive.length} : $inactive');
    blog('active : ${active.length} : $active');
    blog('public : ${public.length} : $public');
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
    if (other is ZoneStages){
      _areIdentical = checkStagesAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      hidden.hashCode^
      inactive.hashCode^
      active.hashCode^
      public.hashCode;
  // -----------------------------------------------------------------------------
}
