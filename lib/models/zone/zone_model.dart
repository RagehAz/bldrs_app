import 'package:bldrs/controllers/drafters/text_mod.dart';

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
      'cityID' : cityID,
      'districtID' : districtID,
    };
  }
// -----------------------------------------------------------------------------
  String cipherToString(){
    return '$countryID/$cityID/$districtID';
  }
// -----------------------------------------------------------------------------
  static Zone decipherZoneMap(Map<String, dynamic> map){

    final Zone _zone = map == null ? null :
    Zone(
      countryID: map['countryID'],
      cityID: map['cityID'],
      districtID: map['districtID'],
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
    final String _countryID = decipherZoneStringToCountryID(zoneString);
    final String _cityID = decipherZoneStringToCityID(zoneString);
    final String _districtID = decipherZoneStringToDistrictID(zoneString);

    return Zone(
      countryID: _countryID,
      cityID: _cityID,
      districtID: _districtID,
    );
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToCountryID(String zoneString){
    final String _countryID = TextMod.trimTextAfterFirstSpecialCharacter(zoneString, '/');
    return _countryID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToCityID(String zoneString){
    final String _cityAndDistrict = TextMod.trimTextBeforeFirstSpecialCharacter(zoneString, '/');
    final String _cityID = TextMod.trimTextAfterLastSpecialCharacter(_cityAndDistrict, '/');
    return _cityID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToDistrictID(String zoneString){
    final String _districtID = TextMod.trimTextBeforeLastSpecialCharacter(zoneString, '/');
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
  static Zone dummyZone(){
    return Zone(
      countryID: 'egy',
      cityID: 'cairo',
      districtID: 'el_rehab',
    );
  }
// -----------------------------------------------------------------------------
}
