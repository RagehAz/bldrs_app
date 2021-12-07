import 'package:bldrs/controllers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/controllers/drafters/text_mod.dart' as TextMod;

class ZoneModel{
  /// --------------------------------------------------------------------------
  ZoneModel({
    this.countryID,
    this.cityID,
    this.districtID,
  });
  /// --------------------------------------------------------------------------
  String countryID;
  String cityID;
  String districtID;
  /// --------------------------------------------------------------------------
  ZoneModel clone(){
    return ZoneModel(
      countryID: countryID,
      cityID: cityID,
      districtID: districtID,
    );
  }
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return <String, dynamic>{
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

    if (finalZone.countryID != originalZone.countryID){
      _zonesAreTheSame = false;
    }

    else if (finalZone.cityID != originalZone.cityID){
      _zonesAreTheSame = false;
    }

    else if (finalZone.districtID != originalZone.districtID){
      _zonesAreTheSame = false;
    }

    else {
      _zonesAreTheSame = true;
    }

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
    final String _countryID = TextMod.removeTextAfterFirstSpecialCharacter(zoneString, '/');
    return _countryID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToCityID(String zoneString){
    final String _cityAndDistrict = TextMod.removeTextBeforeFirstSpecialCharacter(zoneString, '/');
    final String _cityID = TextMod.removeTextAfterLastSpecialCharacter(_cityAndDistrict, '/');
    return _cityID;
  }
// -----------------------------------------------------------------------------
  static String decipherZoneStringToDistrictID(String zoneString){
    final String _districtID = TextMod.removeTextBeforeLastSpecialCharacter(zoneString, '/');
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

    print('countryID : $countryID');
    print('cityID : $cityID');
    print('districtID : $districtID');

    print('$methodName ------------------------------- END');
  }
// -----------------------------------------------------------------------------
  bool isNotEmpty(){
    final bool _isEmpty = TextChecker.stringIsEmpty(countryID) == true;
    final bool _isNotEmpty = !_isEmpty;
    return _isNotEmpty;

  }
// -----------------------------------------------------------------------------
  static bool zoneHasAllIDs(ZoneModel zone){
    final bool _hasAllIDs = zone != null && zone.countryID != null && zone.cityID != null && zone.districtID != null;
    return _hasAllIDs;
  }
// -----------------------------------------------------------------------------
}
