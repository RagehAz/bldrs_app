import 'package:flutter/foundation.dart';

class City{
  final String iso3;
  final String id;
  final String name;
  final String province;
  final String type;
  final double latitude;
  final double longitude;
  final int population;
  /// dashboard manual switch to deactivate entire cities.
  final bool isActivated;
  /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  /// then all flyers will be visible to users not only between bzz
  final bool isPublic;
  final List<Namez> names; // English

  City({
    this.iso3,
    this.id,
    this.name,
    this.province,
    this.type,
    this.latitude,
    this.longitude,
    this.population,
    this.isActivated,
    this.isPublic,
    this.names,
  });

  Map<String, Object> toMap(){
    return {
      'id' : id,
      'name' : name,
      'province' : province,
      'latitude' : latitude,
      'longitude' : longitude,
      'cityPopulation' : population,
      'cityIsActivated' : isActivated,
      'cityWentPublic' : isPublic,
      'names' : names,
    };
  }

}

class Namez {
  final String languageCode;
  final String value;

  Namez({
    @required this.languageCode,
    @required this.value,
  });
  Map<String,String> toMap(){
    return {
      'languageCode' : languageCode,
      'value' : value,
    };
  }
}