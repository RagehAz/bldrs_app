import 'package:bldrs/controllers/drafters/text_mod.dart';

class ZoneModel{
  String countryID;
  String cityID;
  String districtID;

  ZoneModel({
    this.countryID,
    this.cityID,
    this.districtID,
  });

  ZoneModel clone(){
    return ZoneModel(
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
  static ZoneModel decipherZoneMap(Map<String, dynamic> map){

    final ZoneModel _zone = map == null ? null :
    ZoneModel(
      countryID: map['countryID'],
      cityID: map['cityID'],
      districtID: map['districtID'],
    );

    return _zone;
  }
// -----------------------------------------------------------------------------
  static bool zonesAreTheSame(ZoneModel finalZone, ZoneModel originalZone){
    bool _zonesAreTheSame = true;

    if (finalZone.countryID != originalZone.countryID){_zonesAreTheSame = false;}
    else if (finalZone.cityID != originalZone.cityID){_zonesAreTheSame = false;}
    else if (finalZone.districtID != originalZone.districtID){_zonesAreTheSame = false;}
    else {_zonesAreTheSame = true;}

    return _zonesAreTheSame;
  }
// -----------------------------------------------------------------------------
  static ZoneModel decipherZoneString(String zoneString){
    final String _countryID = decipherZoneStringToCountryID(zoneString);
    final String _cityID = decipherZoneStringToCityID(zoneString);
    final String _districtID = decipherZoneStringToDistrictID(zoneString);

    return ZoneModel(
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
  static ZoneModel getZoneFromIDs({String countryID, String cityID, String districtID}){
    return ZoneModel(
      countryID: countryID,
      cityID: cityID,
      districtID: districtID,
    );}
// -----------------------------------------------------------------------------
//   static Zone getZoneFromBzModel(BzModel bzModel){
//       return bzModel.bzZone;
//   }
// -----------------------------------------------------------------------------
  static ZoneModel dummyZone(){
    return ZoneModel(
      countryID: 'egy',
      cityID: 'egy_cairo',
      districtID: 'el_rehab',
    );
  }
// -----------------------------------------------------------------------------
  void printZone({String methodName = 'ZONE - PRINT'}){

    print('$methodName ------------------------------- START');

    print('countryID : ${countryID}');
    print('cityID : ${cityID}');
    print('districtID : ${districtID}');

    print('$methodName ------------------------------- END');
  }
// -----------------------------------------------------------------------------
  static bool zoneHasAllIDs(ZoneModel zone){
    final bool _hasAllIDs = zone != null && zone.countryID != null && zone.cityID != null && zone.districtID != null;
    return _hasAllIDs;
  }
// -----------------------------------------------------------------------------
}
