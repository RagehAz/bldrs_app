// -----------------------------------------------------------------------------
// /// TESTED : WORKS PERFECT
// static String initializePhoneValue({
//   @required ZoneModel zone,
//   @required List<ContactModel> contacts,
// }){
//   return TextMod.initializePhoneNumber(
//     countryID : zone?.countryID,
//     number : ContactModel.getValueFromContacts(
//         contacts: contacts,
//         contactType: ContactType.phone
//     ),
//   );
// }
// ----------------------------------
//   /// TESTED : WORKS PERFECT
//   static String initializeWebLinkValue({
//     @required List<ContactModel> contacts,
//     @required ContactType contactType,
//   }){
//     return TextMod.initializeWebLink(
//         url: ContactModel.getValueFromContacts(
//           contacts: contacts,
//           contactType: contactType,
//         )
//     );
//   }
// ----------------------------------
//   /// TESTED : WORKS PERFECT
//   static List<TextEditingController> initializeContactsControllers({
//     @required List<ContactModel> existingContacts,
//     @required String countryID,
//   }){
//
//     final List<TextEditingController> _controllers = <TextEditingController>[];
//
//     for (final ContactType contactType in contactTypesList){
//
//       String _initialValue;
//
//       /// GET EXISTING CONTACT
//       final ContactModel _existingContact = existingContacts.firstWhere(
//             (contact) => contact.contactType == contactType, orElse: () => null,
//       );
//
//       /// CONTACT NOT FOUND => DEFINE INITIAL VALUE
//       if (_existingContact == null){
//
//         /// IF PHONE
//         if (contactType == ContactType.phone){
//           _initialValue = TextMod.initializePhoneNumber(
//             countryID : countryID,
//             number : null,
//           );
//         }
//         /// IF WEB LINK
//         else if (checkContactTypeIsWebLink(contactType) == true){
//           _initialValue = ContactModel.initializeWebLinkValue(
//             contacts: [],
//             contactType: contactType,
//           );
//         }
//         /// OTHERWISE
//         else {
//           _initialValue = '';
//         }
//
//       }
//
//       /// CONTACT FOUND
//       else {
//         _initialValue = _existingContact.value;
//       }
//
//       /// ASSIGN THE CONTROLLER WITH INITIAL VALUE
//       final TextEditingController _controller = TextEditingController(
//         text: _initialValue,
//       );
//       _controllers.add(_controller);
//
//     }
//
//     return _controllers;
//   }

///
//   static List<String> getListOfIconzFromContactsModelsList(List<ContactModel> contacts) {
//     final List<String> icons = <String>[];
//
//     if (Mapper.checkCanLoopList(contacts)) {
//       for (final ContactModel co in contacts) {
//         icons.add(ContactModel.concludeContactIcon(co.contactType));
//       }
//     }
//
//     return icons;
//   }
///
/// // -----------------------------------------------------------------------------
//
//
//
//
//
//
//
//
//   // static List<ContactModel> createContactsList({
//   //   List<ContactModel> existingContacts,
//   //   String phone,
//   //   String email,
//   //   String webSite,
//   //   String facebook,
//   //   String linkedIn,
//   //   String youTube,
//   //   String instagram,
//   //   String pinterest,
//   //   String tikTok,
//   //   String twitter,
//   // }) {
//   //   final List<ContactModel> _newContacts = <ContactModel>[];
//   //   // ---------------
//   //   addContactIfPossibleToANewContactsList(existingContacts, phone, ContactType.phone, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, email, ContactType.email, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, webSite, ContactType.website, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, facebook, ContactType.facebook, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, linkedIn, ContactType.linkedIn, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, youTube, ContactType.youtube, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, instagram, ContactType.instagram, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, pinterest, ContactType.pinterest, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, tikTok, ContactType.tiktok, _newContacts);
//   //   addContactIfPossibleToANewContactsList(existingContacts, twitter, ContactType.twitter, _newContacts);
//   //   // ---------------
//   //   return _newContacts;
//   // }
//
//
// // ----------------------------------
// //   /// TESTED : WORKS PERFECT
// //   static List<ContactModel> createContactsListByGeneratedControllers({
// //     @required List<TextEditingController> generatedControllers,
// //     @required String countryID,
// //   }){
// //
// //     /// NOTE : CONTROLLERS SHOULD BE AUTO GENERATED BY [generateContactsControllers] method
// //
// //     final List<ContactModel> _models = <ContactModel>[];
// //
// //     for (int i = 0; i < generatedControllers.length; i++){
// //
// //       final TextEditingController _controller = generatedControllers[i];
// //       final ContactType _contactType = contactTypesList[i];
// //
// //       String _endValue;
// //
// //       /// IF PHONE
// //       if (_contactType == ContactType.phone){
// //         _endValue = TextMod.nullifyNumberIfOnlyCountryCode(
// //           number: _controller.text,
// //           countryID: countryID,
// //         );
// //       }
// //       /// IF WEB LINK
// //       else if (checkContactTypeIsWebLink(_contactType) == true){
// //         _endValue = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: _controller.text);
// //       }
// //       /// OTHERWISE
// //       else {
// //         _endValue = _controller.text;
// //       }
// //
// //       final ContactModel _model = ContactModel(
// //         contactType: _contactType,
// //         value: _endValue,
// //       );
// //
// //       if (TextChecker.textControllerIsEmpty(_controller) == false){
// //         _models.add(_model);
// //       }
// //
// //     }
// //
// //     return _models;
// //   }
// // -----------------------------------------------------------------------------
///
//   static List<String> getListOfValuesFromContactsModelsList(List<ContactModel> contacts) {
//     final List<String> values = <String>[];
//
//     if (Mapper.checkCanLoopList(contacts)) {
//       for (final ContactModel co in contacts) {
//         values.add(co.value);
//       }
//     }
//
//     return values;
//   }
///
//   static String getFirstPhoneFromContacts(List<ContactModel> contacts) {
//     /// will let user to only have one phone contact
//     // String phone = contacts?.singleWhere((co) => co.contactType == ContactType.Phone, orElse: ()=> null)?.contact;
//     final List<String> phones = <String>[];
//
//     for (final ContactModel co in contacts) {
//       if (co.contactType == ContactType.phone) {
//         phones.add(co.value);
//       }
//     }
//
//     return phones.isEmpty ? null : phones[0];
//   }
///
// static void addContactIfPossibleToANewContactsList(
//     List<ContactModel> existingContacts,
//     String value,
//     ContactType type,
//     List<ContactModel> newContacts,
//   ) {
//
//     final String _existingContactValue = getValueFromContacts(
//         contacts: existingContacts,
//         contactType: type,
//     );
//
//     bool _contactExistsInExistingContacts;
//
//     if (_existingContactValue == null || _existingContactValue == '') {
//       _contactExistsInExistingContacts = false;
//     }
//
//     else {
//       _contactExistsInExistingContacts = true;
//     }
//
//     bool _userChangedValue;
//
//     if (value == null) {
//       _userChangedValue = false;
//     }
//
//     else {
//       _userChangedValue = true;
//     }
//
//     /// when contact already exists in existingContacts
//     if (_contactExistsInExistingContacts == true) {
//
//       /// if value have changed add this new value otherwise add the existing value
//       if (_userChangedValue == true) {
//         newContacts.add(ContactModel(value: value, contactType: type));
//       }
//
//       else {
//         newContacts.add(
//             ContactModel(value: _existingContactValue, contactType: type));
//       }
//
//     }
//
//     /// when contact is new to existingContacts
//     else {
//       /// add new ContactModel to the new list only if a new value is assigned ( value != null )
//       if (_userChangedValue == true) {
//         newContacts.add(ContactModel(value: value, contactType: type));
//       }
//     }
//   }
///
///
