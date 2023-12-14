// import 'package:basics/helpers/classes/maps/mapper.dart';
// import 'package:flutter/foundation.dart';
//
// @immutable
// class AlertModel {
//   /// ----------------------------------------------------------------------------
//   const AlertModel({
//     required this.alertID,
//     required this.titlePhraseID,
//     required this.messagePhraseID,
//   });
//   /// ----------------------------------------------------------------------------
//   final String alertID;
//   final String titlePhraseID;
//   final String messagePhraseID;
//   // -----------------------------------------------------------------------------
//
//   /// CYPHERS
//
//   // --------------------
//   Map<String, dynamic> toMap(){
//     return {
//       'alertID' : alertID,
//       'titlePhraseID' : titlePhraseID,
//       'messagePhraseID' :  messagePhraseID,
//     };
//   }
//   // --------------------
//   static List<Map<String, dynamic>> cipherAlertModels(List<AlertModel> alertModels){
//
//     final List<Map <String, dynamic>> _maps = <Map<String, dynamic>>[];
//
//     if (Lister.checkCanLoop(alertModels) == true){
//
//       for (final AlertModel alert in alertModels){
//
//         final Map<String, dynamic> _map = alert.toMap();
//         _maps.add(_map);
//
//       }
//
//     }
//
//     return _maps;
//   }
//   // --------------------
//   static AlertModel decipherAlert(Map<String, dynamic> map){
//     return AlertModel(
//       alertID: map['alertID'],
//       titlePhraseID: map['titlePhraseID'],
//       messagePhraseID: map['messagePhraseID'],
//     );
//   }
//   // --------------------
//   static List<AlertModel> decipherAlerts(List<Map<String, dynamic>> maps){
//
//     final List<AlertModel> _alerts = <AlertModel>[];
//
//     if (Lister.checkCanLoop(maps) == true){
//
//       for (final Map<String, dynamic> map in maps){
//
//         final AlertModel _alert = decipherAlert(map);
//         _alerts.add(_alert);
//
//       }
//
//     }
//
//     return _alerts;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// GETTERS
//
//   // --------------------
//   static List<String> getAlertsIDs(List<AlertModel> alerts){
//     final List<String> _ids = <String>[];
//
//     if (Lister.checkCanLoop(alerts) == true){
//
//       for (final AlertModel alertModel in alerts){
//         _ids.add(alertModel.alertID);
//       }
//
//     }
//
//     return _ids;
//   }
//   // --------------------
//   /*
// //   static List<Phrase> getTranslatedAlertsTitles({
// //   required BuildContext context,
// //     required List<>
// // }){
// //     final List<Phrase> _outputs = <Phrase>[];
// //
// //     if (Mapper.canLoopList(alerts) == true){
// //
// //       for (final AlertModel alertModel in alerts){
// //
// //         final Phrase _name = Phrase.getPhraseByCurrentLandFromPhrases(
// //             context: context,
// //             phrases: titlePhraseID
// //         );
// //
// //         _outputs.add(alertModel.titlePhraseID);
// //       }
// //
// //     }
// //
// //     return _outputs;
// //   }
//  */
//   // --------------------
//   /*
// //   static String getAlertsTitlesString(List<AlertModel> alerts){
// //
// //     String _string;
// //
// //     if (Mapper.canLoopList(alerts) == true){
// //
// //       final List<Phrase> _missingFieldsNamesModels = getTranslatedAlertsTitles(alerts);
// //
// //       final List<String> _missingFieldsStrings = Phrase.get;
// //       final String _missingFieldsString = TextGen.generateStringFromStrings(_missingFieldsStrings);
// //
// //     }
// //
// //   }
//  */
//   // -----------------------------------------------------------------------------
// }
