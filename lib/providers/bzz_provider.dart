// import 'package:bldrs/ambassadors/db_brain/old_db_brain.dart';
// import 'package:flutter/material.dart';
// import 'processed_models/processed_bz_data.dart';
//
// class BzProvider with ChangeNotifier {
//   List<ProcessedBzData> _proBzzList = allBzExtractor();
//
//   List<ProcessedBzData> get allBzz {
//     return [..._proBzzList];
//   }
//
//   // List<ProcessedBzData> get followedBzz {
//     // return _ProBzzList.where((bz) => bz.flyerAnkhIsOn).toList();
//   // }
//   //
//   // findFlyerByID (String flyerID){
//   //   ProcessedFlyerData processedFlyer = _flyers.singleWhere((x) => x.flyerID == flyerID);
//   //   return processedFlyer;
//   // }
//   //
//   // findFlyersByType (FlyerType flyerType){
//   //   // 1--- create new List of IDs
//   //   List<String> flyerIDs = [];
//   //
//   //   // 2--- search db for any id when flyertype is the searched flyertype and add them to the list
//   //   _flyers.forEach((flyer) {
//   //     if(flyer.flyerType == flyerType){flyerIDs.add(flyer.flyerID);}
//   //   });
//   //
//   //   // 3--- return list of processedFlyers
//   //   return List<ProcessedFlyerData>.generate(
//   //       flyerIDs.length,
//   //           (indexOfFlyerIDsList) =>
//   //           findFlyerByID(flyerIDs[indexOfFlyerIDsList])
//   //   );
//   // }
//   //
//   // findSavedFlyers (List<ProcessedFlyerData> inputList){
//   //   List<ProcessedFlyerData> outputList = inputList.where((flyer) => flyer.flyerAnkhIsOn).toList();
//   //   return outputList;
//   // }
//
//   // void addFlyerInBeginning(ProcessedFlyerData newFlyer){
//   //   _flyers.insert(0, newFlyer);
//   //   notifyListeners();
//   // }
//   // void addFlyerInEnd(ProcessedFlyerData newFlyer){
//   //   _flyers.add(newFlyer);
//   //   notifyListeners();
//   // }
//   //
//
// }