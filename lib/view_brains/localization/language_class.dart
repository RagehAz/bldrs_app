//
// --- BEHOLD ---
//
// TO ADD NEW LANGUAGE
// 1- CREATE NEW JSON FILE
// 2- UPDATE main.dart FILE
// 3- UPDATE pubspec.yaml FILE
// 4- UPDATE language_class FILE
// 5- UPDATE demo_localization FILE
// 6- UPDATE localization_constants FILE
//
// --- TAWAKAL 3ALA ALLAH ---
//

class LanguageClass {
  final int langId;
  final String langName;
  final String langFlag;
  final String langCode;

  LanguageClass (this.langId, this.langName, this.langFlag, this.langCode);

  static List<LanguageClass> languageList(){
    return <LanguageClass>[
      LanguageClass(1,'English'   ,'assets/dv/dv_blank.svg',  'en'),
      LanguageClass(2,'عربي'      ,'assets/dv/dv_blank.svg',  'ar'),
      LanguageClass(3,'Español'   ,'assets/dv/dv_blank.svg',  'es'),
      LanguageClass(4,'Française' ,'assets/dv/dv_blank.svg',  'fr'),
      LanguageClass(5,'русский'   ,'assets/dv/dv_blank.svg',  'ru'),
      LanguageClass(6,'Türk'      ,'assets/dv/dv_blank.svg',  'tr'),
      LanguageClass(7,'Italiano'  ,'assets/dv/dv_blank.svg',  'it'),
      LanguageClass(8,'中文'  ,'assets/dv/dv_blank.svg',  'zh'),
    ];
  }
}

// -----------------------------------------------
// this used to change language in onChanged
//
//                 onChanged: (Language language) {
//                   _changeLanguage(language);
//                 },
//
// -----------------------------------------------
// this used to put languages in list inside items in a fucking AppBar DropDownButton
//
//                 items: Language.languageList()
//                     .map<DropdownMenuItem<Language>>((lang) =>
//                         DropdownMenuItem(
//                           value: lang,
//                           child: Row(
//                            mainAxisAlignment:
//                                MainAxisAlignment.spaceAround,
//                           children: [Text(lang.flag), Text(lang.name)],
//                          ),
//                        )).toList(),
// -----------------------------------------------
//
// Method used for localization to be put in onChanged was put inside a state class
//
//  void _changeLanguage(LanguageClass language)async{
////    print(language.languageCode);
//    Locale _temp = await setLocale(language.langCode);
//
//    BldrsApp.setLocale(context, _temp);
//  }
// -----------------------------------------------
//
// --- METHOD OF CHANGING THE LANGUAGE USED BY PodCoder el mtaftef
//  void _changeLanguage(LanguageClass lingo) async {
//    print(lingo.langCode);
//    Locale _temp = await setLocale(lingo.langCode);
//    BldrsApp.setLocale(context, _temp);
//  }
// -----------------------------------------------
