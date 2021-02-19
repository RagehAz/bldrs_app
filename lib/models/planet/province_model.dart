import 'package:flutter/foundation.dart';
import 'namez_model.dart';
// ---------------------------------------------------------------------------
class Province{
  final String iso3;
  final String name;
  // hierarchy should be
  // Country - Province - City - Area
  // for Egypt, cities are diluted into areas instead
  // final List<Area> areas;
  // final int population;
  // /// dashboard manual switch to deactivate entire cities.
  // final bool isActivated;
  // /// automatic switch when flyers reach 'city publishing-target ~ 1000 flyers'
  // /// then all flyers will be visible to users not only between bzz
  // final bool isPublic;
  final List<Namez> names; // English

  Province({
    this.iso3,
    this.name,
    // this.areas,
    // this.population,
    // this.isActivated,
    // this.isPublic,
    this.names,
  });

  Map<String, Object> toMap(){
    return {
      'iso3' : iso3,
      'name' : name,
      // 'areas' : areas,
      // 'population' : population,
      // 'isActivated' : isActivated,
      // 'isPublic' : isPublic,
      'names' : names,
    };
  }

}
// ---------------------------------------------------------------------------
