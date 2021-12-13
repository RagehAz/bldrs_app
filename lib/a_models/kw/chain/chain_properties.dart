import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainProperties {
  static const Chain chain = Chain(
    id: 'properties',
    icon: Iconz.bxPropertiesOff,
    names: <Name>[
      Name(code: 'en', value: 'Properties'),
      Name(code: 'ar', value: '')
    ],
    sons: <Chain>[
      // -----------------------------------------------
      /// Industrial
      Chain(
        id: 'ppt_lic_industrial',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Industrial'),
          Name(code: 'ar', value: 'صناعي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_factory',
            names: <Name>[
              Name(code: 'en', value: 'Factory'),
              Name(code: 'ar', value: 'مصنع')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Educational
      Chain(
        id: 'ppt_lic_educational',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Educational'),
          Name(code: 'ar', value: 'تعليمي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_school',
            names: <Name>[
              Name(code: 'en', value: 'School'),
              Name(code: 'ar', value: 'مدرسة')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Hotel
      Chain(
        id: 'ppt_lic_hotel',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Hotel'),
          Name(code: 'ar', value: 'فندقي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_hotel',
            names: <Name>[
              Name(code: 'en', value: 'Hotel'),
              Name(code: 'ar', value: 'فندق')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Entertainment
      Chain(
        id: 'ppt_lic_entertainment',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Entertainment'),
          Name(code: 'ar', value: 'ترفيهي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_gallery',
            names: <Name>[
              Name(code: 'en', value: 'Gallery'),
              Name(code: 'ar', value: 'معرض')
            ],
          ),
          KW(
            id: 'pt_theatre',
            names: <Name>[
              Name(code: 'en', value: 'Theatre'),
              Name(code: 'ar', value: 'مسرح')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Medical
      Chain(
        id: 'ppt_lic_medical',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Medical'),
          Name(code: 'ar', value: 'طبي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_clinic',
            names: <Name>[
              Name(code: 'en', value: 'Clinic'),
              Name(code: 'ar', value: 'عيادة')
            ],
          ),
          KW(
            id: 'pt_hospital',
            names: <Name>[
              Name(code: 'en', value: 'Hospital'),
              Name(code: 'ar', value: 'مستشفى')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Sports
      Chain(
        id: 'ppt_lic_sports',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Sports'),
          Name(code: 'ar', value: 'رياضي')
        ],
        sons: <KW>[
          KW(
            id: 'pt_football',
            names: <Name>[
              Name(code: 'en', value: 'Football court'),
              Name(code: 'ar', value: 'ملعب كرة قدم')
            ],
          ),
          KW(
            id: 'pt_tennis',
            names: <Name>[
              Name(code: 'en', value: 'Tennis court'),
              Name(code: 'ar', value: 'ملعب كرة مضرب')
            ],
          ),
          KW(
            id: 'pt_basketball',
            names: <Name>[
              Name(code: 'en', value: 'Basketball court'),
              Name(code: 'ar', value: 'ملعب كرة سلة')
            ],
          ),
          KW(
            id: 'pt_gym',
            names: <Name>[
              Name(code: 'en', value: 'Gym'),
              Name(code: 'ar', value: 'جيمنازيوم')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Residential
      Chain(
        id: 'ppt_lic_residential',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Residential'),
          Name(code: 'ar', value: 'سكني')
        ],
        sons: <KW>[
          KW(
            id: 'pt_apartment',
            names: <Name>[
              Name(code: 'en', value: 'Apartment'),
              Name(code: 'ar', value: 'شقة')
            ],
          ),
          KW(
            id: 'pt_furnishedApartment',
            names: <Name>[
              Name(code: 'en', value: 'Furnished Apartment'),
              Name(code: 'ar', value: 'شقة مفروشة')
            ],
          ),
          KW(
            id: 'pt_loft',
            names: <Name>[
              Name(code: 'en', value: 'Loft'),
              Name(code: 'ar', value: 'لوفت')
            ],
          ),
          KW(
            id: 'pt_penthouse',
            names: <Name>[
              Name(code: 'en', value: 'Penthouse'),
              Name(code: 'ar', value: 'بنت هاوس')
            ],
          ),
          KW(
            id: 'pt_chalet',
            names: <Name>[
              Name(code: 'en', value: 'Chalet'),
              Name(code: 'ar', value: 'شاليه')
            ],
          ),
          KW(
            id: 'pt_twinhouse',
            names: <Name>[
              Name(code: 'en', value: 'Twin House'),
              Name(code: 'ar', value: 'توين هاوس')
            ],
          ),
          KW(
            id: 'pt_bungalow',
            names: <Name>[
              Name(code: 'en', value: 'Bungalows & Cabanas'),
              Name(code: 'ar', value: 'بونجالو')
            ],
          ),
          KW(
            id: 'pt_villa',
            names: <Name>[
              Name(code: 'en', value: 'Villa'),
              Name(code: 'ar', value: 'فيلا')
            ],
          ),
          KW(
            id: 'pt_condo',
            names: <Name>[
              Name(code: 'en', value: 'Condo'),
              Name(code: 'ar', value: 'كوندو')
            ],
          ),
          KW(
            id: 'pt_farm',
            names: <Name>[
              Name(code: 'en', value: 'Farm'),
              Name(code: 'ar', value: 'مزرعة')
            ],
          ),
          KW(
            id: 'pt_townHome',
            names: <Name>[
              Name(code: 'en', value: 'Town Home'),
              Name(code: 'ar', value: 'تاون هوم')
            ],
          ),
          KW(
            id: 'pt_sharedRoom',
            names: <Name>[
              Name(code: 'en', value: 'Shared Rooms'),
              Name(code: 'ar', value: 'غرفة مشتركة')
            ],
          ),
          KW(
            id: 'pt_duplix',
            names: <Name>[
              Name(code: 'en', value: 'Duplix'),
              Name(code: 'ar', value: 'دوبليكس')
            ],
          ),
          KW(
            id: 'pt_hotelApartment',
            names: <Name>[
              Name(code: 'en', value: 'Hotel apartment'),
              Name(code: 'ar', value: 'شقة فندقية')
            ],
          ),
          KW(
            id: 'pt_studio',
            names: <Name>[
              Name(code: 'en', value: 'Studio'),
              Name(code: 'ar', value: 'ستوديو')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Retail
      Chain(
        id: 'ppt_lic_retail',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Retail'),
          Name(code: 'ar', value: 'تجاري')
        ],
        sons: <KW>[
          KW(
            id: 'pt_store',
            names: <Name>[
              Name(code: 'en', value: 'Store & Shop'),
              Name(code: 'ar', value: 'محل و متجر')
            ],
          ),
          KW(
            id: 'pt_supermarket',
            names: <Name>[
              Name(code: 'en', value: 'Supermarket'),
              Name(code: 'ar', value: 'بقالة')
            ],
          ),
          KW(
            id: 'pt_warehouse',
            names: <Name>[
              Name(code: 'en', value: 'Warehouse '),
              Name(code: 'ar', value: 'مخزن و مستودع')
            ],
          ),
          KW(
            id: 'pt_hall',
            names: <Name>[
              Name(code: 'en', value: 'Events Halls'),
              Name(code: 'ar', value: 'قاعة')
            ],
          ),
          KW(
            id: 'pt_bank',
            names: <Name>[
              Name(code: 'en', value: 'Bank'),
              Name(code: 'ar', value: 'بنك')
            ],
          ),
          KW(
            id: 'pt_restaurant',
            names: <Name>[
              Name(code: 'en', value: 'Restaurant & Café'),
              Name(code: 'ar', value: 'مطعم و مقهى')
            ],
          ),
          KW(
            id: 'pt_pharmacy',
            names: <Name>[
              Name(code: 'en', value: 'Pharmacy'),
              Name(code: 'ar', value: 'صيدلية')
            ],
          ),
          KW(
            id: 'pt_studio',
            names: <Name>[
              Name(code: 'en', value: 'Studio'),
              Name(code: 'ar', value: 'ستوديو')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Administration
      Chain(
        id: 'ppt_lic_administration',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Administration'),
          Name(code: 'ar', value: 'إداري')
        ],
        sons: <KW>[
          KW(
            id: 'pt_office',
            names: <Name>[
              Name(code: 'en', value: 'Office'),
              Name(code: 'ar', value: 'مكتب إداري')
            ],
          ),
        ],
      ),
    ],
  );
}
