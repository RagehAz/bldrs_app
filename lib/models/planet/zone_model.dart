import 'package:bldrs/controllers/drafters/text_manipulators.dart';

// -----------------------------------------------------------------------------
class Zone {
  String countryID;
  String cityID;
  String districtID;

  Zone({
    this.countryID,
    this.cityID,
    this.districtID,
  });

  Zone clone(){
    return Zone(
      countryID: countryID,
      cityID: cityID,
      districtID: districtID,
    );
  }
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'countryID' : countryID,
      'provinceID' : cityID,
      'areaID' : districtID, /// TASK : should update areaID to district ID in firebase
    };
  }
// -----------------------------------------------------------------------------
  String cipherToString(){
    return '$countryID/$cityID/$districtID';
  }
// -----------------------------------------------------------------------------
  static Zone decipherZoneMap(Map<String, dynamic> map){

    Zone _zone = map == null ? null :
    Zone(
      countryID: map['countryID'],
      cityID: map['provinceID'],
      districtID: map['areaID'], /// TASK : should update areaID to district ID in firebase
    );

    return _zone;
  }
// -----------------------------------------------------------------------------
  static bool zonesAreTheSame(Zone finalZone, Zone originalZone){
    bool _zonesAreTheSame = true;

    if (finalZone.countryID != originalZone.countryID){_zonesAreTheSame = false;}
    else if (finalZone.cityID != originalZone.cityID){_zonesAreTheSame = false;}
    else if (finalZone.districtID != originalZone.districtID){_zonesAreTheSame = false;}
    else {_zonesAreTheSame = true;}

    return _zonesAreTheSame;
  }
// -----------------------------------------------------------------------------
  static Zone decipherZoneString(String zoneString){
    String _countryID = decipherZoneStringToCountryID(zoneString);
    String _cityID = decipherZoneStringToCityID(zoneString);
    String _districtID = decipherZoneStringToDistrictID(zoneString);

    return Zone(
      countryID: _countryID,
      cityID: _cityID,
      districtID: _districtID,
    );
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToCountryID(String zoneString){
    String _countryID = TextMod.trimTextAfterFirstSpecialCharacter(zoneString, '/');
    return _countryID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToCityID(String zoneString){
    String _cityAndDistrict = TextMod.trimTextBeforeFirstSpecialCharacter(zoneString, '/');
    String _cityID = TextMod.trimTextAfterLastSpecialCharacter(_cityAndDistrict, '/');
    return _cityID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToDistrictID(String zoneString){
    String _districtID = TextMod.trimTextBeforeLastSpecialCharacter(zoneString, '/');
    return _districtID;
  }
// -----------------------------------------------------------------------------
  static Zone getZoneFromIDs({String countryID, String cityID, String districtID}){
    return Zone(
      countryID: countryID,
      cityID: cityID,
      districtID: districtID,
    );}
// -----------------------------------------------------------------------------
//   static Zone getZoneFromBzModel(BzModel bzModel){
//       return bzModel.bzZone;
//   }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
}
