import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

@immutable
class MapModel{
  /// --------------------------------------------------------------------------
  //  NOTE : A LIST OF MAP MODELS SHOULD NEVER ALLOW DUPLICATE KEYS
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

  // --------------------
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

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return
      <String, dynamic>{
        'key': key,
        'value': value,
      };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static MapModel decipherMapModel(Map<String, dynamic> map){
    MapModel model;
    if(map != null){
      model = MapModel(key: map['key'], value: map['value']);
    }

    return model;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<MapModel> decipherMapModels(Map<String, dynamic> bigMap, {
    bool loopingAlgorithm = true
  }){

    final List<MapModel> _mapModels = <MapModel>[];

    if (bigMap != null){

      /// looping key algorithm
      if (loopingAlgorithm == true){
        final List<String> _bigMapKeys = bigMap.keys.toList();
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

  // --------------------
  void blogMapModel(){
    blog('< $key : ${value.toString()} >');
  }
  // --------------------
  static void blogMapModels({
    @required List<MapModel> mapModels,
    String invoker = 'MapModels',
  }){
    blog('$invoker ------------------------------------------- START');
    for (int i = 0; i < mapModels.length; i++){
      final int _num = i+1;
      final MapModel _mapModel = mapModels[i];
      blog('$_num : < ${_mapModel.key} : ${_mapModel.value} >');
    }
    blog('$invoker ------------------------------------------- END');
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  static List<MapModel> sortValuesAlphabetically(List<MapModel> mapModels){
    mapModels.sort((MapModel a, MapModel b) => a?.value?.compareTo(b?.value));
    return mapModels;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<dynamic> getValuesFromMapModels(List<MapModel> mapModels){
    final List<dynamic> _values = <dynamic>[];

    if (Mapper.checkCanLoopList(mapModels) == true){

      for (final MapModel mm in mapModels){

        if (mm != null){
          if (mm?.value != null){
            _values.add(mm.value);
          }
        }

      }

    }

    return _values;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getKeysFromMapModels(List<MapModel> mapModels){
    final List<String> _values = <String>[];

    if (Mapper.checkCanLoopList(mapModels) == true){
      for (final MapModel mm in mapModels){

        if (mm != null){
          if (mm?.key != null){
            _values.add(mm.key);
          }
        }

      }
    }

    return _values;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  static List<MapModel> getModelsByKeys({
    @required List<MapModel> allModels,
    @required List<String> keys,
  }){
    final List<MapModel> _output = <MapModel>[];

    if (Mapper.checkCanLoopList(allModels) == true
        &&
        Mapper.checkCanLoopList(keys) == true
    ){

      for (final String key in keys){

        final MapModel _model = getModelByKey(
            models: allModels,
            key: key
        );

        _output.add(_model);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
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
  // --------------------
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
  // --------------------
  static List<MapModel> removeMapsWithThisValue({
    @required List<MapModel> mapModels,
    @required dynamic value,
  }){
    final List<MapModel> _output = mapModels ?? <MapModel>[];

    if (Mapper.checkCanLoopList(mapModels) == true && value != null){
      _output.removeWhere((element) => element.value  == value);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
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
  // --------------------
  static bool checkMapsIncludeThisKey({
    @required List<MapModel> mapModels,
    @required String key,
  }){
    bool _include = false;

    if (Mapper.checkCanLoopList(mapModels) == true){

      final MapModel _map = mapModels.firstWhere(
              (element) => element.key == key,
          orElse: () => null
      );

      if (_map != null){
        _include = true;
      }

    }

    return _include;
  }
  // --------------------
  static bool checkMapModelsListsAreIdentical({
    @required List<MapModel> models1,
    @required List<MapModel> models2,
  }){
    bool _output = false;

    if (models1 == null && models2 == null){
      _output = true;
    }
    else if (models1.isEmpty && models2.isEmpty){
      _output = true;
    }
    else if (models1 != null && models2 != null){

      if (models1.length != models2.length){
        _output = false;
      }

      else {

        for (int i = 0; i < models1.length; i++){

          final bool _areIdentical =  models1[i] == models2[i];

          if (_areIdentical == false){
            _output = false;
            break;
          }

          else {
            _output = true;
          }

        }

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() => 'MapModel(key: $key, value: ${value.toString()})';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    return other is MapModel && other.key == key && other.value == value;
  }
  // --------------------
  @override
  int get hashCode => key.hashCode ^ value.hashCode;
  // -----------------------------------------------------------------------------
}
