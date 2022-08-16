// import 'package:bldrs/a_models/flyer/sub/file_model.dart';
// import 'package:bldrs/a_models/secondary_models/contact_model.dart';
// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/a_models/zone/zone_model.dart';
// import 'package:bldrs/f_helpers/drafters/filers.dart';
// import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// class FieldTextController {
//   /// --------------------------------------------------------------------------
//   const FieldTextController({
//     @required this.id,
//     @required this.controller,
//   });
//   /// --------------------------------------------------------------------------
//   final String id;
//   final TextEditingController controller;
// /// --------------------------------------------------------------------------
// }
//
// class UserEditorModel {
//   /// --------------------------------------------------------------------------
//   const UserEditorModel({
//     @required this.picture,
//     @required this.gender,
//     @required this.zone,
//     @required this.userLocation,
//     @required this.textFieldsControllers,
//     });
//   /// --------------------------------------------------------------------------
//   final ValueNotifier<FileModel> picture;
//   final ValueNotifier<Gender> gender;
//   final ValueNotifier<ZoneModel> zone;
//   final ValueNotifier<GeoPoint> userLocation;
//   final List<FieldTextController> textFieldsControllers;
// // --------------------------------------------------------------------------
//
//   /// INITIALIZATION
//
// // ---------------------------------
//   static UserEditorModel initialize({
//     @required UserModel existingUserModel,
//   }){
//
//     return UserEditorModel(
//         picture: _initializePicture(existingUserModel),
//         gender: ValueNotifier(existingUserModel?.gender),
//         zone: ValueNotifier(existingUserModel?.zone),
//         userLocation: ValueNotifier(existingUserModel?.location),
//         textFieldsControllers: _initializeTextFieldsControllers(existingUserModel),
//     );
//
//   }
// // ---------------------------------
//   static ValueNotifier<FileModel> _initializePicture(UserModel userModel){
//     FileModel _file;
//
//     if (userModel != null){
//
//       final bool _picIsFile = ObjectChecker.objectIsFile(userModel.pic);
//
//       _file = FileModel(
//         url: _picIsFile == true ? null : userModel.pic,
//         file: _picIsFile == true ? userModel.pic : null,
//         fileName: _picIsFile == true ? Filers.getFileNameFromFile(file: userModel.pic) : null,
//         size: _picIsFile == true ? Filers.getFileSize(userModel.pic) : null,
//       );
//     }
//
//     return ValueNotifier(_file);
//   }
// // ---------------------------------
//   static const List<String> mainFieldsIDs = <String>[
//     'name',
//     'jobTitle',
//     'company',
//     'email',
//     'phone',
//   ];
// // ---------------------------------
//   static const List<String> socialFieldsIDs = <String>[
//     'facebook',
//     'instagram',
//     'linkedIn',
//     'twitter',
//   ];
// // ---------------------------------
//   static List<FieldTextController> _initializeTextFieldsControllers(UserModel userModel){
//     List<FieldTextController> _fields = <FieldTextController>[];
//
//     /// NAME
//     _fields.add(FieldTextController(id: 'name', controller: TextEditingController(text: userModel?.name)));
//
//     /// JOB TITLE
//     _fields.add(FieldTextController(id: 'jobTitle', controller: TextEditingController(text: userModel?.title)));
//
//     /// COMPANY
//     _fields.add(FieldTextController(id: 'company', controller: TextEditingController(text: userModel?.company)));
//
//     /// EMAIL
//     final String _email = ContactModel.getAContactValueFromContacts(
//         contacts: userModel?.contacts,
//         contactType: ContactType.email,
//     );
//     _fields.add(FieldTextController(id: 'email', controller: TextEditingController(text: _email)));
//
//     /// PHONE
//     final String _phone = ContactModel.getAContactValueFromContacts(
//       contacts: userModel?.contacts,
//       contactType: ContactType.phone,
//     );
//     _fields.add(FieldTextController(id: 'phone', controller: TextEditingController(text: _phone)));
//
//     _fields = _initializeSocialMediaControllersIfExisted(userModel);
//
//     return _fields;
//   }
//
//   static List<FieldTextController> _initializeSocialMediaControllersIfExisted(UserModel userModel){
//
//   }
// }
