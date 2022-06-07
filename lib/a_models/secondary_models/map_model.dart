import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/foundation.dart';

class MapModel{
  /// --------------------------------------------------------------------------
  const MapModel({
    @required this.key,
    @required this.value,
});
  /// --------------------------------------------------------------------------
  final String key;
  final dynamic value;
// -----------------------------------------------------------------------------

  /// CYPHERS

// ----------------------------------------
  Map<String, dynamic> toMap(){
    return
      <String, dynamic>{
          'key': key,
          'value': value,
        };
  }
// ----------------------------------------
  static Map<String, dynamic> cipherMapModels(List<MapModel> maps){
    Map<String, dynamic> _bigMap = {};

    if (Mapper.checkCanLoopList(maps) == true){

      for (final MapModel map in maps){

        _bigMap = Mapper.insertPairInMap(
            map: _bigMap,
            key: map.key,
            value: map.value
        );

      }

    }

    return _bigMap;
  }
// ----------------------------------------
  static MapModel decipherMapModel(Map<String, dynamic> map){
    MapModel model;
    if(map != null){
      model = MapModel(key: map['key'], value: map['value']);
    }

    return model;
  }
// ----------------------------------------
  static List<MapModel> decipherMapModels(
      Map<String, dynamic> bigMap,
      {bool loopingAlgorithm = true}
      ){

    final List<MapModel> _mapModels = <MapModel>[];

    if (bigMap != null){

      /// looping key algorithm
      if (loopingAlgorithm == true){
        final List<String> _bigMapKeys = bigMap.keys;
        if (Mapper.checkCanLoopList(_bigMapKeys) == true){

          for (final String key in _bigMapKeys){

            final MapModel _mapModel = MapModel(
              key: key,
              value: bigMap[key],
            );

            _mapModels.add(_mapModel);

          }

        }
      }

      /// for each algorithm
      else {

        bigMap.forEach((String key, dynamic value){

          final MapModel _mapModel = MapModel(
            key: key,
            value: value,
          );

          _mapModels.add(_mapModel);

        }
        );

      }

    }

    return _mapModels;
  }
// -----------------------------------------------------------------------------

  /// BLOGGERS

// ----------------------------------------
  void blogMapModel(){
    blog('$key : ${value.toString()}');
  }
// ----------------------------------------
  static void blogMapModels(List<MapModel> mapModels){
    for (int i = 0; i < mapModels.length; i++){
      final int _num = i+1;
      final MapModel _mapModel = mapModels[i];
      blog('$_num : ${_mapModel.key} : ${_mapModel.value}');
    }
  }
// -----------------------------------------------------------------------------

  /// SORTING

// ----------------------------------------
  static List<MapModel> sortValuesAlphabetically(List<MapModel> mapModels){
    mapModels.sort((MapModel a, MapModel b) => a?.value?.compareTo(b?.value));
    return mapModels;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// ----------------------------------------
  static List<dynamic> getValuesFromMapModels(List<MapModel> mapModels){
    final List<dynamic> _values = <dynamic>[];

    if (Mapper.checkCanLoopList(mapModels) == true){

      for (final MapModel mm in mapModels){

        _values.add(mm.value);

      }

    }

    return _values;
  }
// ----------------------------------------
  static List<String> getKeysFromMapModels(List<MapModel> mapModels){
    final List<String> _values = <String>[];

    if (Mapper.checkCanLoopList(mapModels) == true){
      for (final MapModel mm in mapModels){
        _values.add(mm.key);
      }
    }

    return _values;
  }
// -----------------------------------------------------------------------------
}
