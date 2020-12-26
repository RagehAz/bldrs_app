import 'package:flutter/foundation.dart';

class CountryModel{
  final String countryISO3;
  final String countryISO2;
  final String countryName;
  final String regionID;
  final String countryFlag;
  final bool countryIsActivated;
  final bool countryWentGlobal;

  CountryModel({
    @required this.countryISO3,
    @required this.countryISO2,
    @required this.countryName,
    @required this.regionID,
    @required this.countryFlag,
    @required this.countryIsActivated,
    @required this.countryWentGlobal,
  });
}