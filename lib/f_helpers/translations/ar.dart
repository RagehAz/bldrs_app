import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';

TransModel bldrsTranslationsArabic = const TransModel(
  langCode: 'en',
  phrases: <Phrase>[
    // -----------------------------------------------------------------------

    /// GENERAL

    // -----------------------------
    Phrase(id: 'g_0002_bldrs', value: 'Bldrs'),
    Phrase(id: 'g_0003_bldrs_net', value: 'Bldrs.net'),
    // -----------------------------------------------------------------------

    /// KEYWORDS

    // -----------------------------
    Phrase(id: 'k_0001_bldrsChain', value: 'Bldrs Keywords'),
    // -----------------------------------------------------------------------

    /// SPECS

    // -----------------------------
    // Phrase(id: 'id', value: 'value'),
    // -----------------------------------------------------------------------

    /// NOTIFICATIONS

    // -----------------------------
    // Phrase(id: 'id', value: 'value'),
    // -----------------------------------------------------------------------

    /// ALERTS

    // -----------------------------
    Phrase(id: 'a_0001_bzTypeMissing_title', value: 'Business Type'),
    Phrase(id: 'a_0002_bzTypeMissing_message', value: 'Select your Business Main Service type.'),

    Phrase(id: 'a_0003_bzFormMissing_title', value: 'Business Form'),
    Phrase(id: 'a_0004_bzFormMissing_message', value: 'Select a company if your business Entity is Regulated.'),

    Phrase(id: 'a_0005_bzNameMissing_title', value: 'Business Name'),
    Phrase(id: 'a_0006_bzNameMissing_message', value: 'Enter Your Business brand name.'),

    Phrase(id: 'a_0007_bzLogoMissing_title', value: 'Business Logo'),
    Phrase(id: 'a_0008_bzLogoMissing_message', value: 'Add your Business logo.'),

    Phrase(id: 'a_0009_bzScopeMissing_title', value: 'Business Scope'),
    Phrase(id: 'a_0010_bzScopeMissing_message', value: 'Add The scope of services or products of your business.'),

    Phrase(id: 'a_0011_bzCountryMissing_title', value: 'Business Country'),
    Phrase(id: 'a_0012_bzCountryMissing_message', value: "Select your Business's target country."),

    Phrase(id: 'a_0013_bzCityMissing_title', value: 'Business City'),
    Phrase(id: 'a_0014_bzCityMissing_message', value: "Select your Business's target City."),

    Phrase(id: 'a_0015_bzAboutMissing_title', value: 'About Business'),
    Phrase(id: 'a_0016_bzAboutMissing_message', value: 'Add more information about your business'),


    // -----------------------------------------------------------------------


  ],
);

TransModel keywordsAndSpecsArabic = const TransModel(
  langCode: 'en',
  phrases: <Phrase>[
    // -----------------------------------------------------------------------

    /// KEYWORDS

    // -----------------------------
    Phrase(id: 'k_0001_bldrsChain', value: 'Bldrs Keywords'),
    Phrase(id: 'k_0002_properties_keywords', value: 'Properties Keywords'),
    Phrase(id: 'k_0003_designs_keywords', value: 'Designs Keywords'),
    Phrase(id: 'k_0004_crafts_keywords', value: 'Crafts Keywords'),
    Phrase(id: 'k_0005_products_keywords', value: 'Products Keywords'),
    Phrase(id: 'k_0006_equipment_keywords', value: 'Equipment Keywords'),

    // -----------------------------------------------------------------------

    /// SPECS

    // -----------------------------
    // Phrase(id: 'id', value: 'value'),
    // -----------------------------------------------------------------------
  ],
);
