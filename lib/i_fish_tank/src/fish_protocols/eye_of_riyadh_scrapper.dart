// import 'package:basics/helpers/checks/error_helpers.dart';
// import 'package:basics/helpers/maps/lister.dart';
// import 'package:basics/helpers/strings/stringer.dart';
// import 'package:basics/helpers/strings/text_check.dart';
// import 'package:basics/helpers/strings/text_mod.dart';
// import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
// import 'package:bldrs/a_models/x_secondary/contact_model.dart';
// import 'package:bldrs/f_helpers/drafters/formers.dart';
// import 'package:bldrs_dashboard/b_modules/gta_manager/protocols/puppeteer_protocols/amazon_ops.dart';
// import 'package:bldrs_dashboard/b_modules/marketing_manager/emailing_manager/models/fish_model.dart';
// import 'package:collection/collection.dart';
// import 'package:puppeteer/puppeteer.dart' as pup;
// /// => TAMAM
// class EyeOfRiyadhScrapper {
//   // -----------------------------------------------------------------------------
//
//   const EyeOfRiyadhScrapper();
//
//   // -----------------------------------------------------------------------------
//
//   /// CONSTANTS
//
//   // --------------------
//   static const String websiteURL = 'https://www.eyeofriyadh.com/';
//   // -----------------------------------------------------------------------------
//
//   /// SCRAP
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<Map<String, dynamic>?> scrap({
//     required String? url,
//   }) async {
//     Map<String, dynamic>? _output;
//
//     if (url != null) {
//
//       final pup.Browser? _browser = await AmazonOps.launchBrowser();
//
//       if (_browser != null) {
//
//         final pup.Page? page = await _browser.newPage();
//
//         await AmazonOps.setCookies(
//           myPage: page,
//           cookiesMaps: [],
//         );
//
//         await tryAndCatch(
//           invoker: 'EyeOfRiyadhScrapper._stealPage.scrap',
//           functions: () async {
//
//             /// OPENS PAGE
//             await page?.goto(
//               url,
//               timeout: Duration.zero,
//               // wait: Until.networkAlmostIdle,
//               // referrer:
//             );
//
//             _output = await page?.evaluate(
//                 //language=js
//                 '''
//                 x => {
//
//                   let output = {};
//
//                   // Select the name
//                   const nameElement = document.querySelector('#td-outer-wrap .content_left h1');
//                   const name = nameElement ? nameElement.innerText.trim() : null;
//
//                   // PHONES
//                   const phones = Array.from(document.querySelectorAll('#td-outer-wrap .list li:nth-child(3) a'))
//                       .map(element => element.href.trim());
//
//                   // EMAIL
//                   const emailElement = document.querySelector('#td-outer-wrap .list li:nth-child(4) a');
//                   const email = emailElement ? emailElement.textContent.trim() : null;
//
//                   // EMAILS
//                   const emails = Array.from(document.querySelectorAll('#td-outer-wrap .list li:nth-child(4) a'))
//                       .map(element => element.href.trim());
//
//                   // WEBSITES
//                   const websites = Array.from(document.querySelectorAll('#td-outer-wrap .list li:nth-child(5) a'))
//                       .map(element => element.href.trim());
//
//
//                   /// SOCIAL MEDIA LINKS
//                   const social = Array.from(document.querySelectorAll('#td-outer-wrap .list li:nth-child(6) a'))
//                       .map(element => element.href.trim());
//
//                   // SOCIAL 2
//                   const social2 = Array.from(document.querySelectorAll('#td-outer-wrap .list li:nth-child(7) a'))
//                       .map(element => element.href.trim());
//
//                   /// IMAGE
//                   const imgElement = document.querySelector("img[src*='/includes/image.php']");
//                   const imageURL = imgElement ? imgElement.getAttribute('src') : null;
//
//                   output = {
//                       name: name,
//                       phones: phones,
//                       email: email,
//                       emails: emails,
//                       websites: websites,
//                       social: social,
//                       social2: social2,
//                       imageURL: imageURL,
//                   };
//
//                       return output;
//                   }
//                 '''
//             );
//
//           },
//         );
//
//       }
//
//       await _browser?.close();
//     }
//
//     return _output;
//   }
//   // -----------------------------------------------------------------------------
//
//   /// CIPHER
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static FishModel? cipherScrappedToFish({
//     required Map<String, dynamic>? map,
//     required BzType bzType,
//   }){
//     FishModel? _output;
//
//     if (map != null){
//
//       final String? _phone = _getPhone(map);
//       final String? _email = _getEmail(map);
//       final String? _website = _getWebsite(map);
//       final String? _logoURL = _getLogo(map);
//
//       _output = FishModel(
//         id: _createID(map),
//         name: _getName(map),
//         type: bzType,
//         countryID: 'sau',
//         imageURL: _logoURL,
//         contacts: <ContactModel>[
//
//           if (_email != null)
//             ContactModel(value: _email, type: ContactType.email),
//
//           if (_phone != null)
//             ContactModel(value: _phone, type: ContactType.phone),
//
//           if (_website != null)
//             ContactModel(value: _website, type: ContactType.website),
//
//           ..._getSocialContacts(map),
//
//         ],
//       );
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static String? _createID(Map<String, dynamic> map){
//     final String? _name = _getName(map);
//     return TextMod.idifyString(_name);
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static String? _getName(Map<String, dynamic> map){
//     return map['name']?.trim();
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static String? _getPhone(Map<String, dynamic>? map){
//     String? _output;
//
//     final List<String>? _phones = Stringer.getStringsFromDynamics(map?['phones']);
//
//     if (Lister.checkCanLoop(_phones) == true){
//
//       final List<String> _cleaned = [];
//
//       for (final String phone in _phones!){
//
//         String? _clean = ContactModel.cleanPhoneNumber(phone: phone);
//
//         if (TextCheck.stringStartsExactlyWith(text: _clean, startsWith: '966') == true){
//           _clean = '+$_clean';
//         }
//
//         if (_clean != null){
//           _cleaned.add(_clean);
//         }
//
//       }
//
//
//       if (Lister.checkCanLoop(_cleaned) == true){
//
//         final String? _withPlus = _cleaned.firstWhereOrNull((element){
//           final bool _match = TextCheck.stringStartsExactlyWith(text: element, startsWith: '+');
//           return _match;
//         });
//
//         if (_withPlus != null){
//           _output = _withPlus;
//         }
//         else {
//           _output = _cleaned.first;
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static String? _getEmail(Map<String, dynamic>? map){
//     String? _output;
//
//     final List<String>? emails = Stringer.getStringsFromDynamics(map?['emails']);
//
//     if (Lister.checkCanLoop(emails) == true){
//
//       for (final String email in emails!){
//
//         final String? _email = TextMod.removeTextBeforeFirstSpecialCharacter(
//             text: TextMod.removeSpacesFromAString(email.toLowerCase()),
//             specialCharacter: ':',
//         );
//         final bool _valid = Formers.emailValidator(email: _email, canValidate: true, ) == null;
//
//         if (_valid == true){
//           _output = _email;
//           break;
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static String? _getWebsite(Map<String, dynamic>? map){
//     String? _output;
//
//     if (map != null){
//
//       final List<String>? websites = Stringer.getStringsFromDynamics(map['websites']);
//
//       if (Lister.checkCanLoop(websites) == true){
//
//         for (final String website in websites!){
//
//           final String? _cleaned = TextMod.removeSpacesFromAString(website.toLowerCase());
//           final bool _valid = Formers.webSiteValidator(website: _cleaned, isMandatory: true) == null;
//           final ContactType? _type = ContactModel.concludeContactTypeByURLDomain(url: _cleaned);
//           if (_valid == true && _type == ContactType.website){
//             _output = _cleaned;
//             break;
//           }
//
//         }
//
//         _output ??= TextMod.removeSpacesFromAString(websites.first.toLowerCase());
//
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static List<ContactModel> _getSocialContacts(Map<String, dynamic>? map){
//     final List<ContactModel> _output = [];
//
//     if (map != null){
//
//       final List<String> _links1 = Stringer.getStringsFromDynamics(map['social']);
//       final List<String> _links2 = Stringer.getStringsFromDynamics(map['social2']);
//       final List<String> websites = Stringer.getStringsFromDynamics(map['websites']);
//       final List<String> emails = Stringer.getStringsFromDynamics(map['emails']);
//       final List<String> _links = [..._links1, ..._links2, ...websites, ...emails];
//
//       if (Lister.checkCanLoop(_links) == true){
//
//         for (final String link in _links){
//
//           final String? _link = TextMod.removeSpacesFromAString(link.toLowerCase());
//
//           final ContactType? _type = ContactModel.concludeContactTypeByURLDomain(
//             url: _link,
//           );
//
//           if (_type != null){
//             _output.add(ContactModel(type: _type, value: _link));
//           }
//
//         }
//
//       }
//
//     }
//
//     return _output;
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static String? _getLogo(Map<String, dynamic>? map){
//     String? _output;
//
//     final String? _address = map?['imageURL'];
//
//     if (_address != null){
//       _output = 'https://www.eyeofriyadh.com$_address';
//     }
//
//     return _output;
//   }
//   // -----------------------------------------------------------------------------
// }
