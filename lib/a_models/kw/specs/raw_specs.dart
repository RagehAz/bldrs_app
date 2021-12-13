import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/chain/chain_crafts.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/kw/specs/data_creator.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';

const String newSaleID = 'contractType_NewSale';
const String resaleID = 'contractType_Resale';
const String rentID = 'contractType_Rent';

// -------------------------------------------------------------------------
/// STYLE ANATOMY
const Chain style = Chain(
  id: 'style',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Design Style'),
    Name(code: 'ar', value: 'الطراز التصميمي')
  ],
  sons: <KW>[
    KW(
      id: 'arch_style_arabian',
      names: <Name>[
        Name(code: 'en', value: 'Arabian'),
        Name(code: 'ar', value: 'عربي')
      ],
    ),
    KW(
      id: 'arch_style_andalusian',
      names: <Name>[
        Name(code: 'en', value: 'Andalusian'),
        Name(code: 'ar', value: 'أندلسي')
      ],
    ),
    KW(
      id: 'arch_style_asian',
      names: <Name>[
        Name(code: 'en', value: 'Asian'),
        Name(code: 'ar', value: 'آسيوي')
      ],
    ),
    KW(
      id: 'arch_style_chinese',
      names: <Name>[
        Name(code: 'en', value: 'Chinese'),
        Name(code: 'ar', value: 'صيني')
      ],
    ),
    KW(
      id: 'arch_style_contemporary',
      names: <Name>[
        Name(code: 'en', value: 'Contemporary'),
        Name(code: 'ar', value: 'معاصر')
      ],
    ),
    KW(
      id: 'arch_style_classic',
      names: <Name>[
        Name(code: 'en', value: 'Classic'),
        Name(code: 'ar', value: 'كلاسيكي')
      ],
    ),
    KW(
      id: 'arch_style_eclectic',
      names: <Name>[
        Name(code: 'en', value: 'Eclectic'),
        Name(code: 'ar', value: 'انتقائي')
      ],
    ),
    KW(
      id: 'arch_style_english',
      names: <Name>[
        Name(code: 'en', value: 'English'),
        Name(code: 'ar', value: 'إنجليزي')
      ],
    ),
    KW(
      id: 'arch_style_farmhouse',
      names: <Name>[
        Name(code: 'en', value: 'Farmhouse'),
        Name(code: 'ar', value: 'ريفي')
      ],
    ),
    KW(
      id: 'arch_style_french',
      names: <Name>[
        Name(code: 'en', value: 'French'),
        Name(code: 'ar', value: 'فرنساوي')
      ],
    ),
    KW(
      id: 'arch_style_gothic',
      names: <Name>[
        Name(code: 'en', value: 'Gothic'),
        Name(code: 'ar', value: 'قوطي')
      ],
    ),
    KW(
      id: 'arch_style_greek',
      names: <Name>[
        Name(code: 'en', value: 'Greek'),
        Name(code: 'ar', value: 'يوناني')
      ],
    ),
    KW(
      id: 'arch_style_indian',
      names: <Name>[
        Name(code: 'en', value: 'Indian'),
        Name(code: 'ar', value: 'هندي')
      ],
    ),
    KW(
      id: 'arch_style_industrial',
      names: <Name>[
        Name(code: 'en', value: 'Industrial'),
        Name(code: 'ar', value: 'صناعي')
      ],
    ),
    KW(
      id: 'arch_style_japanese',
      names: <Name>[
        Name(code: 'en', value: 'Japanese'),
        Name(code: 'ar', value: 'ياباني')
      ],
    ),
    KW(
      id: 'arch_style_mediterranean',
      names: <Name>[
        Name(code: 'en', value: 'Mediterranean'),
        Name(code: 'ar', value: 'البحر المتوسط')
      ],
    ),
    KW(
      id: 'arch_style_midcentury',
      names: <Name>[
        Name(code: 'en', value: 'Mid century modern'),
        Name(code: 'ar', value: 'منتصف القرن الحديث')
      ],
    ),
    KW(
      id: 'arch_style_medieval',
      names: <Name>[
        Name(code: 'en', value: 'Medieval'),
        Name(code: 'ar', value: 'القرون الوسطى')
      ],
    ),
    KW(
      id: 'arch_style_minimalist',
      names: <Name>[
        Name(code: 'en', value: 'Minimalist'),
        Name(code: 'ar', value: 'مينيماليزم')
      ],
    ),
    KW(
      id: 'arch_style_modern',
      names: <Name>[
        Name(code: 'en', value: 'Modern'),
        Name(code: 'ar', value: 'حديث')
      ],
    ),
    KW(
      id: 'arch_style_moroccan',
      names: <Name>[
        Name(code: 'en', value: 'Moroccan'),
        Name(code: 'ar', value: 'مغربي')
      ],
    ),
    KW(
      id: 'arch_style_rustic',
      names: <Name>[
        Name(code: 'en', value: 'Rustic'),
        Name(code: 'ar', value: 'فلاحي')
      ],
    ),
    KW(
      id: 'arch_style_scandinavian',
      names: <Name>[
        Name(code: 'en', value: 'Scandinavian'),
        Name(code: 'ar', value: 'إسكاندنيفي')
      ],
    ),
    KW(
      id: 'arch_style_shabbyChic',
      names: <Name>[
        Name(code: 'en', value: 'Shabby Chic'),
        Name(code: 'ar', value: 'مهترئ أنيق')
      ],
    ),
    KW(
      id: 'arch_style_american',
      names: <Name>[
        Name(code: 'en', value: 'American'),
        Name(code: 'ar', value: 'أمريكي')
      ],
    ),
    KW(
      id: 'arch_style_spanish',
      names: <Name>[
        Name(code: 'en', value: 'Spanish'),
        Name(code: 'ar', value: 'أسباني')
      ],
    ),
    KW(
      id: 'arch_style_traditional',
      names: <Name>[
        Name(code: 'en', value: 'Traditional'),
        Name(code: 'ar', value: 'تقليدي')
      ],
    ),
    KW(
      id: 'arch_style_transitional',
      names: <Name>[
        Name(code: 'en', value: 'Transitional'),
        Name(code: 'ar', value: 'انتقالي')
      ],
    ),
    KW(
      id: 'arch_style_tuscan',
      names: <Name>[
        Name(code: 'en', value: 'Tuscan'),
        Name(code: 'ar', value: 'توسكاني')
      ],
    ),
    KW(
      id: 'arch_style_tropical',
      names: <Name>[
        Name(code: 'en', value: 'Tropical'),
        Name(code: 'ar', value: 'استوائي')
      ],
    ),
    KW(
      id: 'arch_style_victorian',
      names: <Name>[
        Name(code: 'en', value: 'Victorian'),
        Name(code: 'ar', value: 'فيكتوريان')
      ],
    ),
    KW(
      id: 'arch_style_vintage',
      names: <Name>[
        Name(code: 'en', value: 'Vintage'),
        Name(code: 'ar', value: 'عتيق')
      ],
    ),
  ],
);
const Chain color = Chain(
  id: 'color',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Color'),
    Name(code: 'ar', value: 'اللون')
  ],
  sons: <KW>[
    KW(
      id: 'red',
      names: <Name>[
        Name(code: 'en', value: 'Red'),
        Name(code: 'ar', value: 'أحمر')
      ],
    ),
    KW(
      id: 'orange',
      names: <Name>[
        Name(code: 'en', value: 'Orange'),
        Name(code: 'ar', value: 'برتقالي')
      ],
    ),
    KW(
      id: 'yellow',
      names: <Name>[
        Name(code: 'en', value: 'Yellow'),
        Name(code: 'ar', value: 'أصفر')
      ],
    ),
    KW(
      id: 'green',
      names: <Name>[
        Name(code: 'en', value: 'Green'),
        Name(code: 'ar', value: 'أخضر')
      ],
    ),
    KW(
      id: 'blue',
      names: <Name>[
        Name(code: 'en', value: 'Blue'),
        Name(code: 'ar', value: 'أزرق')
      ],
    ),
    KW(
      id: 'indigo',
      names: <Name>[
        Name(code: 'en', value: 'Indigo'),
        Name(code: 'ar', value: 'نيلي')
      ],
    ),
    KW(
      id: 'violet',
      names: <Name>[
        Name(code: 'en', value: 'Violet'),
        Name(code: 'ar', value: 'بنفسجي')
      ],
    ),
    KW(
      id: 'black',
      names: <Name>[
        Name(code: 'en', value: 'Black'),
        Name(code: 'ar', value: 'أسود')
      ],
    ),
    KW(
      id: 'white',
      names: <Name>[
        Name(code: 'en', value: 'White'),
        Name(code: 'ar', value: 'أبيض')
      ],
    ),
    KW(
      id: 'grey',
      names: <Name>[
        Name(code: 'en', value: 'Grey'),
        Name(code: 'ar', value: 'رمادي')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PRICING ANATOMY
const Chain contractType = Chain(
  id: 'contractType',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Contract Type'),
    Name(code: 'ar', value: 'نوع التعاقد')
  ],
  sons: <KW>[
    KW(
      id: newSaleID,
      names: <Name>[
        Name(code: 'en', value: 'New Sale'),
        Name(code: 'ar', value: 'للبيع جديد')
      ],
    ), // if you change ID revise specs_picker_screen
    KW(
      id: resaleID,
      names: <Name>[
        Name(code: 'en', value: 'Resale'),
        Name(code: 'ar', value: 'لإعادة البيع')
      ],
    ), // if you change ID revise specs_picker_screen
    KW(
      id: rentID,
      names: <Name>[
        Name(code: 'en', value: 'Rent'),
        Name(code: 'ar', value: 'للإيجار')
      ],
    ), // if you change ID revise specs_picker_screen
  ],
);
const Chain paymentMethod = Chain(
  id: 'paymentMethod',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Payment Method'),
    Name(code: 'ar', value: 'طريقة السداد')
  ],
  sons: <KW>[
    KW(
      id: 'payment_cash',
      names: <Name>[
        Name(code: 'en', value: 'Cash'),
        Name(code: 'ar', value: 'دفعة واحدة')
      ],
    ),
    KW(
      id: 'payment_installments',
      names: <Name>[
        Name(code: 'en', value: 'Installments'),
        Name(code: 'ar', value: 'على دفعات')
      ],
    ),
  ],
);
const Chain price = Chain(
  id: 'price',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'price'),
    Name(code: 'ar', value: 'السعر')
  ],
  sons: DataCreator.price,
);
const Chain currency = Chain(
  id: 'currency',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Currency'),
    Name(code: 'ar', value: 'العملة')
  ],
  sons: DataCreator.currency,
);
const Chain unitPriceInterval = Chain(
  id: 'unitPriceInterval',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Standard interval'),
    Name(code: 'ar', value: 'مقياس الفترة')
  ],
  sons: <KW>[
    KW(
      id: 'perHour',
      names: <Name>[
        Name(code: 'en', value: 'Per Hour'),
        Name(code: 'ar', value: 'في الساعة')
      ],
    ),
    KW(
      id: 'perDay',
      names: <Name>[
        Name(code: 'en', value: 'per day'),
        Name(code: 'ar', value: 'في اليوم')
      ],
    ),
    KW(
      id: 'perWeek',
      names: <Name>[
        Name(code: 'en', value: 'per week'),
        Name(code: 'ar', value: 'في الأسبوع')
      ],
    ),
    KW(
      id: 'perMonth',
      names: <Name>[
        Name(code: 'en', value: 'per month'),
        Name(code: 'ar', value: 'في الشهر')
      ],
    ),
    KW(
      id: 'perYear',
      names: <Name>[
        Name(code: 'en', value: 'per year'),
        Name(code: 'ar', value: 'في السنة')
      ],
    ),
  ],
);
const Chain numberOfInstallments = Chain(
  id: 'numberOfInstallments',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Number of Installments'),
    Name(code: 'ar', value: 'عدد الدفعات')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain installmentsDuration = Chain(
  id: 'installmentsDuration',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Installments duration'),
    Name(code: 'ar', value: 'مدة الدفعات')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain installmentsDurationUnit = Chain(
  id: 'installmentsDurationUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Installments duration unit'),
    Name(code: 'ar', value: 'مقياس مدة الدفعات')
  ],
  sons: <KW>[
    KW(
      id: 'installmentsDurationUnit_day',
      names: <Name>[
        Name(code: 'en', value: 'day'),
        Name(code: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'installmentsDurationUnit_week',
      names: <Name>[
        Name(code: 'en', value: 'week'),
        Name(code: 'ar', value: 'أسبوع')
      ],
    ),
    KW(
      id: 'installmentsDurationUnit_month',
      names: <Name>[
        Name(code: 'en', value: 'month'),
        Name(code: 'ar', value: 'شهر')
      ],
    ),
    KW(
      id: 'installmentsDurationUnit_year',
      names: <Name>[
        Name(code: 'en', value: 'year'),
        Name(code: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// TIME ANATOMY
const Chain duration = Chain(
  id: 'duration',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Duration'),
    Name(code: 'ar', value: 'الزمن')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain durationUnit = Chain(
  id: 'durationUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Duration unit'),
    Name(code: 'ar', value: 'مقياس الزمن')
  ],
  sons: <KW>[
    KW(
      id: 'minute',
      names: <Name>[
        Name(code: 'en', value: 'minute'),
        Name(code: 'ar', value: 'دقيقة')
      ],
    ),
    KW(
      id: 'hour',
      names: <Name>[
        Name(code: 'en', value: 'hour'),
        Name(code: 'ar', value: 'ساعة')
      ],
    ),
    KW(
      id: 'day',
      names: <Name>[
        Name(code: 'en', value: 'day'),
        Name(code: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'week',
      names: <Name>[
        Name(code: 'en', value: 'week'),
        Name(code: 'ar', value: 'أسبوع')
      ],
    ),
    KW(
      id: 'month',
      names: <Name>[
        Name(code: 'en', value: 'month'),
        Name(code: 'ar', value: 'شهر')
      ],
    ),
    KW(
      id: 'year',
      names: <Name>[
        Name(code: 'en', value: 'year'),
        Name(code: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// AREAL ANATOMY
const Chain propertyArea = Chain(
  id: 'propertyArea',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property Area'),
    Name(code: 'ar', value: 'مساحة العقار')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain propertyAreaUnit = Chain(
  id: 'propertyAreaUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property Area Unit'),
    Name(code: 'ar', value: 'وحدة قياس مساحة العقار')
  ],
  sons: <KW>[
    KW(
      id: 'square_meter',
      names: <Name>[
        Name(code: 'en', value: 'm²'),
        Name(code: 'ar', value: 'م²')
      ],
    ),
    KW(
      id: 'square_feet',
      names: <Name>[
        Name(code: 'en', value: 'ft²'),
        Name(code: 'ar', value: 'قدم²')
      ],
    ),
  ],
);
const Chain lotArea = Chain(
  id: 'plotArea',
  names: <Name>[
    Name(code: 'en', value: 'Lot Area'),
    Name(code: 'ar', value: 'مساحة قطعة الأرض')
  ],
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain lotAreaUnit = Chain(
  id: 'lotAreaUnit',
  names: <Name>[
    Name(code: 'en', value: 'Lot Area Unit'),
    Name(code: 'ar', value: 'وحدة قياس مساحة أرض العقار')
  ],
  icon: null,
  sons: <KW>[
    KW(
      id: 'square_meter',
      names: <Name>[
        Name(code: 'en', value: 'm²'),
        Name(code: 'ar', value: 'م²')
      ],
    ),
    KW(
      id: 'square_Kilometer',
      names: <Name>[
        Name(code: 'en', value: 'Km²'),
        Name(code: 'ar', value: 'كم²')
      ],
    ),
    KW(
      id: 'square_feet',
      names: <Name>[
        Name(code: 'en', value: 'ft²'),
        Name(code: 'ar', value: 'قدم²')
      ],
    ),
    KW(
      id: 'square_yard',
      names: <Name>[
        Name(code: 'en', value: 'yd²'),
        Name(code: 'ar', value: 'ياردة²')
      ],
    ),
    KW(
      id: 'acre',
      names: <Name>[
        Name(code: 'en', value: 'Acre'),
        Name(code: 'ar', value: 'فدان')
      ],
    ),
    KW(
      id: 'hectare',
      names: <Name>[
        Name(code: 'en', value: 'Hectare'),
        Name(code: 'ar', value: 'هكتار')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY GENERAL ANATOMY
const Chain propertyForm = Chain(
  id: 'propertyForm',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property Form'),
    Name(code: 'ar', value: 'هيئة العقار')
  ],
  sons: <KW>[
    KW(
      id: 'pf_fullFloor',
      names: <Name>[
        Name(code: 'en', value: 'Full floor'),
        Name(code: 'ar', value: 'دور كامل')
      ],
    ),
    KW(
      id: 'pf_halfFloor',
      names: <Name>[
        Name(code: 'en', value: 'Half floor'),
        Name(code: 'ar', value: 'نصف دور')
      ],
    ),
    KW(
      id: 'pf_partFloor',
      names: <Name>[
        Name(code: 'en', value: 'Part of floor'),
        Name(code: 'ar', value: 'جزء من دور')
      ],
    ),
    KW(
      id: 'pf_building',
      names: <Name>[
        Name(code: 'en', value: 'Whole building'),
        Name(code: 'ar', value: 'مبنى كامل')
      ],
    ),
    KW(
      id: 'pf_land',
      names: <Name>[
        Name(code: 'en', value: 'Land'),
        Name(code: 'ar', value: 'أرض')
      ],
    ),
    KW(
      id: 'pf_mobile',
      names: <Name>[
        Name(code: 'en', value: 'Mobile'),
        Name(code: 'ar', value: 'منشأ متنقل')
      ],
    ),
  ],
);
const Chain propertyLicense = Chain(
  id: 'propertyLicense',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property License'),
    Name(code: 'ar', value: 'رخصة العقار')
  ],
  sons: <KW>[
    KW(
      id: 'ppt_lic_residential',
      names: <Name>[
        Name(code: 'en', value: 'Residential'),
        Name(code: 'ar', value: 'سكني')
      ],
    ),
    KW(
      id: 'ppt_lic_administration',
      names: <Name>[
        Name(code: 'en', value: 'Administration'),
        Name(code: 'ar', value: 'إداري')
      ],
    ),
    KW(
      id: 'ppt_lic_educational',
      names: <Name>[
        Name(code: 'en', value: 'Educational'),
        Name(code: 'ar', value: 'تعليمي')
      ],
    ),
    KW(
      id: 'ppt_lic_utilities',
      names: <Name>[
        Name(code: 'en', value: 'Utilities'),
        Name(code: 'ar', value: 'خدمات')
      ],
    ),
    KW(
      id: 'ppt_lic_sports',
      names: <Name>[
        Name(code: 'en', value: 'Sports'),
        Name(code: 'ar', value: 'رياضي')
      ],
    ),
    KW(
      id: 'ppt_lic_entertainment',
      names: <Name>[
        Name(code: 'en', value: 'Entertainment'),
        Name(code: 'ar', value: 'ترفيهي')
      ],
    ),
    KW(
      id: 'ppt_lic_medical',
      names: <Name>[
        Name(code: 'en', value: 'Medical'),
        Name(code: 'ar', value: 'طبي')
      ],
    ),
    KW(
      id: 'ppt_lic_retail',
      names: <Name>[
        Name(code: 'en', value: 'Retail'),
        Name(code: 'ar', value: 'تجاري')
      ],
    ),
    KW(
      id: 'ppt_lic_hotel',
      names: <Name>[
        Name(code: 'en', value: 'Hotel'),
        Name(code: 'ar', value: 'فندقي')
      ],
    ),
    KW(
      id: 'ppt_lic_industrial',
      names: <Name>[
        Name(code: 'en', value: 'Industrial'),
        Name(code: 'ar', value: 'صناعي')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY SPATIAL ANATOMY
const Chain propertySpaces = Chain(
  id: 'group_space_type',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Space Type'),
    Name(code: 'ar', value: 'نوع الفراغ')
  ],
  sons: <Chain>[
    // ----------------------------------
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
        KW(
          id: 'space_office',
          names: <Name>[
            Name(code: 'en', value: 'Office'),
            Name(code: 'ar', value: 'مكتب')
          ],
        ),
        KW(
          id: 'space_kitchenette',
          names: <Name>[
            Name(code: 'en', value: 'Office Kitchenette'),
            Name(code: 'ar', value: 'أوفيس / مطبخ صغير')
          ],
        ),
        KW(
          id: 'space_meetingRoom',
          names: <Name>[
            Name(code: 'en', value: 'Meeting room'),
            Name(code: 'ar', value: 'غرفة اجتماعات')
          ],
        ),
        KW(
          id: 'space_seminarHall',
          names: <Name>[
            Name(code: 'en', value: 'Seminar hall'),
            Name(code: 'ar', value: 'قاعة سمينار')
          ],
        ),
        KW(
          id: 'space_conventionHall',
          names: <Name>[
            Name(code: 'en', value: 'Convention hall'),
            Name(code: 'ar', value: 'قاعة عرض')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_lectureRoom',
          names: <Name>[
            Name(code: 'en', value: 'Lecture room'),
            Name(code: 'ar', value: 'غرفة محاضرات')
          ],
        ),
        KW(
          id: 'space_library',
          names: <Name>[
            Name(code: 'en', value: 'Library'),
            Name(code: 'ar', value: 'مكتبة')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_theatre',
          names: <Name>[
            Name(code: 'en', value: 'Theatre'),
            Name(code: 'ar', value: 'مسرح')
          ],
        ),
        KW(
          id: 'space_concertHall',
          names: <Name>[
            Name(code: 'en', value: 'Concert hall'),
            Name(code: 'ar', value: 'قاعة موسيقية')
          ],
        ),
        KW(
          id: 'space_homeCinema',
          names: <Name>[
            Name(code: 'en', value: 'Home Cinema'),
            Name(code: 'ar', value: 'مسرح منزلي')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_spa',
          names: <Name>[
            Name(code: 'en', value: 'Spa'),
            Name(code: 'ar', value: 'منتجع صحي')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_lobby',
          names: <Name>[
            Name(code: 'en', value: 'Lobby'),
            Name(code: 'ar', value: 'ردهة')
          ],
        ),
        KW(
          id: 'space_living',
          names: <Name>[
            Name(code: 'en', value: 'Living room'),
            Name(code: 'ar', value: 'غرفة معيشة')
          ],
        ),
        KW(
          id: 'space_bedroom',
          names: <Name>[
            Name(code: 'en', value: 'Bedroom'),
            Name(code: 'ar', value: 'غرفة نوم')
          ],
        ),
        KW(
          id: 'space_kitchen',
          names: <Name>[
            Name(code: 'en', value: 'Home Kitchen'),
            Name(code: 'ar', value: 'مطبخ')
          ],
        ),
        KW(
          id: 'space_bathroom',
          names: <Name>[
            Name(code: 'en', value: 'Bathroom'),
            Name(code: 'ar', value: 'حمام')
          ],
        ),
        KW(
          id: 'space_reception',
          names: <Name>[
            Name(code: 'en', value: 'Reception'),
            Name(code: 'ar', value: 'استقبال')
          ],
        ),
        KW(
          id: 'space_salon',
          names: <Name>[
            Name(code: 'en', value: 'Salon'),
            Name(code: 'ar', value: 'صالون')
          ],
        ),
        KW(
          id: 'space_laundry',
          names: <Name>[
            Name(code: 'en', value: 'Laundry room'),
            Name(code: 'ar', value: 'غرفة غسيل')
          ],
        ),
        KW(
          id: 'space_balcony',
          names: <Name>[
            Name(code: 'en', value: 'Balcony'),
            Name(code: 'ar', value: 'تراس')
          ],
        ),
        KW(
          id: 'space_toilet',
          names: <Name>[
            Name(code: 'en', value: 'Toilet'),
            Name(code: 'ar', value: 'دورة مياه')
          ],
        ),
        KW(
          id: 'space_dining',
          names: <Name>[
            Name(code: 'en', value: 'Dining room'),
            Name(code: 'ar', value: 'غرفة طعام')
          ],
        ),
        KW(
          id: 'space_stairs',
          names: <Name>[
            Name(code: 'en', value: 'Stairs'),
            Name(code: 'ar', value: 'سلالم')
          ],
        ),
        KW(
          id: 'space_attic',
          names: <Name>[
            Name(code: 'en', value: 'Attic'),
            Name(code: 'ar', value: 'علية / صندرة')
          ],
        ),
        KW(
          id: 'space_corridor',
          names: <Name>[
            Name(code: 'en', value: 'Corridor'),
            Name(code: 'ar', value: 'رواق / طرقة')
          ],
        ),
        KW(
          id: 'space_garage',
          names: <Name>[
            Name(code: 'en', value: 'Garage'),
            Name(code: 'ar', value: 'جراج')
          ],
        ),
        KW(
          id: 'space_storage',
          names: <Name>[
            Name(code: 'en', value: 'Storage room'),
            Name(code: 'ar', value: 'مخزن')
          ],
        ),
        KW(
          id: 'space_maid',
          names: <Name>[
            Name(code: 'en', value: 'Maid room'),
            Name(code: 'ar', value: 'غرفة مربية')
          ],
        ),
        KW(
          id: 'space_walkInCloset',
          names: <Name>[
            Name(code: 'en', value: 'Walk In closet'),
            Name(code: 'ar', value: 'غرفة ملابس')
          ],
        ),
        KW(
          id: 'space_barbecue',
          names: <Name>[
            Name(code: 'en', value: 'Barbecue area'),
            Name(code: 'ar', value: 'مساحة شواية')
          ],
        ),
        KW(
          id: 'space_garden',
          names: <Name>[
            Name(code: 'en', value: 'Private garden'),
            Name(code: 'ar', value: 'حديقة خاصة')
          ],
        ),
        KW(
          id: 'space_privatePool',
          names: <Name>[
            Name(code: 'en', value: 'Private pool'),
            Name(code: 'ar', value: 'حمام سباحة خاص')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_store',
          names: <Name>[
            Name(code: 'en', value: 'Store / Shop'),
            Name(code: 'ar', value: 'محل / متجر')
          ],
        ),
      ],
    ),
    // ----------------------------------
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
          id: 'space_gymnasium',
          names: <Name>[
            Name(code: 'en', value: 'Gymnasium'),
            Name(code: 'ar', value: 'جيمنازيوم')
          ],
        ),
        KW(
          id: 'space_sportsCourt',
          names: <Name>[
            Name(code: 'en', value: 'Sports court'),
            Name(code: 'ar', value: 'ملعب رياضي')
          ],
        ),
        KW(
          id: 'space_sportStadium',
          names: <Name>[
            Name(code: 'en', value: 'Stadium'),
            Name(code: 'ar', value: 'استاد رياضي')
          ],
        ),
      ],
    ),
    // ----------------------------------
    /// Utilities
    Chain(
      id: 'ppt_lic_utilities',
      icon: null,
      names: <Name>[
        Name(code: 'en', value: 'Utilities'),
        Name(code: 'ar', value: 'خدمات')
      ],
      sons: <KW>[
        KW(
          id: 'pFeature_elevator',
          names: <Name>[
            Name(code: 'en', value: 'Elevator'),
            Name(code: 'ar', value: 'مصعد')
          ],
        ),
        KW(
          id: 'space_electricityRoom',
          names: <Name>[
            Name(code: 'en', value: 'Electricity rooms'),
            Name(code: 'ar', value: 'غرفة كهرباء')
          ],
        ),
        KW(
          id: 'space_plumbingRoom',
          names: <Name>[
            Name(code: 'en', value: 'Plumbing rooms'),
            Name(code: 'ar', value: 'غرفة صحي و صرف')
          ],
        ),
        KW(
          id: 'space_mechanicalRoom',
          names: <Name>[
            Name(code: 'en', value: 'Mechanical rooms'),
            Name(code: 'ar', value: 'غرفة ميكانيكية')
          ],
        ),
      ],
    ),
  ],
);
const Chain propertyFloorNumber = Chain(
  id: 'propertyFloorNumber',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property Floor Number'),
    Name(code: 'ar', value: 'رقم دور العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain propertyDedicatedParkingLotsCount = Chain(
  id: 'propertyDedicatedParkingSpaces',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Number of property dedicated parking lots'),
    Name(code: 'ar', value: 'عدد مواقف السيارات المخصصة للعقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain propertyNumberOfBedrooms = Chain(
  id: 'propertyNumberOfBedrooms',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property Number of Bedrooms'),
    Name(code: 'ar', value: 'عدد غرف نوم العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain propertyNumberOfBathrooms = Chain(
  id: 'propertyNumberOfBathrooms',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property Number of bathrooms'),
    Name(code: 'ar', value: 'عدد حمامات العقار')
  ],
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// PROPERTY FEATURES ANATOMY
const Chain propertyView = Chain(
  id: 'propertyView',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property View'),
    Name(code: 'ar', value: 'المنظر المطل عليه  العقار')
  ],
  sons: <KW>[
    KW(
      id: 'view_golf',
      names: <Name>[
        Name(code: 'en', value: 'Golf course view'),
        Name(code: 'ar', value: 'مضمار جولف')
      ],
    ),
    KW(
      id: 'view_hill',
      names: <Name>[
        Name(code: 'en', value: 'Hill or Mountain view'),
        Name(code: 'ar', value: 'تل أو جبل')
      ],
    ),
    KW(
      id: 'view_ocean',
      names: <Name>[
        Name(code: 'en', value: 'Ocean view'),
        Name(code: 'ar', value: 'محيط')
      ],
    ),
    KW(
      id: 'view_city',
      names: <Name>[
        Name(code: 'en', value: 'City view'),
        Name(code: 'ar', value: 'مدينة')
      ],
    ),
    KW(
      id: 'view_lake',
      names: <Name>[
        Name(code: 'en', value: 'Lake view'),
        Name(code: 'ar', value: 'بحيرة')
      ],
    ),
    KW(
      id: 'view_lagoon',
      names: <Name>[
        Name(code: 'en', value: 'Lagoon view'),
        Name(code: 'ar', value: 'لاجون')
      ],
    ),
    KW(
      id: 'view_river',
      names: <Name>[
        Name(code: 'en', value: 'River view'),
        Name(code: 'ar', value: 'نهر')
      ],
    ),
    KW(
      id: 'view_mainStreet',
      names: <Name>[
        Name(code: 'en', value: 'Main street view'),
        Name(code: 'ar', value: 'شارع رئيسي')
      ],
    ),
    KW(
      id: 'view_sideStreet',
      names: <Name>[
        Name(code: 'en', value: 'Side street view'),
        Name(code: 'ar', value: 'شارع جانبي')
      ],
    ),
    KW(
      id: 'view_corner',
      names: <Name>[
        Name(code: 'en', value: 'Corner view'),
        Name(code: 'ar', value: 'ناصية الشارع')
      ],
    ),
    KW(
      id: 'view_back',
      names: <Name>[
        Name(code: 'en', value: 'Back view'),
        Name(code: 'ar', value: 'خلفي')
      ],
    ),
    KW(
      id: 'view_garden',
      names: <Name>[
        Name(code: 'en', value: 'Garden view'),
        Name(code: 'ar', value: 'حديقة')
      ],
    ),
    KW(
      id: 'view_pool',
      names: <Name>[
        Name(code: 'en', value: 'Pool view'),
        Name(code: 'ar', value: 'حمام سباحة')
      ],
    ),
  ],
);
const Chain propertyIndoorFeatures = Chain(
  id: 'sub_ppt_feat_indoor',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Property Indoor Features'),
    Name(code: 'ar', value: 'خواص العقار الداخلية')
  ],
  sons: <KW>[
    KW(
      id: 'pFeature_disabilityFeatures',
      names: <Name>[
        Name(code: 'en', value: 'Disability features'),
        Name(code: 'ar', value: 'خواص معتبرة للإعاقة و المقعدين')
      ],
    ),
    KW(
      id: 'pFeature_fireplace',
      names: <Name>[
        Name(code: 'en', value: 'Fireplace'),
        Name(code: 'ar', value: 'مدفأة حطب')
      ],
    ),
    KW(
      id: 'pFeature_energyEfficient',
      names: <Name>[
        Name(code: 'en', value: 'Energy efficient'),
        Name(code: 'ar', value: 'موفر للطاقة')
      ],
    ),
    KW(
      id: 'pFeature_electricityBackup',
      names: <Name>[
        Name(code: 'en', value: 'Electricity backup'),
        Name(code: 'ar', value: 'دعم كهرباء احتياطي')
      ],
    ),
    KW(
      id: 'pFeature_centralAC',
      names: <Name>[
        Name(code: 'en', value: 'Central AC'),
        Name(code: 'ar', value: 'تكييف مركزي')
      ],
    ),
    KW(
      id: 'pFeature_centralHeating',
      names: <Name>[
        Name(code: 'en', value: 'Central heating'),
        Name(code: 'ar', value: 'تدفئة مركزية')
      ],
    ),
    KW(
      id: 'pFeature_builtinWardrobe',
      names: <Name>[
        Name(code: 'en', value: 'Built-in wardrobes'),
        Name(code: 'ar', value: 'دواليب داخل الحوائط')
      ],
    ),
    KW(
      id: 'pFeature_kitchenAppliances',
      names: <Name>[
        Name(code: 'en', value: 'Kitchen Appliances'),
        Name(code: 'ar', value: 'أجهزة مطبخ')
      ],
    ),
    KW(
      id: 'pFeature_elevator',
      names: <Name>[
        Name(code: 'en', value: 'Elevator'),
        Name(code: 'ar', value: 'مصعد')
      ],
    ),
    KW(
      id: 'pFeature_intercom',
      names: <Name>[
        Name(code: 'en', value: 'Intercom'),
        Name(code: 'ar', value: 'إنتركوم')
      ],
    ),
    KW(
      id: 'pFeature_internet',
      names: <Name>[
        Name(code: 'en', value: 'Broadband internet'),
        Name(code: 'ar', value: 'إنترنت')
      ],
    ),
    KW(
      id: 'pFeature_tv',
      names: <Name>[
        Name(code: 'en', value: 'Satellite / Cable TV'),
        Name(code: 'ar', value: 'قمر صناعي / تلفزيون مركزي')
      ],
    ),
  ],
);
const Chain propertyFinishingLevel = Chain(
  id: 'sub_ppt_feat_finishing',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Finishing level'),
    Name(code: 'ar', value: 'مستوى التشطيب')
  ],
  sons: <KW>[
    KW(
      id: 'finish_coreAndShell',
      names: <Name>[
        Name(code: 'en', value: 'Core and shell'),
        Name(code: 'ar', value: 'خرسانات و حوائط خارجية')
      ],
    ),
    KW(
      id: 'finish_withoutFinishing',
      names: <Name>[
        Name(code: 'en', value: 'Without finishing'),
        Name(code: 'ar', value: 'غير متشطب')
      ],
    ),
    KW(
      id: 'finish_semiFinished',
      names: <Name>[
        Name(code: 'en', value: 'Semi finished'),
        Name(code: 'ar', value: 'نصف تشطيب')
      ],
    ),
    KW(
      id: 'finish_lux',
      names: <Name>[
        Name(code: 'en', value: 'Lux'),
        Name(code: 'ar', value: 'تشطيب لوكس')
      ],
    ),
    KW(
      id: 'finish_superLux',
      names: <Name>[
        Name(code: 'en', value: 'Super lux'),
        Name(code: 'ar', value: 'تشطيب سوبر لوكس')
      ],
    ),
    KW(
      id: 'finish_extraSuperLux',
      names: <Name>[
        Name(code: 'en', value: 'Extra super lux'),
        Name(code: 'ar', value: 'تشطيب إكسترا سوبر لوكس')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// BUILDING FEATURES ANATOMY
const Chain buildingNumberOfFloors = Chain(
  id: 'buildingNumberOfFloors',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Building number of floors'),
    Name(code: 'ar', value: 'عدد أدوار المبنى')
  ],
  sons: DataCreator.integerIncrementer, // TASK : define range 0 - g163
);
const Chain buildingAgeInYears = Chain(
  id: 'buildingAge',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Building Age'),
    Name(code: 'ar', value: 'عمر المنشأ')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain buildingTotalParkingLotsCount = Chain(
  id: 'buildingTotalParkingLotsCount',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Total Building parking lots count'),
    Name(code: 'ar', value: 'مجموع عدد مواقف السيارات للمبنى')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain buildingTotalUnitsCount = Chain(
  id: 'buildingTotalPropertiesCount',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Total Building units count'),
    Name(code: 'ar', value: 'مجموع عدد وحدات المبنى')
  ],
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// COMMUNITY FEATURES ANATOMY
const Chain inACompound = Chain(
  id: 'sub_ppt_feat_compound',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'In a Compound'),
    Name(code: 'ar', value: 'في مجمع سكني')
  ],
  sons: <KW>[
    KW(
      id: 'in_compound',
      names: <Name>[
        Name(code: 'en', value: 'In a compound'),
        Name(code: 'ar', value: 'في مجمع سكني')
      ],
    ),
    KW(
      id: 'not_in_compound',
      names: <Name>[
        Name(code: 'en', value: 'Not in a compound'),
        Name(code: 'ar', value: 'ليست في مجمع سكني')
      ],
    ),
  ],
);
const Chain amenities = Chain(
  id: 'sub_ppt_feat_amenities',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Amenities'),
    Name(code: 'ar', value: 'منشآت خدمية ملحقة')
  ],
  sons: <KW>[
    KW(
      id: 'am_laundry',
      names: <Name>[
        Name(code: 'en', value: 'Laundry'),
        Name(code: 'ar', value: 'مغسلة')
      ],
    ),
    KW(
      id: 'am_swimmingPool',
      names: <Name>[
        Name(code: 'en', value: 'Swimming pool'),
        Name(code: 'ar', value: 'حمام سباحة')
      ],
    ),
    KW(
      id: 'am_kidsPool',
      names: <Name>[
        Name(code: 'en', value: 'Kids pool'),
        Name(code: 'ar', value: 'حمام سباحة أطفال')
      ],
    ),
    KW(
      id: 'am_boatFacilities',
      names: <Name>[
        Name(code: 'en', value: 'Boat facilities'),
        Name(code: 'ar', value: 'خدمات مراكب مائية')
      ],
    ),
    KW(
      id: 'am_gymFacilities',
      names: <Name>[
        Name(code: 'en', value: 'Gym'),
        Name(code: 'ar', value: 'صالة جيمنازيوم')
      ],
    ),
    KW(
      id: 'am_clubHouse',
      names: <Name>[
        Name(code: 'en', value: 'Clubhouse'),
        Name(code: 'ar', value: 'كلاب هاوس')
      ],
    ),
    KW(
      id: 'am_horseFacilities',
      names: <Name>[
        Name(code: 'en', value: 'Horse facilities'),
        Name(code: 'ar', value: 'خدمات خيول')
      ],
    ),
    KW(
      id: 'am_sportsCourts',
      names: <Name>[
        Name(code: 'en', value: 'Sports courts'),
        Name(code: 'ar', value: 'ملاعب رياضية')
      ],
    ),
    KW(
      id: 'am_park',
      names: <Name>[
        Name(code: 'en', value: 'Park / garden'),
        Name(code: 'ar', value: 'حديقة')
      ],
    ),
    KW(
      id: 'am_golfCourse',
      names: <Name>[
        Name(code: 'en', value: 'Golf course'),
        Name(code: 'ar', value: 'مضمار جولف')
      ],
    ),
    KW(
      id: 'am_spa',
      names: <Name>[
        Name(code: 'en', value: 'Spa'),
        Name(code: 'ar', value: 'منتجع صحي')
      ],
    ),
    KW(
      id: 'am_kidsArea',
      names: <Name>[
        Name(code: 'en', value: 'Kids Area'),
        Name(code: 'ar', value: 'منطقة أطفال')
      ],
    ),
    KW(
      id: 'am_cafeteria',
      names: <Name>[
        Name(code: 'en', value: 'Cafeteria'),
        Name(code: 'ar', value: 'كافيتيريا')
      ],
    ),
    KW(
      id: 'am_businessCenter',
      names: <Name>[
        Name(code: 'en', value: 'Business center'),
        Name(code: 'ar', value: 'مقر أعمال')
      ],
    ),
    KW(
      id: 'am_lobby',
      names: <Name>[
        Name(code: 'en', value: 'Building lobby'),
        Name(code: 'ar', value: 'ردهة مدخل للمبنى')
      ],
    ),
  ],
);
const Chain communityServices = Chain(
  id: 'sub_ppt_feat_services',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Community Services'),
    Name(code: 'ar', value: 'خدمات المجتمع')
  ],
  sons: <KW>[
    KW(
      id: 'pService_houseKeeping',
      names: <Name>[
        Name(code: 'en', value: 'Housekeeping'),
        Name(code: 'ar', value: 'خدمة تنظيف منزلي')
      ],
    ),
    KW(
      id: 'pService_laundryService',
      names: <Name>[
        Name(code: 'en', value: 'LaundryService'),
        Name(code: 'ar', value: 'خدمة غسيل ملابس')
      ],
    ),
    KW(
      id: 'pService_concierge',
      names: <Name>[
        Name(code: 'en', value: 'Concierge'),
        Name(code: 'ar', value: 'خدمة استقبال')
      ],
    ),
    KW(
      id: 'pService_securityStaff',
      names: <Name>[
        Name(code: 'en', value: 'Security  staff'),
        Name(code: 'ar', value: 'فريق حراسة')
      ],
    ),
    KW(
      id: 'pService_securityCCTV',
      names: <Name>[
        Name(code: 'en', value: 'CCTV security'),
        Name(code: 'ar', value: 'كاميرات مراقبة')
      ],
    ),
    KW(
      id: 'pService_petsAllowed',
      names: <Name>[
        Name(code: 'en', value: 'Pets allowed'),
        Name(code: 'ar', value: 'مسموح بالحيوانات الأليفة')
      ],
    ),
    KW(
      id: 'pService_doorMan',
      names: <Name>[
        Name(code: 'en', value: 'Doorman'),
        Name(code: 'ar', value: 'حاجب العقار')
      ],
    ),
    KW(
      id: 'pService_maintenance',
      names: <Name>[
        Name(code: 'en', value: 'Maintenance staff'),
        Name(code: 'ar', value: 'فريق صيانة')
      ],
    ),
    KW(
      id: 'pService_wasteDisposal',
      names: <Name>[
        Name(code: 'en', value: 'Waste disposal'),
        Name(code: 'ar', value: 'خدمة رفع القمامة')
      ],
    ),
    KW(
      id: 'pFeature_atm',
      names: <Name>[
        Name(code: 'en', value: 'ATM'),
        Name(code: 'ar', value: 'ماكينة سحب أموال ATM')
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
  names: const <Name>[
    Name(code: 'en', value: 'Project construction activities'),
    Name(code: 'ar', value: 'بنود تنفيذ المشروع')
  ],
  sons: ChainCrafts.chain.sons,
);
const Chain constructionActivityMeasurementMethod = Chain(
  id: 'constructionActivityMeasurementMethod',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Measurement unit'),
    Name(code: 'ar', value: 'أسلوب القياس')
  ],
  sons: <KW>[
    KW(
      id: 'byLength',
      names: <Name>[
        Name(code: 'en', value: 'by Length'),
        Name(code: 'ar', value: 'بالأطوال')
      ],
    ),
    KW(
      id: 'byArea',
      names: <Name>[
        Name(code: 'en', value: 'by Area'),
        Name(code: 'ar', value: 'بالمساحة')
      ],
    ),
    KW(
      id: 'byVolume',
      names: <Name>[
        Name(code: 'en', value: 'by Volume'),
        Name(code: 'ar', value: 'بالحجم')
      ],
    ),
    KW(
      id: 'byCount',
      names: <Name>[
        Name(code: 'en', value: 'by Count'),
        Name(code: 'ar', value: 'بالعدد')
      ],
    ),
    KW(
      id: 'byTime',
      names: <Name>[
        Name(code: 'en', value: 'by Time'),
        Name(code: 'ar', value: 'بالفترة الزمنية')
      ],
    ),
    KW(
      id: 'byLove',
      names: <Name>[
        Name(code: 'en', value: 'by Love'),
        Name(code: 'ar', value: 'بالحب')
      ],
    ),
  ],
);
// -------------------------------------------------------------------------
/// SIZING ANATOMY
const Chain width = Chain(
  id: 'width',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Width'),
    Name(code: 'ar', value: 'العرض')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain length = Chain(
  id: 'length',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Length'),
    Name(code: 'ar', value: 'الطول')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain height = Chain(
  id: 'height',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Height'),
    Name(code: 'ar', value: 'الارتفاع')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain thickness = Chain(
  id: 'thickness',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Thickness'),
    Name(code: 'ar', value: 'السمك')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain diameter = Chain(
  id: 'diameter',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Diameter'),
    Name(code: 'ar', value: 'القطر')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain radius = Chain(
  id: 'radius',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Radius'),
    Name(code: 'ar', value: 'نصف القطر')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain linearMeasurementUnit = Chain(
  id: 'linearMeasureUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Linear measurement unit'),
    Name(code: 'ar', value: 'وحدة القياس الطولي')
  ],
  sons: <KW>[
    KW(
      id: 'micron',
      names: <Name>[
        Name(code: 'en', value: 'micron'),
        Name(code: 'ar', value: 'ميكرون')
      ],
    ),
    KW(
      id: 'millimeter',
      names: <Name>[
        Name(code: 'en', value: 'millimetre'),
        Name(code: 'ar', value: 'ملليمتر')
      ],
    ),
    KW(
      id: 'centimeter',
      names: <Name>[
        Name(code: 'en', value: 'centimeter'),
        Name(code: 'ar', value: 'سنتيمتر')
      ],
    ),
    KW(
      id: 'meter',
      names: <Name>[
        Name(code: 'en', value: 'meter'),
        Name(code: 'ar', value: 'متر')
      ],
    ),
    KW(
      id: 'kilometer',
      names: <Name>[
        Name(code: 'en', value: 'Kilometer'),
        Name(code: 'ar', value: 'كيلومتر')
      ],
    ),
    KW(
      id: 'inch',
      names: <Name>[
        Name(code: 'en', value: 'inch'),
        Name(code: 'ar', value: 'بوصة')
      ],
    ),
    KW(
      id: 'feet',
      names: <Name>[
        Name(code: 'en', value: 'feet'),
        Name(code: 'ar', value: 'قدم')
      ],
    ),
    KW(
      id: 'yard',
      names: <Name>[
        Name(code: 'en', value: 'yard'),
        Name(code: 'ar', value: 'ياردة')
      ],
    ),
    KW(
      id: 'mile',
      names: <Name>[
        Name(code: 'en', value: 'mile'),
        Name(code: 'ar', value: 'ميل')
      ],
    ),
  ],
);
const Chain footPrint = Chain(
  id: 'footPrint',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Footprint'),
    Name(code: 'ar', value: 'مساحة الأرضية')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain areaMeasureUnit = Chain(
  id: 'areaMeasureUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Area measurement unit'),
    Name(code: 'ar', value: 'وحدة القياس المساحة')
  ],
  sons: <KW>[
    KW(
      id: 'square_meter',
      names: <Name>[
        Name(code: 'en', value: 'm²'),
        Name(code: 'ar', value: 'م²')
      ],
    ),
    KW(
      id: 'square_Kilometer',
      names: <Name>[
        Name(code: 'en', value: 'Km²'),
        Name(code: 'ar', value: 'كم²')
      ],
    ),
    KW(
      id: 'square_feet',
      names: <Name>[
        Name(code: 'en', value: 'ft²'),
        Name(code: 'ar', value: 'قدم²')
      ],
    ),
    KW(
      id: 'square_yard',
      names: <Name>[
        Name(code: 'en', value: 'yd²'),
        Name(code: 'ar', value: 'ياردة²')
      ],
    ),
    KW(
      id: 'acre',
      names: <Name>[
        Name(code: 'en', value: 'Acre'),
        Name(code: 'ar', value: 'فدان')
      ],
    ),
    KW(
      id: 'hectare',
      names: <Name>[
        Name(code: 'en', value: 'Hectare'),
        Name(code: 'ar', value: 'هكتار')
      ],
    ),
  ],
);
const Chain volume = Chain(
  id: 'volume',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Volume'),
    Name(code: 'ar', value: 'الحجم')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain volumeMeasurementUnit = Chain(
  id: 'volumeMeasurementUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Volume measurement unit'),
    Name(code: 'ar', value: 'وحدة قياس الحجم')
  ],
  sons: <KW>[
    KW(
      id: 'cubic_cm',
      names: <Name>[
        Name(code: 'en', value: 'cm³'),
        Name(code: 'ar', value: 'سم³')
      ],
    ),
    KW(
      id: 'cubic_m',
      names: <Name>[
        Name(code: 'en', value: 'm³'),
        Name(code: 'ar', value: 'م³')
      ],
    ),
    KW(
      id: 'millilitre',
      names: <Name>[
        Name(code: 'en', value: 'ml'),
        Name(code: 'ar', value: 'مم')
      ],
    ),
    KW(
      id: 'litre',
      names: <Name>[
        Name(code: 'en', value: 'L'),
        Name(code: 'ar', value: 'لتر')
      ],
    ),
    KW(
      id: 'fluidOunce',
      names: <Name>[
        Name(code: 'en', value: 'fl oz'),
        Name(code: 'ar', value: 'أونصة سائلة')
      ],
    ),
    KW(
      id: 'gallon',
      names: <Name>[
        Name(code: 'en', value: 'gal'),
        Name(code: 'ar', value: 'جالون')
      ],
    ),
    KW(
      id: 'cubic_inch',
      names: <Name>[
        Name(code: 'en', value: 'inch³'),
        Name(code: 'ar', value: 'بوصة مكعبة')
      ],
    ),
    KW(
      id: 'cubic_feet',
      names: <Name>[
        Name(code: 'en', value: 'feet³'),
        Name(code: 'ar', value: 'قدم مكعب')
      ],
    ),
  ],
);
const Chain weight = Chain(
  id: 'weight',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Weight'),
    Name(code: 'ar', value: 'الوزن')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain weightMeasurementUnit = Chain(
  id: 'weightMeasurementUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Weight measurement unit'),
    Name(code: 'ar', value: 'وحدة قياس الوزن')
  ],
  sons: <KW>[
    KW(
      id: 'ounce',
      names: <Name>[
        Name(code: 'en', value: 'oz'),
        Name(code: 'ar', value: 'أونصة')
      ],
    ),
    KW(
      id: 'pound',
      names: <Name>[
        Name(code: 'en', value: 'lb'),
        Name(code: 'ar', value: 'رطل')
      ],
    ),
    KW(
      id: 'ton',
      names: <Name>[
        Name(code: 'en', value: 'ton'),
        Name(code: 'ar', value: 'طن')
      ],
    ),
    KW(
      id: 'gram',
      names: <Name>[
        Name(code: 'en', value: 'gm'),
        Name(code: 'ar', value: 'جرام')
      ],
    ),
    KW(
      id: 'kilogram',
      names: <Name>[
        Name(code: 'en', value: 'kg'),
        Name(code: 'ar', value: 'كج')
      ],
    ),
  ],
);
const Chain count = Chain(
  id: 'count',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Count'),
    Name(code: 'ar', value: 'العدد')
  ],
  sons: DataCreator.integerIncrementer,
);
const Chain size = Chain(
  id: 'size',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Size'),
    Name(code: 'ar', value: 'المقاس')
  ],
  sons: <KW>[
    KW(
      id: 'xxxSmall',
      names: <Name>[
        Name(code: 'en', value: '3xs'),
        Name(code: 'ar', value: '3xs')
      ],
    ),
    KW(
      id: 'xxSmall',
      names: <Name>[
        Name(code: 'en', value: '2xs'),
        Name(code: 'ar', value: '2xs')
      ],
    ),
    KW(
      id: 'xSmall',
      names: <Name>[
        Name(code: 'en', value: 'xs'),
        Name(code: 'ar', value: 'xs')
      ],
    ),
    KW(
      id: 'small',
      names: <Name>[Name(code: 'en', value: 's'), Name(code: 'ar', value: 's')],
    ),
    KW(
      id: 'medium',
      names: <Name>[Name(code: 'en', value: 'm'), Name(code: 'ar', value: 'm')],
    ),
    KW(
      id: 'large',
      names: <Name>[Name(code: 'en', value: 'L'), Name(code: 'ar', value: 'L')],
    ),
    KW(
      id: 'xLarge',
      names: <Name>[
        Name(code: 'en', value: 'xL'),
        Name(code: 'ar', value: 'xL')
      ],
    ),
    KW(
      id: 'xxLarge',
      names: <Name>[
        Name(code: 'en', value: 'xxL'),
        Name(code: 'ar', value: 'xxL')
      ],
    ),
    KW(
      id: 'xxxLarge',
      names: <Name>[
        Name(code: 'en', value: 'xxxL'),
        Name(code: 'ar', value: 'xxxL')
      ],
    ),
  ],
);
// ------------------------------------------
/// ELECTRICAL ANATOMY
const Chain wattage = Chain(
  id: 'wattage',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Watt'),
    Name(code: 'ar', value: 'وات')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain voltage = Chain(
  id: 'voltage',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'volt'),
    Name(code: 'ar', value: 'فولت')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain ampere = Chain(
  id: 'ampere',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'amps'),
    Name(code: 'ar', value: 'أمبير')
  ],
  sons: DataCreator.doubleCreator,
);
// ------------------------------------------
/// LOGISTICS ANATOMY
const Chain inStock = Chain(
  id: 'inStock',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'In Stock'),
    Name(code: 'ar', value: 'متوفر في المخزون')
  ],
  sons: DataCreator.boolSwitch,
);
const Chain deliveryAvailable = Chain(
  id: 'deliveryAvailable',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Available delivery'),
    Name(code: 'ar', value: 'التوصيل متوفر')
  ],
  sons: DataCreator.boolSwitch,
);
const Chain deliveryDuration = Chain(
  id: 'deliveryMinDuration',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Delivery duration'),
    Name(code: 'ar', value: 'فترة التوصيل')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain deliveryDurationUnit = Chain(
  id: 'deliveryDurationUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Delivery duration unit'),
    Name(code: 'ar', value: 'مقياس فترة التوصيل')
  ],
  sons: <KW>[
    KW(
      id: 'hour',
      names: <Name>[
        Name(code: 'en', value: 'hour'),
        Name(code: 'ar', value: 'ساعة')
      ],
    ),
    KW(
      id: 'day',
      names: <Name>[
        Name(code: 'en', value: 'day'),
        Name(code: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'week',
      names: <Name>[
        Name(code: 'en', value: 'week'),
        Name(code: 'ar', value: 'أسبوع')
      ],
    ),
  ],
);
// ------------------------------------------
/// PRODUCT INFO
const Chain madeIn = Chain(
  id: 'madeIn',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Made in'),
    Name(code: 'ar', value: 'صنع في')
  ],
  sons: null, // getCountriesAsKeywords()
);
const Chain warrantyDuration = Chain(
  id: 'insuranceDuration',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Warranty duration'),
    Name(code: 'ar', value: 'مدة الضمان')
  ],
  sons: DataCreator.doubleCreator,
);
const Chain warrantyDurationUnit = Chain(
  id: 'warrantyDurationUnit',
  icon: null,
  names: <Name>[
    Name(code: 'en', value: 'Warranty duration unit'),
    Name(code: 'ar', value: 'وحدة قياس مدة الضمان')
  ],
  sons: <KW>[
    KW(
      id: 'hour',
      names: <Name>[
        Name(code: 'en', value: 'hour'),
        Name(code: 'ar', value: 'ساعة')
      ],
    ),
    KW(
      id: 'day',
      names: <Name>[
        Name(code: 'en', value: 'day'),
        Name(code: 'ar', value: 'يوم')
      ],
    ),
    KW(
      id: 'week',
      names: <Name>[
        Name(code: 'en', value: 'week'),
        Name(code: 'ar', value: 'أسبوع')
      ],
    ),
    KW(
      id: 'year',
      names: <Name>[
        Name(code: 'en', value: 'year'),
        Name(code: 'ar', value: 'سنة')
      ],
    ),
  ],
);
// ------------------------------------------
