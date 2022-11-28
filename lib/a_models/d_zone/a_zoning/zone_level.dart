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
///   - is a zone that reached a level that can be visible to other zones
///
/// ACTIVE CITY
///   - is a city that has certain amount of flyers and bzz to be visible to users
///
/// ACTIVE COUNTRY
///   - is a country that has atleast 1 active city
///
/// PUBLIC CITY
///   - is a city that reached a level that can be visible to other cities
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

enum ZoneLevelType {
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

@immutable
class ZoneLevel {
  // --------------------------------------------------------------------------
  const ZoneLevel({
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
  static ZoneLevel decipher(Map<String, dynamic> map){
    ZoneLevel _level;

    if (map != null){

      _level = ZoneLevel(
        hidden: Stringer.getStringsFromDynamics(dynamics: map['hidden']),
        inactive: Stringer.getStringsFromDynamics(dynamics: map['inactive']),
        active: Stringer.getStringsFromDynamics(dynamics: map['active']),
        public: Stringer.getStringsFromDynamics(dynamics: map['public']),
      );

    }

    return _level;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherLevelType(ZoneLevelType type){

    switch (type) {
      case ZoneLevelType.hidden:    return 'hidden';    break;
      case ZoneLevelType.inactive:  return 'inactive';  break;
      case ZoneLevelType.active:    return 'active';    break;
      case ZoneLevelType.public:    return 'public';    break;
      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneLevelType decipherLevelType(String type){

      switch (type) {
        case 'hidden':    return ZoneLevelType.hidden;    break;
        case 'inactive':  return ZoneLevelType.inactive;  break;
        case 'active':    return ZoneLevelType.active;    break;
        case 'public':    return ZoneLevelType.public;    break;
        default: return null;
      }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  ZoneLevel copyWith({
    List<String> hidden,
    List<String> inactive,
    List<String> active,
    List<String> public,
  }) {
    return ZoneLevel(
      hidden: hidden ?? this.hidden,
      inactive: inactive ?? this.inactive,
      active: active ?? this.active,
      public: public ?? this.public,
    );
  }
  // --------------------
  /// TASK : TEST ME
  ZoneLevel copyListWith({
    @required List<String> list,
    @required ZoneLevelType type,
  }){
    ZoneLevel _output = this;

    if (this != null && list != null && type != null){

      _output = _output.copyWith(
        hidden:    type == ZoneLevelType.hidden    ? list : _output.hidden,
        inactive:  type == ZoneLevelType.inactive  ? list : _output.inactive,
        active:    type == ZoneLevelType.active    ? list : _output.active,
        public:    type == ZoneLevelType.public    ? list : _output.public,
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
  /// TASK : TEST ME
  List<String> getIDsByLevel(ZoneLevelType level){
    switch (level) {
      case ZoneLevelType.hidden:    return hidden;    break;
      case ZoneLevelType.inactive:  return inactive;  break;
      case ZoneLevelType.active:    return active;    break;
      case ZoneLevelType.public:    return public;    break;
      default: return getAllIDs();
    }
  }
  // --------------------
  /// TASK : TEST ME
  ZoneLevelType getLevelTypeByID(String id){

    if (checkHasID(id: id, levelType: ZoneLevelType.hidden) == true){
      return ZoneLevelType.hidden;
    }
    else if (checkHasID(id: id, levelType: ZoneLevelType.inactive) == true){
      return ZoneLevelType.inactive;
    }
    else if (checkHasID(id: id, levelType: ZoneLevelType.active) == true){
      return ZoneLevelType.active;
    }
    else if (checkHasID(id: id, levelType: ZoneLevelType.public) == true){
      return ZoneLevelType.public;
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TASK : TEST ME
  static ZoneLevelType concludeLowestZoneLevelOnViewingEvent({
    @required ZoneViewingEvent event,
    @required bool isAuthor,
  }){

    /// AUTHOR
    if (isAuthor == true){

      switch(event){
        case ZoneViewingEvent.homeView    : return ZoneLevelType.active;    break; /// = if active : will show bzz : if public : will show flyers
        case ZoneViewingEvent.userEditor  : return ZoneLevelType.inactive;  break;
        case ZoneViewingEvent.bzEditor    : return ZoneLevelType.inactive;  break;
        case ZoneViewingEvent.flyerEditor : return ZoneLevelType.active;    break; /// WHEN BZ IS CREATED, ZONE GETS ACTIVE
        default: return null; break;
      }

    }

    /// USER
    else {

      switch(event){
        case ZoneViewingEvent.homeView    : return ZoneLevelType.active;    break; /// = if active : will show bzz : if public : will show flyers
        case ZoneViewingEvent.userEditor  : return ZoneLevelType.inactive;  break;
        case ZoneViewingEvent.bzEditor    : return ZoneLevelType.inactive;  break;
        case ZoneViewingEvent.flyerEditor : return null;                break; /// USER DOES NOT PUBLISH FLYERS
        default: return null; break;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TASK : TEST ME
  static ZoneLevel updateIDLevel({
    @required ZoneLevel oldLevel,
    @required String id,
    @required ZoneLevelType newType,
  }){

    ZoneLevel _output;

    if (oldLevel == null || id == null || newType == null){
      _output = oldLevel;
    }

    else {

      final ZoneLevelType _type = oldLevel.getLevelTypeByID(id);

      if (_type == null){
        _output = oldLevel;
      }

      else {

        _output = _removeIDFromZoneLevel(
          id: id,
          zoneLevel: _output,
        );

        _output = _addIDToZoneLevel(
          id: id,
          zoneLevel: _output,
          newType: newType,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static ZoneLevel _removeIDFromZoneLevel({
    @required String id,
    @required ZoneLevel zoneLevel,
  }){
    ZoneLevel _output = zoneLevel;

    if (zoneLevel != null && id != null){

      final bool _idExists = zoneLevel.checkHasID(id: id);

      if (_idExists == true){

        final ZoneLevelType _type = zoneLevel.getLevelTypeByID(id);
        final List<String> _oldList = zoneLevel.getIDsByLevel(_type);

        final List<String> _newList = Stringer.removeStringsFromStrings(
            removeFrom: _oldList,
            removeThis: [id],
        );

        _output = _output.copyListWith(
            list: _newList,
            type: _type,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static ZoneLevel _addIDToZoneLevel({
    @required String id,
    @required ZoneLevelType newType,
    @required ZoneLevel zoneLevel,
  }){
    ZoneLevel _output = zoneLevel;

    if (zoneLevel != null && id != null){

      final bool _idExists = zoneLevel.checkHasID(id: id);

      if (_idExists == true){
        _output = _removeIDFromZoneLevel(
          id: id,
          zoneLevel: _output,
        );
      }


      final List<String> _oldList = zoneLevel.getIDsByLevel(newType);

      final List<String> _newList = Stringer.addStringToListIfDoesNotContainIt(
          strings: _oldList,
          stringToAdd: id,
      );

      _output = _output.copyListWith(
        list: _newList,
        type: newType,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // ---------------------
  /// TASK : TEST ME
  bool checkHasID({
    @required String id,
    ZoneLevelType levelType,
  }){

    /// CHECK ALL
    if (levelType == null){
      return Stringer.checkStringsContainString(
          strings: getAllIDs(),
          string: id
      );
    }

    /// CHECK SPECIFIC LEVEL
    else {
      return Stringer.checkStringsContainString(
          strings: getIDsByLevel(levelType),
          string: id
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkLevelsAreIdentical(ZoneLevel lvl1, ZoneLevel lvl2){
    bool _identical = false;

    if (lvl1 == null && lvl2 == null){
      _identical = true;
    }

    else if (lvl1 != null && lvl2 != null) {
      if (
          Mapper.checkListsAreIdentical(list1: lvl1.hidden, list2: lvl2.hidden) == true &&
          Mapper.checkListsAreIdentical(list1: lvl1.inactive, list2: lvl2.inactive) == true &&
          Mapper.checkListsAreIdentical(list1: lvl1.active, list2: lvl2.active) == true &&
          Mapper.checkListsAreIdentical(list1: lvl1.public, list2: lvl2.public) == true
      ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogLeveL(){
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
    if (other is ZoneLevel){
      _areIdentical = checkLevelsAreIdentical(
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
