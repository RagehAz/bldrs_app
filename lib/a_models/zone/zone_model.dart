import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class ZoneModel {
  /// --------------------------------------------------------------------------
  ZoneModel({
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
  String countryID;
  String cityID;
  String districtID;

  String countryName;
  String cityName;
  String districtName;
  CountryModel countryModel;
  CityModel cityModel;
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

  /// CLONING

// -------------------------------------
  ZoneModel clone() {
    return ZoneModel(
      countryID: countryID,
      cityID: cityID,
      districtID: districtID,
    );
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool zonesAreTheSame(ZoneModel finalZone, ZoneModel originalZone) {
    bool _zonesAreTheSame = true;

    if (finalZone.countryID != originalZone.countryID) {
      _zonesAreTheSame = false;
    }

    else if (finalZone.cityID != originalZone.cityID) {
      _zonesAreTheSame = false;
    }

    else if (finalZone.districtID != originalZone.districtID) {
      _zonesAreTheSame = false;
    }

    else {
      _zonesAreTheSame = true;
    }

    return _zonesAreTheSame;
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
// -----------------------------------------------------------------------------

  /// BLOGGING

// -------------------------------------
  void blogZone({String methodName = 'ZONE - PRINT'}) {
    blog('$methodName ------------------------------- START');

    blog('countryID : $countryID');
    blog('cityID : $cityID');
    blog('districtID : $districtID');

    blog('$methodName ------------------------------- END');
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// -------------------------------------
  static ZoneModel dummyZone() {
    return ZoneModel(
      countryID: 'egy',
      cityID: 'egy_cairo',
      districtID: 'el_rehab',
    );
  }
// -----------------------------------------------------------------------------

  /// STRING GENERATORS

// -------------------------------------
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
// -----------------------------------------------------------------------------
}
