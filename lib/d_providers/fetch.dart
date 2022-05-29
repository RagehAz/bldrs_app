// import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
// import 'package:flutter/material.dart';
// import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
//
// Future<Map<String, dynamic>> fetch ({
//   @required BuildContext context,
//   @required String fireCollName,
//   @required String objectID,
//   @required String idFieldName,
//   @required String ldbDocName,
// }) async {
//
//   Map<String, dynamic> _map;
//
//   /// SEARCH LDB
//   _map = await LDBOps.searchFirstMap(
//       fieldToSortBy: null,
//       searchField: idFieldName,
//       searchValue: objectID,
//       docName: ldbDocName,
//   );
//
//   /// WHEN NOT FOUND IN LDB
//   _map ??= await Fire.readDoc(
//       context: context,
//       collName: fireCollName,
//       docName: objectID,
//     );
//
//   if (_map != null){
//
//     await LDBOps.insertMap(
//         primaryKey: objectID,
//         input: input,
//         docName: docName
//     );
//
//   }
// }
