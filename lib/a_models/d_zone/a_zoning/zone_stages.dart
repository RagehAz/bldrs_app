import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/main.dart';
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

/*

HIDDEN -> VISIBLE -> ACTIVE -> PUBLIC

 */

/// X Flyers is minimum number of flyers for zone to go to flyers stage
/// Y BZZ is minimum number of bzz for zone to go to bzz stage
enum StageType {
  /// LVL 1 - ZONE IS EMPTY : no users - no bzz - no flyers
  emptyStage,

  /// LVL 2 - ZONE HAS A BZ : has some users and less than X flyers
  bzzStage,

  /// LVL 3 - ZONE HAS MORE THAN X FLYERS
  flyersStage,

  /// LVL 4 - ZONE HAS MORE THAN X FLYERS AND Y BZZ
  publicStage,
}

/// ZONE VIEWING EVENT TYPE
enum ZoneViewingEvent {
  homeView,
  userEditor,
  bzEditor,
  flyerEditor,
  flyerPromotion,
  admin, /// sees everything
}

// --------------------------------------------------------------------------
/// => TAMAM
@immutable
class Staging {
  // --------------------------------------------------------------------------
  const Staging({
    @required this.id,
    @required this.emptyStageIDs,
    @required this.bzzStageIDs,
    @required this.flyersStageIDs,
    @required this.publicStageIDs,
  });
  // --------------------------------------------------------------------------
  final String id;
  final List<String> emptyStageIDs;
  final List<String> bzzStageIDs;
  final List<String> flyersStageIDs;
  final List<String> publicStageIDs;
  // --------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String countriesStagingId = 'countries';
  // --------------------
  static const List<StageType> zoneStagesList = <StageType>[
    StageType.emptyStage,
    StageType.bzzStage,
    StageType.flyersStage,
    StageType.publicStage,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static Staging emptyStaging(){
    return const Staging(
      id: 'emptyStaging',
      emptyStageIDs: [],
      bzzStageIDs: [],
      flyersStageIDs: [],
      publicStageIDs: [],
    );
  }
  // --------------------------------------------------------------------------

    /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toLDB,
  }){

    Map<String, dynamic> _map = {
      '1_empty_stage': Stringer.sortAlphabetically2(emptyStageIDs),
      '2_bzz_stage': Stringer.sortAlphabetically2(bzzStageIDs),
      '3_flyers_stage': Stringer.sortAlphabetically2(flyersStageIDs),
      '4_public_stage': Stringer.sortAlphabetically2(publicStageIDs),
    };

    if (toLDB) {
      _map = Mapper.insertPairInMap(
          map: _map,
          key: 'id',
          value: id,
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Staging decipher({
    @required Map<String, dynamic> map,
    @required String id,
  }){
    Staging _output;

    if (map != null){

      _output = Staging(
        id: map['id'] ?? id,
        emptyStageIDs: Stringer.getStringsFromDynamics(dynamics: map['1_empty_stage']),
        bzzStageIDs: Stringer.getStringsFromDynamics(dynamics: map['2_bzz_stage']),
        flyersStageIDs: Stringer.getStringsFromDynamics(dynamics: map['3_flyers_stage']),
        publicStageIDs: Stringer.getStringsFromDynamics(dynamics: map['4_public_stage']),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherStageType(StageType type){

    switch (type) {
      case StageType.emptyStage:     return '1_empty';     break;
      case StageType.bzzStage:       return '2_bzz';       break;
      case StageType.flyersStage:    return '3_flyers';    break;
      case StageType.publicStage:    return '4_public';    break;
      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StageType decipherStageType(String type){

      switch (type) {
        case '1_empty':    return StageType.emptyStage;    break;
        case '2_bzz':      return StageType.bzzStage;      break;
        case '3_flyers':   return StageType.flyersStage;   break;
        case '4_public':   return StageType.publicStage;   break;
        default: return null;
      }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Staging copyWith({
    String id,
    List<String> emptyStageIDs,
    List<String> bzzStageIDs,
    List<String> flyersStageIDs,
    List<String> publicStageIDs,
  }) {
    return Staging(
      id: id ?? this.id,
      emptyStageIDs: emptyStageIDs ?? this.emptyStageIDs,
      bzzStageIDs: bzzStageIDs ?? this.bzzStageIDs,
      flyersStageIDs: flyersStageIDs ?? this.flyersStageIDs,
      publicStageIDs: publicStageIDs ?? this.publicStageIDs,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Staging copyListWith({
    @required List<String> newList,
    @required StageType type,
  }){
    Staging _output = this;

    if (this != null && newList != null && type != null){

      _output = _output.copyWith(
        emptyStageIDs:    type == StageType.emptyStage    ? newList : _output.emptyStageIDs,
        bzzStageIDs:      type == StageType.bzzStage      ? newList : _output.bzzStageIDs,
        flyersStageIDs:   type == StageType.flyersStage   ? newList : _output.flyersStageIDs,
        publicStageIDs:   type == StageType.publicStage   ? newList : _output.publicStageIDs,
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
      ...?emptyStageIDs,
      ...?bzzStageIDs,
      ...?flyersStageIDs,
      ...?publicStageIDs,
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> getIDsByType(StageType stageType){
    switch (stageType) {
      case StageType.emptyStage:    return emptyStageIDs;   break;
      case StageType.bzzStage:      return bzzStageIDs;     break;
      case StageType.flyersStage:   return flyersStageIDs;  break;
      case StageType.publicStage:   return publicStageIDs;  break;
      default: return getAllIDs();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  StageType getTypeByID(String id){

    if (checkHasID(id: id, zoneStageType: StageType.emptyStage) == true){
      return StageType.emptyStage;
    }
    else if (checkHasID(id: id, zoneStageType: StageType.bzzStage) == true){
      return StageType.bzzStage;
    }
    else if (checkHasID(id: id, zoneStageType: StageType.flyersStage) == true){
      return StageType.flyersStage;
    }
    else if (checkHasID(id: id, zoneStageType: StageType.publicStage) == true){
      return StageType.publicStage;
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// VIEWING EVENT CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> getIDsByViewingEvent({
    @required ZoneViewingEvent event,
  }){

    if (event == ZoneViewingEvent.admin){
      return getAllIDs();
    }

    else {

      final StageType _minStage = _concludeLowestStageOnViewingEvent(
        event: event,
      );


      return _getIDsFromMinStageToMax(
        minStage: _minStage,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StageType _concludeLowestStageOnViewingEvent({
    @required ZoneViewingEvent event,
  }){

    final UserModel _user = UsersProvider.proGetMyUserModel(
        context: BldrsAppStarter.navigatorKey.currentContext,
        listen: false,
    );
    final bool _userIsAuthor = UserModel.checkUserIsAuthor(_user);

    /// AUTHOR
    if (_userIsAuthor == true){

      switch(event){
        /// = if active : will show bzz : if public : will show flyers
        case ZoneViewingEvent.homeView        : return StageType.flyersStage;    break;
        case ZoneViewingEvent.userEditor      : return StageType.emptyStage;    break;
        case ZoneViewingEvent.bzEditor        : return StageType.emptyStage;    break;
        /// WHEN BZ IS CREATED, ZONE GETS ACTIVE
        case ZoneViewingEvent.flyerEditor     : return StageType.bzzStage;    break;
        /// flyer can be promoted in active or public zones  only
        case ZoneViewingEvent.flyerPromotion  : return StageType.flyersStage;    break;
        default: return null; break;
      }

    }

    /// USER
    else {

      switch(event){
        /// = if active : will show bzz : if public : will show flyers
        case ZoneViewingEvent.homeView        : return StageType.flyersStage;    break;
        case ZoneViewingEvent.userEditor      : return StageType.emptyStage;    break;
        case ZoneViewingEvent.bzEditor        : return StageType.emptyStage ;   break;
        /// USER DOES NOT PUBLISH FLYERS
        case ZoneViewingEvent.flyerEditor     : return null;                break;
        /// normal user does not promote flyers
        case ZoneViewingEvent.flyerPromotion  : return null;                break;
        default: return null; break;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> _getIDsFromMinStageToMax({
    @required StageType minStage,
  }){
    List<String> _output = <String>[];

    switch(minStage){
      case StageType.emptyStage:    _output = getAllIDs();                                                  break;
      case StageType.bzzStage:  _output.addAll([...?bzzStageIDs, ...?flyersStageIDs, ...?publicStageIDs]);  break;
      case StageType.flyersStage:    _output.addAll([...?flyersStageIDs, ...?publicStageIDs]);              break;
      case StageType.publicStage:    _output.addAll(publicStageIDs);                                        break;
      default: break;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Staging removeIDFromStaging({
    @required String id,
    @required Staging staging,
  }){
    Staging _output = staging;

    if (staging != null && id != null){

      final bool _idExists = staging.checkHasID(id: id);

      if (_idExists == true){

        final StageType _type = staging.getTypeByID(id);
        final List<String> _oldList = staging.getIDsByType(_type);

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
  static Staging insertIDToStaging({
    @required String id,
    @required StageType newType,
    @required Staging staging,
  }){
    Staging _output = staging;

    if (staging != null && id != null){


      final bool _idExists = staging.checkHasID(id: id);


      if (_idExists == true){

        // print('5 _output : $_output');

        _output = removeIDFromStaging(
          id: id,
          staging: _output,
        );

        // print('6 _output : $_output');

      }


      final List<String> _oldList = staging.getIDsByType(newType);

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
          strings: getIDsByType(zoneStageType),
          string: id
      );
    }

  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static bool checkAllZonesAreInEmptyStage(Staging staging){
    bool _output;

    if (staging != null){

      final List<String> _allIDs = staging.getAllIDs();
      final List<String> _emptyStageIDs = staging.getIDsByType(StageType.emptyStage);

      _output = Mapper.checkListsAreIdentical(
          list1: _allIDs,
          list2: _emptyStageIDs,
      );


    }

    blog('checkAllZonesAreInEmptyStage : _output : $_output');

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static bool checkStagingHasSelectableZones({
    @required Staging staging,
    @required ZoneViewingEvent zoneViewingEvent,
  }){
    bool _output = false;

    if (staging != null && zoneViewingEvent != null){

      final List<String> _ids = staging.getIDsByViewingEvent(
        event: zoneViewingEvent,
      );

      _output = Mapper.checkCanLoopList(_ids);

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static bool checkMayShowViewAllZonesButton({
    @required ZoneViewingEvent zoneViewingEvent,
  }){
    return zoneViewingEvent == ZoneViewingEvent.homeView;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkStagingsAreIdentical(Staging staging1, Staging staging2){
    bool _identical = false;

    if (staging1 == null && staging2 == null){
      _identical = true;
    }

    else if (staging1 != null && staging2 != null) {
      if (
          Mapper.checkListsAreIdentical(list1: staging1.emptyStageIDs, list2: staging2.emptyStageIDs) == true &&
          Mapper.checkListsAreIdentical(list1: staging1.bzzStageIDs, list2: staging2.bzzStageIDs) == true &&
          Mapper.checkListsAreIdentical(list1: staging1.flyersStageIDs, list2: staging2.flyersStageIDs) == true &&
          Mapper.checkListsAreIdentical(list1: staging1.publicStageIDs, list2: staging2.publicStageIDs) == true
      ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogStaging(){
    blog('emptyStage : ${emptyStageIDs.length} : $emptyStageIDs');
    blog('bzzStage : ${bzzStageIDs.length} : $bzzStageIDs');
    blog('flyerStage : ${flyersStageIDs.length} : $flyersStageIDs');
    blog('publicStage : ${publicStageIDs.length} : $publicStageIDs');
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
    if (other is Staging){
      _areIdentical = checkStagingsAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      emptyStageIDs.hashCode^
      bzzStageIDs.hashCode^
      flyersStageIDs.hashCode^
      publicStageIDs.hashCode;
  // -----------------------------------------------------------------------------
}
