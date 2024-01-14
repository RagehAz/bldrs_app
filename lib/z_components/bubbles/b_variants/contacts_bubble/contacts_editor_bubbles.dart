// import 'package:basics/helpers/checks/tracers.dart';
// import 'package:basics/helpers/maps/mapper.dart';
// import 'package:basics/components/drawing/dot_separator.dart';
// import 'package:bldrs/a_models/x_secondary/contact_model.dart';
// import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
// import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
// import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:flutter/material.dart';
//
// class ContactsEditorsBubbles extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const ContactsEditorsBubbles({
//     required this.contacts,
//     required this.contactsOwnerType,
//     required this.appBarType,
//     required this.globalKey,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final List<ContactModel> contacts;
//   final ContactsOwnerType contactsOwnerType;
//   final AppBarType appBarType;
//   final GlobalKey globalKey;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     const List<ContactType?> _types = <ContactType?>[
//       ContactType.phone,
//       ContactType.email,
//       ContactType.website,
//       null,
//       ContactType.facebook,
//       ContactType.linkedIn,
//       ContactType.youtube,
//       ContactType.instagram,
//       ContactType.pinterest,
//       ContactType.tiktok,
//       ContactType.twitter,
//     ];
//     // --------------------
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       // crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//
//         const DotSeparator(),
//
//         /// CONTACTS
//         if (Lister.checkCanLoop(_types) == true)
//         ...List.generate(_types.length, (index){
//
//           final ContactType? _contactType = _types[index];
//
//           final bool _isBlocked = ContactModel.checkContactIsBlocked(
//             contactType: _contactType,
//             ownerType: contactsOwnerType,
//           );
//
//           if (_isBlocked == true || _contactType == null){
//             return const SizedBox();
//           }
//
//           else {
//
//             final TextEditingController? _controller = ContactModel.getControllerFromContacts(
//               contacts: contacts,
//               contactType: _contactType,
//             );
//
//             blog('ContactsEditorsBubbles : _contactType : $_contactType : _controller: ${_controller?.hashCode} : ${_controller?.text}');
//
//             if (_controller == null){
//               return const SizedBox();
//             }
//             else {
//               return ContactFieldEditorBubble(
//                 formKey: globalKey,
//                 headerViewModel: BldrsBubbleHeaderVM.bake(
//                     context: context,
//                     headlineVerse: Verse(
//                       id: ContactModel.getContactTypePhid(
//                         contactType: _contactType,
//                       ),
//                       translate: true,
//                     ),
//                     leadingIcon: ContactModel.concludeContactIcon(
//                         contactType: _contactType,
//                       isPublic: true,
//                     ),
//                     leadingIconSizeFactor: 0.7
//                 ),
//                 appBarType: appBarType,
//                 isFormField: true,
//                 fieldIsRequired: ContactModel.checkContactIsRequired(
//                   contactType: _contactType,
//                   ownerType: ContactsOwnerType.author,
//                 ),
//                 // textController: _controller,
//                 keyboardTextInputAction: TextInputAction.next,
//                 keyboardTextInputType: ContactModel.concludeContactTextInputType(
//                   contactType: _contactType,
//                 ),
//
//               );
//             }
//
//
//           }
//
//         }),
//
//         const DotSeparator(),
//
//         /// TO COMPACT CONTACTS = > TURN THE WIDGET INTO STATEFUL WIDGET
//         // Container(
//         //   width: BldrsAppBar.width(context),
//         //   height: 100,
//         //   color: Colorz.bloodTest,
//         //   child: GridView(
//         //     physics: const ,
//         //   ),
//         // ),
//
//       ],
//     );
//     // --------------------
//   }
//   /// --------------------------------------------------------------------------
// }
