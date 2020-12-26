// import 'package:bldrs/ambassadors/db_brain/old_db_brain.dart';
// import 'package:bldrs/mos/enum_flyer_type.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'processed_models/processed_flyer.dart';
//
// class FlyersProvider with ChangeNotifier {
// List<ProcessedFlyerData> _flyers = allFlyersExtractor();
//
// List<ProcessedFlyerData> get allFlyers {
//   return [..._flyers];
// }
//
// List<ProcessedFlyerData> get savedFlyers {
//   return _flyers.where((flyer) => flyer.flyerAnkhIsOn).toList();
// }
//
//     findFlyerByID (String flyerID){
//     ProcessedFlyerData processedFlyer = _flyers.singleWhere((x) => x.flyerID == flyerID);
//     return processedFlyer;
//     }
//
//     findFlyersByType (FlyerType flyerType){
//       // 1--- create new List of IDs
//       List<String> flyerIDs = [];
//
//       // 2--- search db for any id when flyer type is the searched flyer type and add them to the list
//       _flyers.forEach((flyer) {
//       if(flyer.flyerType == flyerType){flyerIDs.add(flyer.flyerID);}
//     });
//
//       // 3--- return list of processedFlyers
//       return List<ProcessedFlyerData>.generate(
//           flyerIDs.length,
//               (indexOfFlyerIDsList) =>
//                   findFlyerByID(flyerIDs[indexOfFlyerIDsList])
//       );
//     }
//
//     findSavedFlyers (List<ProcessedFlyerData> inputList){
//    List<ProcessedFlyerData> outputList = inputList.where((flyer) => flyer.flyerAnkhIsOn).toList();
//   return outputList;
//     }
//
//     void addFlyerInBeginning(ProcessedFlyerData newFlyer){
//   _flyers.insert(0, newFlyer);
//   notifyListeners();
//     }
//     void addFlyerInEnd(ProcessedFlyerData newFlyer){
//   _flyers.add(newFlyer);
//   notifyListeners();
//     }
//
//
// }