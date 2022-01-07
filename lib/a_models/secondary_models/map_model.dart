

import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/foundation.dart';

class MapModel{
  /// --------------------------------------------------------------------------
  MapModel({
    @required this.key,
    @required this.value,
});
  /// --------------------------------------------------------------------------
  final String key;
  final dynamic value;
  /// --------------------------------------------------------------------------
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
  void blogMapModel(){
    blog('$key : ${value.toString()}');
  }
// -----------------------------------------------------------------------------
  static void blogMapModels(List<MapModel> mapModels){
    for (int i = 0; i < mapModels.length; i++){
      final int _num = i+1;
      final MapModel _mapModel = mapModels[i];
      blog('$_num : ${_mapModel.key} : ${_mapModel.value}');
    }
  }
// -----------------------------------------------------------------------------
}
