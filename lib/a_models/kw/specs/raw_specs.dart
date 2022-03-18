import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/chain/chain_crafts.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/kw/specs/data_creator.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';

const String newSaleID = 'contractType_NewSale';
const String resaleID = 'contractType_Resale';
const String rentID = 'contractType_Rent';

// -------------------------------------------------------------------------
/// STYLE ANATOMY
const Chain style = Chain(
  id: 'style',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Design Style'),
    Phrase(langCode: 'ar', value: 'الطراز التصميمي')
  ],
  sons: <KW>[
    KW(
      id: 'arch_style_arabian',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Arabian'),
        Phrase(langCode: 'ar', value: 'عربي')
      ],
    ),
    KW(
      id: 'arch_style_andalusian',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Andalusian'),
        Phrase(langCode: 'ar', value: 'أندلسي')
      ],
    ),
    KW(
      id: 'arch_style_asian',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Asian'),
        Phrase(langCode: 'ar', value: 'آسيوي')
      ],
    ),
    KW(
      id: 'arch_style_chinese',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Chinese'),
        Phrase(langCode: 'ar', value: 'صيني')
      ],
    ),
    KW(
      id: 'arch_style_contemporary',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Contemporary'),
        Phrase(langCode: 'ar', value: 'معاصر')
      ],
    ),
    KW(
      id: 'arch_style_classic',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Classic'),
        Phrase(langCode: 'ar', value: 'كلاسيكي')
      ],
    ),
    KW(
      id: 'arch_style_eclectic',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Eclectic'),
        Phrase(langCode: 'ar', value: 'انتقائي')
      ],
    ),
    KW(
      id: 'arch_style_english',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'English'),
        Phrase(langCode: 'ar', value: 'إنجليزي')
      ],
    ),
    KW(
      id: 'arch_style_farmhouse',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Farmhouse'),
        Phrase(langCode: 'ar', value: 'ريفي')
      ],
    ),
    KW(
      id: 'arch_style_french',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'French'),
        Phrase(langCode: 'ar', value: 'فرنساوي')
      ],
    ),
    KW(
      id: 'arch_style_gothic',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Gothic'),
        Phrase(langCode: 'ar', value: 'قوطي')
      ],
    ),
    KW(
      id: 'arch_style_greek',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Greek'),
        Phrase(langCode: 'ar', value: 'يوناني')
      ],
    ),
    KW(
      id: 'arch_style_indian',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Indian'),
        Phrase(langCode: 'ar', value: 'هندي')
      ],
    ),
    KW(
      id: 'arch_style_industrial',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Industrial'),
        Phrase(langCode: 'ar', value: 'صناعي')
      ],
    ),
    KW(
      id: 'arch_style_japanese',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Japanese'),
        Phrase(langCode: 'ar', value: 'ياباني')
      ],
    ),
    KW(
      id: 'arch_style_mediterranean',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Mediterranean'),
        Phrase(langCode: 'ar', value: 'البحر المتوسط')
      ],
    ),
    KW(
      id: 'arch_style_midcentury',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Mid century modern'),
        Phrase(langCode: 'ar', value: 'منتصف القرن الحديث')
      ],
    ),
    KW(
      id: 'arch_style_medieval',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Medieval'),
        Phrase(langCode: 'ar', value: 'القرون الوسطى')
      ],
    ),
    KW(
      id: 'arch_style_minimalist',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Minimalist'),
        Phrase(langCode: 'ar', value: 'مينيماليزم')
      ],
    ),
    KW(
      id: 'arch_style_modern',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Modern'),
        Phrase(langCode: 'ar', value: 'حديث')
      ],
    ),
    KW(
      id: 'arch_style_moroccan',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Moroccan'),
        Phrase(langCode: 'ar', value: 'مغربي')
      ],
    ),
    KW(
      id: 'arch_style_rustic',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Rustic'),
        Phrase(langCode: 'ar', value: 'فلاحي')
      ],
    ),
    KW(
      id: 'arch_style_scandinavian',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Scandinavian'),
        Phrase(langCode: 'ar', value: 'إسكاندنيفي')
      ],
    ),
    KW(
      id: 'arch_style_shabbyChic',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Shabby Chic'),
        Phrase(langCode: 'ar', value: 'مهترئ أنيق')
      ],
    ),
    KW(
      id: 'arch_style_american',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'American'),
        Phrase(langCode: 'ar', value: 'أمريكي')
      ],
    ),
    KW(
      id: 'arch_style_spanish',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Spanish'),
        Phrase(langCode: 'ar', value: 'أسباني')
      ],
    ),
    KW(
      id: 'arch_style_traditional',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Traditional'),
        Phrase(langCode: 'ar', value: 'تقليدي')
      ],
    ),
    KW(
      id: 'arch_style_transitional',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Transitional'),
        Phrase(langCode: 'ar', value: 'انتقالي')
      ],
    ),
    KW(
      id: 'arch_style_tuscan',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Tuscan'),
        Phrase(langCode: 'ar', value: 'توسكاني')
      ],
    ),
    KW(
      id: 'arch_style_tropical',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Tropical'),
        Phrase(langCode: 'ar', value: 'استوائي')
      ],
    ),
    KW(
      id: 'arch_style_victorian',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Victorian'),
        Phrase(langCode: 'ar', value: 'فيكتوريان')
      ],
    ),
    KW(
      id: 'arch_style_vintage',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Vintage'),
        Phrase(langCode: 'ar', value: 'عتيق')
      ],
    ),
  ],
);
const Chain color = Chain(
  id: 'color',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Color'),
    Phrase(langCode: 'ar', value: 'اللون')
  ],
  sons: <KW>[
    KW(
      id: 'red',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Red'),
        Phrase(langCode: 'ar', value: 'أحمر')
      ],
    ),
    KW(
      id: 'orange',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Orange'),
        Phrase(langCode: 'ar', value: 'برتقالي')
      ],
    ),
    KW(
      id: 'yellow',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Yellow'),
        Phrase(langCode: 'ar', value: 'أصفر')
      ],
    ),
    KW(
      id: 'green',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Green'),
        Phrase(langCode: 'ar', value: 'أخضر')
      ],
    ),
    KW(
      id: 'blue',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Blue'),
        Phrase(langCode: 'ar', value: 'أزرق')
      ],
    ),
    KW(
      id: 'indigo',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Indigo'),
        Phrase(langCode: 'ar', value: 'نيلي')
      ],
    ),
    KW(
      id: 'violet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Violet'),
        Phrase(langCode: 'ar', value: 'بنفسجي')
      ],
    ),
    KW(
      id: 'black',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Black'),
        Phrase(langCode: 'ar', value: 'أسود')
      ],
    ),
    KW(
      id: 'white',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'White'),
        Phrase(langCode: 'ar', value: 'أبيض')
      ],
    ),
    KW(
      id: 'grey',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Grey'),
        Phrase(langCode: 'ar', value: 'رمادي')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PRICING ANATOMY
const Chain contractType = Chain(
  id: 'contractType',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Contract Type'),
    Phrase(langCode: 'ar', value: 'نوع التعاقد')
  ],
  sons: <KW>[
    KW(
      id: newSaleID,
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'New Sale'),
        Phrase(langCode: 'ar', value: 'للبيع جديد')
      ],
    ), // if you change ID revise specs_picker_screen
    KW(
      id: resaleID,
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Resale'),
        Phrase(langCode: 'ar', value: 'لإعادة البيع')
      ],
    ), // if you change ID revise specs_picker_screen
    KW(
      id: rentID,
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Rent'),
        Phrase(langCode: 'ar', value: 'للإيجار')
      ],
    ), // if you change ID revise specs_picker_screen
  ],
);
const Chain paymentMethod = Chain(
  id: 'paymentMethod',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Payment Method'),
    Phrase(langCode: 'ar', value: 'طريقة السداد')
  ],
  sons: <KW>[
    KW(
      id: 'payment_cash',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Cash'),
        Phrase(langCode: 'ar', value: 'دفعة واحدة')
      ],
    ),
    KW(
      id: 'payment_installments',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Installments'),
        Phrase(langCode: 'ar', value: 'على دفعات')
      ],
    ),
  ],
);
const Chain price = Chain(
  id: 'price',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'price'),
    Phrase(langCode: 'ar', value: 'السعر')
  ],
  sons: DataCreator.price,
);
const Chain currency = Chain(
  id: 'currency',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Currency'),
    Phrase(langCode: 'ar', value: 'العملة')
  ],
  sons: DataCreator.currency,
);
const Chain unitPriceInterval = Chain(
  id: 'unitPriceInterval',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Standard interval'),
    Phrase(langCode: 'ar', value: 'مقياس الفترة')
  ],
  sons: <KW>[
    KW(
      id: 'perHour',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Per Hour'),
        Phrase(langCode: 'ar', value: 'في الساعة')
      ],
    ),
    KW(
      id: 'perDay',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'per day'),
        Phrase(langCode: 'ar', value: 'في اليوم')
      ],
    ),
    KW(
      id: 'perWeek',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'per week'),
        Phrase(langCode: 'ar', value: 'في الأسبوع')
      ],
    ),
    KW(
      id: 'perMonth',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'per month'),
        Phrase(langCode: 'ar', value: 'في الشهر')
      ],
    ),
    KW(
      id: 'perYear',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'per year'),
        Phrase(langCode: 'ar', value: 'في السنة')
      ],
    ),
  ],
);
const Chain numberOfInstallments = Chain(
  id: 'numberOfInstallments',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Number of Installments'),
    Phrase(langCode: 'ar', value: 'عدد الدفعات')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain installmentsDuration = Chain(
  id: 'installmentsDuration',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Installments duration'),
    Phrase(langCode: 'ar', value: 'مدة الدفعات')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain installmentsDurationUnit = Chain(
  id: 'installmentsDurationUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Installments duration unit'),
    Phrase(langCode: 'ar', value: 'مقياس مدة الدفعات')
  ],
  sons: <KW>[
    KW(
      id: 'installmentsDurationUnit_day',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'day'),
        Phrase(langCode: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'installmentsDurationUnit_week',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'week'),
        Phrase(langCode: 'ar', value: 'أسبوع')
      ],
    ),
    KW(
      id: 'installmentsDurationUnit_month',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'month'),
        Phrase(langCode: 'ar', value: 'شهر')
      ],
    ),
    KW(
      id: 'installmentsDurationUnit_year',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'year'),
        Phrase(langCode: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// TIME ANATOMY
const Chain duration = Chain(
  id: 'duration',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Duration'),
    Phrase(langCode: 'ar', value: 'الزمن')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain durationUnit = Chain(
  id: 'durationUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Duration unit'),
    Phrase(langCode: 'ar', value: 'مقياس الزمن')
  ],
  sons: <KW>[
    KW(
      id: 'minute',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'minute'),
        Phrase(langCode: 'ar', value: 'دقيقة')
      ],
    ),
    KW(
      id: 'hour',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'hour'),
        Phrase(langCode: 'ar', value: 'ساعة')
      ],
    ),
    KW(
      id: 'day',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'day'),
        Phrase(langCode: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'week',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'week'),
        Phrase(langCode: 'ar', value: 'أسبوع')
      ],
    ),
    KW(
      id: 'month',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'month'),
        Phrase(langCode: 'ar', value: 'شهر')
      ],
    ),
    KW(
      id: 'year',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'year'),
        Phrase(langCode: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// AREAL ANATOMY
const Chain propertyArea = Chain(
  id: 'propertyArea',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property Area'),
    Phrase(langCode: 'ar', value: 'مساحة العقار')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain propertyAreaUnit = Chain(
  id: 'propertyAreaUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property Area Unit'),
    Phrase(langCode: 'ar', value: 'وحدة قياس مساحة العقار')
  ],
  sons: <KW>[
    KW(
      id: 'square_meter',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'm²'),
        Phrase(langCode: 'ar', value: 'م²')
      ],
    ),
    KW(
      id: 'square_feet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'ft²'),
        Phrase(langCode: 'ar', value: 'قدم²')
      ],
    ),
  ],
);
const Chain lotArea = Chain(
  id: 'plotArea',
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Lot Area'),
    Phrase(langCode: 'ar', value: 'مساحة قطعة الأرض')
  ],
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain lotAreaUnit = Chain(
  id: 'lotAreaUnit',
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Lot Area Unit'),
    Phrase(langCode: 'ar', value: 'وحدة قياس مساحة أرض العقار')
  ],
  icon: null,
  sons: <KW>[
    KW(
      id: 'square_meter',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'm²'),
        Phrase(langCode: 'ar', value: 'م²')
      ],
    ),
    KW(
      id: 'square_Kilometer',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Km²'),
        Phrase(langCode: 'ar', value: 'كم²')
      ],
    ),
    KW(
      id: 'square_feet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'ft²'),
        Phrase(langCode: 'ar', value: 'قدم²')
      ],
    ),
    KW(
      id: 'square_yard',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'yd²'),
        Phrase(langCode: 'ar', value: 'ياردة²')
      ],
    ),
    KW(
      id: 'acre',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Acre'),
        Phrase(langCode: 'ar', value: 'فدان')
      ],
    ),
    KW(
      id: 'hectare',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Hectare'),
        Phrase(langCode: 'ar', value: 'هكتار')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY GENERAL ANATOMY
const Chain propertyForm = Chain(
  id: 'propertyForm',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property Form'),
    Phrase(langCode: 'ar', value: 'هيئة العقار')
  ],
  sons: <KW>[
    KW(
      id: 'pf_fullFloor',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Full floor'),
        Phrase(langCode: 'ar', value: 'دور كامل')
      ],
    ),
    KW(
      id: 'pf_halfFloor',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Half floor'),
        Phrase(langCode: 'ar', value: 'نصف دور')
      ],
    ),
    KW(
      id: 'pf_partFloor',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Part of floor'),
        Phrase(langCode: 'ar', value: 'جزء من دور')
      ],
    ),
    KW(
      id: 'pf_building',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Whole building'),
        Phrase(langCode: 'ar', value: 'مبنى كامل')
      ],
    ),
    KW(
      id: 'pf_land',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Land'),
        Phrase(langCode: 'ar', value: 'أرض')
      ],
    ),
    KW(
      id: 'pf_mobile',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Mobile'),
        Phrase(langCode: 'ar', value: 'منشأ متنقل')
      ],
    ),
  ],
);
const Chain propertyLicense = Chain(
  id: 'propertyLicense',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property License'),
    Phrase(langCode: 'ar', value: 'رخصة العقار')
  ],
  sons: <KW>[
    KW(
      id: 'ppt_lic_residential',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Residential'),
        Phrase(langCode: 'ar', value: 'سكني')
      ],
    ),
    KW(
      id: 'ppt_lic_administration',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Administration'),
        Phrase(langCode: 'ar', value: 'إداري')
      ],
    ),
    KW(
      id: 'ppt_lic_educational',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Educational'),
        Phrase(langCode: 'ar', value: 'تعليمي')
      ],
    ),
    KW(
      id: 'ppt_lic_utilities',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Utilities'),
        Phrase(langCode: 'ar', value: 'خدمات')
      ],
    ),
    KW(
      id: 'ppt_lic_sports',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Sports'),
        Phrase(langCode: 'ar', value: 'رياضي')
      ],
    ),
    KW(
      id: 'ppt_lic_entertainment',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Entertainment'),
        Phrase(langCode: 'ar', value: 'ترفيهي')
      ],
    ),
    KW(
      id: 'ppt_lic_medical',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Medical'),
        Phrase(langCode: 'ar', value: 'طبي')
      ],
    ),
    KW(
      id: 'ppt_lic_retail',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Retail'),
        Phrase(langCode: 'ar', value: 'تجاري')
      ],
    ),
    KW(
      id: 'ppt_lic_hotel',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Hotel'),
        Phrase(langCode: 'ar', value: 'فندقي')
      ],
    ),
    KW(
      id: 'ppt_lic_industrial',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Industrial'),
        Phrase(langCode: 'ar', value: 'صناعي')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY SPATIAL ANATOMY
const Chain propertySpaces = Chain(
  id: 'group_space_type',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Space Type'),
    Phrase(langCode: 'ar', value: 'نوع الفراغ')
  ],
  sons: <Chain>[
    // ----------------------------------
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
        KW(
          id: 'space_office',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Office'),
            Phrase(langCode: 'ar', value: 'مكتب')
          ],
        ),
        KW(
          id: 'space_kitchenette',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Office Kitchenette'),
            Phrase(langCode: 'ar', value: 'أوفيس / مطبخ صغير')
          ],
        ),
        KW(
          id: 'space_meetingRoom',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Meeting room'),
            Phrase(langCode: 'ar', value: 'غرفة اجتماعات')
          ],
        ),
        KW(
          id: 'space_seminarHall',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Seminar hall'),
            Phrase(langCode: 'ar', value: 'قاعة سمينار')
          ],
        ),
        KW(
          id: 'space_conventionHall',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Convention hall'),
            Phrase(langCode: 'ar', value: 'قاعة عرض')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_lectureRoom',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Lecture room'),
            Phrase(langCode: 'ar', value: 'غرفة محاضرات')
          ],
        ),
        KW(
          id: 'space_library',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Library'),
            Phrase(langCode: 'ar', value: 'مكتبة')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_theatre',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Theatre'),
            Phrase(langCode: 'ar', value: 'مسرح')
          ],
        ),
        KW(
          id: 'space_concertHall',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Concert hall'),
            Phrase(langCode: 'ar', value: 'قاعة موسيقية')
          ],
        ),
        KW(
          id: 'space_homeCinema',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Home Cinema'),
            Phrase(langCode: 'ar', value: 'مسرح منزلي')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_spa',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Spa'),
            Phrase(langCode: 'ar', value: 'منتجع صحي')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_lobby',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Lobby'),
            Phrase(langCode: 'ar', value: 'ردهة')
          ],
        ),
        KW(
          id: 'space_living',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Living room'),
            Phrase(langCode: 'ar', value: 'غرفة معيشة')
          ],
        ),
        KW(
          id: 'space_bedroom',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Bedroom'),
            Phrase(langCode: 'ar', value: 'غرفة نوم')
          ],
        ),
        KW(
          id: 'space_kitchen',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Home Kitchen'),
            Phrase(langCode: 'ar', value: 'مطبخ')
          ],
        ),
        KW(
          id: 'space_bathroom',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Bathroom'),
            Phrase(langCode: 'ar', value: 'حمام')
          ],
        ),
        KW(
          id: 'space_reception',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Reception'),
            Phrase(langCode: 'ar', value: 'استقبال')
          ],
        ),
        KW(
          id: 'space_salon',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Salon'),
            Phrase(langCode: 'ar', value: 'صالون')
          ],
        ),
        KW(
          id: 'space_laundry',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Laundry room'),
            Phrase(langCode: 'ar', value: 'غرفة غسيل')
          ],
        ),
        KW(
          id: 'space_balcony',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Balcony'),
            Phrase(langCode: 'ar', value: 'تراس')
          ],
        ),
        KW(
          id: 'space_toilet',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Toilet'),
            Phrase(langCode: 'ar', value: 'دورة مياه')
          ],
        ),
        KW(
          id: 'space_dining',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Dining room'),
            Phrase(langCode: 'ar', value: 'غرفة طعام')
          ],
        ),
        KW(
          id: 'space_stairs',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Stairs'),
            Phrase(langCode: 'ar', value: 'سلالم')
          ],
        ),
        KW(
          id: 'space_attic',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Attic'),
            Phrase(langCode: 'ar', value: 'علية / صندرة')
          ],
        ),
        KW(
          id: 'space_corridor',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Corridor'),
            Phrase(langCode: 'ar', value: 'رواق / طرقة')
          ],
        ),
        KW(
          id: 'space_garage',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Garage'),
            Phrase(langCode: 'ar', value: 'جراج')
          ],
        ),
        KW(
          id: 'space_storage',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Storage room'),
            Phrase(langCode: 'ar', value: 'مخزن')
          ],
        ),
        KW(
          id: 'space_maid',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Maid room'),
            Phrase(langCode: 'ar', value: 'غرفة مربية')
          ],
        ),
        KW(
          id: 'space_walkInCloset',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Walk In closet'),
            Phrase(langCode: 'ar', value: 'غرفة ملابس')
          ],
        ),
        KW(
          id: 'space_barbecue',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Barbecue area'),
            Phrase(langCode: 'ar', value: 'مساحة شواية')
          ],
        ),
        KW(
          id: 'space_garden',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Private garden'),
            Phrase(langCode: 'ar', value: 'حديقة خاصة')
          ],
        ),
        KW(
          id: 'space_privatePool',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Private pool'),
            Phrase(langCode: 'ar', value: 'حمام سباحة خاص')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_store',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Store / Shop'),
            Phrase(langCode: 'ar', value: 'محل / متجر')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_gymnasium',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Gymnasium'),
            Phrase(langCode: 'ar', value: 'جيمنازيوم')
          ],
        ),
        KW(
          id: 'space_sportsCourt',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Sports court'),
            Phrase(langCode: 'ar', value: 'ملعب رياضي')
          ],
        ),
        KW(
          id: 'space_sportStadium',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Stadium'),
            Phrase(langCode: 'ar', value: 'استاد رياضي')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Utilities
    Chain(
      id: 'ppt_lic_utilities',
      icon: null,
      phraseID: <Phrase>[
        Phrase(langCode: 'en', value: 'Utilities'),
        Phrase(langCode: 'ar', value: 'خدمات')
      ],
      sons: <KW>[
        KW(
          id: 'pFeature_elevator',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Elevator'),
            Phrase(langCode: 'ar', value: 'مصعد')
          ],
        ),
        KW(
          id: 'space_electricityRoom',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Electricity rooms'),
            Phrase(langCode: 'ar', value: 'غرفة كهرباء')
          ],
        ),
        KW(
          id: 'space_plumbingRoom',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Plumbing rooms'),
            Phrase(langCode: 'ar', value: 'غرفة صحي و صرف')
          ],
        ),
        KW(
          id: 'space_mechanicalRoom',
          names: <Phrase>[
            Phrase(langCode: 'en', value: 'Mechanical rooms'),
            Phrase(langCode: 'ar', value: 'غرفة ميكانيكية')
          ],
        ),
      ],
    ),
  ],
);
const Chain propertyFloorNumber = Chain(
  id: 'propertyFloorNumber',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property Floor Number'),
    Phrase(langCode: 'ar', value: 'رقم دور العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain propertyDedicatedParkingLotsCount = Chain(
  id: 'propertyDedicatedParkingSpaces',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Number of property dedicated parking lots'),
    Phrase(langCode: 'ar', value: 'عدد مواقف السيارات المخصصة للعقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain propertyNumberOfBedrooms = Chain(
  id: 'propertyNumberOfBedrooms',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property Number of Bedrooms'),
    Phrase(langCode: 'ar', value: 'عدد غرف نوم العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain propertyNumberOfBathrooms = Chain(
  id: 'propertyNumberOfBathrooms',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property Number of bathrooms'),
    Phrase(langCode: 'ar', value: 'عدد حمامات العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// PROPERTY FEATURES ANATOMY
const Chain propertyView = Chain(
  id: 'propertyView',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property View'),
    Phrase(langCode: 'ar', value: 'المنظر المطل عليه  العقار')
  ],
  sons: <KW>[
    KW(
      id: 'view_golf',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Golf course view'),
        Phrase(langCode: 'ar', value: 'مضمار جولف')
      ],
    ),
    KW(
      id: 'view_hill',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Hill or Mountain view'),
        Phrase(langCode: 'ar', value: 'تل أو جبل')
      ],
    ),
    KW(
      id: 'view_ocean',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Ocean view'),
        Phrase(langCode: 'ar', value: 'محيط')
      ],
    ),
    KW(
      id: 'view_city',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'City view'),
        Phrase(langCode: 'ar', value: 'مدينة')
      ],
    ),
    KW(
      id: 'view_lake',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Lake view'),
        Phrase(langCode: 'ar', value: 'بحيرة')
      ],
    ),
    KW(
      id: 'view_lagoon',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Lagoon view'),
        Phrase(langCode: 'ar', value: 'لاجون')
      ],
    ),
    KW(
      id: 'view_river',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'River view'),
        Phrase(langCode: 'ar', value: 'نهر')
      ],
    ),
    KW(
      id: 'view_mainStreet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Main street view'),
        Phrase(langCode: 'ar', value: 'شارع رئيسي')
      ],
    ),
    KW(
      id: 'view_sideStreet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Side street view'),
        Phrase(langCode: 'ar', value: 'شارع جانبي')
      ],
    ),
    KW(
      id: 'view_corner',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Corner view'),
        Phrase(langCode: 'ar', value: 'ناصية الشارع')
      ],
    ),
    KW(
      id: 'view_back',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Back view'),
        Phrase(langCode: 'ar', value: 'خلفي')
      ],
    ),
    KW(
      id: 'view_garden',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Garden view'),
        Phrase(langCode: 'ar', value: 'حديقة')
      ],
    ),
    KW(
      id: 'view_pool',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Pool view'),
        Phrase(langCode: 'ar', value: 'حمام سباحة')
      ],
    ),
  ],
);
const Chain propertyIndoorFeatures = Chain(
  id: 'sub_ppt_feat_indoor',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Property Indoor Features'),
    Phrase(langCode: 'ar', value: 'خواص العقار الداخلية')
  ],
  sons: <KW>[
    KW(
      id: 'pFeature_disabilityFeatures',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Disability features'),
        Phrase(langCode: 'ar', value: 'خواص معتبرة للإعاقة و المقعدين')
      ],
    ),
    KW(
      id: 'pFeature_fireplace',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Fireplace'),
        Phrase(langCode: 'ar', value: 'مدفأة حطب')
      ],
    ),
    KW(
      id: 'pFeature_energyEfficient',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Energy efficient'),
        Phrase(langCode: 'ar', value: 'موفر للطاقة')
      ],
    ),
    KW(
      id: 'pFeature_electricityBackup',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Electricity backup'),
        Phrase(langCode: 'ar', value: 'دعم كهرباء احتياطي')
      ],
    ),
    KW(
      id: 'pFeature_centralAC',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Central AC'),
        Phrase(langCode: 'ar', value: 'تكييف مركزي')
      ],
    ),
    KW(
      id: 'pFeature_centralHeating',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Central heating'),
        Phrase(langCode: 'ar', value: 'تدفئة مركزية')
      ],
    ),
    KW(
      id: 'pFeature_builtinWardrobe',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Built-in wardrobes'),
        Phrase(langCode: 'ar', value: 'دواليب داخل الحوائط')
      ],
    ),
    KW(
      id: 'pFeature_kitchenAppliances',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Kitchen Appliances'),
        Phrase(langCode: 'ar', value: 'أجهزة مطبخ')
      ],
    ),
    KW(
      id: 'pFeature_elevator',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Elevator'),
        Phrase(langCode: 'ar', value: 'مصعد')
      ],
    ),
    KW(
      id: 'pFeature_intercom',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Intercom'),
        Phrase(langCode: 'ar', value: 'إنتركوم')
      ],
    ),
    KW(
      id: 'pFeature_internet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Broadband internet'),
        Phrase(langCode: 'ar', value: 'إنترنت')
      ],
    ),
    KW(
      id: 'pFeature_tv',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Satellite / Cable TV'),
        Phrase(langCode: 'ar', value: 'قمر صناعي / تلفزيون مركزي')
      ],
    ),
  ],
);
const Chain propertyFinishingLevel = Chain(
  id: 'sub_ppt_feat_finishing',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Finishing level'),
    Phrase(langCode: 'ar', value: 'مستوى التشطيب')
  ],
  sons: <KW>[
    KW(
      id: 'finish_coreAndShell',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Core and shell'),
        Phrase(langCode: 'ar', value: 'خرسانات و حوائط خارجية')
      ],
    ),
    KW(
      id: 'finish_withoutFinishing',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Without finishing'),
        Phrase(langCode: 'ar', value: 'غير متشطب')
      ],
    ),
    KW(
      id: 'finish_semiFinished',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Semi finished'),
        Phrase(langCode: 'ar', value: 'نصف تشطيب')
      ],
    ),
    KW(
      id: 'finish_lux',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Lux'),
        Phrase(langCode: 'ar', value: 'تشطيب لوكس')
      ],
    ),
    KW(
      id: 'finish_superLux',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Super lux'),
        Phrase(langCode: 'ar', value: 'تشطيب سوبر لوكس')
      ],
    ),
    KW(
      id: 'finish_extraSuperLux',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Extra super lux'),
        Phrase(langCode: 'ar', value: 'تشطيب إكسترا سوبر لوكس')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// BUILDING FEATURES ANATOMY
const Chain buildingNumberOfFloors = Chain(
  id: 'buildingNumberOfFloors',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Building number of floors'),
    Phrase(langCode: 'ar', value: 'عدد أدوار المبنى')
  ],
  sons: DataCreator.integerIncrementer, // TASK : define range 0 - g163
);
const Chain buildingAgeInYears = Chain(
  id: 'buildingAge',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Building Age'),
    Phrase(langCode: 'ar', value: 'عمر المنشأ')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain buildingTotalParkingLotsCount = Chain(
  id: 'buildingTotalParkingLotsCount',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Total Building parking lots count'),
    Phrase(langCode: 'ar', value: 'مجموع عدد مواقف السيارات للمبنى')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain buildingTotalUnitsCount = Chain(
  id: 'buildingTotalPropertiesCount',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Total Building units count'),
    Phrase(langCode: 'ar', value: 'مجموع عدد وحدات المبنى')
  ],
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// COMMUNITY FEATURES ANATOMY
const Chain inACompound = Chain(
  id: 'sub_ppt_feat_compound',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'In a Compound'),
    Phrase(langCode: 'ar', value: 'في مجمع سكني')
  ],
  sons: <KW>[
    KW(
      id: 'in_compound',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'In a compound'),
        Phrase(langCode: 'ar', value: 'في مجمع سكني')
      ],
    ),
    KW(
      id: 'not_in_compound',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Not in a compound'),
        Phrase(langCode: 'ar', value: 'ليست في مجمع سكني')
      ],
    ),
  ],
);
const Chain amenities = Chain(
  id: 'sub_ppt_feat_amenities',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Amenities'),
    Phrase(langCode: 'ar', value: 'منشآت خدمية ملحقة')
  ],
  sons: <KW>[
    KW(
      id: 'am_laundry',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Laundry'),
        Phrase(langCode: 'ar', value: 'مغسلة')
      ],
    ),
    KW(
      id: 'am_swimmingPool',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Swimming pool'),
        Phrase(langCode: 'ar', value: 'حمام سباحة')
      ],
    ),
    KW(
      id: 'am_kidsPool',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Kids pool'),
        Phrase(langCode: 'ar', value: 'حمام سباحة أطفال')
      ],
    ),
    KW(
      id: 'am_boatFacilities',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Boat facilities'),
        Phrase(langCode: 'ar', value: 'خدمات مراكب مائية')
      ],
    ),
    KW(
      id: 'am_gymFacilities',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Gym'),
        Phrase(langCode: 'ar', value: 'صالة جيمنازيوم')
      ],
    ),
    KW(
      id: 'am_clubHouse',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Clubhouse'),
        Phrase(langCode: 'ar', value: 'كلاب هاوس')
      ],
    ),
    KW(
      id: 'am_horseFacilities',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Horse facilities'),
        Phrase(langCode: 'ar', value: 'خدمات خيول')
      ],
    ),
    KW(
      id: 'am_sportsCourts',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Sports courts'),
        Phrase(langCode: 'ar', value: 'ملاعب رياضية')
      ],
    ),
    KW(
      id: 'am_park',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Park / garden'),
        Phrase(langCode: 'ar', value: 'حديقة')
      ],
    ),
    KW(
      id: 'am_golfCourse',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Golf course'),
        Phrase(langCode: 'ar', value: 'مضمار جولف')
      ],
    ),
    KW(
      id: 'am_spa',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Spa'),
        Phrase(langCode: 'ar', value: 'منتجع صحي')
      ],
    ),
    KW(
      id: 'am_kidsArea',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Kids Area'),
        Phrase(langCode: 'ar', value: 'منطقة أطفال')
      ],
    ),
    KW(
      id: 'am_cafeteria',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Cafeteria'),
        Phrase(langCode: 'ar', value: 'كافيتيريا')
      ],
    ),
    KW(
      id: 'am_businessCenter',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Business center'),
        Phrase(langCode: 'ar', value: 'مقر أعمال')
      ],
    ),
    KW(
      id: 'am_lobby',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Building lobby'),
        Phrase(langCode: 'ar', value: 'ردهة مدخل للمبنى')
      ],
    ),
  ],
);
const Chain communityServices = Chain(
  id: 'sub_ppt_feat_services',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Community Services'),
    Phrase(langCode: 'ar', value: 'خدمات المجتمع')
  ],
  sons: <KW>[
    KW(
      id: 'pService_houseKeeping',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Housekeeping'),
        Phrase(langCode: 'ar', value: 'خدمة تنظيف منزلي')
      ],
    ),
    KW(
      id: 'pService_laundryService',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'LaundryService'),
        Phrase(langCode: 'ar', value: 'خدمة غسيل ملابس')
      ],
    ),
    KW(
      id: 'pService_concierge',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Concierge'),
        Phrase(langCode: 'ar', value: 'خدمة استقبال')
      ],
    ),
    KW(
      id: 'pService_securityStaff',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Security  staff'),
        Phrase(langCode: 'ar', value: 'فريق حراسة')
      ],
    ),
    KW(
      id: 'pService_securityCCTV',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'CCTV security'),
        Phrase(langCode: 'ar', value: 'كاميرات مراقبة')
      ],
    ),
    KW(
      id: 'pService_petsAllowed',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Pets allowed'),
        Phrase(langCode: 'ar', value: 'مسموح بالحيوانات الأليفة')
      ],
    ),
    KW(
      id: 'pService_doorMan',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Doorman'),
        Phrase(langCode: 'ar', value: 'حاجب العقار')
      ],
    ),
    KW(
      id: 'pService_maintenance',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Maintenance staff'),
        Phrase(langCode: 'ar', value: 'فريق صيانة')
      ],
    ),
    KW(
      id: 'pService_wasteDisposal',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Waste disposal'),
        Phrase(langCode: 'ar', value: 'خدمة رفع القمامة')
      ],
    ),
    KW(
      id: 'pFeature_atm',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'ATM'),
        Phrase(langCode: 'ar', value: 'ماكينة سحب أموال ATM')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// CONSTRUCTION ACTIVITY ANATOMY
// const Chain projectCost = const Chain(
//   id: 'projectCost',
//   icon: null,
//   names: <Name>[Name(code: 'en', value: 'Project cost'), Name(code: 'ar', value: 'تكلفة المشروع')],
//   sons: DataCreator.numberKeyboard,
// );

Chain constructionActivities = Chain(
  id: 'constructionActivities',
  icon: null,
  phraseID: const <Phrase>[
    Phrase(langCode: 'en', value: 'Project construction activities'),
    Phrase(langCode: 'ar', value: 'بنود تنفيذ المشروع')
  ],
  sons: ChainCrafts.chain.sons,
);
const Chain constructionActivityMeasurementMethod = Chain(
  id: 'constructionActivityMeasurementMethod',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Measurement unit'),
    Phrase(langCode: 'ar', value: 'أسلوب القياس')
  ],
  sons: <KW>[
    KW(
      id: 'byLength',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'by Length'),
        Phrase(langCode: 'ar', value: 'بالأطوال')
      ],
    ),
    KW(
      id: 'byArea',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'by Area'),
        Phrase(langCode: 'ar', value: 'بالمساحة')
      ],
    ),
    KW(
      id: 'byVolume',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'by Volume'),
        Phrase(langCode: 'ar', value: 'بالحجم')
      ],
    ),
    KW(
      id: 'byCount',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'by Count'),
        Phrase(langCode: 'ar', value: 'بالعدد')
      ],
    ),
    KW(
      id: 'byTime',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'by Time'),
        Phrase(langCode: 'ar', value: 'بالفترة الزمنية')
      ],
    ),
    KW(
      id: 'byLove',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'by Love'),
        Phrase(langCode: 'ar', value: 'بالحب')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// SIZING ANATOMY
const Chain width = Chain(
  id: 'width',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Width'),
    Phrase(langCode: 'ar', value: 'العرض')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain length = Chain(
  id: 'length',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Length'),
    Phrase(langCode: 'ar', value: 'الطول')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain height = Chain(
  id: 'height',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Height'),
    Phrase(langCode: 'ar', value: 'الارتفاع')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain thickness = Chain(
  id: 'thickness',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Thickness'),
    Phrase(langCode: 'ar', value: 'السمك')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain diameter = Chain(
  id: 'diameter',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Diameter'),
    Phrase(langCode: 'ar', value: 'القطر')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain radius = Chain(
  id: 'radius',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Radius'),
    Phrase(langCode: 'ar', value: 'نصف القطر')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain linearMeasurementUnit = Chain(
  id: 'linearMeasureUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Linear measurement unit'),
    Phrase(langCode: 'ar', value: 'وحدة القياس الطولي')
  ],
  sons: <KW>[
    KW(
      id: 'micron',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'micron'),
        Phrase(langCode: 'ar', value: 'ميكرون')
      ],
    ),
    KW(
      id: 'millimeter',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'millimetre'),
        Phrase(langCode: 'ar', value: 'ملليمتر')
      ],
    ),
    KW(
      id: 'centimeter',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'centimeter'),
        Phrase(langCode: 'ar', value: 'سنتيمتر')
      ],
    ),
    KW(
      id: 'meter',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'meter'),
        Phrase(langCode: 'ar', value: 'متر')
      ],
    ),
    KW(
      id: 'kilometer',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Kilometer'),
        Phrase(langCode: 'ar', value: 'كيلومتر')
      ],
    ),
    KW(
      id: 'inch',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'inch'),
        Phrase(langCode: 'ar', value: 'بوصة')
      ],
    ),
    KW(
      id: 'feet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'feet'),
        Phrase(langCode: 'ar', value: 'قدم')
      ],
    ),
    KW(
      id: 'yard',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'yard'),
        Phrase(langCode: 'ar', value: 'ياردة')
      ],
    ),
    KW(
      id: 'mile',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'mile'),
        Phrase(langCode: 'ar', value: 'ميل')
      ],
    ),
  ],
);
const Chain footPrint = Chain(
  id: 'footPrint',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Footprint'),
    Phrase(langCode: 'ar', value: 'مساحة الأرضية')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain areaMeasureUnit = Chain(
  id: 'areaMeasureUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Area measurement unit'),
    Phrase(langCode: 'ar', value: 'وحدة القياس المساحة')
  ],
  sons: <KW>[
    KW(
      id: 'square_meter',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'm²'),
        Phrase(langCode: 'ar', value: 'م²')
      ],
    ),
    KW(
      id: 'square_Kilometer',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Km²'),
        Phrase(langCode: 'ar', value: 'كم²')
      ],
    ),
    KW(
      id: 'square_feet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'ft²'),
        Phrase(langCode: 'ar', value: 'قدم²')
      ],
    ),
    KW(
      id: 'square_yard',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'yd²'),
        Phrase(langCode: 'ar', value: 'ياردة²')
      ],
    ),
    KW(
      id: 'acre',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Acre'),
        Phrase(langCode: 'ar', value: 'فدان')
      ],
    ),
    KW(
      id: 'hectare',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'Hectare'),
        Phrase(langCode: 'ar', value: 'هكتار')
      ],
    ),
  ],
);
const Chain volume = Chain(
  id: 'volume',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Volume'),
    Phrase(langCode: 'ar', value: 'الحجم')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain volumeMeasurementUnit = Chain(
  id: 'volumeMeasurementUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Volume measurement unit'),
    Phrase(langCode: 'ar', value: 'وحدة قياس الحجم')
  ],
  sons: <KW>[
    KW(
      id: 'cubic_cm',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'cm³'),
        Phrase(langCode: 'ar', value: 'سم³')
      ],
    ),
    KW(
      id: 'cubic_m',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'm³'),
        Phrase(langCode: 'ar', value: 'م³')
      ],
    ),
    KW(
      id: 'millilitre',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'ml'),
        Phrase(langCode: 'ar', value: 'مم')
      ],
    ),
    KW(
      id: 'litre',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'L'),
        Phrase(langCode: 'ar', value: 'لتر')
      ],
    ),
    KW(
      id: 'fluidOunce',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'fl oz'),
        Phrase(langCode: 'ar', value: 'أونصة سائلة')
      ],
    ),
    KW(
      id: 'gallon',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'gal'),
        Phrase(langCode: 'ar', value: 'جالون')
      ],
    ),
    KW(
      id: 'cubic_inch',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'inch³'),
        Phrase(langCode: 'ar', value: 'بوصة مكعبة')
      ],
    ),
    KW(
      id: 'cubic_feet',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'feet³'),
        Phrase(langCode: 'ar', value: 'قدم مكعب')
      ],
    ),
  ],
);
const Chain weight = Chain(
  id: 'weight',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Weight'),
    Phrase(langCode: 'ar', value: 'الوزن')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain weightMeasurementUnit = Chain(
  id: 'weightMeasurementUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Weight measurement unit'),
    Phrase(langCode: 'ar', value: 'وحدة قياس الوزن')
  ],
  sons: <KW>[
    KW(
      id: 'ounce',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'oz'),
        Phrase(langCode: 'ar', value: 'أونصة')
      ],
    ),
    KW(
      id: 'pound',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'lb'),
        Phrase(langCode: 'ar', value: 'رطل')
      ],
    ),
    KW(
      id: 'ton',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'ton'),
        Phrase(langCode: 'ar', value: 'طن')
      ],
    ),
    KW(
      id: 'gram',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'gm'),
        Phrase(langCode: 'ar', value: 'جرام')
      ],
    ),
    KW(
      id: 'kilogram',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'kg'),
        Phrase(langCode: 'ar', value: 'كج')
      ],
    ),
  ],
);
const Chain count = Chain(
  id: 'count',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Count'),
    Phrase(langCode: 'ar', value: 'العدد')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain size = Chain(
  id: 'size',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Size'),
    Phrase(langCode: 'ar', value: 'المقاس')
  ],
  sons: <KW>[
    KW(
      id: 'xxxSmall',
      names: <Phrase>[
        Phrase(langCode: 'en', value: '3xs'),
        Phrase(langCode: 'ar', value: '3xs')
      ],
    ),
    KW(
      id: 'xxSmall',
      names: <Phrase>[
        Phrase(langCode: 'en', value: '2xs'),
        Phrase(langCode: 'ar', value: '2xs')
      ],
    ),
    KW(
      id: 'xSmall',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'xs'),
        Phrase(langCode: 'ar', value: 'xs')
      ],
    ),
    KW(
      id: 'small',
      names: <Phrase>[Phrase(langCode: 'en', value: 's'), Phrase(langCode: 'ar', value: 's')],
    ),
    KW(
      id: 'medium',
      names: <Phrase>[Phrase(langCode: 'en', value: 'm'), Phrase(langCode: 'ar', value: 'm')],
    ),
    KW(
      id: 'large',
      names: <Phrase>[Phrase(langCode: 'en', value: 'L'), Phrase(langCode: 'ar', value: 'L')],
    ),
    KW(
      id: 'xLarge',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'xL'),
        Phrase(langCode: 'ar', value: 'xL')
      ],
    ),
    KW(
      id: 'xxLarge',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'xxL'),
        Phrase(langCode: 'ar', value: 'xxL')
      ],
    ),
    KW(
      id: 'xxxLarge',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'xxxL'),
        Phrase(langCode: 'ar', value: 'xxxL')
      ],
    ),
  ],
);
// ------------------------------------------
/// ELECTRICAL ANATOMY
const Chain wattage = Chain(
  id: 'wattage',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Watt'),
    Phrase(langCode: 'ar', value: 'وات')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain voltage = Chain(
  id: 'voltage',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'volt'),
    Phrase(langCode: 'ar', value: 'فولت')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain ampere = Chain(
  id: 'ampere',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'amps'),
    Phrase(langCode: 'ar', value: 'أمبير')
  ],
  sons: DataCreator.doubleCreator,
);
// ------------------------------------------
/// LOGISTICS ANATOMY
const Chain inStock = Chain(
  id: 'inStock',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'In Stock'),
    Phrase(langCode: 'ar', value: 'متوفر في المخزون')
  ],
  sons: DataCreator.boolSwitch,
);
const Chain deliveryAvailable = Chain(
  id: 'deliveryAvailable',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Available delivery'),
    Phrase(langCode: 'ar', value: 'التوصيل متوفر')
  ],
  sons: DataCreator.boolSwitch,
);
const Chain deliveryDuration = Chain(
  id: 'deliveryMinDuration',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Delivery duration'),
    Phrase(langCode: 'ar', value: 'فترة التوصيل')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain deliveryDurationUnit = Chain(
  id: 'deliveryDurationUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Delivery duration unit'),
    Phrase(langCode: 'ar', value: 'مقياس فترة التوصيل')
  ],
  sons: <KW>[
    KW(
      id: 'hour',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'hour'),
        Phrase(langCode: 'ar', value: 'ساعة')
      ],
    ),
    KW(
      id: 'day',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'day'),
        Phrase(langCode: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'week',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'week'),
        Phrase(langCode: 'ar', value: 'أسبوع')
      ],
    ),
  ],
);
// ------------------------------------------
/// PRODUCT INFO
const Chain madeIn = Chain(
  id: 'madeIn',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Made in'),
    Phrase(langCode: 'ar', value: 'صنع في')
  ],
  sons: null, // getCountriesAsKeywords()
);
const Chain warrantyDuration = Chain(
  id: 'insuranceDuration',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Warranty duration'),
    Phrase(langCode: 'ar', value: 'مدة الضمان')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain warrantyDurationUnit = Chain(
  id: 'warrantyDurationUnit',
  icon: null,
  phraseID: <Phrase>[
    Phrase(langCode: 'en', value: 'Warranty duration unit'),
    Phrase(langCode: 'ar', value: 'وحدة قياس مدة الضمان')
  ],
  sons: <KW>[
    KW(
      id: 'hour',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'hour'),
        Phrase(langCode: 'ar', value: 'ساعة')
      ],
    ),
    KW(
      id: 'day',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'day'),
        Phrase(langCode: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'week',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'week'),
        Phrase(langCode: 'ar', value: 'أسبوع')
      ],
    ),
    KW(
      id: 'year',
      names: <Phrase>[
        Phrase(langCode: 'en', value: 'year'),
        Phrase(langCode: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// ------------------------------------------
