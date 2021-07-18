import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/models/keywords/keys_set.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
class Zone {
  String countryID;
  String provinceID;
  String districtID;

  Zone({
    this.countryID,
    this.provinceID,
    this.districtID,
  });

  Zone clone(){
    return Zone(
      countryID: countryID,
      provinceID: provinceID,
      districtID: districtID,
    );
  }
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'countryID' : countryID,
      'provinceID' : provinceID,
      'areaID' : districtID, /// TASK : should update areaID to district ID in firebase
    };
  }
// -----------------------------------------------------------------------------
  String cipherToString(){
    return '$countryID/$provinceID/$districtID';
  }
// -----------------------------------------------------------------------------
  static Zone decipherZoneMap(Map<String, dynamic> map){

    Zone _zone = map == null ? null :
    Zone(
      countryID: map['countryID'],
      provinceID: map['provinceID'],
      districtID: map['areaID'], /// TASK : should update areaID to district ID in firebase
    );

    return _zone;
  }
// -----------------------------------------------------------------------------
  static bool zonesAreTheSame(Zone finalZone, Zone originalZone){
    bool _zonesAreTheSame = true;

    if (finalZone.countryID != originalZone.countryID){_zonesAreTheSame = false;}
    else if (finalZone.provinceID != originalZone.provinceID){_zonesAreTheSame = false;}
    else if (finalZone.districtID != originalZone.districtID){_zonesAreTheSame = false;}
    else {_zonesAreTheSame = true;}

    return _zonesAreTheSame;
  }
// -----------------------------------------------------------------------------
  static Zone decipherZoneString(String zoneString){
    String _countryID = decipherZoneStringToCountryID(zoneString);
    String _provinceID = decipherZoneStringToProvinceID(zoneString);
    String _districtID = decipherZoneStringToDistrictID(zoneString);

    return Zone(
      countryID: _countryID,
      provinceID: _provinceID,
      districtID: _districtID,
    );
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToCountryID(String zoneString){
    String _countryID = TextMod.trimTextAfterFirstSpecialCharacter(zoneString, '/');
    return _countryID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToProvinceID(String zoneString){
    String _provinceAndDistrict = TextMod.trimTextBeforeFirstSpecialCharacter(zoneString, '/');
    String _provinceID = TextMod.trimTextAfterLastSpecialCharacter(_provinceAndDistrict, '/');
    return _provinceID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToDistrictID(String zoneString){
    String _districtID = TextMod.trimTextBeforeLastSpecialCharacter(zoneString, '/');
    return _districtID;
  }
// -----------------------------------------------------------------------------
  static Zone getZoneFromIDs({String countryID, String provinceID, String districtID}){
    return Zone(
      countryID: countryID,
      provinceID: provinceID,
      districtID: districtID,
    );}
// -----------------------------------------------------------------------------
//   static Zone getZoneFromBzModel(BzModel bzModel){
//       return bzModel.bzZone;
//   }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
}
