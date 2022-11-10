// import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
// import 'package:bldrs/f_helpers/drafters/mappers.dart';
// import 'package:flutter/material.dart';
//
// void dothing() {
//   Map<String, dynamic> _map = {};
//
//   for (int i = 0; i < 10; i++) {
//     _map = Mapper.insertPairInMap(
//       map: _map,
//       key: 'key$i',
//       value: i,
//     );
//   }
//
//   Mapper.blogMap(_map);
// }
//
//
// Map<String, dynamic> insertPairInMap({
//   @required Map<String, dynamic> map,
//   @required String key,
//   @required dynamic value,
//   bool overrideExisting = false,
// }) {
//   Map<String, dynamic> _result = <String, dynamic>{};
//
//   if (map != null) {
//     _result = map;
//
//     /// PAIR IS NULL
//     if (map[key] == null) {
//       _result.putIfAbsent(key, () => value);
//     }
//
//     /// PAIR HAS VALUE
//     else {
//       if (overrideExisting == true) {
//         _result[key] = value;
//       }
//     }
//   }
//
//   return _result;
// }
//
// //
//
