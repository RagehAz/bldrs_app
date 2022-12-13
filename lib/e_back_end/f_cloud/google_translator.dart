import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
/// => TAMAM
class GoogleTranslate {
  // -----------------------------------------------------------------------------

  /// GOOGLE TRANSLATE SINGLETON

  // --------------------
  /// private constructor to create instances of this class only in itself
  GoogleTranslate.singleton();
  // --------------------
  /// Singleton instance
  static final GoogleTranslate _singleton = GoogleTranslate.singleton();
  // --------------------
  /// Singleton accessor
  static GoogleTranslate get instance => _singleton;
  // -----------------------------------------------------------------------------
  /// AWESOME NOTIFICATIONS SINGLETON
  GoogleTranslator _translator;
  GoogleTranslator get translator => _translator ??= GoogleTranslator();
  static GoogleTranslator getTranslator() => GoogleTranslate.instance.translator;
  // -----------------------------------------------------------------------------

  /// TRANSLATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> translate({
    @required String input,
    @required String from,
    @required String to,
  }) async {
    if (input == null || input.isEmpty) {
      return null;
    }

    else {
      final Translation _translation = await getTranslator().translate(
        input,
        from: from,
        to: to,
      );

      return _translation?.text;
    }
  }
  // -----------------------------------------------------------------------------

  /// LANG CODES

  // --------------------
  /// NOT USED : KEPT FOR FUTURE
  /*
  static const Map<String, dynamic> allGoogleLangCodes = {
  'Afrikaans': 'af',
  'Albanian': 'sq',
  'Amharic': 'am',
  'Arabic': 'ar',
  'Armenian': 'hy',
  'Azerbaijani': 'az',
  'Basque': 'eu',
  'Belarusian': 'be',
  'Bengali': 'bn',
  'Bosnian': 'bs',
  'Bulgarian': 'bg',
  'Catalan': 'ca',
  'Cebuano ISO-639-2': 'ceb',
  'Chinese (Simplified)': 'zh-CN',
  'Chinese (Simplified BCP-47)': 'zh',
  'Chinese (Traditional BCP-47)': 'zh-TW',
  'Corsican': 'co',
  'Croatian': 'hr',
  'Czech': 'cs',
  'Danish': 'da',
  'Dutch': 'nl',
  'English': 'en',
  'Esperanto': 'eo',
  'Estonian': 'et',
  'Finnish': 'fi',
  'French': 'fr',
  'Frisian': 'fy',
  'Galician': 'gl',
  'Georgian': 'ka',
  'German': 'de',
  'Greek': 'el',
  'Gujarati': 'gu',
  'Haitian Creole': 'ht',
  'Hausa': 'ha',
  'Hawaiian (ISO-639-2)': 'haw',
  'Hebrew1': 'he',
  'Hebrew2': 'iw',
  'Hindi': 'hi',
  'Hmong (ISO-639-2)': 'hmn',
  'Hungarian': 'hu',
  'Icelandic': 'is',
  'Igbo': 'ig',
  'Indonesian': 'id',
  'Irish': 'ga',
  'Italian': 'it',
  'Japanese': 'ja',
  'Javanese': 'jv',
  'Kannada': 'kn',
  'Kazakh': 'kk',
  'Khmer': 'km',
  'Kinyarwanda': 'rw',
  'Korean': 'ko',
  'Kurdish': 'ku',
  'Kyrgyz': 'ky',
  'Lao': 'lo',
  'Latin': 'la',
  'Latvian': 'lv',
  'Lithuanian': 'lt',
  'Luxembourgish': 'lb',
  'Macedonian': 'mk',
  'Malagasy': 'mg',
  'Malay': 'ms',
  'Malayalam': 'ml',
  'Maltese': 'mt',
  'Maori': 'mi',
  'Marathi': 'mr',
  'Mongolian': 'mn',
  'Myanmar (Burmese)': 'my',
  'Nepali': 'ne',
  'Norwegian': 'no',
  'Nyanja (Chichewa)': 'ny',
  'Odia (Oriya)': 'or',
  'Pashto': 'ps',
  'Persian': 'fa',
  'Polish': 'pl',
  'Portuguese (Portugal, Brazil)': 'pt',
  'Punjabi': 'pa',
  'Romanian': 'ro',
  'Russian': 'ru',
  'Samoan': 'sm',
  'Scots Gaelic': 'gd',
  'Serbian': 'sr',
  'Sesotho': 'st',
  'Shona': 'sn',
  'Sindhi': 'sd',
  'Sinhala (Sinhalese)': 'si',
  'Slovak': 'sk',
  'Slovenian': 'sl',
  'Somali': 'so',
  'Spanish': 'es',
  'Sundanese': 'su',
  'Swahili': 'sw',
  'Swedish': 'sv',
  'Tagalog (Filipino)': 'tl',
  'Tajik': 'tg',
  'Tamil': 'ta',
  'Tatar': 'tt',
  'Telugu': 'te',
  'Thai': 'th',
  'Turkish': 'tr',
  'Turkmen': 'tk',
  'Ukrainian': 'uk',
  'Urdu': 'ur',
  'Uyghur': 'ug',
  'Uzbek': 'uz',
  'Vietnamese': 'vi',
  'Welsh': 'cy',
  'Xhosa': 'xh',
  'Yiddish': 'yi',
  'Yoruba': 'yo',
  'Zulu': 'zu',
};
   */
  // -----------------------------------------------------------------------------
}
