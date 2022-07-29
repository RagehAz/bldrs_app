// import 'package:bldrs/b_views/z_components/sizing/expander.dart';
// import 'package:bldrs/f_helpers/drafters/mappers.dart';
// import 'package:flutter/material.dart';
// import 'package:bldrs/f_helpers/drafters/timers.dart';
//
// enum AuthorshipResponse{
//   accepted,
//   declined,
//   pending,
// }
//
// @immutable
// class AuthorshipModel {
// // ---------------------------------
//   const AuthorshipModel({
//     @required this.id,
//     @required this.bzID,
//     @required this.authorID,
//     @required this.receiverID,
//     @required this.sentTime,
//     @required this.response,
//     @required this.responseTime,
//   });
// // ---------------------------------
//   final String id;
//   final String bzID;
//   final String authorID;
//   final String receiverID;
//   final DateTime sentTime;
//   final AuthorshipResponse response;
//   final DateTime responseTime;
// // -----------------------------------------------------------------------------
//
//   /// CLONING
//
// // ---------------------------------
//   AuthorshipModel copyWith({
//     String id,
//     String bzID,
//     String authorID,
//     String receiverID,
//     DateTime sentTime,
//     AuthorshipResponse response,
//     DateTime responseTime,
//   }) {
//     return AuthorshipModel(
//       id: id ?? this.id,
//       bzID: bzID ?? this.bzID,
//       authorID: authorID ?? this.authorID,
//       receiverID: receiverID ?? this.receiverID,
//       sentTime: sentTime ?? this.sentTime,
//       response: response ?? this.response,
//       responseTime: responseTime ?? this.responseTime,
//     );
//   }
// // -----------------------------------------------------------------------------
//
//   /// CYPHERS
//
// // ---------------------------------
//   Map<String, dynamic> toMap({
//     @required bool toJSON,
//   }){
//     return {
//       'id': id,
//       'bzID': bzID,
//       'authorID': authorID,
//       'receiverID': receiverID,
//       'sentTime': Timers.cipherTime(time: sentTime, toJSON: toJSON),
//       'response': cipherAuthorshipsResponse(response),
//       'responseTime': Timers.cipherTime(time: responseTime, toJSON: toJSON),
//     };
//   }
// // ---------------------------------
//   static AuthorshipModel decipherAuthorship({
//     @required Map<String, dynamic> map,
//     @required bool fromJSON,
//   }){
//     AuthorshipModel _model;
//
//     if (map != null){
//
//       _model = AuthorshipModel(
//         id: map['id'],
//         bzID: map['bzID'],
//         authorID: map['authorID'],
//         receiverID: map['receiverID'],
//         sentTime: Timers.decipherTime(time: map['sentTime'], fromJSON: fromJSON),
//         response: decipherAuthorshipResponse(map['response']),
//         responseTime: Timers.decipherTime(time: map['responseTime'], fromJSON: fromJSON),
//       );
//
//     }
//
//     return _model;
//   }
// // ---------------------------------
//   static List<Map<String, dynamic>> cipherAuthorships({
//     @required List<AuthorshipModel> models,
//     @required bool toJSON,
//   }){
//     final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
//
//     if (Mapper.checkCanLoopList(models) == true){
//
//       for (final AuthorshipModel model in models){
//
//         final Map<String, dynamic> _map = model.toMap(toJSON: toJSON);
//         _maps.add(_map);
//
//       }
//
//     }
//
//     return _maps;
//   }
// // ---------------------------------
//   static List<AuthorshipModel> decipherAuthorships({
//     @required List<Map<String, dynamic>> maps,
//     @required bool fromJSON,
//   }){
//     final List<AuthorshipModel> _models = <AuthorshipModel>[];
//
//     if (Mapper.checkCanLoopList(maps) == true){
//
//       for (final Map<String, dynamic> map in maps){
//
//         final AuthorshipModel _model = decipherAuthorship(
//             map: map,
//             fromJSON: fromJSON,
//         );
//
//         _models.add(_model);
//
//       }
//
//     }
//
//     return _models;
//   }
// // -----------------------------------------------------------------------------
//
//   /// AUTHORSHIPS CYPHERS
//
// // ---------------------------------
//   static String cipherAuthorshipsResponse(AuthorshipResponse response){
//     switch (response){
//       case AuthorshipResponse.accepted: return 'accepted'; break;
//       case AuthorshipResponse.declined: return 'declines'; break;
//       case AuthorshipResponse.pending: return 'pending'; break;
//       default: return null;
//     }
//   }
// // ---------------------------------
//   static AuthorshipResponse decipherAuthorshipResponse(String response){
//     switch (response){
//       case 'accepted': return AuthorshipResponse.accepted; break;
//       case 'declines': return AuthorshipResponse.declined; break;
//       case 'pending': return AuthorshipResponse.pending; break;
//       default: return null;
//     }
//   }
// // -----------------------------------------------------------------------------
//
//   /// BLOG
//
// // ---------------------------------
//   void blogAuthorshipModel(){
//
//     blog('AuthorshipModel --------------------------------------- START');
//
//       blog('id : $id');
//       blog('bzID : $bzID');
//       blog('authorID : $authorID');
//       blog('receiverID : $receiverID');
//       blog('sentTime : $sentTime');
//       blog('response : $response');
//       blog('responseTime : $responseTime');
//
//     blog('AuthorshipModel --------------------------------------- END');
//   }
// // -----------------------------------------------------------------------------
//
// }
