import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
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
  /// TESTED : WORKS PERFECT
  static bool checkZonesIDsAreIdentical({
    @required ZoneModel zone1,
    @required ZoneModel zone2,
  }) {
    bool _zonesAreIdentical = true;

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

    return _zonesAreIdentical;
  }
// -------------------------------------
  bool isNotEmpty() {
    final bool _isEmpty = TextChecker.stringIsEmpty(countryID) == true;
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
    final String _inn = superPhrase(context, 'phid_inn');

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
}
