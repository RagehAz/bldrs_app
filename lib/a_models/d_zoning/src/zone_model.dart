part of world_zoning;

/// => TAMAM
@immutable
class ZoneModel {
  /// --------------------------------------------------------------------------
  const ZoneModel({
    required this.countryID,
    this.cityID,
    this.countryName,
    this.cityName,
    this.countryModel,
    this.cityModel,
    this.icon,
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  final String? countryName;
  final String? icon;
  final String? cityID;
  final String? cityName;
  final CountryModel? countryModel;
  final CityModel? cityModel;
  // -----------------------------------------------------------------------------

  /// STANDARDS

  // --------------------

  // --------------------
  static ZoneModel planetZone = ZoneModel(
    countryID: Flag.planetID,
    icon: Iconz.planet,
    countryName: getWord('phid_the_world'),
    // cityModel: null,
    // cityName: null,
    // cityID: null,
    // countryModel: null,
  );
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> prepareZoneForEditing({
    required ZoneModel? zoneModel,
  }) async {

    final ZoneModel? _zone =
            zoneModel
            ??
            ZoneProvider.proGetCurrentZone(context: getMainContext(), listen: false)
            // ??
            // await ZoneProtocols.getZoneByIP()
    ;

    return ZoneProtocols.completeZoneModel(
      incompleteZoneModel: _zone,
      invoker: 'prepareZoneForEditing',
    );

  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ZoneModel copyWith({
    String? countryID,
    String? cityID,
    String? countryName,
    String? cityName,
    CountryModel? countryModel,
    CityModel? cityModel,
    String? icon,
  }){
    return ZoneModel(
      countryID: countryID ?? this.countryID,
      cityID: cityID ?? this.cityID,
      countryName: countryName ?? this.countryName,
      cityName: cityName ?? this.cityName,
      countryModel: countryModel ?? this.countryModel,
      cityModel: cityModel ?? this.cityModel,
      icon: icon ?? this.icon,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  ZoneModel nullifyField({
    // bool countryID = false,
    bool cityID = false,
    bool countryName = false,
    bool cityName = false,
    bool countryModel = false,
    bool cityModel = false,
    bool icon = false,
  }){
    return ZoneModel(
      countryID: countryID,
      cityID: cityID == true ? null : this.cityID,
      countryName: countryName == true ? null : this.countryName,
      cityName: cityName == true ? null : this.cityName,
      countryModel: countryModel == true ? null : this.countryModel,
      cityModel: cityModel == true ? null : this.cityModel,
      icon: icon == true ? null : this.icon,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryID': countryID,
      'cityID': cityID,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel? decipherZone(Map<String, dynamic>? map) {


    if (map == null){
      return null;
    }

    else {
      return ZoneModel(
        countryID: map['countryID'],
        cityID: map['cityID'],
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String cipherToString() {
    return '$countryID/$cityID';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel decipherZoneString(String zoneString) {

    final String? _countryID = TextMod.removeTextAfterFirstSpecialCharacter(
        text: zoneString,
        specialCharacter: '/',
    );
    final String? _cityID = TextMod.removeTextBeforeFirstSpecialCharacter(
        text: zoneString,
        specialCharacter: '/',
    );

    return ZoneModel(
      countryID: _countryID!,
      cityID: _cityID,
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool isNotEmpty() {
    final bool _isEmpty = TextCheck.isEmpty(countryID) == false;
    final bool _isNotEmpty = !_isEmpty;
    return _isNotEmpty;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool zoneHasAllIDs(ZoneModel? zone) {
    final bool _hasAllIDs = zone != null && zone.cityID != null;
    return _hasAllIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkZoneHasCountryAndCityIDs(ZoneModel? zone){
    final bool _has = zone != null && zone.cityID != null;
    return _has;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogZone({String invoker = 'ZONE - PRINT'}) {
    blog('$invoker ------------------------------- START');

    blog('  IDs [ $cityID - $countryID ]');
    blog('  names [ $cityName - $countryName ]');
    blog('  models [ cityModelExists : ${cityModel != null} / countryModelExists : ${countryModel != null} ]');

    blog('$invoker ------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogZoneIDs({String invoker = 'ZONE-IDs BLOG : '}){

    blog('$invoker [ $cityID - $countryID ]');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogZonesDifferences({
    required ZoneModel? zone1,
    required ZoneModel? zone2,
  }){

    blog('blogZonesDifferences ---------- START');

    if (zone1 == null){
      blog('blogBzzDifferences : zone1 = null');
    }
    if (zone2 == null){
      blog('blogBzzDifferences : zone2 = null');
    }
    if (zone1 != null && zone2 != null){

      if (zone1.countryID != zone2.countryID){
        blog('countryIDs are not Identical');
      }
      if (zone1.cityID != zone2.cityID){
        blog('cityIDs are not Identical');
      }
      if (zone1.countryName != zone2.countryName){
        blog('countryNames are not Identical');
      }
      if (zone1.cityName != zone2.cityName){
        blog('cityNames are not Identical');
      }
      if (CountryModel.checkCountriesAreIdentical(zone1.countryModel, zone2.countryModel) == false){
        blog('countryModels are not Identical');
      }
      if (CityModel.checkCitiesAreIdentical(zone1.cityModel, zone2.cityModel) == false){
        blog('cityModels are not Identical');
      }
      if (zone1.icon != zone2.icon){
        blog('flags are not Identical');
      }

    }

    blog('blogZonesDifferences ---------- END');
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel dummyZone() {
    return const ZoneModel(
      countryID: 'egy',
      cityID: 'egy+cairo',
    );
  }
  // -----------------------------------------------------------------------------
  /// static const ZoneModel planetZone = ZoneModel(
  ///   countryID: planetID,
  ///   icon: Iconz.planet,
  ///
  /// );
  // -----------------------------------------------------------------------------

  /// STRING GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse generateInZoneVerse ({
    required ZoneModel? zoneModel,
    bool showCity = true,
  }){

    // zoneModel?.blogZone(invoker: 'translateZoneString');

    String _text = '...';
    final String? _inn = getWord('phid_inn');

    if (zoneModel != null){

        final String? _countryName = CountryModel.translateCountry(
          langCode: Localizer.getCurrentLangCode(),
          countryID: zoneModel.countryID,
        );

        _text = '$_inn $_countryName';

        if (showCity == true && (zoneModel.cityModel != null || zoneModel.cityName != null)){

          final String? _cityName = zoneModel.cityName ?? CityModel.translateCity(
            city: zoneModel.cityModel,
            langCode: Localizer.getCurrentLangCode(),
          );

          _text = '$_inn $_cityName, $_countryName';

        }

    }

    return Verse(
      id: _text,
      translate: false,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse generateObeliskVerse({
    required ZoneModel? zone,
  }){

    String? _line = getWord('phid_select_a_country');

    if (zone != null){

      final String? _countryName = CountryModel.translateCountry(
        langCode: Localizer.getCurrentLangCode(),
        countryID: zone.countryID,
      );

      final String? _cityName = CityModel.translateCity(
        city: zone.cityModel,
        langCode: Localizer.getCurrentLangCode(),
      );

      if (_countryName != null && _countryName != '...'){

        _line = _countryName;

        if (_cityName != null && _cityName != '...'){

          _line = '$_cityName, $_countryName';

        }

      }

      else {
        _line = getWord('phid_the_entire_world');
      }

    }

    return Verse(
      id: _line,
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkZonesAreIdentical({
    required ZoneModel? zone1,
    required ZoneModel? zone2,
  }){
    bool _identical = false;

    if (zone1 == null && zone2 == null){
      _identical = true;
    }

    else if (zone1 != null && zone2 != null){

      if (
          zone1.countryID == zone2.countryID &&
          zone1.cityID == zone2.cityID &&
          zone1.countryName == zone2.countryName &&
          zone1.cityName == zone2.cityName &&
          CountryModel.checkCountriesAreIdentical(zone1.countryModel, zone2.countryModel) == true &&
          CityModel.checkCitiesAreIdentical(zone1.cityModel, zone2.cityModel) == true &&
          zone1.icon == zone2.icon
      ){
        _identical = true;
      }

    }

    // if (_identical == false){
    //   blogZonesDifferences(
    //     zone1: zone1,
    //     zone2: zone2,
    //   );
    // }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkZonesIDsAreIdentical({
    required ZoneModel? zone1,
    required ZoneModel? zone2,
  }) {
    bool _zonesAreIdentical = false;

    if (
        zone1?.countryID    == zone2?.countryID &&
        zone1?.cityID       == zone2?.cityID
    ){
      _zonesAreIdentical = true;
    }

    return _zonesAreIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){

    final String _blog =
    '''
    ZoneModel(
      countryID: $countryID,
      cityID: $cityID,
      countryName: $countryName,
      cityName: $cityName,
      countryModel: $countryModel,
      cityModel: $cityModel,
      icon: $icon,
    );
    ''';

    return _blog;
   }
  // --------------------
  /// TESTED : WORKS PERFECT
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is ZoneModel){
      _areIdentical = checkZonesAreIdentical(
        zone1: this,
        zone2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      countryID.hashCode ^
      cityID.hashCode ^
      countryName.hashCode ^
      cityName.hashCode ^
      countryModel.hashCode ^
      cityModel.hashCode ^
      icon.hashCode;
  // -----------------------------------------------------------------------------
}
