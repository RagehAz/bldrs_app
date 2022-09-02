import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/zone_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

@immutable
class ZoneModel {
  /// --------------------------------------------------------------------------
  const ZoneModel({
    this.countryID,
    this.cityID,
    this.districtID,
    this.countryName,
    this.cityName,
    this.districtName,
    this.countryModel,
    this.cityModel,
    this.flag,
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  final String cityID;
  final String districtID;
  final String countryName;
  final String cityName;
  final String districtName;
  final CountryModel countryModel;
  final CityModel cityModel;
  final String flag;
// -----------------------------------------------------------------------------

  /// INITIALIZATION

// -----------------------------------
  static Future<ZoneModel> initializeZoneForEditing({
    @required BuildContext context,
    @required ZoneModel zoneModel,
  }) async {

    final ZoneModel _zone = zoneModel ?? ZoneProvider.proGetCurrentZone(
      context: context,
      listen: false,
    ) ?? await ZoneFireOps.superGetZoneByIP(context);

    return ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _zone,
    );

  }
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  ZoneModel copyWith({
    String countryID,
    String cityID,
    String districtID,
    String countryName,
    String cityName,
    String districtName,
    CountryModel countryModel,
    CityModel cityModel,
    String flag,
  }){
    return ZoneModel(
      countryID: countryID ?? this.countryID,
      cityID: cityID ?? this.cityID,
      districtID: districtID ?? this.districtID,
      countryName: countryName ?? this.countryName,
      cityName: cityName ?? this.cityName,
      districtName: districtName ?? this.districtName,
      countryModel: countryModel ?? this.countryModel,
      cityModel: cityModel ?? this.cityModel,
      flag: flag ?? this.flag,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryID': countryID,
      'cityID': cityID,
      'districtID': districtID,
    };
  }
// -------------------------------------
  static ZoneModel decipherZoneMap(Map<String, dynamic> map) {
    final ZoneModel _zone = map == null ? null :
    ZoneModel(
      countryID: map['countryID'],
      cityID: map['cityID'],
      districtID: map['districtID'],
    );

    return _zone;
  }
// -------------------------------------
  String cipherToString() {
    return '$countryID/$cityID/$districtID';
  }
// -------------------------------------
  static ZoneModel decipherZoneString(String zoneString) {
    final String _countryID = decipherZoneStringToCountryID(zoneString);
    final String _cityID = decipherZoneStringToCityID(zoneString);
    final String _districtID = decipherZoneStringToDistrictID(zoneString);

    return ZoneModel(
      countryID: _countryID,
      cityID: _cityID,
      districtID: _districtID,
    );
  }
// -------------------------------------
  static String decipherZoneStringToCountryID(String zoneString) {
    final String _countryID = TextMod.removeTextAfterFirstSpecialCharacter(zoneString, '/');
    return _countryID;
  }
// -------------------------------------
  static String decipherZoneStringToCityID(String zoneString) {
    final String _cityAndDistrict = TextMod.removeTextBeforeFirstSpecialCharacter(zoneString, '/');
    final String _cityID = TextMod.removeTextAfterLastSpecialCharacter(_cityAndDistrict, '/');
    return _cityID;
  }
// -------------------------------------
  static String decipherZoneStringToDistrictID(String zoneString) {
    final String _districtID =
    TextMod.removeTextBeforeLastSpecialCharacter(zoneString, '/');
    return _districtID;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------

  static bool checkZonesAreIdentical({
    @required ZoneModel zone1,
    @required ZoneModel zone2,
  }){
    bool _identical = false;

    if (zone1 == null && zone2 == null){
      _identical = true;
    }
    else if (zone1 != null && zone2 != null){

      if (
      zone1.countryID == zone2.countryID &&
      zone1.cityID == zone2.cityID &&
      zone1.districtID == zone2.districtID &&
      zone1.countryName == zone2.countryName &&
      zone1.cityName == zone2.cityName &&
      zone1.districtName == zone2.districtName &&
      CountryModel.checkCountriesAreIdentical(zone1.countryModel, zone2.countryModel) == true &&
      CityModel.checkCitiesAreIdentical(zone1.cityModel, zone2.cityModel) == true &&
      zone1.flag == zone2.flag
      ){
        _identical = true;
      }

    }

    if (_identical == false){
      blogZonesDifferences(
          zone1: zone1,
          zone2: zone2,
      );
    }

    return _identical;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkZonesIDsAreIdentical({
    @required ZoneModel zone1,
    @required ZoneModel zone2,
  }) {
    bool _zonesAreIdentical = true;

    if (zone1 == null && zone2 == null){
      _zonesAreIdentical = true;
    }

    else {

      if (zone1 != null && zone2 != null){

        if (zone1.countryID != zone2.countryID) {
          _zonesAreIdentical = false;
        }

        else if (zone1.cityID != zone2.cityID) {
          _zonesAreIdentical = false;
        }

        else if (zone1.districtID != zone2.districtID) {
          _zonesAreIdentical = false;
        }

        else {
          _zonesAreIdentical = true;
        }

      }
      else {
        _zonesAreIdentical = false;
      }

    }


    return _zonesAreIdentical;
  }
// -------------------------------------
  bool isNotEmpty() {
    final bool _isEmpty = Stringer.checkStringIsEmpty(countryID) == true;
    final bool _isNotEmpty = !_isEmpty;
    return _isNotEmpty;
  }
// -------------------------------------
  static bool zoneHasAllIDs(ZoneModel zone) {
    final bool _hasAllIDs = zone != null &&
        zone.countryID != null &&
        zone.cityID != null &&
        zone.districtID != null;
    return _hasAllIDs;
  }
// -------------------------------------
  static bool checkZoneHasCountryAndCityIDs(ZoneModel zone){
    final bool _has = zone != null &&
        zone.countryID != null &&
        zone.cityID != null;
    return _has;
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// -------------------------------------
  void blogZone({String methodName = 'ZONE - PRINT'}) {
    blog('$methodName ------------------------------- START');

    blog('IDs [ $districtID - $cityID - $countryID ]');
    blog('names [ $districtName - $cityName - $countryName ]');
    blog('models [ cityModelExists : ${cityModel != null} - countryModelExists : ${countryModel != null} ]');

    blog('$methodName ------------------------------- END');
  }
// -------------------------------------
  void blogZoneIDs({String methodName = 'ZONE-IDs BLOG : '}){

    blog('$methodName [ $districtID - $cityID - $countryID ]');

  }

  static void blogZonesDifferences({
  @required ZoneModel zone1,
    @required ZoneModel zone2,
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
      if (zone1.districtID != zone2.districtID){
        blog('districtIDs are not Identical');
      }
      if (zone1.countryName != zone2.countryName){
        blog('countryNames are not Identical');
      }
      if (zone1.cityName != zone2.cityName){
        blog('cityNames are not Identical');
      }
      if (zone1.districtName != zone2.districtName){
        blog('districtNames are not Identical');
      }
      if (CountryModel.checkCountriesAreIdentical(zone1.countryModel, zone2.countryModel) == false){
        blog('countryModels are not Identical');
      }
      if (CityModel.checkCitiesAreIdentical(zone1.cityModel, zone2.cityModel) == false){
        blog('cityModels are not Identical');
      }
      if (zone1.flag != zone2.flag){
        blog('flags are not Identical');
      }

    }

    blog('blogZonesDifferences ---------- END');
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// -------------------------------------
  static ZoneModel dummyZone() {
    return const ZoneModel(
      countryID: 'egy',
      cityID: 'egy_cairo',
      districtID: 'el_rehab',
    );
  }
// -----------------------------------------------------------------------------

  /// STRING GENERATORS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateZoneString ({
    @required BuildContext context,
    @required ZoneModel zoneModel,
    bool showCity = true,
    bool showDistrict = true,
  }){

    String _verse = '...';
    const String _inn = 'phid_inn';

    if (zoneModel?.countryID != null){

      final String _countryName = CountryModel.getTranslatedCountryName(
        context: context,
        countryID: zoneModel.countryID,
      );

      _verse = '$_inn $_countryName';

      if (showCity == true && zoneModel?.cityModel != null){

        final String _cityName = CityModel.getTranslatedCityNameFromCity(
          context: context,
          city: zoneModel.cityModel,
        );

        _verse = '$_inn $_cityName, $_countryName';

        if (showDistrict == true && zoneModel.districtID != null){

          final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
            context: context,
            city: zoneModel.cityModel,
            districtID: zoneModel.districtID,
          );

          _verse = '$_inn $_districtName, $_cityName, $_countryName';

        }

      }

    }

    return _verse;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateObeliskString({
    @required BuildContext context,
    @required ZoneModel zone,
  }){

    String _line = 'Select Country';

    if (zone != null){

      if (zone.countryName != null && zone.countryName != '...'){

        _line = zone?.countryName;

        if (zone.cityName != null && zone.cityName != '...'){

          _line = '${zone?.cityName}, ${zone?.countryName}';

          if (zone.districtName != null && zone.districtName != '...'){

            _line = '${zone?.districtName}, ${zone?.cityName}, ${zone?.countryName}';

          }

        }

      }

    }

    return _line;
  }
// -----------------------------------------------------------------------------

  /// OVERRIDES

// ----------------------------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
// ----------------------------------------
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
// ----------------------------------------
  @override
  int get hashCode =>
      countryID.hashCode ^
      cityID.hashCode ^
      districtID.hashCode ^
      countryName.hashCode ^
      cityName.hashCode ^
      districtName.hashCode ^
      countryModel.hashCode ^
      cityModel.hashCode ^
      flag.hashCode;
// -----------------------------------------------------------------------------
}
