part of world_zoning;

// --------------------------------------------------------------------------

/// NOTES:-

// --------------------
/// ZONE :
///   - Either Country - City
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
enum ViewingEvent {
  homeView,
  userEditor,
  bzEditor,
  flyerEditor,
  admin, /// sees everything
}

// --------------------------------------------------------------------------
/// => TAMAM
@immutable
class StagingModel {
  // --------------------------------------------------------------------------
  const StagingModel({
    required this.id,
    required this.emptyStageIDs,
    required this.bzzStageIDs,
    required this.flyersStageIDs,
    required this.publicStageIDs,
  });
  // --------------------------------------------------------------------------
  final String? id;
  final List<String>? emptyStageIDs;
  final List<String>? bzzStageIDs;
  final List<String>? flyersStageIDs;
  final List<String>? publicStageIDs;
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
  static StagingModel emptyStaging(){
    return const StagingModel(
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
    required bool toLDB,
  }){

    Map<String, dynamic> _map = {
      '1_empty_stage': Stringer.sortAlphabetically(emptyStageIDs),
      '2_bzz_stage': Stringer.sortAlphabetically(bzzStageIDs),
      '3_flyers_stage': Stringer.sortAlphabetically(flyersStageIDs),
      '4_public_stage': Stringer.sortAlphabetically(publicStageIDs),
    };

    if (toLDB == true) {
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: id,
        overrideExisting: true,
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StagingModel? decipher({
    required Map<String, dynamic>? map,
    required String? id,
  }){
    StagingModel? _output;

    if (map != null){

      _output = StagingModel(
        id: id ?? map['id'],
        emptyStageIDs: Mapper.getStringsFromTheDamnThing(map['1_empty_stage']),
        bzzStageIDs: Mapper.getStringsFromTheDamnThing(map['2_bzz_stage']),
        flyersStageIDs: Mapper.getStringsFromTheDamnThing(map['3_flyers_stage']),
        publicStageIDs: Mapper.getStringsFromTheDamnThing(map['4_public_stage']),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherStageType(StageType? type){

    switch (type) {
      case StageType.emptyStage:     return '1_empty';
      case StageType.bzzStage:       return '2_bzz';
      case StageType.flyersStage:    return '3_flyers';
      case StageType.publicStage:    return '4_public';
      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StageType? decipherStageType(String? type){

      switch (type) {
        case '1_empty':    return StageType.emptyStage;
        case '2_bzz':      return StageType.bzzStage;
        case '3_flyers':   return StageType.flyersStage;
        case '4_public':   return StageType.publicStage;
        default: return null;
      }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  StagingModel copyWith({
    String? id,
    List<String>? emptyStageIDs,
    List<String>? bzzStageIDs,
    List<String>? flyersStageIDs,
    List<String>? publicStageIDs,
  }) {
    return StagingModel(
      id: id ?? this.id,
      emptyStageIDs: emptyStageIDs ?? this.emptyStageIDs,
      bzzStageIDs: bzzStageIDs ?? this.bzzStageIDs,
      flyersStageIDs: flyersStageIDs ?? this.flyersStageIDs,
      publicStageIDs: publicStageIDs ?? this.publicStageIDs,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  StagingModel copyListWith({
    required List<String>? newList,
    required StageType? type,
  }){
    StagingModel? _output = this;

    if (newList != null && type != null){

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
  List<String>? getIDsByType(StageType? stageType){
    switch (stageType) {
      case StageType.emptyStage:    return emptyStageIDs;
      case StageType.bzzStage:      return bzzStageIDs;
      case StageType.flyersStage:   return flyersStageIDs;
      case StageType.publicStage:   return publicStageIDs;
      default: return getAllIDs();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  StageType? getTypeByID(String? id){

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
    required ViewingEvent event,
    required String? countryID,
    required String? viewerCountryID,
  }){

    if (event == ViewingEvent.admin){
      return getAllIDs();
    }

    else {

      final StageType? _minStage = _concludeLowestStageOnViewingEvent(
        event: event,
        countryID: countryID,
        viewerCountryID: viewerCountryID,
      );

      return _getIDsFromMinStageToMax(
        minStage: _minStage,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StageType? _concludeLowestStageOnViewingEvent({
    required ViewingEvent? event,
    required String? countryID,
    required String? viewerCountryID,
  }){

    const Map<String, dynamic> _localUser = {
      'homeView' : { /// USER BROWSING HOME PAGE FLYERS AND BZZ
        'user':           {'country' : StageType.flyersStage, 'city' : StageType.flyersStage},
        'author':         {'country' : StageType.bzzStage,    'city' : StageType.bzzStage},
        'global_user':    {'country' : StageType.flyersStage, 'city' : StageType.publicStage},
        'global_author':  {'country' : StageType.bzzStage,    'city' : StageType.flyersStage},
      },
      'userEditor' : { /// SO USER CAN BE CREATED HERE
        'user':           {'country' : StageType.emptyStage, 'city' : StageType.emptyStage},
        'author':         {'country' : StageType.emptyStage, 'city' : StageType.emptyStage}, /// NOT USED
        'global_user':    {'country' : StageType.emptyStage, 'city' : StageType.emptyStage},
        'global_author':  {'country' : StageType.emptyStage, 'city' : StageType.emptyStage}, /// NOT USED
      },
      'bzEditor' : { /// AND BZ ACCOUNT CAN BE LOCATED HERE
        'user':           {'country' : StageType.emptyStage, 'city' : StageType.emptyStage}, /// NOT USED
        'author':         {'country' : StageType.emptyStage, 'city' : StageType.emptyStage},
        'global_user':    {'country' : StageType.emptyStage, 'city' : StageType.emptyStage}, /// NOT USED
        'global_author':  {'country' : StageType.emptyStage, 'city' : StageType.emptyStage},
      },
      'flyerEditor' : { /// AND FLYER CAN BE CREATED HERE
        // 'user':           {'country' : StageType.bzzStage, 'city' : StageType.emptyStage}, /// NOT USED
        'author':         {'country' : StageType.emptyStage, 'city' : StageType.emptyStage},
        // 'global_user':    {'country' : StageType.bzzStage, 'city' : StageType.flyersStage}, /// NOT USED
        'global_author':  {'country' : StageType.emptyStage, 'city' : StageType.emptyStage},
      },
    };

    final String? _view = cipherViewingEvent(event);
    final String _userType = _getUserTypeKey(
      countryID: countryID,
      viewerCountryID: viewerCountryID,
    );
    final String _zoneLevel = countryID == null ? 'country' : 'city';

    // blog('_view : $_view : _userType : $_userType : _zoneLevel : $_zoneLevel  = ${_localUser[_view][_userType][_zoneLevel]}');

    return _localUser[_view][_userType][_zoneLevel];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getUserTypeKey({
    required String? countryID,
    required String? viewerCountryID,
  }){

    final UserModel? _user = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
    );
    final bool _isAuthor = UserModel.checkUserIsAuthor(_user);
    final bool _isGlobal =
        countryID != null &&
        viewerCountryID != null &&
        countryID != viewerCountryID;

    if (_isAuthor == true){

      if (_isGlobal == true){
        return 'global_author';
      }
      else {
        return 'author';
      }

    }

    else {
      if (_isGlobal == true){
        return 'user';
      }
      else {
        return 'global_user';
      }
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherViewingEvent(ViewingEvent? event){
      switch(event){
        case ViewingEvent.homeView        : return 'homeView';
        case ViewingEvent.userEditor      : return 'userEditor';
        case ViewingEvent.bzEditor        : return 'bzEditor';
        case ViewingEvent.flyerEditor     : return 'flyerEditor';
        default: return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> _getIDsFromMinStageToMax({
    required StageType? minStage,
  }){
    List<String> _output = <String>[];

    switch(minStage){
      case StageType.emptyStage:    _output = getAllIDs();                                                  break;
      case StageType.bzzStage:  _output.addAll([...?bzzStageIDs, ...?flyersStageIDs, ...?publicStageIDs]);  break;
      case StageType.flyersStage:    _output.addAll([...?flyersStageIDs, ...?publicStageIDs]);              break;
      case StageType.publicStage:    _output.addAll([...?publicStageIDs]);
      break;
      default: break;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static StagingModel? removeIDFromStaging({
    required String? id,
    required StagingModel? staging,
  }){
    StagingModel? _output = staging;

    if (staging != null && id != null){

      final bool _idExists = staging.checkHasID(id: id);

      if (_idExists == true){

        final StageType? _type = staging.getTypeByID(id);
        final List<String>? _oldList = staging.getIDsByType(_type);

        final List<String> _newList = Stringer.removeStringsFromStrings(
            removeFrom: _oldList,
            removeThis: [id],
        );

        _output = _output?.copyListWith(
            newList: _newList,
            type: _type,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StagingModel? insertIDToStaging({
    required String? id,
    required StageType? newType,
    required StagingModel? staging,
  }){
    StagingModel? _output = staging;

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


      final List<String>? _oldList = staging.getIDsByType(newType);

      final List<String> _newList = Stringer.addStringToListIfDoesNotContainIt(
          strings: _oldList,
          stringToAdd: id,
      );

      _output = _output?.copyListWith(
        newList: _newList,
        type: newType,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MY IDS

  // ---------------------
  /// TESTED : WORKS PERFECT
  static List<String> addMyCountryIDToActiveCountries({
    required List<String>? shownCountriesIDs,
    required String? myCountryID,
    required ViewingEvent? event,
  }){
    List<String> _output = <String>[...?shownCountriesIDs];

    if (myCountryID != null){

      bool _addMyID = false;
      switch(event){
        case ViewingEvent.homeView:     _addMyID = true; break;
        case ViewingEvent.userEditor:   _addMyID = true; break;
        case ViewingEvent.bzEditor:     _addMyID = true; break;
        case ViewingEvent.flyerEditor:  _addMyID = true; break;
        case ViewingEvent.admin:        _addMyID = true; break;
        case null: _addMyID = true; break;
      }

      if (_addMyID == true){
        _output = Stringer.addStringToListIfDoesNotContainIt(
            strings: _output,
            stringToAdd: myCountryID,
        );
      }

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static List<String> addMyStateIDToShownStates({
    required List<String>? shownStatesIDs,
    required String? myCountryID,
    required ViewingEvent? event,
  }){
    List<String> _output = <String>[...?shownStatesIDs];

    final bool _idIsState = America.checkCountryIDIsStateID(myCountryID);

    if (_idIsState == true){

      bool _addMyID = false;
      switch(event){
        case ViewingEvent.homeView:     _addMyID = true; break;
        case ViewingEvent.userEditor:   _addMyID = true; break;
        case ViewingEvent.bzEditor:     _addMyID = true; break;
        case ViewingEvent.flyerEditor:  _addMyID = true; break;
        case ViewingEvent.admin:        _addMyID = true; break;
        case null: _addMyID = true; break;
      }

      if (_addMyID == true){
        _output = Stringer.addStringToListIfDoesNotContainIt(
            strings: _output,
            stringToAdd: myCountryID,
        );
      }

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static List<String> addMyCityIDToShownCities({
    required List<String>? shownIDs,
    required String? myCityID,
    required ViewingEvent? event,
  }){
    List<String> _output = <String>[...?shownIDs];

    if (Mapper.checkCanLoopList(_output) == true && myCityID != null){

      final String? _shownCountryID = CityModel.getCountryIDFromCityID(_output.first);
      final String? _myCountryID = CityModel.getCountryIDFromCityID(myCityID);

      if (_shownCountryID != null && _shownCountryID == _myCountryID){
      bool _addMyID = false;
      switch(event){
        case ViewingEvent.homeView:     _addMyID = true; break;
        case ViewingEvent.userEditor:   _addMyID = true; break;
        case ViewingEvent.bzEditor:     _addMyID = true; break;
        case ViewingEvent.flyerEditor:  _addMyID = true; break;
        case ViewingEvent.admin:        _addMyID = true; break;
        case null: _addMyID = true; break;
      }

      if (_addMyID == true){
        _output = Stringer.addStringToListIfDoesNotContainIt(
          strings: _output,
          stringToAdd: myCityID,
        );
      }

    }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // ---------------------
  /// TESTED : WORKS PERFECT
  bool checkHasID({
    required String? id,
    StageType? zoneStageType,
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
  static bool checkAllZonesAreInEmptyStage(StagingModel? staging){
    bool _output = false;

    if (staging != null){

      final List<String> _allIDs = staging.getAllIDs();
      final List<String>? _emptyStageIDs = staging.getIDsByType(StageType.emptyStage);

      _output = Mapper.checkListsAreIdentical(
          list1: _allIDs,
          list2: _emptyStageIDs,
      );


    }

    // blog('checkAllZonesAreInEmptyStage : _output : $_output');

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static bool checkStagingHasSelectableZones({
    required StagingModel? staging,
    required ViewingEvent? zoneViewingEvent,
    required String countryID,
    required String viewerCountryID,
  }){
    bool _output = false;

    if (staging != null && zoneViewingEvent != null){

      final List<String> _ids = staging.getIDsByViewingEvent(
        event: zoneViewingEvent,
        countryID: countryID,
        viewerCountryID: viewerCountryID,
      );

      _output = Mapper.checkCanLoopList(_ids);

    }

    return _output;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static bool checkMayShowViewAllZonesButton({
    required ViewingEvent? zoneViewingEvent,
  }){
    return zoneViewingEvent == ViewingEvent.homeView
    ||
    zoneViewingEvent == ViewingEvent.admin
    ;
  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static bool isEmpty(StagingModel? staging){
    bool _output = true;

    if (staging != null){
      _output = staging.getAllIDs().isEmpty;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkStagingsAreIdentical(StagingModel? staging1, StagingModel? staging2){
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
    blog('STAGING :--- >');
    blog('emptyStage : ${emptyStageIDs?.length} : $emptyStageIDs');
    blog('bzzStage : ${bzzStageIDs?.length} : $bzzStageIDs');
    blog('flyerStage : ${flyersStageIDs?.length} : $flyersStageIDs');
    blog('publicStage : ${publicStageIDs?.length} : $publicStageIDs');
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() =>
       '''
StagingModel(
  emptyStageIDs: $emptyStageIDs,
  bzzStageIDs: $bzzStageIDs,
  flyersStageIDs: $flyersStageIDs,
  publicStageIDs: $publicStageIDs,
  )
       ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is StagingModel){
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
