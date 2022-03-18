import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainProperties {

  static const Chain chain = Chain(
    id: 'properties',
    icon: Iconz.bxPropertiesOff,
    phraseID: 'phid_k_properties_keywords',
    sons: <Chain>[


      // -----------------------------------------------
      /// Industrial
      Chain(
        id: 'ppt_lic_industrial',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Industrial'),
          Phrase(langCode: 'ar', value: 'صناعي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_factory',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Factory'),
              Phrase(langCode: 'ar', value: 'مصنع')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Educational
      Chain(
        id: 'ppt_lic_educational',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Educational'),
          Phrase(langCode: 'ar', value: 'تعليمي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_school',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'School'),
              Phrase(langCode: 'ar', value: 'مدرسة')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Hotel
      Chain(
        id: 'ppt_lic_hotel',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Hotel'),
          Phrase(langCode: 'ar', value: 'فندقي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_hotel',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Hotel'),
              Phrase(langCode: 'ar', value: 'فندق')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Entertainment
      Chain(
        id: 'ppt_lic_entertainment',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Entertainment'),
          Phrase(langCode: 'ar', value: 'ترفيهي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_gallery',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Gallery'),
              Phrase(langCode: 'ar', value: 'معرض')
            ],
          ),
          KW(
            id: 'pt_theatre',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Theatre'),
              Phrase(langCode: 'ar', value: 'مسرح')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Medical
      Chain(
        id: 'ppt_lic_medical',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Medical'),
          Phrase(langCode: 'ar', value: 'طبي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_clinic',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Clinic'),
              Phrase(langCode: 'ar', value: 'عيادة')
            ],
          ),
          KW(
            id: 'pt_hospital',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Hospital'),
              Phrase(langCode: 'ar', value: 'مستشفى')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Sports
      Chain(
        id: 'ppt_lic_sports',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Sports'),
          Phrase(langCode: 'ar', value: 'رياضي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_football',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Football court'),
              Phrase(langCode: 'ar', value: 'ملعب كرة قدم')
            ],
          ),
          KW(
            id: 'pt_tennis',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Tennis court'),
              Phrase(langCode: 'ar', value: 'ملعب كرة مضرب')
            ],
          ),
          KW(
            id: 'pt_basketball',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Basketball court'),
              Phrase(langCode: 'ar', value: 'ملعب كرة سلة')
            ],
          ),
          KW(
            id: 'pt_gym',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Gym'),
              Phrase(langCode: 'ar', value: 'جيمنازيوم')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Residential
      Chain(
        id: 'ppt_lic_residential',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Residential'),
          Phrase(langCode: 'ar', value: 'سكني')
        ],
        sons: <KW>[
          KW(
            id: 'pt_apartment',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Apartment'),
              Phrase(langCode: 'ar', value: 'شقة')
            ],
          ),
          KW(
            id: 'pt_furnishedApartment',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Furnished Apartment'),
              Phrase(langCode: 'ar', value: 'شقة مفروشة')
            ],
          ),
          KW(
            id: 'pt_loft',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Loft'),
              Phrase(langCode: 'ar', value: 'لوفت')
            ],
          ),
          KW(
            id: 'pt_penthouse',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Penthouse'),
              Phrase(langCode: 'ar', value: 'بنت هاوس')
            ],
          ),
          KW(
            id: 'pt_chalet',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Chalet'),
              Phrase(langCode: 'ar', value: 'شاليه')
            ],
          ),
          KW(
            id: 'pt_twinhouse',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Twin House'),
              Phrase(langCode: 'ar', value: 'توين هاوس')
            ],
          ),
          KW(
            id: 'pt_bungalow',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Bungalows & Cabanas'),
              Phrase(langCode: 'ar', value: 'بونجالو')
            ],
          ),
          KW(
            id: 'pt_villa',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Villa'),
              Phrase(langCode: 'ar', value: 'فيلا')
            ],
          ),
          KW(
            id: 'pt_condo',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Condo'),
              Phrase(langCode: 'ar', value: 'كوندو')
            ],
          ),
          KW(
            id: 'pt_farm',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Farm'),
              Phrase(langCode: 'ar', value: 'مزرعة')
            ],
          ),
          KW(
            id: 'pt_townHome',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Town Home'),
              Phrase(langCode: 'ar', value: 'تاون هوم')
            ],
          ),
          KW(
            id: 'pt_sharedRoom',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Shared Rooms'),
              Phrase(langCode: 'ar', value: 'غرفة مشتركة')
            ],
          ),
          KW(
            id: 'pt_duplix',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Duplix'),
              Phrase(langCode: 'ar', value: 'دوبليكس')
            ],
          ),
          KW(
            id: 'pt_hotelApartment',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Hotel apartment'),
              Phrase(langCode: 'ar', value: 'شقة فندقية')
            ],
          ),
          KW(
            id: 'pt_studio',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Studio'),
              Phrase(langCode: 'ar', value: 'ستوديو')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Retail
      Chain(
        id: 'ppt_lic_retail',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Retail'),
          Phrase(langCode: 'ar', value: 'تجاري')
        ],
        sons: <KW>[
          KW(
            id: 'pt_store',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Store & Shop'),
              Phrase(langCode: 'ar', value: 'محل و متجر')
            ],
          ),
          KW(
            id: 'pt_supermarket',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Supermarket'),
              Phrase(langCode: 'ar', value: 'بقالة')
            ],
          ),
          KW(
            id: 'pt_warehouse',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Warehouse '),
              Phrase(langCode: 'ar', value: 'مخزن و مستودع')
            ],
          ),
          KW(
            id: 'pt_hall',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Events Halls'),
              Phrase(langCode: 'ar', value: 'قاعة')
            ],
          ),
          KW(
            id: 'pt_bank',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Bank'),
              Phrase(langCode: 'ar', value: 'بنك')
            ],
          ),
          KW(
            id: 'pt_restaurant',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Restaurant & Café'),
              Phrase(langCode: 'ar', value: 'مطعم و مقهى')
            ],
          ),
          KW(
            id: 'pt_pharmacy',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Pharmacy'),
              Phrase(langCode: 'ar', value: 'صيدلية')
            ],
          ),
          KW(
            id: 'pt_studio',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Studio'),
              Phrase(langCode: 'ar', value: 'ستوديو')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Administration
      Chain(
        id: 'ppt_lic_administration',
        icon: null,
        phraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Administration'),
          Phrase(langCode: 'ar', value: 'إداري')
        ],
        sons: <KW>[
          KW(
            id: 'pt_office',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Office'),
              Phrase(langCode: 'ar', value: 'مكتب إداري')
            ],
          ),
        ],
      ),
      // -----------------------------------------------


    ],
  );

}
