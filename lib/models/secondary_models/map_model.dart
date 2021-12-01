

import 'package:flutter/foundation.dart';

class MapModel{
  final String key;
  final dynamic value;

  MapModel({
    @required this.key,
    @required this.value,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
      <String, dynamic>{
          'key': key,
          'value': value,
        };
  }
// -----------------------------------------------------------------------------
  static MapModel fromMap(Map<String, dynamic> map){
    MapModel model;
    if(map != null){
      model = MapModel(key: map['key'], value: map['value']);
    }

    return model;
  }
// -----------------------------------------------------------------------------
  static List<MapModel> getModelsFromMap(Map<String, dynamic> map){
    final List<MapModel> _models = <MapModel>[];

    if (map != null){
      map.forEach((String key, dynamic value) => _models.add(MapModel(key: key, value: value)));
    }
    return _models;
  }
// -----------------------------------------------------------------------------
}