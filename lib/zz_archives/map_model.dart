// import 'package:basics/helpers/checks/tracers.dart';
// import 'package:basics/helpers/maps/lister.dart';
// import 'package:basics/helpers/maps/mapper.dart';
// import 'package:collection/collection.dart';
// import 'package:flutter/foundation.dart';
//
// @immutable
// class MapModel{
//   /// --------------------------------------------------------------------------
//   //  NOTE : A LIST OF MAP MODELS SHOULD NEVER ALLOW DUPLICATE KEYS
//   /// --------------------------------------------------------------------------
//   const MapModel({
//     required this.key,
//     required this.value,
//   });
//   /// --------------------------------------------------------------------------
//   final String? key;
//   final dynamic value;
//   // -----------------------------------------------------------------------------
//
//   /// CREATORS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   MapModel copyWith({
//     String? key,
//     dynamic value,
//   }){
//
//     return MapModel(
//       key: key ?? this.key,
//       value: value ?? this.value,
//     );
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// CYPHERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Map<String, dynamic> toMap(){
//     return
//       <String, dynamic>{
//         'key': key,
//         'value': value,
//       };
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Map<String, dynamic> cipherMapModels(List<MapModel>? maps){
//     Map<String, dynamic> _bigMap = {};
//
//     if (Lister.checkCanLoop(maps) == true){
//
//       for (final MapModel map in maps!){
//
//         _bigMap = Mapper.insertPairInMap(
//           map: _bigMap,
//           key: map.key,
//           value: map.value,
//           overrideExisting: true,
//         );
//
//       }
//
//     }
//
//     return _bigMap;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static MapModel? decipherMapModel(Map<String, dynamic>? map){
//     MapModel? model;
//     if(map != null){
//       model = MapModel(key: map['key'], value: map['value']);
//     }
//
//     return model;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<MapModel> decipherMapModels(Map<String, dynamic>? bigMap, {
//     bool loopingAlgorithm = true
//   }){
//
//     final List<MapModel> _mapModels = <MapModel>[];
//
//     if (bigMap != null){
//
//       /// looping key algorithm
//       if (loopingAlgorithm == true){
//         final List<String> _bigMapKeys = bigMap.keys.toList();
//         if (Lister.checkCanLoop(_bigMapKeys) == true){
//
//           for (final String key in _bigMapKeys){
//
//             final MapModel _mapModel = MapModel(
//               key: key,
//               value: bigMap[key],
//             );
//
//             _mapModels.add(_mapModel);
//
//           }
//
//         }
//       }
//
//       /// for each algorithm
//       else {
//
//         bigMap.forEach((String key, dynamic value){
//
//           final MapModel _mapModel = MapModel(
//             key: key,
//             value: value,
//           );
//
//           _mapModels.add(_mapModel);
//
//         }
//         );
//
//       }
//
//     }
//
//     return _mapModels;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Map<String, int> cipherIntsMapModels(List<MapModel>? maps){
//     final Map<String, int> _ints = {};
//
//     if (Lister.checkCanLoop(maps) == true){
//
//       for (final MapModel map in maps!){
//
//         if (map.key != null && map.value != null && map.value is int){
//           _ints[map.key!] = map.value;
//         }
//
//       }
//
//     }
//
//     return _ints;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// BLOGGERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   void blogMapModel(){
//     blog('< $key : $value >');
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static void blogMapModels({
//     required List<MapModel>? phidsMaps,
//     String invoker = 'MapModels',
//   }){
//     blog('$invoker ------------------------------------------- START');
//     if (Lister.checkCanLoop(phidsMaps) == true){
//       for (int i = 0; i < phidsMaps!.length; i++){
//         final int _num = i+1;
//         final MapModel _mapModel = phidsMaps[i];
//         blog('$_num : < ${_mapModel.key} : ${_mapModel.value} >');
//       }
//     }
//     else {
//       blog('phidsMaps is null or empty');
//     }
//     blog('$invoker ------------------------------------------- END');
//   }
//   // -----------------------------------------------------------------------------
//
//   /// SORTING
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<MapModel>? sortValuesAlphabetically(List<MapModel>? mapModels){
//     mapModels?.sort((MapModel a, MapModel b) => a.value?.compareTo(b.value));
//     return mapModels;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// GETTERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<dynamic> getValuesFromMapModels(List<MapModel>? mapModels){
//     final List<dynamic> _values = <dynamic>[];
//
//     if (Lister.checkCanLoop(mapModels) == true){
//
//       for (final MapModel mm in mapModels!){
//
//           if (mm.value != null){
//             _values.add(mm.value);
//           }
//
//       }
//
//     }
//
//     return _values;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<String> getKeysFromMapModels(List<MapModel>? mapModels){
//     final List<String> _values = <String>[];
//
//     if (Lister.checkCanLoop(mapModels) == true){
//       for (final MapModel mm in mapModels!){
//
//         final String? _key = mm.key;
//
//           if (_key != null){
//             _values.add(_key);
//           }
//
//       }
//     }
//
//     return _values;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static MapModel? getModelByKey({
//     required List<MapModel>? models,
//     required String? key,
//   }){
//     MapModel? _model;
//
//     if (Lister.checkCanLoop(models) == true){
//       _model = models!.firstWhereOrNull((m) => m.key == key);
//     }
//
//     return _model;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<MapModel> getModelsByKeys({
//     required List<MapModel>? allModels,
//     required List<String>? keys,
//   }){
//     final List<MapModel> _output = <MapModel>[];
//
//     if (Lister.checkCanLoop(allModels) == true
//         &&
//         Lister.checkCanLoop(keys) == true
//     ){
//
//       for (final String key in keys!){
//
//         final MapModel? _model = getModelByKey(
//             models: allModels,
//             key: key
//         );
//
//         if (_model != null){
//           _output.add(_model);
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// MODIFIERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<MapModel> replaceMapModel({
//     required List<MapModel>? mapModels,
//     required MapModel? mapModel,
//   }){
//
//     final List<MapModel> _output = mapModels ?? <MapModel>[];
//
//     if (Lister.checkCanLoop(mapModels) && mapModel != null){
//
//       final int _index = mapModels!.indexWhere((m) => m.key == mapModel.key);
//
//       if (_index != -1){
//         mapModels.removeAt(_index);
//         mapModels.insert(_index, mapModel);
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TASK : TEST ME
//   static List<MapModel> insertMapModel({
//     required List<MapModel>? mapModels,
//     required MapModel? mapModel,
//     bool replaceExistingID = true,
//   }){
//
//     List<MapModel> _output = mapModels ?? <MapModel>[];
//
//     if (mapModel != null){
//
//       final bool _existsAlready = checkMapExists(
//           mapModels: mapModels,
//           mapModel: mapModel
//       );
//
//       /// REPLACE IF EXISTS
//       if (_existsAlready == true){
//         _output = replaceMapModel(
//             mapModels: _output,
//             mapModel: mapModel
//         );
//       }
//
//       /// ADD IF DOES NOT EXIST
//       else {
//         _output.add(mapModel);
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TASK : TEST ME
//   static List<MapModel> removeMapModel({
//     required List<MapModel>? mapModels,
//     required String? key,
//   }){
//
//     final List<MapModel> _output = mapModels ?? <MapModel>[];
//
//     if (key != null){
//
//       final int _index = _output.indexWhere((mm) => mm.key == key);
//
//       if (_index != -1){
//         _output.removeAt(_index);
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TASK : TEST ME
//   static List<MapModel> removeMapsWithThisValue({
//     required List<MapModel>? mapModels,
//     required dynamic value,
//   }){
//     final List<MapModel> _output = mapModels ?? <MapModel>[];
//
//     if (Lister.checkCanLoop(mapModels) == true && value != null){
//       _output.removeWhere((element) => element.value  == value);
//     }
//
//     return _output;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// CHECKERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool checkMapExists({
//     required List<MapModel>? mapModels,
//     required MapModel? mapModel,
//   }){
//
//     bool _exists = false;
//
//     if (Lister.checkCanLoop(mapModels) && mapModel != null){
//
//       final MapModel? _found = getModelByKey(
//         models: mapModels,
//         key: mapModel.key,
//       );
//
//
//       if (_found != null){
//         _exists = true;
//       }
//
//     }
//
//     return _exists;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool checkMapsIncludeThisKey({
//     required List<MapModel>? mapModels,
//     required String key,
//   }){
//     bool _include = false;
//
//     if (Lister.checkCanLoop(mapModels) == true){
//
//       final MapModel? _map = mapModels!.firstWhereOrNull(
//               (element) => element.key == key,
//       );
//
//       if (_map != null){
//         _include = true;
//       }
//
//     }
//
//     return _include;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static bool checkMapModelsListsAreIdentical({
//     required List<MapModel>? models1,
//     required List<MapModel>? models2,
//   }){
//     bool _output = false;
//
//     if (models1 == null && models2 == null){
//       _output = true;
//     }
//     else if (models1 != null && models1.isEmpty && models2 != null && models2.isEmpty){
//       _output = true;
//     }
//     else if (models1 != null && models2 != null){
//
//       if (models1.length != models2.length){
//         _output = false;
//       }
//
//       else {
//
//         for (int i = 0; i < models1.length; i++){
//
//           final bool _areIdentical =  models1[i] == models2[i];
//
//           if (_areIdentical == false){
//             _output = false;
//             break;
//           }
//
//           else {
//             _output = true;
//           }
//
//         }
//
//       }
//
//
//     }
//
//     return _output;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// OVERRIDES
//
//   // --------------------
//   @override
//   String toString() => 'MapModel(key: $key, value: $value)';
//   // --------------------
//   @override
//   bool operator == (Object other){
//
//     if (identical(this, other)) {
//       return true;
//     }
//
//     return other is MapModel && other.key == key && other.value == value;
//   }
//   // --------------------
//   @override
//   int get hashCode => key.hashCode ^ value.hashCode;
//   // -----------------------------------------------------------------------------
// }
