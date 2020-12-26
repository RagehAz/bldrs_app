import 'package:flutter/foundation.dart';

class CityModel {
  final int cityID;
  final String cityName;
  final String cityNameASCII;
  final String cityNameAdmin;
  final double latitude;
  final double longitude;
  final String countryISO3;
  final int cityPopulation;
  final bool cityIsActivated;
  final bool cityWentPublic;

  CityModel({
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