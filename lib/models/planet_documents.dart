import 'package:flutter/foundation.dart';

class CityDocument {
  final int cityID;
  final String cityName;
  final String cityNameASCII;
  final String cityNameAdmin;
  final double latitude;
  final double longitude;
  final String countryISO3;
  /// for statistics
  final int cityPopulation;
  /// some cities will be in database but we need to hide from the cities screens
  /// for business and political reasons
  final bool cityIsActivated;
  /// when bzz & flyers reach certain numbers, this should turn true,, and flyers
  /// then can be viewed by users,, w nshaghal kahareb in this city for going live
  final bool cityWentPublic;

  CityDocument({
    @required this.cityID,
    @required this.cityName,
    @required this.cityNameASCII,
    @required this.cityNameAdmin,
    @required this.latitude,
    @required this.longitude,
    @required this.countryISO3,
    @required this.cityPopulation,
    @required this.cityIsActivated,
    @required this.cityWentPublic,
  });
}


class CountryDocument{
  /// which is the country ID that consists of 3 letters
  final String countryISO3;
  /// country ID with only 2 letters,, will be needed at somePoint
  final String countryISO2;
  final String countryName;
  final String regionID;
  final String countryFlag;
  /// controlled automatically by certain equation to allow the country's
  /// flyers to be viewable to users or not
  final bool countryIsActivated;
  /// controlled automatically by certain quation to allow the bzz of a country
  /// to communicate & publish in another countries,, and allow other countries
  /// to view this country's content
  final bool countryWentGlobal;

  CountryDocument({
    @required this.countryISO3,
    @required this.countryISO2,
    @required this.countryName,
    @required this.regionID,
    @required this.countryFlag,
    @required this.countryIsActivated,
    @required this.countryWentGlobal,
  });
}


/// because I can
class RegionDocument{
  final String regionID;
  final String regionName;
  final String continentID;

  RegionDocument({
    @required this.regionID,
    @required this.regionName,
    @required this.continentID,
  });
}

/// because I will
class ContinentDocument{
  final String continentID;
  final String continentName;

  ContinentDocument({
    @required this.continentID,
    @required this.continentName,
  });
}
