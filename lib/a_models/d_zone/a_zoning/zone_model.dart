import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class ZoneModel {
  /// --------------------------------------------------------------------------
  const ZoneModel({
    @required this.countryID,
    this.cityID,
    this.districtID,
    this.countryName,
    this.cityName,
    this.districtName,
    this.countryModel,
    this.cityModel,
    this.districtModel,
    this.icon,
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
  final DistrictModel districtModel;
  final String icon;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> prepareZoneForEditing({
    @required BuildContext context,
    @required ZoneModel zoneModel,
  }) async {

    final ZoneModel _zone =
            zoneModel
            ??
            ZoneProvider.proGetCurrentZone(context: context, listen: false)
            ??
            await ZoneProtocols.getZoneByIP(context: context);

    return ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _zone,
    );

  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ZoneModel copyWith({
    String countryID,
    String cityID,
    String districtID,
    String countryName,
    String cityName,
    String districtName,
    CountryModel countryModel,
    CityModel cityModel,
    DistrictModel districtModel,
    String icon,
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
      districtModel: districtModel ?? this.districtModel,
      icon: icon ?? this.icon,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  ZoneModel nullifyField({
    bool countryID = false,
    bool cityID = false,
    bool districtID = false,
    bool countryName = false,
    bool cityName = false,
    bool districtName = false,
    bool countryModel = false,
    bool cityModel = false,
    bool districtModel = false,
    bool icon = false,
  }){
    return ZoneModel(
      countryID: countryID == true ? null : this.countryID,
      cityID: cityID == true ? null : this.cityID,
      districtID: districtID == true ? null : this.districtID,
      countryName: countryName == true ? null : this.countryName,
      cityName: cityName == true ? null : this.cityName,
      districtName: districtName == true ? null : this.districtName,
      countryModel: countryModel == true ? null : this.countryModel,
      cityModel: cityModel == true ? null : this.cityModel,
      districtModel: districtModel == true ? null : this.districtModel,
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
      'districtID': districtID,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel decipherZone(Map<String, dynamic> map) {


    if (map == null){
      return null;
    }

    else {
      return ZoneModel(
        countryID: map['countryID'],
        cityID: map['cityID'],
        districtID: map['districtID'],
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String cipherToString() {
    return '$countryID/$cityID/$districtID';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static String decipherZoneStringToCountryID(String zoneString) {
    return TextMod.removeTextAfterFirstSpecialCharacter(zoneString, '/');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String decipherZoneStringToCityID(String zoneString) {
    final String _cityAndDistrict = TextMod.removeTextBeforeFirstSpecialCharacter(zoneString, '/');
    return TextMod.removeTextAfterLastSpecialCharacter(_cityAndDistrict, '/');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String decipherZoneStringToDistrictID(String zoneString) {
    return TextMod.removeTextBeforeLastSpecialCharacter(zoneString, '/');
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
          DistrictModel.checkDistrictsAreIdentical(zone1.districtModel, zone2.districtModel) == true &&
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
    @required ZoneModel zone1,
    @required ZoneModel zone2,
  }) {
    bool _zonesAreIdentical = false;

    if (
        zone1?.countryID    == zone2?.countryID &&
        zone1?.cityID       == zone2?.cityID &&
        zone1?.districtID   == zone2?.districtID
    ){
      _zonesAreIdentical = true;
    }

    return _zonesAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool isNotEmpty() {
    final bool _isEmpty = TextCheck.isEmpty(countryID) == false;
    final bool _isNotEmpty = !_isEmpty;
    return _isNotEmpty;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool zoneHasAllIDs(ZoneModel zone) {
    final bool _hasAllIDs = zone != null &&
        zone.countryID != null &&
        zone.cityID != null &&
        zone.districtID != null;
    return _hasAllIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkZoneHasCountryAndCityIDs(ZoneModel zone){
    final bool _has = zone != null &&
        zone.countryID != null &&
        zone.cityID != null;
    return _has;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogZone({String invoker = 'ZONE - PRINT'}) {
    blog('$invoker ------------------------------- START');

    blog('IDs [ $districtID - $cityID - $countryID ]');
    blog('names [ $districtName - $cityName - $countryName ]');
    blog('models [ districtModelExists: ${districtModel != null} / cityModelExists : ${cityModel != null} / countryModelExists : ${countryModel != null} ]');

    blog('$invoker ------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogZoneIDs({String invoker = 'ZONE-IDs BLOG : '}){

    blog('$invoker [ $districtID - $cityID - $countryID ]');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
      if (DistrictModel.checkDistrictsAreIdentical(zone1.districtModel, zone2.districtModel) == false){
        blog('districtModels are not Identical');
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
      cityID: 'egy_cairo',
      districtID: 'el_rehab',
    );
  }
  // -----------------------------------------------------------------------------

  /// STRING GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse generateInZoneVerse ({
    @required BuildContext context,
    @required ZoneModel zoneModel,
    bool showCity = true,
    bool showDistrict = true,
  }){

    // zoneModel?.blogZone(invoker: 'translateZoneString');

    String _text = '...';
    final String _inn = xPhrase(context, 'phid_inn');

    if (zoneModel != null){

      if (zoneModel.countryID != null){

        final String _countryName = Flag.getCountryNameByCurrentLang(
          context: context,
          countryID: zoneModel.countryID,
        );

        _text = '$_inn $_countryName';


        if (showCity == true && zoneModel.cityModel != null){

          final String _cityName = CityModel.translateCity(
            context: context,
            city: zoneModel.cityModel,
          );

          _text = '$_inn $_cityName, $_countryName';

          if (showDistrict == true && zoneModel.districtModel != null){

            final String _districtName = DistrictModel.translateDistrict(
                context: context,
                district: zoneModel.districtModel,
            );

            _text = '$_inn $_districtName, $_cityName, $_countryName';

          }

        }

      }

    }

    return Verse(
      text: _text,
      translate: false,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse generateObeliskVerse({
    @required BuildContext context,
    @required ZoneModel zone,
  }){

    String _line = xPhrase(context, 'phid_select_a_country');

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

    return Verse(
      text: _line,
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
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
      districtID.hashCode ^
      countryName.hashCode ^
      cityName.hashCode ^
      districtName.hashCode ^
      countryModel.hashCode ^
      cityModel.hashCode ^
      districtModel.hashCode ^
      icon.hashCode;
  // -----------------------------------------------------------------------------
}
