import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/area_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
class Zone {
  String countryID;
  String provinceID;
  String areaID;

  Zone({
    this.countryID,
    this.provinceID,
    this.areaID,
  });

  Zone clone(){
    return Zone(
      countryID: countryID,
      provinceID: provinceID,
      areaID: areaID,
    );
  }
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'countryID' : countryID,
      'provinceID' : provinceID,
      'areaID' : areaID,
    };
  }
// -----------------------------------------------------------------------------
  String cipherToString(){
    return '$countryID/$provinceID/$areaID';
  }
// -----------------------------------------------------------------------------
  static Zone decipherZoneMap(Map<String, dynamic> map){

    Zone _zone = map == null ? null :
    Zone(
      countryID: map['countryID'],
      provinceID: map['provinceID'],
      areaID: map['areaID'],
    );

    return _zone;
  }
// -----------------------------------------------------------------------------
  static bool zonesAreTheSame(Zone finalZone, Zone originalZone){
    bool _zonesAreTheSame = true;

    if (finalZone.countryID != originalZone.countryID){_zonesAreTheSame = false;}
    else if (finalZone.provinceID != originalZone.provinceID){_zonesAreTheSame = false;}
    else if (finalZone.areaID != originalZone.areaID){_zonesAreTheSame = false;}
    else {_zonesAreTheSame = true;}

    return _zonesAreTheSame;
  }
// -----------------------------------------------------------------------------
  static Zone decipherZoneString(String zoneString){
    String _countryID = decipherZoneStringToCountryID(zoneString);
    String _provinceID = decipherZoneStringToProvinceID(zoneString);
    String _areaID = decipherZoneStringToAreaID(zoneString);

    return Zone(
      countryID: _countryID,
      provinceID: _provinceID,
      areaID: _areaID,
    );
  }
// -----------------------------------------------------------------------------
  /// implementation : _zone.decipherZoneToCountryID(_zoneString)
  static String decipherZoneStringToCountryID(String zoneString){
    String _countryID = trimTextAfterFirstSpecialCharacter(zoneString, '/');
    return _countryID;
  }
// -----------------------------------------------------------------------------
  /// implementation : _zone.decipherZoneToProvinceID(_zoneString)
  static String decipherZoneStringToProvinceID(String zoneString){
    String _provinceAndArea = trimTextBeforeFirstSpecialCharacter(zoneString, '/');
    String _provinceID = trimTextAfterLastSpecialCharacter(_provinceAndArea, '/');
    return _provinceID;
  }
// -----------------------------------------------------------------------------
  /// implementation : _zone.decipherZoneToAreaID(_zoneString)
  static String decipherZoneStringToAreaID(String zoneString){
    String _areaID = trimTextBeforeLastSpecialCharacter(zoneString, '/');
    return _areaID;
  }
// -----------------------------------------------------------------------------
  static Zone getZoneFromIDs({String countryID, String provinceID, String areaID}){
    return Zone(
      countryID: countryID,
      provinceID: provinceID,
      areaID: areaID,
    );}
// -----------------------------------------------------------------------------
//   static Zone getZoneFromBzModel(BzModel bzModel){
//       return bzModel.bzZone;
//   }
// -----------------------------------------------------------------------------
  static FilterModel getFilterModelFromCurrentZoneAreas(BuildContext context){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _provinceID = _countryPro.currentProvinceID;
    List<Area> _areas = _countryPro.getAreasModelsByProvinceID(context, _provinceID);

    List<KeywordModel> _areasAsKeywords = Area.getKeywordsModelsFromAreas(_areas);

    FilterModel _filterModel = FilterModel(filterID: _areasAsKeywords[0].filterID, canPickMany: false, keywordModels: _areasAsKeywords);

    return _filterModel;
  }
// -----------------------------------------------------------------------------
}
