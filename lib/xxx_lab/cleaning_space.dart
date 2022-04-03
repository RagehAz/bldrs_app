import 'package:bldrs/a_models/kw/chain/chain_crafts.dart';
import 'package:bldrs/a_models/kw/specs/data_creator.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/foundation.dart';

const String newSaleID = 'contractType_NewSale';
const String resaleID = 'contractType_Resale';
const String rentID = 'contractType_Rent';

// -------------------------------------------------------------------------
/// STYLE ANATOMY
const Chaing style = Chaing(
  id: 'style',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Design Style'),
    Phra(langCode: 'ar', value: 'الطراز التصميمي')
  ],
  sons: <KWs>[
    KWs(
      id: 'arch_style_arabian',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Arabian'),
        Phra(langCode: 'ar', value: 'عربي')
      ],
    ),
    KWs(
      id: 'arch_style_andalusian',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Andalusian'),
        Phra(langCode: 'ar', value: 'أندلسي')
      ],
    ),
    KWs(
      id: 'arch_style_asian',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Asian'),
        Phra(langCode: 'ar', value: 'آسيوي')
      ],
    ),
    KWs(
      id: 'arch_style_chinese',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Chinese'),
        Phra(langCode: 'ar', value: 'صيني')
      ],
    ),
    KWs(
      id: 'arch_style_contemporary',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Contemporary'),
        Phra(langCode: 'ar', value: 'معاصر')
      ],
    ),
    KWs(
      id: 'arch_style_classic',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Classic'),
        Phra(langCode: 'ar', value: 'كلاسيكي')
      ],
    ),
    KWs(
      id: 'arch_style_eclectic',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Eclectic'),
        Phra(langCode: 'ar', value: 'انتقائي')
      ],
    ),
    KWs(
      id: 'arch_style_english',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'English'),
        Phra(langCode: 'ar', value: 'إنجليزي')
      ],
    ),
    KWs(
      id: 'arch_style_farmhouse',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Farmhouse'),
        Phra(langCode: 'ar', value: 'ريفي')
      ],
    ),
    KWs(
      id: 'arch_style_french',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'French'),
        Phra(langCode: 'ar', value: 'فرنساوي')
      ],
    ),
    KWs(
      id: 'arch_style_gothic',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Gothic'),
        Phra(langCode: 'ar', value: 'قوطي')
      ],
    ),
    KWs(
      id: 'arch_style_greek',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Greek'),
        Phra(langCode: 'ar', value: 'يوناني')
      ],
    ),
    KWs(
      id: 'arch_style_indian',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Indian'),
        Phra(langCode: 'ar', value: 'هندي')
      ],
    ),
    KWs(
      id: 'arch_style_industrial',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Industrial'),
        Phra(langCode: 'ar', value: 'صناعي')
      ],
    ),
    KWs(
      id: 'arch_style_japanese',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Japanese'),
        Phra(langCode: 'ar', value: 'ياباني')
      ],
    ),
    KWs(
      id: 'arch_style_mediterranean',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Mediterranean'),
        Phra(langCode: 'ar', value: 'البحر المتوسط')
      ],
    ),
    KWs(
      id: 'arch_style_midcentury',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Mid century modern'),
        Phra(langCode: 'ar', value: 'منتصف القرن الحديث')
      ],
    ),
    KWs(
      id: 'arch_style_medieval',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Medieval'),
        Phra(langCode: 'ar', value: 'القرون الوسطى')
      ],
    ),
    KWs(
      id: 'arch_style_minimalist',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Minimalist'),
        Phra(langCode: 'ar', value: 'مينيماليزم')
      ],
    ),
    KWs(
      id: 'arch_style_modern',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Modern'),
        Phra(langCode: 'ar', value: 'حديث')
      ],
    ),
    KWs(
      id: 'arch_style_moroccan',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Moroccan'),
        Phra(langCode: 'ar', value: 'مغربي')
      ],
    ),
    KWs(
      id: 'arch_style_rustic',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Rustic'),
        Phra(langCode: 'ar', value: 'فلاحي')
      ],
    ),
    KWs(
      id: 'arch_style_scandinavian',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Scandinavian'),
        Phra(langCode: 'ar', value: 'إسكاندنيفي')
      ],
    ),
    KWs(
      id: 'arch_style_shabbyChic',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Shabby Chic'),
        Phra(langCode: 'ar', value: 'مهترئ أنيق')
      ],
    ),
    KWs(
      id: 'arch_style_american',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'American'),
        Phra(langCode: 'ar', value: 'أمريكي')
      ],
    ),
    KWs(
      id: 'arch_style_spanish',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Spanish'),
        Phra(langCode: 'ar', value: 'أسباني')
      ],
    ),
    KWs(
      id: 'arch_style_traditional',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Traditional'),
        Phra(langCode: 'ar', value: 'تقليدي')
      ],
    ),
    KWs(
      id: 'arch_style_transitional',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Transitional'),
        Phra(langCode: 'ar', value: 'انتقالي')
      ],
    ),
    KWs(
      id: 'arch_style_tuscan',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Tuscan'),
        Phra(langCode: 'ar', value: 'توسكاني')
      ],
    ),
    KWs(
      id: 'arch_style_tropical',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Tropical'),
        Phra(langCode: 'ar', value: 'استوائي')
      ],
    ),
    KWs(
      id: 'arch_style_victorian',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Victorian'),
        Phra(langCode: 'ar', value: 'فيكتوريان')
      ],
    ),
    KWs(
      id: 'arch_style_vintage',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Vintage'),
        Phra(langCode: 'ar', value: 'عتيق')
      ],
    ),
  ],
);
const Chaing color = Chaing(
  id: 'color',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Color'),
    Phra(langCode: 'ar', value: 'اللون')
  ],
  sons: <KWs>[
    KWs(
      id: 'red',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Red'),
        Phra(langCode: 'ar', value: 'أحمر')
      ],
    ),
    KWs(
      id: 'orange',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Orange'),
        Phra(langCode: 'ar', value: 'برتقالي')
      ],
    ),
    KWs(
      id: 'yellow',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Yellow'),
        Phra(langCode: 'ar', value: 'أصفر')
      ],
    ),
    KWs(
      id: 'green',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Green'),
        Phra(langCode: 'ar', value: 'أخضر')
      ],
    ),
    KWs(
      id: 'blue',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Blue'),
        Phra(langCode: 'ar', value: 'أزرق')
      ],
    ),
    KWs(
      id: 'indigo',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Indigo'),
        Phra(langCode: 'ar', value: 'نيلي')
      ],
    ),
    KWs(
      id: 'violet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Violet'),
        Phra(langCode: 'ar', value: 'بنفسجي')
      ],
    ),
    KWs(
      id: 'black',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Black'),
        Phra(langCode: 'ar', value: 'أسود')
      ],
    ),
    KWs(
      id: 'white',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'White'),
        Phra(langCode: 'ar', value: 'أبيض')
      ],
    ),
    KWs(
      id: 'grey',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Grey'),
        Phra(langCode: 'ar', value: 'رمادي')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PRICING ANATOMY
const Chaing contractType = Chaing(
  id: 'contractType',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Contract Type'),
    Phra(langCode: 'ar', value: 'نوع التعاقد')
  ],
  sons: <KWs>[
    KWs(
      id: newSaleID,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'New Sale'),
        Phra(langCode: 'ar', value: 'للبيع جديد')
      ],
    ), // if you change ID revise specs_picker_screen
    KWs(
      id: resaleID,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Resale'),
        Phra(langCode: 'ar', value: 'لإعادة البيع')
      ],
    ), // if you change ID revise specs_picker_screen
    KWs(
      id: rentID,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Rent'),
        Phra(langCode: 'ar', value: 'للإيجار')
      ],
    ), // if you change ID revise specs_picker_screen
  ],
);
const Chaing paymentMethod = Chaing(
  id: 'paymentMethod',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Payment Method'),
    Phra(langCode: 'ar', value: 'طريقة السداد')
  ],
  sons: <KWs>[
    KWs(
      id: 'payment_cash',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Cash'),
        Phra(langCode: 'ar', value: 'دفعة واحدة')
      ],
    ),
    KWs(
      id: 'payment_installments',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Installments'),
        Phra(langCode: 'ar', value: 'على دفعات')
      ],
    ),
  ],
);
const Chaing price = Chaing(
  id: 'price',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'price'),
    Phra(langCode: 'ar', value: 'السعر')
  ],
  sons: DataCreator.price,
);
const Chaing currency = Chaing(
  id: 'currency',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Currency'),
    Phra(langCode: 'ar', value: 'العملة')
  ],
  sons: DataCreator.currency,
);
const Chaing unitPriceInterval = Chaing(
  id: 'unitPriceInterval',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Standard interval'),
    Phra(langCode: 'ar', value: 'مقياس الفترة')
  ],
  sons: <KWs>[
    KWs(
      id: 'perHour',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Per Hour'),
        Phra(langCode: 'ar', value: 'في الساعة')
      ],
    ),
    KWs(
      id: 'perDay',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'per day'),
        Phra(langCode: 'ar', value: 'في اليوم')
      ],
    ),
    KWs(
      id: 'perWeek',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'per week'),
        Phra(langCode: 'ar', value: 'في الأسبوع')
      ],
    ),
    KWs(
      id: 'perMonth',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'per month'),
        Phra(langCode: 'ar', value: 'في الشهر')
      ],
    ),
    KWs(
      id: 'perYear',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'per year'),
        Phra(langCode: 'ar', value: 'في السنة')
      ],
    ),
  ],
);
const Chaing numberOfInstallments = Chaing(
  id: 'numberOfInstallments',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Number of Installments'),
    Phra(langCode: 'ar', value: 'عدد الدفعات')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing installmentsDuration = Chaing(
  id: 'installmentsDuration',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Installments duration'),
    Phra(langCode: 'ar', value: 'مدة الدفعات')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing installmentsDurationUnit = Chaing(
  id: 'installmentsDurationUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Installments duration unit'),
    Phra(langCode: 'ar', value: 'مقياس مدة الدفعات')
  ],
  sons: <KWs>[
    KWs(
      id: 'installmentsDurationUnit_day',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'day'),
        Phra(langCode: 'ar', value: 'يوم')
      ],
    ),
    KWs(
      id: 'installmentsDurationUnit_week',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'week'),
        Phra(langCode: 'ar', value: 'أسبوع')
      ],
    ),
    KWs(
      id: 'installmentsDurationUnit_month',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'month'),
        Phra(langCode: 'ar', value: 'شهر')
      ],
    ),
    KWs(
      id: 'installmentsDurationUnit_year',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'year'),
        Phra(langCode: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// TIME ANATOMY
const Chaing duration = Chaing(
  id: 'duration',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Duration'),
    Phra(langCode: 'ar', value: 'الزمن')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing durationUnit = Chaing(
  id: 'durationUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Duration unit'),
    Phra(langCode: 'ar', value: 'مقياس الزمن')
  ],
  sons: <KWs>[
    KWs(
      id: 'minute',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'minute'),
        Phra(langCode: 'ar', value: 'دقيقة')
      ],
    ),
    KWs(
      id: 'hour',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'hour'),
        Phra(langCode: 'ar', value: 'ساعة')
      ],
    ),
    KWs(
      id: 'day',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'day'),
        Phra(langCode: 'ar', value: 'يوم')
      ],
    ),
    KWs(
      id: 'week',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'week'),
        Phra(langCode: 'ar', value: 'أسبوع')
      ],
    ),
    KWs(
      id: 'month',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'month'),
        Phra(langCode: 'ar', value: 'شهر')
      ],
    ),
    KWs(
      id: 'year',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'year'),
        Phra(langCode: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// AREAL ANATOMY
const Chaing propertyArea = Chaing(
  id: 'propertyArea',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property Area'),
    Phra(langCode: 'ar', value: 'مساحة العقار')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing propertyAreaUnit = Chaing(
  id: 'propertyAreaUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property Area Unit'),
    Phra(langCode: 'ar', value: 'وحدة قياس مساحة العقار')
  ],
  sons: <KWs>[
    KWs(
      id: 'square_meter',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'm²'),
        Phra(langCode: 'ar', value: 'م²')
      ],
    ),
    KWs(
      id: 'square_feet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'ft²'),
        Phra(langCode: 'ar', value: 'قدم²')
      ],
    ),
  ],
);
const Chaing lotArea = Chaing(
  id: 'plotArea',
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Lot Area'),
    Phra(langCode: 'ar', value: 'مساحة قطعة الأرض')
  ],
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chaing lotAreaUnit = Chaing(
  id: 'lotAreaUnit',
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Lot Area Unit'),
    Phra(langCode: 'ar', value: 'وحدة قياس مساحة أرض العقار')
  ],
  icon: null,
  sons: <KWs>[
    KWs(
      id: 'square_meter',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'm²'),
        Phra(langCode: 'ar', value: 'م²')
      ],
    ),
    KWs(
      id: 'square_Kilometer',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Km²'),
        Phra(langCode: 'ar', value: 'كم²')
      ],
    ),
    KWs(
      id: 'square_feet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'ft²'),
        Phra(langCode: 'ar', value: 'قدم²')
      ],
    ),
    KWs(
      id: 'square_yard',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'yd²'),
        Phra(langCode: 'ar', value: 'ياردة²')
      ],
    ),
    KWs(
      id: 'acre',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Acre'),
        Phra(langCode: 'ar', value: 'فدان')
      ],
    ),
    KWs(
      id: 'hectare',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Hectare'),
        Phra(langCode: 'ar', value: 'هكتار')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY GENERAL ANATOMY
const Chaing propertyForm = Chaing(
  id: 'propertyForm',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property Form'),
    Phra(langCode: 'ar', value: 'هيئة العقار')
  ],
  sons: <KWs>[
    KWs(
      id: 'pf_fullFloor',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Full floor'),
        Phra(langCode: 'ar', value: 'دور كامل')
      ],
    ),
    KWs(
      id: 'pf_halfFloor',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Half floor'),
        Phra(langCode: 'ar', value: 'نصف دور')
      ],
    ),
    KWs(
      id: 'pf_partFloor',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Part of floor'),
        Phra(langCode: 'ar', value: 'جزء من دور')
      ],
    ),
    KWs(
      id: 'pf_building',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Whole building'),
        Phra(langCode: 'ar', value: 'مبنى كامل')
      ],
    ),
    KWs(
      id: 'pf_land',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Land'),
        Phra(langCode: 'ar', value: 'أرض')
      ],
    ),
    KWs(
      id: 'pf_mobile',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Mobile'),
        Phra(langCode: 'ar', value: 'منشأ متنقل')
      ],
    ),
  ],
);
const Chaing propertyLicense = Chaing(
  id: 'propertyLicense',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property License'),
    Phra(langCode: 'ar', value: 'رخصة العقار')
  ],
  sons: <KWs>[
    KWs(
      id: 'ppt_lic_residential',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Residential'),
        Phra(langCode: 'ar', value: 'سكني')
      ],
    ),
    KWs(
      id: 'ppt_lic_administration',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Administration'),
        Phra(langCode: 'ar', value: 'إداري')
      ],
    ),
    KWs(
      id: 'ppt_lic_educational',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Educational'),
        Phra(langCode: 'ar', value: 'تعليمي')
      ],
    ),
    KWs(
      id: 'ppt_lic_utilities',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Utilities'),
        Phra(langCode: 'ar', value: 'خدمات')
      ],
    ),
    KWs(
      id: 'ppt_lic_sports',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Sports'),
        Phra(langCode: 'ar', value: 'رياضي')
      ],
    ),
    KWs(
      id: 'ppt_lic_entertainment',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Entertainment'),
        Phra(langCode: 'ar', value: 'ترفيهي')
      ],
    ),
    KWs(
      id: 'ppt_lic_medical',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Medical'),
        Phra(langCode: 'ar', value: 'طبي')
      ],
    ),
    KWs(
      id: 'ppt_lic_retail',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Retail'),
        Phra(langCode: 'ar', value: 'تجاري')
      ],
    ),
    KWs(
      id: 'ppt_lic_hotel',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Hotel'),
        Phra(langCode: 'ar', value: 'فندقي')
      ],
    ),
    KWs(
      id: 'ppt_lic_industrial',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Industrial'),
        Phra(langCode: 'ar', value: 'صناعي')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY SPATIAL ANATOMY
const Chaing propertySpaces = Chaing(
  id: 'group_space_type',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Space Type'),
    Phra(langCode: 'ar', value: 'نوع الفراغ')
  ],
  sons: <Chaing>[
    // ----------------------------------
    /// Administration
    Chaing(
      id: 'ppt_lic_administration',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Administration'),
        Phra(langCode: 'ar', value: 'إداري')
      ],
      sons: <KWs>[
        KWs(
          id: 'pt_office',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Office'),
            Phra(langCode: 'ar', value: 'مكتب إداري')
          ],
        ),
        KWs(
          id: 'space_office',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Office'),
            Phra(langCode: 'ar', value: 'مكتب')
          ],
        ),
        KWs(
          id: 'space_kitchenette',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Office Kitchenette'),
            Phra(langCode: 'ar', value: 'أوفيس / مطبخ صغير')
          ],
        ),
        KWs(
          id: 'space_meetingRoom',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Meeting room'),
            Phra(langCode: 'ar', value: 'غرفة اجتماعات')
          ],
        ),
        KWs(
          id: 'space_seminarHall',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Seminar hall'),
            Phra(langCode: 'ar', value: 'قاعة سمينار')
          ],
        ),
        KWs(
          id: 'space_conventionHall',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Convention hall'),
            Phra(langCode: 'ar', value: 'قاعة عرض')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Educational
    Chaing(
      id: 'ppt_lic_educational',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Educational'),
        Phra(langCode: 'ar', value: 'تعليمي')
      ],
      sons: <KWs>[
        KWs(
          id: 'space_lectureRoom',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Lecture room'),
            Phra(langCode: 'ar', value: 'غرفة محاضرات')
          ],
        ),
        KWs(
          id: 'space_library',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Library'),
            Phra(langCode: 'ar', value: 'مكتبة')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Entertainment
    Chaing(
      id: 'ppt_lic_entertainment',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Entertainment'),
        Phra(langCode: 'ar', value: 'ترفيهي')
      ],
      sons: <KWs>[
        KWs(
          id: 'space_theatre',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Theatre'),
            Phra(langCode: 'ar', value: 'مسرح')
          ],
        ),
        KWs(
          id: 'space_concertHall',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Concert hall'),
            Phra(langCode: 'ar', value: 'قاعة موسيقية')
          ],
        ),
        KWs(
          id: 'space_homeCinema',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Home Cinema'),
            Phra(langCode: 'ar', value: 'مسرح منزلي')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Medical
    Chaing(
      id: 'ppt_lic_medical',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Medical'),
        Phra(langCode: 'ar', value: 'طبي')
      ],
      sons: <KWs>[
        KWs(
          id: 'space_spa',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Spa'),
            Phra(langCode: 'ar', value: 'منتجع صحي')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Residential
    Chaing(
      id: 'ppt_lic_residential',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Residential'),
        Phra(langCode: 'ar', value: 'سكني')
      ],
      sons: <KWs>[
        KWs(
          id: 'space_lobby',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Lobby'),
            Phra(langCode: 'ar', value: 'ردهة')
          ],
        ),
        KWs(
          id: 'space_living',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Living room'),
            Phra(langCode: 'ar', value: 'غرفة معيشة')
          ],
        ),
        KWs(
          id: 'space_bedroom',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Bedroom'),
            Phra(langCode: 'ar', value: 'غرفة نوم')
          ],
        ),
        KWs(
          id: 'space_kitchen',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Home Kitchen'),
            Phra(langCode: 'ar', value: 'مطبخ')
          ],
        ),
        KWs(
          id: 'space_bathroom',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Bathroom'),
            Phra(langCode: 'ar', value: 'حمام')
          ],
        ),
        KWs(
          id: 'space_reception',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Reception'),
            Phra(langCode: 'ar', value: 'استقبال')
          ],
        ),
        KWs(
          id: 'space_salon',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Salon'),
            Phra(langCode: 'ar', value: 'صالون')
          ],
        ),
        KWs(
          id: 'space_laundry',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Laundry room'),
            Phra(langCode: 'ar', value: 'غرفة غسيل')
          ],
        ),
        KWs(
          id: 'space_balcony',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Balcony'),
            Phra(langCode: 'ar', value: 'تراس')
          ],
        ),
        KWs(
          id: 'space_toilet',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Toilet'),
            Phra(langCode: 'ar', value: 'دورة مياه')
          ],
        ),
        KWs(
          id: 'space_dining',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Dining room'),
            Phra(langCode: 'ar', value: 'غرفة طعام')
          ],
        ),
        KWs(
          id: 'space_stairs',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Stairs'),
            Phra(langCode: 'ar', value: 'سلالم')
          ],
        ),
        KWs(
          id: 'space_attic',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Attic'),
            Phra(langCode: 'ar', value: 'علية / صندرة')
          ],
        ),
        KWs(
          id: 'space_corridor',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Corridor'),
            Phra(langCode: 'ar', value: 'رواق / طرقة')
          ],
        ),
        KWs(
          id: 'space_garage',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Garage'),
            Phra(langCode: 'ar', value: 'جراج')
          ],
        ),
        KWs(
          id: 'space_storage',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Storage room'),
            Phra(langCode: 'ar', value: 'مخزن')
          ],
        ),
        KWs(
          id: 'space_maid',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Maid room'),
            Phra(langCode: 'ar', value: 'غرفة مربية')
          ],
        ),
        KWs(
          id: 'space_walkInCloset',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Walk In closet'),
            Phra(langCode: 'ar', value: 'غرفة ملابس')
          ],
        ),
        KWs(
          id: 'space_barbecue',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Barbecue area'),
            Phra(langCode: 'ar', value: 'مساحة شواية')
          ],
        ),
        KWs(
          id: 'space_garden',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Private garden'),
            Phra(langCode: 'ar', value: 'حديقة خاصة')
          ],
        ),
        KWs(
          id: 'space_privatePool',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Private pool'),
            Phra(langCode: 'ar', value: 'حمام سباحة خاص')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Retail
    Chaing(
      id: 'ppt_lic_retail',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Retail'),
        Phra(langCode: 'ar', value: 'تجاري')
      ],
      sons: <KWs>[
        KWs(
          id: 'space_store',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Store / Shop'),
            Phra(langCode: 'ar', value: 'محل / متجر')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Sports
    Chaing(
      id: 'ppt_lic_sports',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Sports'),
        Phra(langCode: 'ar', value: 'رياضي')
      ],
      sons: <KWs>[
        KWs(
          id: 'space_gymnasium',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Gymnasium'),
            Phra(langCode: 'ar', value: 'جيمنازيوم')
          ],
        ),
        KWs(
          id: 'space_sportsCourt',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Sports court'),
            Phra(langCode: 'ar', value: 'ملعب رياضي')
          ],
        ),
        KWs(
          id: 'space_sportStadium',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Stadium'),
            Phra(langCode: 'ar', value: 'استاد رياضي')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Utilities
    Chaing(
      id: 'ppt_lic_utilities',
      icon: null,
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Utilities'),
        Phra(langCode: 'ar', value: 'خدمات')
      ],
      sons: <KWs>[
        KWs(
          id: 'pFeature_elevator',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Elevator'),
            Phra(langCode: 'ar', value: 'مصعد')
          ],
        ),
        KWs(
          id: 'space_electricityRoom',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Electricity rooms'),
            Phra(langCode: 'ar', value: 'غرفة كهرباء')
          ],
        ),
        KWs(
          id: 'space_plumbingRoom',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Plumbing rooms'),
            Phra(langCode: 'ar', value: 'غرفة صحي و صرف')
          ],
        ),
        KWs(
          id: 'space_mechanicalRoom',
          phras: <Phra>[
            Phra(langCode: 'en', value: 'Mechanical rooms'),
            Phra(langCode: 'ar', value: 'غرفة ميكانيكية')
          ],
        ),
      ],
    ),
  ],
);
const Chaing propertyFloorNumber = Chaing(
  id: 'propertyFloorNumber',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property Floor Number'),
    Phra(langCode: 'ar', value: 'رقم دور العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing propertyDedicatedParkingLotsCount = Chaing(
  id: 'propertyDedicatedParkingSpaces',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Number of property dedicated parking lots'),
    Phra(langCode: 'ar', value: 'عدد مواقف السيارات المخصصة للعقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing propertyNumberOfBedrooms = Chaing(
  id: 'propertyNumberOfBedrooms',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property Number of Bedrooms'),
    Phra(langCode: 'ar', value: 'عدد غرف نوم العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing propertyNumberOfBathrooms = Chaing(
  id: 'propertyNumberOfBathrooms',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property Number of bathrooms'),
    Phra(langCode: 'ar', value: 'عدد حمامات العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// PROPERTY FEATURES ANATOMY
const Chaing propertyView = Chaing(
  id: 'propertyView',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property View'),
    Phra(langCode: 'ar', value: 'المنظر المطل عليه  العقار')
  ],
  sons: <KWs>[
    KWs(
      id: 'view_golf',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Golf course view'),
        Phra(langCode: 'ar', value: 'مضمار جولف')
      ],
    ),
    KWs(
      id: 'view_hill',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Hill or Mountain view'),
        Phra(langCode: 'ar', value: 'تل أو جبل')
      ],
    ),
    KWs(
      id: 'view_ocean',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Ocean view'),
        Phra(langCode: 'ar', value: 'محيط')
      ],
    ),
    KWs(
      id: 'view_city',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'City view'),
        Phra(langCode: 'ar', value: 'مدينة')
      ],
    ),
    KWs(
      id: 'view_lake',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Lake view'),
        Phra(langCode: 'ar', value: 'بحيرة')
      ],
    ),
    KWs(
      id: 'view_lagoon',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Lagoon view'),
        Phra(langCode: 'ar', value: 'لاجون')
      ],
    ),
    KWs(
      id: 'view_river',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'River view'),
        Phra(langCode: 'ar', value: 'نهر')
      ],
    ),
    KWs(
      id: 'view_mainStreet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Main street view'),
        Phra(langCode: 'ar', value: 'شارع رئيسي')
      ],
    ),
    KWs(
      id: 'view_sideStreet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Side street view'),
        Phra(langCode: 'ar', value: 'شارع جانبي')
      ],
    ),
    KWs(
      id: 'view_corner',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Corner view'),
        Phra(langCode: 'ar', value: 'ناصية الشارع')
      ],
    ),
    KWs(
      id: 'view_back',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Back view'),
        Phra(langCode: 'ar', value: 'خلفي')
      ],
    ),
    KWs(
      id: 'view_garden',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Garden view'),
        Phra(langCode: 'ar', value: 'حديقة')
      ],
    ),
    KWs(
      id: 'view_pool',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Pool view'),
        Phra(langCode: 'ar', value: 'حمام سباحة')
      ],
    ),
  ],
);
const Chaing propertyIndoorFeatures = Chaing(
  id: 'sub_ppt_feat_indoor',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Property Indoor Features'),
    Phra(langCode: 'ar', value: 'خواص العقار الداخلية')
  ],
  sons: <KWs>[
    KWs(
      id: 'pFeature_disabilityFeatures',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Disability features'),
        Phra(langCode: 'ar', value: 'خواص معتبرة للإعاقة و المقعدين')
      ],
    ),
    KWs(
      id: 'pFeature_fireplace',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Fireplace'),
        Phra(langCode: 'ar', value: 'مدفأة حطب')
      ],
    ),
    KWs(
      id: 'pFeature_energyEfficient',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Energy efficient'),
        Phra(langCode: 'ar', value: 'موفر للطاقة')
      ],
    ),
    KWs(
      id: 'pFeature_electricityBackup',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Electricity backup'),
        Phra(langCode: 'ar', value: 'دعم كهرباء احتياطي')
      ],
    ),
    KWs(
      id: 'pFeature_centralAC',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Central AC'),
        Phra(langCode: 'ar', value: 'تكييف مركزي')
      ],
    ),
    KWs(
      id: 'pFeature_centralHeating',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Central heating'),
        Phra(langCode: 'ar', value: 'تدفئة مركزية')
      ],
    ),
    KWs(
      id: 'pFeature_builtinWardrobe',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Built-in wardrobes'),
        Phra(langCode: 'ar', value: 'دواليب داخل الحوائط')
      ],
    ),
    KWs(
      id: 'pFeature_kitchenAppliances',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Kitchen Appliances'),
        Phra(langCode: 'ar', value: 'أجهزة مطبخ')
      ],
    ),
    KWs(
      id: 'pFeature_elevator',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Elevator'),
        Phra(langCode: 'ar', value: 'مصعد')
      ],
    ),
    KWs(
      id: 'pFeature_intercom',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Intercom'),
        Phra(langCode: 'ar', value: 'إنتركوم')
      ],
    ),
    KWs(
      id: 'pFeature_internet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Broadband internet'),
        Phra(langCode: 'ar', value: 'إنترنت')
      ],
    ),
    KWs(
      id: 'pFeature_tv',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Satellite / Cable TV'),
        Phra(langCode: 'ar', value: 'قمر صناعي / تلفزيون مركزي')
      ],
    ),
  ],
);
const Chaing propertyFinishingLevel = Chaing(
  id: 'sub_ppt_feat_finishing',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Finishing level'),
    Phra(langCode: 'ar', value: 'مستوى التشطيب')
  ],
  sons: <KWs>[
    KWs(
      id: 'finish_coreAndShell',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Core and shell'),
        Phra(langCode: 'ar', value: 'خرسانات و حوائط خارجية')
      ],
    ),
    KWs(
      id: 'finish_withoutFinishing',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Without finishing'),
        Phra(langCode: 'ar', value: 'غير متشطب')
      ],
    ),
    KWs(
      id: 'finish_semiFinished',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Semi finished'),
        Phra(langCode: 'ar', value: 'نصف تشطيب')
      ],
    ),
    KWs(
      id: 'finish_lux',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Lux'),
        Phra(langCode: 'ar', value: 'تشطيب لوكس')
      ],
    ),
    KWs(
      id: 'finish_superLux',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Super lux'),
        Phra(langCode: 'ar', value: 'تشطيب سوبر لوكس')
      ],
    ),
    KWs(
      id: 'finish_extraSuperLux',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Extra super lux'),
        Phra(langCode: 'ar', value: 'تشطيب إكسترا سوبر لوكس')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// BUILDING FEATURES ANATOMY
const Chaing buildingNumberOfFloors = Chaing(
  id: 'buildingNumberOfFloors',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Building number of floors'),
    Phra(langCode: 'ar', value: 'عدد أدوار المبنى')
  ],
  sons: DataCreator.integerIncrementer, // TASK : define range 0 - g163
);
const Chaing buildingAgeInYears = Chaing(
  id: 'buildingAge',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Building Age'),
    Phra(langCode: 'ar', value: 'عمر المنشأ')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing buildingTotalParkingLotsCount = Chaing(
  id: 'buildingTotalParkingLotsCount',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Total Building parking lots count'),
    Phra(langCode: 'ar', value: 'مجموع عدد مواقف السيارات للمبنى')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing buildingTotalUnitsCount = Chaing(
  id: 'buildingTotalPropertiesCount',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Total Building units count'),
    Phra(langCode: 'ar', value: 'مجموع عدد وحدات المبنى')
  ],
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// COMMUNITY FEATURES ANATOMY
const Chaing inACompound = Chaing(
  id: 'sub_ppt_feat_compound',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'In a Compound'),
    Phra(langCode: 'ar', value: 'في مجمع سكني')
  ],
  sons: <KWs>[
    KWs(
      id: 'in_compound',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'In a compound'),
        Phra(langCode: 'ar', value: 'في مجمع سكني')
      ],
    ),
    KWs(
      id: 'not_in_compound',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Not in a compound'),
        Phra(langCode: 'ar', value: 'ليست في مجمع سكني')
      ],
    ),
  ],
);
const Chaing amenities = Chaing(
  id: 'sub_ppt_feat_amenities',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Amenities'),
    Phra(langCode: 'ar', value: 'منشآت خدمية ملحقة')
  ],
  sons: <KWs>[
    KWs(
      id: 'am_laundry',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Laundry'),
        Phra(langCode: 'ar', value: 'مغسلة')
      ],
    ),
    KWs(
      id: 'am_swimmingPool',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Swimming pool'),
        Phra(langCode: 'ar', value: 'حمام سباحة')
      ],
    ),
    KWs(
      id: 'am_kidsPool',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Kids pool'),
        Phra(langCode: 'ar', value: 'حمام سباحة أطفال')
      ],
    ),
    KWs(
      id: 'am_boatFacilities',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Boat facilities'),
        Phra(langCode: 'ar', value: 'خدمات مراكب مائية')
      ],
    ),
    KWs(
      id: 'am_gymFacilities',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Gym'),
        Phra(langCode: 'ar', value: 'صالة جيمنازيوم')
      ],
    ),
    KWs(
      id: 'am_clubHouse',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Clubhouse'),
        Phra(langCode: 'ar', value: 'كلاب هاوس')
      ],
    ),
    KWs(
      id: 'am_horseFacilities',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Horse facilities'),
        Phra(langCode: 'ar', value: 'خدمات خيول')
      ],
    ),
    KWs(
      id: 'am_sportsCourts',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Sports courts'),
        Phra(langCode: 'ar', value: 'ملاعب رياضية')
      ],
    ),
    KWs(
      id: 'am_park',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Park / garden'),
        Phra(langCode: 'ar', value: 'حديقة')
      ],
    ),
    KWs(
      id: 'am_golfCourse',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Golf course'),
        Phra(langCode: 'ar', value: 'مضمار جولف')
      ],
    ),
    KWs(
      id: 'am_spa',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Spa'),
        Phra(langCode: 'ar', value: 'منتجع صحي')
      ],
    ),
    KWs(
      id: 'am_kidsArea',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Kids Area'),
        Phra(langCode: 'ar', value: 'منطقة أطفال')
      ],
    ),
    KWs(
      id: 'am_cafeteria',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Cafeteria'),
        Phra(langCode: 'ar', value: 'كافيتيريا')
      ],
    ),
    KWs(
      id: 'am_businessCenter',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Business center'),
        Phra(langCode: 'ar', value: 'مقر أعمال')
      ],
    ),
    KWs(
      id: 'am_lobby',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Building lobby'),
        Phra(langCode: 'ar', value: 'ردهة مدخل للمبنى')
      ],
    ),
  ],
);
const Chaing communityServices = Chaing(
  id: 'sub_ppt_feat_services',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Community Services'),
    Phra(langCode: 'ar', value: 'خدمات المجتمع')
  ],
  sons: <KWs>[
    KWs(
      id: 'pService_houseKeeping',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Housekeeping'),
        Phra(langCode: 'ar', value: 'خدمة تنظيف منزلي')
      ],
    ),
    KWs(
      id: 'pService_laundryService',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'LaundryService'),
        Phra(langCode: 'ar', value: 'خدمة غسيل ملابس')
      ],
    ),
    KWs(
      id: 'pService_concierge',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Concierge'),
        Phra(langCode: 'ar', value: 'خدمة استقبال')
      ],
    ),
    KWs(
      id: 'pService_securityStaff',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Security  staff'),
        Phra(langCode: 'ar', value: 'فريق حراسة')
      ],
    ),
    KWs(
      id: 'pService_securityCCTV',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'CCTV security'),
        Phra(langCode: 'ar', value: 'كاميرات مراقبة')
      ],
    ),
    KWs(
      id: 'pService_petsAllowed',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Pets allowed'),
        Phra(langCode: 'ar', value: 'مسموح بالحيوانات الأليفة')
      ],
    ),
    KWs(
      id: 'pService_doorMan',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Doorman'),
        Phra(langCode: 'ar', value: 'حاجب العقار')
      ],
    ),
    KWs(
      id: 'pService_maintenance',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Maintenance staff'),
        Phra(langCode: 'ar', value: 'فريق صيانة')
      ],
    ),
    KWs(
      id: 'pService_wasteDisposal',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Waste disposal'),
        Phra(langCode: 'ar', value: 'خدمة رفع القمامة')
      ],
    ),
    KWs(
      id: 'pFeature_atm',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'ATM'),
        Phra(langCode: 'ar', value: 'ماكينة سحب أموال ATM')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// CONSTRUCTION ACTIVITY ANATOMY
// const Chaing projectCost = const Chaing(
//   id: 'projectCost',
//   icon: null,
//   names: <Name>[Name(code: 'en', value: 'Project cost'), Name(code: 'ar', value: 'تكلفة المشروع')],
//   sons: DataCreator.numberKeyboard,
// );

Chaing constructionActivities = Chaing(
  id: 'constructionActivities',
  icon: null,
  phras: const <Phra>[
    Phra(langCode: 'en', value: 'Project construction activities'),
    Phra(langCode: 'ar', value: 'بنود تنفيذ المشروع')
  ],
  sons: ChainCrafts.chain.sons,
);
const Chaing constructionActivityMeasurementMethod = Chaing(
  id: 'constructionActivityMeasurementMethod',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Measurement unit'),
    Phra(langCode: 'ar', value: 'أسلوب القياس')
  ],
  sons: <KWs>[
    KWs(
      id: 'byLength',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'by Length'),
        Phra(langCode: 'ar', value: 'بالأطوال')
      ],
    ),
    KWs(
      id: 'byArea',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'by Area'),
        Phra(langCode: 'ar', value: 'بالمساحة')
      ],
    ),
    KWs(
      id: 'byVolume',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'by Volume'),
        Phra(langCode: 'ar', value: 'بالحجم')
      ],
    ),
    KWs(
      id: 'byCount',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'by Count'),
        Phra(langCode: 'ar', value: 'بالعدد')
      ],
    ),
    KWs(
      id: 'byTime',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'by Time'),
        Phra(langCode: 'ar', value: 'بالفترة الزمنية')
      ],
    ),
    KWs(
      id: 'byLove',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'by Love'),
        Phra(langCode: 'ar', value: 'بالحب')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// SIZING ANATOMY
const Chaing width = Chaing(
  id: 'width',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Width'),
    Phra(langCode: 'ar', value: 'العرض')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing length = Chaing(
  id: 'length',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Length'),
    Phra(langCode: 'ar', value: 'الطول')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing height = Chaing(
  id: 'height',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Height'),
    Phra(langCode: 'ar', value: 'الارتفاع')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing thickness = Chaing(
  id: 'thickness',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Thickness'),
    Phra(langCode: 'ar', value: 'السمك')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing diameter = Chaing(
  id: 'diameter',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Diameter'),
    Phra(langCode: 'ar', value: 'القطر')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing radius = Chaing(
  id: 'radius',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Radius'),
    Phra(langCode: 'ar', value: 'نصف القطر')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing linearMeasurementUnit = Chaing(
  id: 'linearMeasureUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Linear measurement unit'),
    Phra(langCode: 'ar', value: 'وحدة القياس الطولي')
  ],
  sons: <KWs>[
    KWs(
      id: 'micron',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'micron'),
        Phra(langCode: 'ar', value: 'ميكرون')
      ],
    ),
    KWs(
      id: 'millimeter',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'millimetre'),
        Phra(langCode: 'ar', value: 'ملليمتر')
      ],
    ),
    KWs(
      id: 'centimeter',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'centimeter'),
        Phra(langCode: 'ar', value: 'سنتيمتر')
      ],
    ),
    KWs(
      id: 'meter',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'meter'),
        Phra(langCode: 'ar', value: 'متر')
      ],
    ),
    KWs(
      id: 'kilometer',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Kilometer'),
        Phra(langCode: 'ar', value: 'كيلومتر')
      ],
    ),
    KWs(
      id: 'inch',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'inch'),
        Phra(langCode: 'ar', value: 'بوصة')
      ],
    ),
    KWs(
      id: 'feet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'feet'),
        Phra(langCode: 'ar', value: 'قدم')
      ],
    ),
    KWs(
      id: 'yard',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'yard'),
        Phra(langCode: 'ar', value: 'ياردة')
      ],
    ),
    KWs(
      id: 'mile',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'mile'),
        Phra(langCode: 'ar', value: 'ميل')
      ],
    ),
  ],
);
const Chaing footPrint = Chaing(
  id: 'footPrint',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Footprint'),
    Phra(langCode: 'ar', value: 'مساحة الأرضية')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing areaMeasureUnit = Chaing(
  id: 'areaMeasureUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Area measurement unit'),
    Phra(langCode: 'ar', value: 'وحدة القياس المساحة')
  ],
  sons: <KWs>[
    KWs(
      id: 'square_meter',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'm²'),
        Phra(langCode: 'ar', value: 'م²')
      ],
    ),
    KWs(
      id: 'square_Kilometer',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Km²'),
        Phra(langCode: 'ar', value: 'كم²')
      ],
    ),
    KWs(
      id: 'square_feet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'ft²'),
        Phra(langCode: 'ar', value: 'قدم²')
      ],
    ),
    KWs(
      id: 'square_yard',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'yd²'),
        Phra(langCode: 'ar', value: 'ياردة²')
      ],
    ),
    KWs(
      id: 'acre',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Acre'),
        Phra(langCode: 'ar', value: 'فدان')
      ],
    ),
    KWs(
      id: 'hectare',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'Hectare'),
        Phra(langCode: 'ar', value: 'هكتار')
      ],
    ),
  ],
);
const Chaing volume = Chaing(
  id: 'volume',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Volume'),
    Phra(langCode: 'ar', value: 'الحجم')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing volumeMeasurementUnit = Chaing(
  id: 'volumeMeasurementUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Volume measurement unit'),
    Phra(langCode: 'ar', value: 'وحدة قياس الحجم')
  ],
  sons: <KWs>[
    KWs(
      id: 'cubic_cm',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'cm³'),
        Phra(langCode: 'ar', value: 'سم³')
      ],
    ),
    KWs(
      id: 'cubic_m',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'm³'),
        Phra(langCode: 'ar', value: 'م³')
      ],
    ),
    KWs(
      id: 'millilitre',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'ml'),
        Phra(langCode: 'ar', value: 'مم')
      ],
    ),
    KWs(
      id: 'litre',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'L'),
        Phra(langCode: 'ar', value: 'لتر')
      ],
    ),
    KWs(
      id: 'fluidOunce',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'fl oz'),
        Phra(langCode: 'ar', value: 'أونصة سائلة')
      ],
    ),
    KWs(
      id: 'gallon',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'gal'),
        Phra(langCode: 'ar', value: 'جالون')
      ],
    ),
    KWs(
      id: 'cubic_inch',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'inch³'),
        Phra(langCode: 'ar', value: 'بوصة مكعبة')
      ],
    ),
    KWs(
      id: 'cubic_feet',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'feet³'),
        Phra(langCode: 'ar', value: 'قدم مكعب')
      ],
    ),
  ],
);
const Chaing weight = Chaing(
  id: 'weight',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Weight'),
    Phra(langCode: 'ar', value: 'الوزن')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing weightMeasurementUnit = Chaing(
  id: 'weightMeasurementUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Weight measurement unit'),
    Phra(langCode: 'ar', value: 'وحدة قياس الوزن')
  ],
  sons: <KWs>[
    KWs(
      id: 'ounce',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'oz'),
        Phra(langCode: 'ar', value: 'أونصة')
      ],
    ),
    KWs(
      id: 'pound',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'lb'),
        Phra(langCode: 'ar', value: 'رطل')
      ],
    ),
    KWs(
      id: 'ton',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'ton'),
        Phra(langCode: 'ar', value: 'طن')
      ],
    ),
    KWs(
      id: 'gram',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'gm'),
        Phra(langCode: 'ar', value: 'جرام')
      ],
    ),
    KWs(
      id: 'kilogram',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'kg'),
        Phra(langCode: 'ar', value: 'كج')
      ],
    ),
  ],
);
const Chaing count = Chaing(
  id: 'count',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Count'),
    Phra(langCode: 'ar', value: 'العدد')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chaing size = Chaing(
  id: 'size',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Size'),
    Phra(langCode: 'ar', value: 'المقاس')
  ],
  sons: <KWs>[
    KWs(
      id: 'xxxSmall',
      phras: <Phra>[
        Phra(langCode: 'en', value: '3xs'),
        Phra(langCode: 'ar', value: '3xs')
      ],
    ),
    KWs(
      id: 'xxSmall',
      phras: <Phra>[
        Phra(langCode: 'en', value: '2xs'),
        Phra(langCode: 'ar', value: '2xs')
      ],
    ),
    KWs(
      id: 'xSmall',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'xs'),
        Phra(langCode: 'ar', value: 'xs')
      ],
    ),
    KWs(
      id: 'small',
      phras: <Phra>[Phra(langCode: 'en', value: 's'), Phra(langCode: 'ar', value: 's')],
    ),
    KWs(
      id: 'medium',
      phras: <Phra>[Phra(langCode: 'en', value: 'm'), Phra(langCode: 'ar', value: 'm')],
    ),
    KWs(
      id: 'large',
      phras: <Phra>[Phra(langCode: 'en', value: 'L'), Phra(langCode: 'ar', value: 'L')],
    ),
    KWs(
      id: 'xLarge',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'xL'),
        Phra(langCode: 'ar', value: 'xL')
      ],
    ),
    KWs(
      id: 'xxLarge',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'xxL'),
        Phra(langCode: 'ar', value: 'xxL')
      ],
    ),
    KWs(
      id: 'xxxLarge',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'xxxL'),
        Phra(langCode: 'ar', value: 'xxxL')
      ],
    ),
  ],
);
// ------------------------------------------
/// ELECTRICAL ANATOMY
const Chaing wattage = Chaing(
  id: 'wattage',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Watt'),
    Phra(langCode: 'ar', value: 'وات')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing voltage = Chaing(
  id: 'voltage',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'volt'),
    Phra(langCode: 'ar', value: 'فولت')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing ampere = Chaing(
  id: 'ampere',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'amps'),
    Phra(langCode: 'ar', value: 'أمبير')
  ],
  sons: DataCreator.doubleCreator,
);
// ------------------------------------------
/// LOGISTICS ANATOMY
const Chaing inStock = Chaing(
  id: 'inStock',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'In Stock'),
    Phra(langCode: 'ar', value: 'متوفر في المخزون')
  ],
  sons: DataCreator.boolSwitch,
);
const Chaing deliveryAvailable = Chaing(
  id: 'deliveryAvailable',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Available delivery'),
    Phra(langCode: 'ar', value: 'التوصيل متوفر')
  ],
  sons: DataCreator.boolSwitch,
);
const Chaing deliveryDuration = Chaing(
  id: 'deliveryMinDuration',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Delivery duration'),
    Phra(langCode: 'ar', value: 'فترة التوصيل')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing deliveryDurationUnit = Chaing(
  id: 'deliveryDurationUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Delivery duration unit'),
    Phra(langCode: 'ar', value: 'مقياس فترة التوصيل')
  ],
  sons: <KWs>[
    KWs(
      id: 'hour',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'hour'),
        Phra(langCode: 'ar', value: 'ساعة')
      ],
    ),
    KWs(
      id: 'day',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'day'),
        Phra(langCode: 'ar', value: 'يوم')
      ],
    ),
    KWs(
      id: 'week',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'week'),
        Phra(langCode: 'ar', value: 'أسبوع')
      ],
    ),
  ],
);
// ------------------------------------------
/// PRODUCT INFO
const Chaing madeIn = Chaing(
  id: 'madeIn',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Made in'),
    Phra(langCode: 'ar', value: 'صنع في')
  ],
  sons: null, // getCountriesAsKeywords()
);
const Chaing warrantyDuration = Chaing(
  id: 'insuranceDuration',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Warranty duration'),
    Phra(langCode: 'ar', value: 'مدة الضمان')
  ],
  sons: DataCreator.doubleCreator,
);
const Chaing warrantyDurationUnit = Chaing(
  id: 'warrantyDurationUnit',
  icon: null,
  phras: <Phra>[
    Phra(langCode: 'en', value: 'Warranty duration unit'),
    Phra(langCode: 'ar', value: 'وحدة قياس مدة الضمان')
  ],
  sons: <KWs>[
    KWs(
      id: 'hour',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'hour'),
        Phra(langCode: 'ar', value: 'ساعة')
      ],
    ),
    KWs(
      id: 'day',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'day'),
        Phra(langCode: 'ar', value: 'يوم')
      ],
    ),
    KWs(
      id: 'week',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'week'),
        Phra(langCode: 'ar', value: 'أسبوع')
      ],
    ),
    KWs(
      id: 'year',
      phras: <Phra>[
        Phra(langCode: 'en', value: 'year'),
        Phra(langCode: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// ------------------------------------------
class Chaing{

  const Chaing({
    @required this.sons,
    @required this.icon,
    @required this.phras,
    @required this.id,
  });

  final dynamic sons;
  final List<Phra> phras;
  final String icon;
  final String id;

  static List<Phrase> getPhrasesFromChaing(Chaing chaing){
    final List<Phrase> _phrases = <Phrase>[];

    /// add chain en phrase
    final Phrase _en = Phrase(
      id: chaing.id,
      value: Phra.getPhraseByLangFromPhras(chaing.phras, 'en', chaing.id).value,
      langCode: 'en',
    );
    _phrases.add(_en);
    /// add chain ar phrase
    final Phrase _ar = Phrase(
      id: chaing.id,
      value: Phra.getPhraseByLangFromPhras(chaing.phras, 'ar', chaing.id).value,
      langCode: 'ar',
    );
    _phrases.add(_ar);

    // blog('chaing  : ${chaing.id} :  sons ya seedy are : [ ${chaing.sons.runtimeType} ]');

    final bool sonsAreDataCreator = chaing.sons.runtimeType.toString() == 'DataCreator';
    final bool sonsAreKWs = chaing.sons.runtimeType.toString() == 'List<KWs>';
    final bool sonsAreChaings = chaing.sons.runtimeType.toString() == 'List<Chaing>';

    if (chaing.sons != null && sonsAreDataCreator == false){
      // blog('chaing  : ${chaing.id} :  sons are : [ ${chaing.sons.runtimeType} ] : '
      //     'sonsAreKWs : ${sonsAreKWs} : sonsAreChaings : ${sonsAreChaings}');


      if (sonsAreKWs == true){
        final List<Phrase> _new = KWs.getPhrasesFromKWs(chaing.sons);
        _phrases.addAll([..._new]);
      }

      else if (sonsAreChaings == true){
        final List<Phrase> _new = getPhrasesFromChaings(chaing.sons);
        _phrases.addAll([..._new]);
      }
      else {
        // blog('chaing sons are : ${chaing.sons}');
      }

    }

    // blog('GETTING PHRASES FROM ${chaing.id}');
    // Phrase.blogPhrases(_phrases);
    // blog('====================================================================== xxx');
    return _phrases;
  }

  static List<Phrase> getPhrasesFromChaings(List<Chaing> chaings){

    final List<Phrase> _phrases = <Phrase>[];

    for (final Chaing chaing in chaings){
      final List<Phrase> _add = getPhrasesFromChaing(chaing);
      _phrases.addAll(_add);
    }

    return _phrases;
  }

}

class KWs {
  const KWs({
    @required this.phras,
    @required this.id,
  });

  final List<Phra> phras;
  final String id;

  static List<Phrase> getPhrasesFromKWs(List<KWs> kws){
    final List<Phrase> _output = <Phrase>[];

    for (final k in kws){

      final Phrase _en = Phrase(
        id: k.id,
        value:  Phra.getPhraseByLangFromPhras(k.phras, 'en', k.id).value,
        langCode: 'en',
      );
      final Phrase _ar = Phrase(
        id: k.id,
        value:  Phra.getPhraseByLangFromPhras(k.phras, 'ar', k.id).value,
        langCode: 'ar',
      );

      _output.addAll([_en, _ar]);

    }

    // blog('getting phrases from ${kws}');

    return _output;
  }
}

class Phra {

  const Phra({
    @required this.langCode,
    @required this.value,
    this.id,
});

  final String langCode;
  final String value;
  final String id;

  static Phrase getPhraseByLangFromPhras(List<Phra> phras, String langCode, String phid){
    final Phra _enPhra = phras.firstWhere((x) => x.langCode == langCode);
    return Phrase(
      id: phid,
      value: _enPhra.value,
      langCode: langCode,
    );
  }

}

List<Phrase> specsPhrasesMan(){
  final List<Phrase> _phrases = Chaing.getPhrasesFromChaings(chaingezzz);
  final List<Phrase> _modified = _fixPhrasesIDs(_phrases);
  final List<Phrase> _cleaned = Phrase.cleanIdenticalPhrases(_modified);
  Phrase.blogPhrases(_cleaned);
  blog('_phrases of phid_s_ are : ${_cleaned.length} mixed phrases');
  return _cleaned;
}

List<Phrase> _fixPhrasesIDs(List<Phrase> phrases){
  final List<Phrase> _output = <Phrase>[];

  for (final Phrase phrase in phrases){

    final String fixedID = 'phid_s_${phrase.id}';

    _output.add(
      Phrase(
        id: fixedID,
        value: phrase.value,
        langCode: phrase.langCode,
      )
    );

  }

  return _output;
}

const List<Chaing> chaingezzz = [
style,
color,
contractType,
paymentMethod,
price,
currency,
unitPriceInterval,
numberOfInstallments,
installmentsDuration,
installmentsDurationUnit,
duration,
durationUnit,
propertyArea,
propertyAreaUnit,
lotArea,
lotAreaUnit,
propertyForm,
propertyLicense,
propertySpaces,
propertyFloorNumber,
propertyDedicatedParkingLotsCount,
propertyNumberOfBedrooms,
propertyNumberOfBathrooms,
propertyView,
propertyIndoorFeatures,
propertyFinishingLevel,
buildingNumberOfFloors,
buildingAgeInYears,
buildingTotalParkingLotsCount,
buildingTotalUnitsCount,
inACompound,
amenities,
communityServices,
constructionActivityMeasurementMethod,
width,
length,
height,
thickness,
diameter,
radius,
linearMeasurementUnit,
footPrint,
areaMeasureUnit,
volume,
volumeMeasurementUnit,
weight,
weightMeasurementUnit,
count,
size,
wattage,
voltage,
ampere,
inStock,
deliveryAvailable,
deliveryDuration,
deliveryDurationUnit,
madeIn,
warrantyDuration,
warrantyDurationUnit,
];