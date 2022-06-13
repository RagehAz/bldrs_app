import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/foundation.dart';

@immutable
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

  /// CREATORS

// ----------------------------------------
  MapModel copyWith({
    String key,
    dynamic value,
}){

    return MapModel(
      key: key ?? this.key,
      value: value ?? this.value,
    );

  }
// -----------------------------------------------------------------------------

  /// OVERRIDES

// ----------------------------------------
  @override
  String toString() => 'MapModel(key: $key, value: ${value.toString()})';
// ----------------------------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    return other is MapModel && other.key == key && other.value == value;
  }
// ----------------------------------------
  @override
  int get hashCode => key.hashCode ^ value.hashCode;
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
  static List<MapModel> decipherMapModels(Map<String, dynamic> bigMap, {
    bool loopingAlgorithm = true
  }){

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
    blog('< $key : ${value.toString()} >');
  }
// ----------------------------------------
  static void blogMapModels({
    @required List<MapModel> mapModels,
    String methodName = 'MapModels',
  }){
    blog('$methodName ------------------------------------------- START');
    for (int i = 0; i < mapModels.length; i++){
      final int _num = i+1;
      final MapModel _mapModel = mapModels[i];
      blog('$_num : < ${_mapModel.key} : ${_mapModel.value} >');
    }
    blog('$methodName ------------------------------------------- END');
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
// ----------------------------------------
  static MapModel getModelByKey({
    @required List<MapModel> models,
    @required String key,
  }){
    MapModel _model;

    if (Mapper.checkCanLoopList(models) == true){
      _model = models.firstWhere((m) => m.key == key, orElse: ()=> null);
    }

    return _model;
  }
// -----------------------------------------------------------------------------

/// MODIFIERS

// ----------------------------------------
  static List<MapModel> replaceMapModel({
    @required List<MapModel> mapModels,
    @required MapModel mapModel,
  }){

    final List<MapModel> _output = mapModels ?? <MapModel>[];

    if (Mapper.checkCanLoopList(mapModels) && mapModel != null){

      final int _index = mapModels.indexWhere((m) => m.key == mapModel.key);

      if (_index != -1){
        mapModels.removeAt(_index);
        mapModels.insert(_index, mapModel);
      }

    }

    return _output;
  }
// ----------------------------------------
  static List<MapModel> insertMapModel({
    @required List<MapModel> mapModels,
    @required MapModel mapModel,
  }){

    List<MapModel> _output = mapModels ?? <MapModel>[];

    if (mapModel != null){

      final bool _existsAlready = checkMapExists(
          mapModels: mapModels,
          mapModel: mapModel
      );

      /// REPLACE IF EXISTS
      if (_existsAlready == true){
        _output = replaceMapModel(
            mapModels: _output,
            mapModel: mapModel
        );
      }

      /// ADD IF DOES NOT EXIST
      else {
        _output.add(mapModel);
      }

    }

    return _output;
  }

  static List<MapModel> removeMapModel({
    @required List<MapModel> mapModels,
    @required String key,
  }){

    final List<MapModel> _output = mapModels ?? <MapModel>[];

    if (key != null){

      final int _index = _output.indexWhere((mm) => mm.key == key);

      if (_index != -1){
        _output.removeAt(_index);
      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

/// CHECKERS

// ----------------------------------------
  static bool checkMapExists({
    @required List<MapModel> mapModels,
    @required MapModel mapModel,
  }){

    bool _exists = false;

    if (Mapper.checkCanLoopList(mapModels) && mapModel != null){

      final MapModel _found = getModelByKey(
        models: mapModels,
        key: mapModel.key,
      );


      if (_found != null){
        _exists = true;
      }

    }

    return _exists;
  }
// ----------------------------------------
}
