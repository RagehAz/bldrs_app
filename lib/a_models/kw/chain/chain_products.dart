import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainProducts {

  static const Chain chain = Chain(
    id: 'products',
    icon: Iconz.bxProductsOff,
    phraseID: 'phid_k_products_keywords',
    sons: <Chain>[

      /*

      // -----------------------------------------------
      /// Appliances
      Chain(
        id: 'group_prd_appliances',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Appliances'),
          Phrase(langCode: 'ar', value: 'أجهزة كهربائية')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Waste Disposal Appliances
          Chain(
            id: 'sub_prd_app_wasteDisposal',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Waste Disposal Appliances'),
              Phrase(langCode: 'ar', value: 'أجهزة تخلص من النفايات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_waste_compactor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Trash compactor'),
                  Phrase(langCode: 'ar', value: 'حاويات ضغط قمامة')
                ],
              ),
              KW(
                id: 'prd_app_waste_disposer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Food waste disposers'),
                  Phrase(langCode: 'ar', value: 'مطاحن فضلات طعام')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Snacks Appliances
          Chain(
            id: 'sub_prd_app_snacks',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Snacks Appliances'),
              Phrase(langCode: 'ar', value: 'أجهزة تحضير وجبات خفيفة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_snack_icecream',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ice cream makers'),
                  Phrase(langCode: 'ar', value: 'ماكينات آيس كريم')
                ],
              ),
              KW(
                id: 'prd_app_snack_popcorn',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Popcorn makers'),
                  Phrase(langCode: 'ar', value: 'ماكينات فشار')
                ],
              ),
              KW(
                id: 'prd_app_snack_toaster',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Toasters'),
                  Phrase(langCode: 'ar', value: 'محمصة خبز')
                ],
              ),
              KW(
                id: 'prd_app_snack_waffle',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Waffle makers'),
                  Phrase(langCode: 'ar', value: 'ماكينات وافل')
                ],
              ),
              KW(
                id: 'prd_app_snack_bread',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bread machine'),
                  Phrase(langCode: 'ar', value: 'ماكينات خبز')
                ],
              ),
              KW(
                id: 'prd_app_snack_canOpener',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Can opener'),
                  Phrase(langCode: 'ar', value: 'فواتح معلبات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Refrigeration
          Chain(
            id: 'sub_prd_app_refrigeration',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Refrigeration'),
              Phrase(langCode: 'ar', value: 'مبردات و ثلاجات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_ref_fridge',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fridges'),
                  Phrase(langCode: 'ar', value: 'ثلاجات')
                ],
              ),
              KW(
                id: 'prd_app_ref_freezer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Freezers'),
                  Phrase(langCode: 'ar', value: 'ثلاجات تجميد')
                ],
              ),
              KW(
                id: 'prd_app_ref_icemaker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ice makers'),
                  Phrase(langCode: 'ar', value: 'ماكينات ثلج')
                ],
              ),
              KW(
                id: 'prd_app_ref_water',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Water Dispensers'),
                  Phrase(langCode: 'ar', value: 'كولدير مياه')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Cooking
          Chain(
            id: 'sub_prd_app_outdoorCooking',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Outdoor Cooking'),
              Phrase(langCode: 'ar', value: 'أجهزة طبخ خارجي')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_outcook_grill',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Grills'),
                  Phrase(langCode: 'ar', value: 'شوايات و أفران خارجية')
                ],
              ),
              KW(
                id: 'prd_app_outcook_grillTools',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Grill tools and accessories'),
                  Phrase(langCode: 'ar', value: 'أدوات و اكسسوارات شوي')
                ],
              ),
              KW(
                id: 'prd_app_outcook_oven',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoors Ovens'),
                  Phrase(langCode: 'ar', value: 'أفران خارجية')
                ],
              ),
              KW(
                id: 'prd_app_outcook_smoker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Smokers'),
                  Phrase(langCode: 'ar', value: 'أفران مدخنة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Media Appliances
          Chain(
            id: 'sub_prd_app_media',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Media Appliances'),
              Phrase(langCode: 'ar', value: 'أجهزة ميديا')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_media_tv',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Televisions'),
                  Phrase(langCode: 'ar', value: 'تلفزيونات و شاشات')
                ],
              ),
              KW(
                id: 'prd_app_media_soundSystem',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sound systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة صوت')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Indoor Cooking
          Chain(
            id: 'sub_prd_app_indoorCooking',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Indoor Cooking'),
              Phrase(langCode: 'ar', value: 'أجهزة طبخ داخلي')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_incook_microwave',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Microwave ovens'),
                  Phrase(langCode: 'ar', value: 'فرن مايكرويف')
                ],
              ),
              KW(
                id: 'prd_app_incook_fryer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fryers'),
                  Phrase(langCode: 'ar', value: 'قلايات')
                ],
              ),
              KW(
                id: 'prd_app_incook_elecGrill',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Electric grills'),
                  Phrase(langCode: 'ar', value: 'شوايات كهربائية')
                ],
              ),
              KW(
                id: 'prd_app_incook_cooktop',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cooktops'),
                  Phrase(langCode: 'ar', value: 'بوتاجاز سطحي')
                ],
              ),
              KW(
                id: 'prd_app_incook_range',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gas & Electric ranges'),
                  Phrase(langCode: 'ar', value: 'بوتاجاز كهربائي أو غاز')
                ],
              ),
              KW(
                id: 'prd_app_incook_oven',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gas & Electric Ovens'),
                  Phrase(langCode: 'ar', value: 'فرن كهربائي أو غاز')
                ],
              ),
              KW(
                id: 'prd_app_incook_hood',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Range hoods & vents'),
                  Phrase(langCode: 'ar', value: 'شفاطات بوتاجاز')
                ],
              ),
              KW(
                id: 'prd_app_incook_skillet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Electric skillets'),
                  Phrase(langCode: 'ar', value: 'مقلاه كهربائية')
                ],
              ),
              KW(
                id: 'prd_app_incook_rooster',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Electric roaster ovens'),
                  Phrase(langCode: 'ar', value: 'فرن شواء')
                ],
              ),
              KW(
                id: 'prd_app_incook_hotPlate',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hot plates & burners'),
                  Phrase(langCode: 'ar', value: 'مواقد و لوحات ساخنة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// HouseKeeping Appliances
          Chain(
            id: 'sub_prd_app_housekeeping',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'HouseKeeping Appliances'),
              Phrase(langCode: 'ar', value: 'أجهزة غسيل و نظافة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_hk_washingMachine',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Washing & Drying machines'),
                  Phrase(langCode: 'ar', value: 'مغاسل و مناشف ملابس')
                ],
              ),
              KW(
                id: 'prd_app_hk_dishWasher',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dish washer'),
                  Phrase(langCode: 'ar', value: 'مغسلة صحون')
                ],
              ),
              KW(
                id: 'prd_app_hk_warmingDrawers',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Warming drawers'),
                  Phrase(langCode: 'ar', value: 'أدراج تدفئة')
                ],
              ),
              KW(
                id: 'prd_app_hk_vacuum',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vacuum cleaner'),
                  Phrase(langCode: 'ar', value: 'مكانس كهربائية')
                ],
              ),
              KW(
                id: 'prd_app_hk_iron',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Irons'),
                  Phrase(langCode: 'ar', value: 'مكواه ')
                ],
              ),
              KW(
                id: 'prd_app_hk_steamer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Garment steamers'),
                  Phrase(langCode: 'ar', value: 'مكواه بخارية')
                ],
              ),
              KW(
                id: 'prd_app_hk_carpet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Carpet cleaners'),
                  Phrase(langCode: 'ar', value: 'مغاسل سجاد')
                ],
              ),
              KW(
                id: 'prd_app_hk_sewing',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sewing machines'),
                  Phrase(langCode: 'ar', value: 'ماكينات خياطة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Food Processors
          Chain(
            id: 'sub_prd_app_foodProcessors',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Food Processors'),
              Phrase(langCode: 'ar', value: 'محضرات طعام')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_pro_slowCooker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Slow cookers'),
                  Phrase(langCode: 'ar', value: 'مواقد بطيئة')
                ],
              ),
              KW(
                id: 'prd_app_pro_pro',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Food processor'),
                  Phrase(langCode: 'ar', value: 'أجهزة معالجة للطعام')
                ],
              ),
              KW(
                id: 'prd_app_pro_meat',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Meat grinders'),
                  Phrase(langCode: 'ar', value: 'مطاحن لحوم')
                ],
              ),
              KW(
                id: 'prd_app_pro_rice',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rice cookers & steamers'),
                  Phrase(langCode: 'ar', value: 'حلل طهي أرز')
                ],
              ),
              KW(
                id: 'prd_app_pro_dehydrator',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Food Dehydrators'),
                  Phrase(langCode: 'ar', value: 'مجففات طعام')
                ],
              ),
              KW(
                id: 'prd_app_pro_mixer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Food Mixers'),
                  Phrase(langCode: 'ar', value: 'آلة عجن و خلط')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Drinks Appliances
          Chain(
            id: 'sub_prd_app_drinks',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Drinks Appliances'),
              Phrase(langCode: 'ar', value: 'أجهزة تحضير مشروبات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_drink_coffeeMaker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Coffee maker'),
                  Phrase(langCode: 'ar', value: 'ماكينات قهوة')
                ],
              ),
              KW(
                id: 'prd_app_drink_coffeeGrinder',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Coffee grinder'),
                  Phrase(langCode: 'ar', value: 'مطاحن قهوة')
                ],
              ),
              KW(
                id: 'prd_app_drink_espresso',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Espresso machine'),
                  Phrase(langCode: 'ar', value: 'ماكينات اسبريسو')
                ],
              ),
              KW(
                id: 'prd_app_drink_blender',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Blender'),
                  Phrase(langCode: 'ar', value: 'خلاطات')
                ],
              ),
              KW(
                id: 'prd_app_drink_juicer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Juicers'),
                  Phrase(langCode: 'ar', value: 'عصارات')
                ],
              ),
              KW(
                id: 'prd_app_drink_kettle',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Boilers / Kettles'),
                  Phrase(langCode: 'ar', value: 'غلايات و سخانات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bathroom Appliances
          Chain(
            id: 'sub_prd_app_bathroom',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Bathroom Appliances'),
              Phrase(langCode: 'ar', value: 'أجهزة حمام كهربائية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_app_bath_handDryer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hand dryer'),
                  Phrase(langCode: 'ar', value: 'منشفة أيدي')
                ],
              ),
              KW(
                id: 'prd_app_bath_hairDryer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hair dryer'),
                  Phrase(langCode: 'ar', value: 'سشوار شعر')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Doors & Windows
      Chain(
        id: 'group_prd_doors',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Doors & Windows'),
          Phrase(langCode: 'ar', value: 'أبواب و شبابيك')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Windows
          Chain(
            id: 'sub_prd_door_windows',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Windows'),
              Phrase(langCode: 'ar', value: 'شبابيك')
            ],
            sons: <KW>[
              KW(
                id: 'prd_doors_win_glassPanel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Window panels'),
                  Phrase(langCode: 'ar', value: 'قطاعات شبابيك')
                ],
              ),
              KW(
                id: 'prd_doors_win_skyLight',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Skylights'),
                  Phrase(langCode: 'ar', value: 'قطاعات شبابيك سقفية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Shutters
          Chain(
            id: 'sub_prd_doors_shutters',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Shutters'),
              Phrase(langCode: 'ar', value: 'شيش حصيرة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_doors_shutters_metal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Metal shutters'),
                  Phrase(langCode: 'ar', value: 'شيش حصيرة معدني')
                ],
              ),
              KW(
                id: 'prd_doors_shutters_aluminum',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Aluminum shutters'),
                  Phrase(langCode: 'ar', value: 'شيش حصيرة ألومنيوم')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Hardware
          Chain(
            id: 'sub_prd_door_hardware',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Hardware'),
              Phrase(langCode: 'ar', value: 'اكسسوارات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_doors_hardware_hinges',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hinges & Accessories'),
                  Phrase(langCode: 'ar', value: 'مفصلات و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_doorbell',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door Chimes'),
                  Phrase(langCode: 'ar', value: 'أجراس أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_entrySet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door Entry sets'),
                  Phrase(langCode: 'ar', value: 'أطقم مقابض أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_lever',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door levers'),
                  Phrase(langCode: 'ar', value: 'أكر أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_knob',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door knobs'),
                  Phrase(langCode: 'ar', value: 'مقابض أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_knocker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door knockers'),
                  Phrase(langCode: 'ar', value: 'مطارق أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_lock',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door locks'),
                  Phrase(langCode: 'ar', value: 'أقفال أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_stop',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door stops & bumpers'),
                  Phrase(langCode: 'ar', value: 'مصدات أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_sliding',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sliding doors systems'),
                  Phrase(langCode: 'ar', value: 'مجاري أبواب منزلقة')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_hook',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door hooks'),
                  Phrase(langCode: 'ar', value: 'كلّاب أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_eye',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door eye'),
                  Phrase(langCode: 'ar', value: 'عيون أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_sign',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door signs'),
                  Phrase(langCode: 'ar', value: 'لافتات أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_dust',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door dust draught'),
                  Phrase(langCode: 'ar', value: 'فرشاة تراب ')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_closer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door closers'),
                  Phrase(langCode: 'ar', value: 'غالقات أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_tint',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Window tint films'),
                  Phrase(langCode: 'ar', value: 'أفلام زجاج شبابيك')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Doors
          Chain(
            id: 'sub_prd_door_doors',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Doors'),
              Phrase(langCode: 'ar', value: 'أبواب')
            ],
            sons: <KW>[
              KW(
                id: 'prd_doors_doors_front',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Front doors'),
                  Phrase(langCode: 'ar', value: 'أبواب أمامية')
                ],
              ),
              KW(
                id: 'prd_doors_doors_interior',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Interior doors'),
                  Phrase(langCode: 'ar', value: 'أبواب داخلية')
                ],
              ),
              KW(
                id: 'prd_doors_doors_folding',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Folding &  Accordion doors'),
                  Phrase(langCode: 'ar', value: 'أبواب قابلة للطي و أكورديون')
                ],
              ),
              KW(
                id: 'prd_doors_doors_shower',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower doors'),
                  Phrase(langCode: 'ar', value: 'أبواب دش استحمام')
                ],
              ),
              KW(
                id: 'prd_doors_doors_patio',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Patio & Sliding doors'),
                  Phrase(langCode: 'ar', value: 'أبواب تراس منزلقة')
                ],
              ),
              KW(
                id: 'prd_doors_doors_screen',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Screen & Mesh doors'),
                  Phrase(langCode: 'ar', value: 'أبواب سلك شبكي')
                ],
              ),
              KW(
                id: 'prd_doors_doors_garage',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Garage doors'),
                  Phrase(langCode: 'ar', value: 'أبواب جراج')
                ],
              ),
              KW(
                id: 'prd_doors_doors_metalGate',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Metal gates'),
                  Phrase(langCode: 'ar', value: 'بوابات معدنية')
                ],
              ),
              KW(
                id: 'prd_doors_doors_escape',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Escape doors'),
                  Phrase(langCode: 'ar', value: 'أبواب هروب')
                ],
              ),
              KW(
                id: 'prd_doors_doors_blast',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Blast proof doors'),
                  Phrase(langCode: 'ar', value: 'أبواب مقاومة للإنفجار')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Electricity
      Chain(
        id: 'group_prd_electricity',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Electricity'),
          Phrase(langCode: 'ar', value: 'كهرباء')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Power Storage
          Chain(
            id: 'sub_prd_elec_powerStorage',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Power Storage'),
              Phrase(langCode: 'ar', value: 'تخزين كهرباء')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_storage_rechargeable',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rechargeable batteries'),
                  Phrase(langCode: 'ar', value: 'بطاريات قابلة للشحن')
                ],
              ),
              KW(
                id: 'prd_elec_storage_nonRechargeable',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Non Rechargeable batteries'),
                  Phrase(langCode: 'ar', value: 'بطاريات غير قابلة للشحن')
                ],
              ),
              KW(
                id: 'prd_elec_storage_accessories',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Battery accessories'),
                  Phrase(langCode: 'ar', value: 'اكسسوارات بطاريات')
                ],
              ),
              KW(
                id: 'prd_elec_storage_portable',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Portable power storage'),
                  Phrase(langCode: 'ar', value: 'تخزين طاقة متنقل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electricity Organizers
          Chain(
            id: 'sub_prd_elec_organization',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Electricity Organizers'),
              Phrase(langCode: 'ar', value: 'منسقات كهربائية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_org_load',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Load centers'),
                  Phrase(langCode: 'ar', value: 'مراكز حمل كهربي')
                ],
              ),
              KW(
                id: 'prd_elec_org_conduit',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Conduit & fittings'),
                  Phrase(langCode: 'ar', value: 'خراطيم كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_org_junction',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Junction boxes & covers'),
                  Phrase(langCode: 'ar', value: 'بواط توزيع كهرباء و أغطيتها')
                ],
              ),
              KW(
                id: 'prd_elec_org_hook',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hooks & cable organizers'),
                  Phrase(langCode: 'ar', value: 'خطافات و منظمات أسلاك')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electricity Instruments
          Chain(
            id: 'sub_prd_elec_instruments',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Electricity Instruments'),
              Phrase(langCode: 'ar', value: 'أجهزة كهربائية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_instr_factor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power factor controllers'),
                  Phrase(langCode: 'ar', value: 'منظمات عامل طاقة')
                ],
              ),
              KW(
                id: 'prd_elec_instr_measure',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power measurement devices'),
                  Phrase(langCode: 'ar', value: 'أجهزة قياس كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_instr_clamp',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power clamp meters'),
                  Phrase(langCode: 'ar', value: 'أجهزة قياس كهرباء كلّابة معلقة')
                ],
              ),
              KW(
                id: 'prd_elec_instr_powerMeter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power meters'),
                  Phrase(langCode: 'ar', value: 'عداد كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_instr_resistance',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Resistance testers'),
                  Phrase(langCode: 'ar', value: 'فاحص مقاومة')
                ],
              ),
              KW(
                id: 'prd_elec_instr_transformer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Transformers'),
                  Phrase(langCode: 'ar', value: 'محولات كهربائية')
                ],
              ),
              KW(
                id: 'prd_elec_instr_frequency',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Frequency inverters'),
                  Phrase(langCode: 'ar', value: 'عاكس تردد')
                ],
              ),
              KW(
                id: 'prd_elec_instr_relay',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Current relays'),
                  Phrase(langCode: 'ar', value: 'ممررات تيار كهربي')
                ],
              ),
              KW(
                id: 'prd_elec_inst_dc',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power supplies'),
                  Phrase(langCode: 'ar', value: 'مزودات طاقة')
                ],
              ),
              KW(
                id: 'prd_elec_inst_inverter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power inverters'),
                  Phrase(langCode: 'ar', value: 'محولات طاقة')
                ],
              ),
              KW(
                id: 'prd_elec_inst_regulator',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Voltage regulators'),
                  Phrase(langCode: 'ar', value: 'منظمات جهد كهربي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electricity Generators
          Chain(
            id: 'sub_prd_elec_generators',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Electricity Generators'),
              Phrase(langCode: 'ar', value: 'مولدات كهرباء')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_gen_solar',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Solar power'),
                  Phrase(langCode: 'ar', value: 'طاقة شمسية')
                ],
              ),
              KW(
                id: 'prd_elec_gen_wind',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wind power'),
                  Phrase(langCode: 'ar', value: 'طاقة رياح')
                ],
              ),
              KW(
                id: 'prd_elec_gen_hydro',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hydro power'),
                  Phrase(langCode: 'ar', value: 'طاقة تيارات')
                ],
              ),
              KW(
                id: 'prd_elec_gen_steam',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Steam power'),
                  Phrase(langCode: 'ar', value: 'طاقة بخار')
                ],
              ),
              KW(
                id: 'prd_elec_gen_diesel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Diesel power'),
                  Phrase(langCode: 'ar', value: 'طاقة ديزل')
                ],
              ),
              KW(
                id: 'prd_elec_gen_gasoline',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gasoline power'),
                  Phrase(langCode: 'ar', value: 'طاقة بنزين')
                ],
              ),
              KW(
                id: 'prd_elec_gen_gas',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Natural gas power'),
                  Phrase(langCode: 'ar', value: 'طاقة غاز طبيعي')
                ],
              ),
              KW(
                id: 'prd_elec_gen_hydrogen',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hydrogen power'),
                  Phrase(langCode: 'ar', value: 'طاقة هيدروجين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electrical Switches
          Chain(
            id: 'sub_prd_elec_switches',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Electrical Switches'),
              Phrase(langCode: 'ar', value: 'مفاتيح كهربائية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_switches_outlet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall switches & Outlets'),
                  Phrase(langCode: 'ar', value: 'مفاتيح كهربائية و إضاءة')
                ],
              ),
              KW(
                id: 'prd_elec_switches_thermostat',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Thermostats'),
                  Phrase(langCode: 'ar', value: 'ترموستات منظم حرارة')
                ],
              ),
              KW(
                id: 'prd_elec_switches_dimmer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dimmers'),
                  Phrase(langCode: 'ar', value: 'متحكم و معتم قوة الإضاءة')
                ],
              ),
              KW(
                id: 'prd_elec_switches_plate',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Switch plates & outlet covers'),
                  Phrase(langCode: 'ar', value: 'لوحات و أغطية كهربائية')
                ],
              ),
              KW(
                id: 'prd_elec_switches_circuit',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Circuit breakers & fuses'),
                  Phrase(langCode: 'ar', value: 'قواطع و فيوزات كهربائية')
                ],
              ),
              KW(
                id: 'prd_elec_switches_doorbell',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Doorbells'),
                  Phrase(langCode: 'ar', value: 'أجراس أبواب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electrical Motors
          Chain(
            id: 'sub_prd_elec_motors',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Electrical Motors'),
              Phrase(langCode: 'ar', value: 'مواتير كهربائية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_motor_ac',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'AC motors'),
                  Phrase(langCode: 'ar', value: 'مواتير تيار متردد')
                ],
              ),
              KW(
                id: 'prd_elec_motor_dc',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'DC motors'),
                  Phrase(langCode: 'ar', value: 'مواتير تيار ثابت')
                ],
              ),
              KW(
                id: 'prd_elec_motor_vibro',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vibration motors'),
                  Phrase(langCode: 'ar', value: 'مواتير اهتزاز')
                ],
              ),
              KW(
                id: 'prd_elec_motor_controller',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Motor controllers & drivers'),
                  Phrase(langCode: 'ar', value: 'متحكمات مواتير')
                ],
              ),
              KW(
                id: 'prd_elec_motor_part',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Motor parts'),
                  Phrase(langCode: 'ar', value: 'أجزاء مواتير')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electrical Connectors
          Chain(
            id: 'sub_prd_elec_connectors',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Electrical Connectors'),
              Phrase(langCode: 'ar', value: 'وصلات كهربائية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_connectors_alligator',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Alligator clips'),
                  Phrase(langCode: 'ar', value: 'مقلمة تمساح')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_connector',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power connectors'),
                  Phrase(langCode: 'ar', value: 'لقم توصيل')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_terminal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Terminals & accessories'),
                  Phrase(langCode: 'ar', value: 'أقطاب و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_strip',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Power strips'),
                  Phrase(langCode: 'ar', value: 'مشترك كهربائي')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_socket',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sockets & plugs'),
                  Phrase(langCode: 'ar', value: 'مقابس كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_adapter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Adapters'),
                  Phrase(langCode: 'ar', value: 'محولات كهربائية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cables & Wires
          Chain(
            id: 'sub_prd_elec_cables',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Cables & Wires'),
              Phrase(langCode: 'ar', value: 'كابلات أسلاك')
            ],
            sons: <KW>[
              KW(
                id: 'prd_elec_cables_wire',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cables & Wires'),
                  Phrase(langCode: 'ar', value: 'أسلاك')
                ],
              ),
              KW(
                id: 'prd_elec_cables_extension',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Extension cables'),
                  Phrase(langCode: 'ar', value: 'أسلاك إطالة')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Fire Fighting
      Chain(
        id: 'group_prd_fireFighting',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Fire Fighting'),
          Phrase(langCode: 'ar', value: 'مقاومة حريق')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Pumps & Controllers
          Chain(
            id: 'sub_prd_fire_pumpsCont',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Pumps & Controllers'),
              Phrase(langCode: 'ar', value: 'مضخات و متحكمات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_fireFighting_pump_pump',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire pumps'),
                  Phrase(langCode: 'ar', value: 'مضخات حريق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_filter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Filtration systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة تصفية مياه')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_system',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wet systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة إطفاء سائلة')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_foamSystems',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Foam & Powder based systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة إطفاء فوم و بودرة')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_gasSystems',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gas based systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة إطفاء غازية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fire Fighting Equipment
          Chain(
            id: 'sub_prd_fire_equip',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Fire Fighting Equipment'),
              Phrase(langCode: 'ar', value: 'معدات مكافحة حريق')
            ],
            sons: <KW>[
              KW(
                id: 'prd_fireFighting_equip_hydrant',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire hydrants'),
                  Phrase(langCode: 'ar', value: 'صنبور إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_extinguisher',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire Extinguishers'),
                  Phrase(langCode: 'ar', value: 'طفاية حريق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_pipe',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pipes, Valves & Risers'),
                  Phrase(langCode: 'ar', value: 'مواسير، مفاتيح، صواعد')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_reel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Reels & Cabinets'),
                  Phrase(langCode: 'ar', value: 'بكرة خرطوم حريق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_hose',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hoses & Accessories'),
                  Phrase(langCode: 'ar', value: 'خراطيم حريق و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_curtains',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire curtains'),
                  Phrase(langCode: 'ar', value: 'ستائر حريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fire Fighting Cloth
          Chain(
            id: 'sub_prd_fire_clothes',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Fire Fighting Cloth'),
              Phrase(langCode: 'ar', value: 'ملابس مكافحة حريق')
            ],
            sons: <KW>[
              KW(
                id: 'prd_fireFighting_equip_suit',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Suits'),
                  Phrase(langCode: 'ar', value: 'بدلة إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_helmet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Helmets & hoods'),
                  Phrase(langCode: 'ar', value: 'خوذة و أوشحة إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_glove',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gloves'),
                  Phrase(langCode: 'ar', value: 'قفازات إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_boots',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Boots'),
                  Phrase(langCode: 'ar', value: 'أحذية إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_torches',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drip torches'),
                  Phrase(langCode: 'ar', value: 'شعلة تنقيط')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_breathing',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Breathing apparatus'),
                  Phrase(langCode: 'ar', value: 'جهاز تنفس')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fire Detectors
          Chain(
            id: 'sub_prd_fire_detectors',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Fire Detectors'),
              Phrase(langCode: 'ar', value: 'كاشفات حريق')
            ],
            sons: <KW>[
              KW(
                id: 'prd_fireFighting_detectors_alarm',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire detection & Alarm systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة كشف و إنذار حرائق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_detectors_control',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Extinguishing control systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة تحكم إطفاء حرائق')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Floors & ٍSkirting
      Chain(
        id: 'group_prd_floors',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Floors & ٍSkirting'),
          Phrase(langCode: 'ar', value: 'أرضيات و وزر')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Skirting
          Chain(
            id: 'sub_prd_floors_skirting',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Skirting'),
              Phrase(langCode: 'ar', value: 'وزر')
            ],
            sons: <KW>[
              KW(
                id: 'prd_floors_skirting_skirting',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Floor skirting'),
                  Phrase(langCode: 'ar', value: 'وزر أرضيات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Tiles
          Chain(
            id: 'sub_prd_floors_tiles',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Floor Tiles'),
              Phrase(langCode: 'ar', value: 'بلاط أرضيات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_floors_tiles_ceramic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ceramic'),
                  Phrase(langCode: 'ar', value: 'سيراميك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_porcelain',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Porcelain'),
                  Phrase(langCode: 'ar', value: 'بورسلين')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_mosaic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mosaic'),
                  Phrase(langCode: 'ar', value: 'موزاييك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_stones',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Stones'),
                  Phrase(langCode: 'ar', value: 'حجر')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_marble',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Marble'),
                  Phrase(langCode: 'ar', value: 'رخام')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_granite',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Granite'),
                  Phrase(langCode: 'ar', value: 'جرانيت')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_interlock',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Interlock & brick tiles'),
                  Phrase(langCode: 'ar', value: 'إنترلوك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_cork',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cork tiles'),
                  Phrase(langCode: 'ar', value: 'كورك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_parquet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Parquet'),
                  Phrase(langCode: 'ar', value: 'باركيه')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_glass',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Acrylic & Glass tiles'),
                  Phrase(langCode: 'ar', value: 'زجاج و أكريليك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_grc',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'GRC tiles'),
                  Phrase(langCode: 'ar', value: 'جي آر سي')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_metal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Metal tiles'),
                  Phrase(langCode: 'ar', value: 'معادن')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_terrazzo',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Terrazzo tiles'),
                  Phrase(langCode: 'ar', value: 'تيرازو')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_medallions',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Floor Medallion & Inlays'),
                  Phrase(langCode: 'ar', value: 'ميدالية أرض')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Planks
          Chain(
            id: 'sub_prd_floors_planks',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Floor Planks'),
              Phrase(langCode: 'ar', value: 'ألواح أرضيات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_floors_planks_bamboo',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bamboo flooring'),
                  Phrase(langCode: 'ar', value: 'بامبو')
                ],
              ),
              KW(
                id: 'prd_floors_planks_engineered',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Engineered wood plank'),
                  Phrase(langCode: 'ar', value: 'ألواح خشب هندسية')
                ],
              ),
              KW(
                id: 'prd_floors_planks_hardwood',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hardwood plank'),
                  Phrase(langCode: 'ar', value: 'ألواح خب صلب')
                ],
              ),
              KW(
                id: 'prd_floors_planks_laminate',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Laminate plank'),
                  Phrase(langCode: 'ar', value: 'قشرة خشب')
                ],
              ),
              KW(
                id: 'prd_floors_planks_wpc',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'WPC plank'),
                  Phrase(langCode: 'ar', value: 'ألواح دبليو بي سي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Paving
          Chain(
            id: 'sub_prd_floors_paving',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Floor Paving'),
              Phrase(langCode: 'ar', value: 'تمهيد أرضيات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_floors_paving_screed',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cement screed'),
                  Phrase(langCode: 'ar', value: 'أرضية أسمنتية')
                ],
              ),
              KW(
                id: 'prd_floors_paving_epoxy',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Epoxy coating'),
                  Phrase(langCode: 'ar', value: 'إيبوكسي')
                ],
              ),
              KW(
                id: 'prd_floors_paving_asphalt',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Asphalt flooring'),
                  Phrase(langCode: 'ar', value: 'أسفلت')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Covering
          Chain(
            id: 'sub_prd_floors_covering',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Floor Covering'),
              Phrase(langCode: 'ar', value: 'تغطيات أرضيات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_floors_covering_vinyl',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vinyl flooring'),
                  Phrase(langCode: 'ar', value: 'فينيل')
                ],
              ),
              KW(
                id: 'prd_floors_covering_carpet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Carpet flooring'),
                  Phrase(langCode: 'ar', value: 'سجاد')
                ],
              ),
              KW(
                id: 'prd_floors_covering_raised',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Raised flooring'),
                  Phrase(langCode: 'ar', value: 'أرضية مرتفعة')
                ],
              ),
              KW(
                id: 'prd_floors_covering_rubber',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rubber mats'),
                  Phrase(langCode: 'ar', value: 'أرضية مطاط')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Furniture
      Chain(
        id: 'group_prd_furniture',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Furniture'),
          Phrase(langCode: 'ar', value: 'أثاث و مفروشات')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Waste Disposal
          Chain(
            id: 'sub_prd_furn_wasteDisposal',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Waste Disposal'),
              Phrase(langCode: 'ar', value: 'تخلص من النفايات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_waste_small',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Small trash cans'),
                  Phrase(langCode: 'ar', value: 'سلات قمامة صغيرة')
                ],
              ),
              KW(
                id: 'prd_furn_waste_large',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Large trash cans'),
                  Phrase(langCode: 'ar', value: 'سلات قمامة كبيرة')
                ],
              ),
              KW(
                id: 'prd_furn_waste_pull',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pullout trash bins'),
                  Phrase(langCode: 'ar', value: 'سلات قمامة منزلقة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Vanity Tops
          Chain(
            id: 'sub_prd_furn_tops',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Vanity Tops'),
              Phrase(langCode: 'ar', value: 'أسطح وحدات حمام و مطبخ')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_tops_bathVanity',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom vanity tops'),
                  Phrase(langCode: 'ar', value: 'مسطحات وحدات حمام')
                ],
              ),
              KW(
                id: 'prd_furn_tops_kit',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen counter tops'),
                  Phrase(langCode: 'ar', value: 'مسطحات و جوانب وحدات مطبخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Tables
          Chain(
            id: 'sub_prd_furn_tables',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Tables'),
              Phrase(langCode: 'ar', value: 'طاولات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_tables_dining',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dining tables'),
                  Phrase(langCode: 'ar', value: 'طاولات طعام')
                ],
              ),
              KW(
                id: 'prd_furn_tables_bistro',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pub & Bistro table'),
                  Phrase(langCode: 'ar', value: 'طاولات مقاهي')
                ],
              ),
              KW(
                id: 'prd_furn_tables_coffee',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Coffee table'),
                  Phrase(langCode: 'ar', value: 'طاولات قهوة')
                ],
              ),
              KW(
                id: 'prd_furn_tables_folding',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Folding table'),
                  Phrase(langCode: 'ar', value: 'طاولات قابلة للطي')
                ],
              ),
              KW(
                id: 'prd_furn_tables_console',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Console'),
                  Phrase(langCode: 'ar', value: 'كونسول')
                ],
              ),
              KW(
                id: 'prd_furn_tables_meeting',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Meeting tables'),
                  Phrase(langCode: 'ar', value: 'طاولات اجتماعات')
                ],
              ),
              KW(
                id: 'prd_furn_tables_side',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Side & End tables'),
                  Phrase(langCode: 'ar', value: 'طاولات جانبية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Seating Benches
          Chain(
            id: 'sub_prd_furn_seatingBench',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Seating Benches'),
              Phrase(langCode: 'ar', value: 'مجالس')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_bench_shower',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower benches & seats'),
                  Phrase(langCode: 'ar', value: 'مجالس دش استحمام')
                ],
              ),
              KW(
                id: 'prd_furn_bench_bedVanity',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vanity stools & benches'),
                  Phrase(langCode: 'ar', value: 'كراسي وحدة حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bench_bedBench',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bedroom benches'),
                  Phrase(langCode: 'ar', value: 'مجالس غرفة نوم')
                ],
              ),
              KW(
                id: 'prd_furn_bench_storage',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Accent & storage benches'),
                  Phrase(langCode: 'ar', value: 'مجالس تخزين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Planting
          Chain(
            id: 'sub_prd_furn_planting',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Planting'),
              Phrase(langCode: 'ar', value: 'زراعة منزلية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_planting_stand',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Plant stands'),
                  Phrase(langCode: 'ar', value: 'منصة نباتات')
                ],
              ),
              KW(
                id: 'prd_furn_planting_potting',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Potting tables'),
                  Phrase(langCode: 'ar', value: 'طاولات أصيص نبات')
                ],
              ),
              KW(
                id: 'prd_furn_planting_pot',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Plants pots'),
                  Phrase(langCode: 'ar', value: 'أصيص نبات')
                ],
              ),
              KW(
                id: 'prd_furn_planting_vase',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vases'),
                  Phrase(langCode: 'ar', value: 'مزهريات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Tables
          Chain(
            id: 'sub_prd_furn_outTables',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Outdoor Tables'),
              Phrase(langCode: 'ar', value: 'طاولات خارجية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_outTable_coffee',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Coffee tables'),
                  Phrase(langCode: 'ar', value: 'طاولات قهوة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outTable_side',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor side tables'),
                  Phrase(langCode: 'ar', value: 'طاولات جانبية خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outTable_dining',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor dining tables'),
                  Phrase(langCode: 'ar', value: 'طاولات طعام خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outTable_cart',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor serving carts'),
                  Phrase(langCode: 'ar', value: 'عربة تقديم خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Seating
          Chain(
            id: 'sub_prd_furn_outSeating',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Outdoor Seating'),
              Phrase(langCode: 'ar', value: 'مقاعد خارجية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_outSeat_lounge',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor lounge chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي معيشة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_dining',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor dining chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي مائدة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_bar',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor bar stools'),
                  Phrase(langCode: 'ar', value: 'كراسي بار خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_chaise',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Chaise Lounges'),
                  Phrase(langCode: 'ar', value: 'شيزلونج خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_glider',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor gliders'),
                  Phrase(langCode: 'ar', value: 'جلايدر خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_rocking',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Rocking chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي هزازة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_adirondack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Adirondack chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي أديرونداك خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_love',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor love seats'),
                  Phrase(langCode: 'ar', value: 'مجالس ثنائية خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_poolLounger',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pool lounger'),
                  Phrase(langCode: 'ar', value: 'سرائر حمام سباحة')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_bench',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor benches'),
                  Phrase(langCode: 'ar', value: 'مجالس مسطحة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_swing',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor porch swings'),
                  Phrase(langCode: 'ar', value: 'كنب هزاز خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_sofa',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor sofas'),
                  Phrase(langCode: 'ar', value: 'أريكة خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Organizers
          Chain(
            id: 'sub_prd_furn_organizers',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Organizers'),
              Phrase(langCode: 'ar', value: 'منظمات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_org_shelf',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Display & wall shelves'),
                  Phrase(langCode: 'ar', value: 'أرفف عرض حائطي')
                ],
              ),
              KW(
                id: 'prd_furn_org_drawer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drawer organizers'),
                  Phrase(langCode: 'ar', value: 'منظمات أدراج')
                ],
              ),
              KW(
                id: 'prd_furn_org_closet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Closet Organizers'),
                  Phrase(langCode: 'ar', value: 'منظمات دولاب ملابس')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Office Furniture
          Chain(
            id: 'sub_prd_furn_office',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Office Furniture'),
              Phrase(langCode: 'ar', value: 'أثاث مكاتب')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_office_desk',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Office desks'),
                  Phrase(langCode: 'ar', value: 'مكاتب')
                ],
              ),
              KW(
                id: 'prd_furn_office_deskAccess',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Desk accessories'),
                  Phrase(langCode: 'ar', value: 'اكسسوارات مكاتب')
                ],
              ),
              KW(
                id: 'prd_furn_office_drafting',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drafting tables'),
                  Phrase(langCode: 'ar', value: 'طاولات رسم')
                ],
              ),
              KW(
                id: 'prd_furn_officeStore_filing',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Filing cabinets'),
                  Phrase(langCode: 'ar', value: 'كابينات ملفات')
                ],
              ),
              KW(
                id: 'prd_furn_officeStore_cart',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Office carts & stands'),
                  Phrase(langCode: 'ar', value: 'عربات مكاتب و منصات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Living Storage
          Chain(
            id: 'sub_prd_furn_livingStorage',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Living Storage'),
              Phrase(langCode: 'ar', value: 'خزائن غرفة معيشة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_living_blanket',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Blanket & Quilt racks'),
                  Phrase(langCode: 'ar', value: 'وحدات بطانية و لحاف')
                ],
              ),
              KW(
                id: 'prd_furn_living_chest',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Accent chests'),
                  Phrase(langCode: 'ar', value: 'وحدات صندوقية')
                ],
              ),
              KW(
                id: 'prd_furn_living_bookcase',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bookcases'),
                  Phrase(langCode: 'ar', value: 'مكاتب كتب')
                ],
              ),
              KW(
                id: 'prd_furn_living_media',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Media cabinets & TV tables'),
                  Phrase(langCode: 'ar', value: 'وحدات تلفزيون و ميديا')
                ],
              ),
              KW(
                id: 'prd_furn_living_mediaRack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Media racks'),
                  Phrase(langCode: 'ar', value: 'أرفف ميديا')
                ],
              ),
              KW(
                id: 'prd_furn_living_hallTree',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hall trees'),
                  Phrase(langCode: 'ar', value: 'شماعات القاعة')
                ],
              ),
              KW(
                id: 'prd_furn_living_barCart',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bar carts'),
                  Phrase(langCode: 'ar', value: 'عربات بار')
                ],
              ),
              KW(
                id: 'prd_furn_living_umbrella',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Coat racks & umbrella stands'),
                  Phrase(langCode: 'ar', value: 'شماعات معاطف و شمسيات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Laundry
          Chain(
            id: 'sub_prd_furn_laundry',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Laundry'),
              Phrase(langCode: 'ar', value: 'تجهيزات مغسلة ملابس')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_laundry_dryingRack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drying racks'),
                  Phrase(langCode: 'ar', value: 'أرفف تجفيف ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_laundry_ironingTable',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ironing table'),
                  Phrase(langCode: 'ar', value: 'طاولات كي ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_laundry_hamper',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Laundry hampers'),
                  Phrase(langCode: 'ar', value: 'سلات غسيل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kitchen Storage
          Chain(
            id: 'sub_prd_furn_kitchenStorage',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Kitchen Storage'),
              Phrase(langCode: 'ar', value: 'خزائن مطبخ')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_kitStore_cabinet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen cabinet'),
                  Phrase(langCode: 'ar', value: 'كابينات مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_pantry',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pantry cabinet'),
                  Phrase(langCode: 'ar', value: 'كابينات تخزين')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_baker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: "Baker's racks"),
                  Phrase(langCode: 'ar', value: 'وحدة أرفف خباز')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_island',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen island'),
                  Phrase(langCode: 'ar', value: 'وحدات جزيرة مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_utilityShelf',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Utility shelves'),
                  Phrase(langCode: 'ar', value: 'أرفف خدمية')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_utilityCart',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Utility carts'),
                  Phrase(langCode: 'ar', value: 'عربات خدمية')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_kitCart',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen carts'),
                  Phrase(langCode: 'ar', value: 'عربات مطبخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kitchen Accessories
          Chain(
            id: 'sub_prd_furn_Kitchen Accessories',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Kitchen Accessories'),
              Phrase(langCode: 'ar', value: 'اكسسوارات مطبخ')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_kitaccess_rack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Holders and racks'),
                  Phrase(langCode: 'ar', value: 'وحدات تنظيم مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_drawerOrg',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drawer organizers'),
                  Phrase(langCode: 'ar', value: 'وحدات تنظيم أدراج مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_paperHolder',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Paper towel holders'),
                  Phrase(langCode: 'ar', value: 'حاملات مناديل مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_shelfLiner',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drawer & shelf liners'),
                  Phrase(langCode: 'ar', value: 'بطانة أدراج و أرفف مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_bookstand',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Book stands'),
                  Phrase(langCode: 'ar', value: 'منصات كتب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kids Furniture
          Chain(
            id: 'sub_prd_furn_kids',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Kids Furniture'),
              Phrase(langCode: 'ar', value: 'أثاث أطفال')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_kids_set',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids bedroom sets'),
                  Phrase(langCode: 'ar', value: 'أطقم نوم أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_vanity',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids Vanities'),
                  Phrase(langCode: 'ar', value: 'تسريحات أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_highChair',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids high chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي مرتفعة للأطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_chair',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids seating & chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_dresser',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids Dressers'),
                  Phrase(langCode: 'ar', value: 'وحدات تخزين أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_bookcase',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids Bookcases'),
                  Phrase(langCode: 'ar', value: 'مكاتب كتب أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_nightstand',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids nightstands'),
                  Phrase(langCode: 'ar', value: 'وحدات سرير أطفال جانبية')
                ],
              ),
              KW(
                id: 'prd_furn_kids_box',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids boxes & organizers'),
                  Phrase(langCode: 'ar', value: 'صناديق أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_rug',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids rugs'),
                  Phrase(langCode: 'ar', value: 'سجاد أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_bed',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids beds'),
                  Phrase(langCode: 'ar', value: 'سرير أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_cradle',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Toddler beds & cradles'),
                  Phrase(langCode: 'ar', value: 'سرير و مهد رضيع')
                ],
              ),
              KW(
                id: 'prd_furn_kids_desk',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids desks'),
                  Phrase(langCode: 'ar', value: 'مكاتب أطفال')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Furniture Parts
          Chain(
            id: 'sub_prd_furn_parts',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Furniture Parts'),
              Phrase(langCode: 'ar', value: 'أجزاء أثاث')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_parts_tableLeg',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Table legs'),
                  Phrase(langCode: 'ar', value: 'أرجل طاولات')
                ],
              ),
              KW(
                id: 'prd_furn_parts_tableTop',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Table tops'),
                  Phrase(langCode: 'ar', value: 'أسطح طاولات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Furniture Accessories
          Chain(
            id: 'sub_prd_furn_accessories',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Furniture Accessories'),
              Phrase(langCode: 'ar', value: 'اكسسوارات أثاث')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_access_mirror',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall Mirrors'),
                  Phrase(langCode: 'ar', value: 'مرايا حائط')
                ],
              ),
              KW(
                id: 'prd_furn_access_clock',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall clocks'),
                  Phrase(langCode: 'ar', value: 'ساعات حائط')
                ],
              ),
              KW(
                id: 'prd_furn_access_step',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Step ladders & stools'),
                  Phrase(langCode: 'ar', value: 'عتبات')
                ],
              ),
              KW(
                id: 'prd_furn_access_charging',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Charging station'),
                  Phrase(langCode: 'ar', value: 'محطات شحن')
                ],
              ),
              KW(
                id: 'prd_furn_access_magazine',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Magazine racks'),
                  Phrase(langCode: 'ar', value: 'أرفف مجلات')
                ],
              ),
              KW(
                id: 'prd_furn_org_wall',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall Organizers'),
                  Phrase(langCode: 'ar', value: 'منظمات حائطية')
                ],
              ),
              KW(
                id: 'prd_furn_access_furnProtector',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Furniture protectors'),
                  Phrase(langCode: 'ar', value: 'حاميات أثاث')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Dressing Storage
          Chain(
            id: 'sub_prd_furn_dressingStorage',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Dressing Storage'),
              Phrase(langCode: 'ar', value: 'خزائن ملابس')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_dressStore_wardrobe',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Armories & Wardrobes'),
                  Phrase(langCode: 'ar', value: 'دواليب ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_dresser',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dresser'),
                  Phrase(langCode: 'ar', value: 'تسريحات')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_shoe',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shoes closet'),
                  Phrase(langCode: 'ar', value: 'دولاب أحذية')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_clothRack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Clothes racks'),
                  Phrase(langCode: 'ar', value: 'شماعات ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_valet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Clothes Valets'),
                  Phrase(langCode: 'ar', value: 'فاليه ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_jewelry',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Jewelry armories'),
                  Phrase(langCode: 'ar', value: 'وحدات مجوهرات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Dining Storage
          Chain(
            id: 'sub_prd_furn_diningStorage',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Dining Storage'),
              Phrase(langCode: 'ar', value: 'خزائن غرفة طعام')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_dinStore_china',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'China cabinet & Hutches'),
                  Phrase(langCode: 'ar', value: 'نيش')
                ],
              ),
              KW(
                id: 'prd_furn_dinStore_buffet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Buffet & sideboards'),
                  Phrase(langCode: 'ar', value: 'بوفيه')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cushions & Pillows
          Chain(
            id: 'sub_prd_furn_cushions',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Cushions & Pillows'),
              Phrase(langCode: 'ar', value: 'وسائد و مساند')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_cush_pillow',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pillows'),
                  Phrase(langCode: 'ar', value: 'مخدات')
                ],
              ),
              KW(
                id: 'prd_furn_cush_seat',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Seats cushions'),
                  Phrase(langCode: 'ar', value: 'وسائد مقاعد')
                ],
              ),
              KW(
                id: 'prd_furn_cush_throw',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Throws'),
                  Phrase(langCode: 'ar', value: 'أغطية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_floorPillow',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Floor Pillows'),
                  Phrase(langCode: 'ar', value: 'وسائد أرضية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_pouf',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pouf'),
                  Phrase(langCode: 'ar', value: 'بوف')
                ],
              ),
              KW(
                id: 'prd_furn_cush_cush',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cushions'),
                  Phrase(langCode: 'ar', value: 'وسائد')
                ],
              ),
              KW(
                id: 'prd_furn_cush_ottoman',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Foot stools & Ottomans'),
                  Phrase(langCode: 'ar', value: 'مساند أقدام عثمانية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_beanbag',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bean bags'),
                  Phrase(langCode: 'ar', value: 'بين باج')
                ],
              ),
              KW(
                id: 'prd_furn_cush_outOttoman',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Ottomans'),
                  Phrase(langCode: 'ar', value: 'مساند عثمانية خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_outCushion',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor cushions & pillows'),
                  Phrase(langCode: 'ar', value: 'مخدات و وسائد خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Couches
          Chain(
            id: 'sub_prd_furn_couch',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Couches'),
              Phrase(langCode: 'ar', value: 'أرائك و كنب')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_couch_chaise',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Chaise lounge'),
                  Phrase(langCode: 'ar', value: 'شيزلونج')
                ],
              ),
              KW(
                id: 'prd_furn_couch_banquette',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Banquettes'),
                  Phrase(langCode: 'ar', value: 'بانكيت')
                ],
              ),
              KW(
                id: 'prd_furn_couch_sofa',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sofas'),
                  Phrase(langCode: 'ar', value: 'أرائك')
                ],
              ),
              KW(
                id: 'prd_furn_couch_sectional',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sectional sofas'),
                  Phrase(langCode: 'ar', value: 'أرائك منفصلة')
                ],
              ),
              KW(
                id: 'prd_furn_couch_futon',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Futons'),
                  Phrase(langCode: 'ar', value: 'فوتون')
                ],
              ),
              KW(
                id: 'prd_furn_couch_love',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Love seats'),
                  Phrase(langCode: 'ar', value: 'أرائك مزدوجة')
                ],
              ),
              KW(
                id: 'prd_furn_couch_sleeper',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sleeper sofas'),
                  Phrase(langCode: 'ar', value: 'أرائك سرير')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Complete Sets
          Chain(
            id: 'sub_prd_furn_sets',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Complete Sets'),
              Phrase(langCode: 'ar', value: 'أطقم متكااملة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_sets_dining',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dining set'),
                  Phrase(langCode: 'ar', value: 'أطقم غرفة طعام')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bistro',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pub & Bistro set'),
                  Phrase(langCode: 'ar', value: 'أطقم مقاهي')
                ],
              ),
              KW(
                id: 'prd_furn_sets_living',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Living room set'),
                  Phrase(langCode: 'ar', value: 'أطقم غرفة معيشة')
                ],
              ),
              KW(
                id: 'prd_furn_sets_tv',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tv set'),
                  Phrase(langCode: 'ar', value: 'أطقم تلفزيون')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bathVanity',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom vanities'),
                  Phrase(langCode: 'ar', value: 'وحدات حمام')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bedroom',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bedroom sets'),
                  Phrase(langCode: 'ar', value: 'أطقم غرف نوم')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bedVanity',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bedroom vanities'),
                  Phrase(langCode: 'ar', value: 'أطقم تسريحة')
                ],
              ),
              KW(
                id: 'prd_furn_sets_outLounge',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor lounge sets'),
                  Phrase(langCode: 'ar', value: 'أطقم معيشة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_sets_outDining',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Dining sets'),
                  Phrase(langCode: 'ar', value: 'أطقم غرفة طعام')
                ],
              ),
              KW(
                id: 'prd_furn_sets_outBistro',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor pub & bistro sets'),
                  Phrase(langCode: 'ar', value: 'أطقم مقاهي خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Chairs
          Chain(
            id: 'sub_prd_furn_chairs',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Chairs'),
              Phrase(langCode: 'ar', value: 'كراسي')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_chair_bar',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bar & Counter stools'),
                  Phrase(langCode: 'ar', value: 'كراسي بار')
                ],
              ),
              KW(
                id: 'prd_furn_chair_dining',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dining Chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي مائدة')
                ],
              ),
              KW(
                id: 'prd_furn_chair_diningBench',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dining Benches'),
                  Phrase(langCode: 'ar', value: 'مجالس مائدة منبسطة')
                ],
              ),
              KW(
                id: 'prd_furn_chair_arm',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Arm chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي بذراع')
                ],
              ),
              KW(
                id: 'prd_furn_chair_recliner',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Recliner chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي ريكلاينر')
                ],
              ),
              KW(
                id: 'prd_furn_chair_glider',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gliders'),
                  Phrase(langCode: 'ar', value: 'كراسي جلايدر')
                ],
              ),
              KW(
                id: 'prd_furn_chair_rocking',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rocking chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي هزازة')
                ],
              ),
              KW(
                id: 'prd_furn_chair_hanging',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hammock & Swing chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي متدلية')
                ],
              ),
              KW(
                id: 'prd_furn_chair_lift',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lift chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي رفع')
                ],
              ),
              KW(
                id: 'prd_furn_chair_massage',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Massage chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي تدليك')
                ],
              ),
              KW(
                id: 'prd_furn_chair_sleeper',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sleeper chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي سرير')
                ],
              ),
              KW(
                id: 'prd_furn_chair_theatre',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Theatre seating'),
                  Phrase(langCode: 'ar', value: 'كراسي مسرح')
                ],
              ),
              KW(
                id: 'prd_furn_chair_folding',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Folding chairs & stools'),
                  Phrase(langCode: 'ar', value: 'كراسي قابلة للطي')
                ],
              ),
              KW(
                id: 'prd_furn_chair_office',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Office chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي مكتب')
                ],
              ),
              KW(
                id: 'prd_furn_chair_gaming',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gaming chairs'),
                  Phrase(langCode: 'ar', value: 'كراسي ألعاب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Carpets & Rugs
          Chain(
            id: 'sub_prd_furn_carpetsRugs',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Carpets & Rugs'),
              Phrase(langCode: 'ar', value: 'سجاد')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_carpet_bathMat',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom Mats'),
                  Phrase(langCode: 'ar', value: 'سجاد حمامات')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_rug',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Area rugs'),
                  Phrase(langCode: 'ar', value: 'بساط مساحات')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_doorMat',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Door mats'),
                  Phrase(langCode: 'ar', value: 'حصيرة أبواب')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_runner',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hall & stairs runners'),
                  Phrase(langCode: 'ar', value: 'بساط سلالم')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_kitchen',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen mats'),
                  Phrase(langCode: 'ar', value: 'سجاد مطابخ')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_outdoor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor rugs'),
                  Phrase(langCode: 'ar', value: 'سجاد خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_pad',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rug pads'),
                  Phrase(langCode: 'ar', value: 'بطانة سجاد')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_handmade',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Handmade rugs'),
                  Phrase(langCode: 'ar', value: 'سجاد يدوي الصنع')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cabinet Hardware
          Chain(
            id: 'sub_prd_furn_cabinetHardware',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Cabinet Hardware'),
              Phrase(langCode: 'ar', value: 'اكسسوارات كابينات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_cabhard_pull',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cabinet & drawers pulls'),
                  Phrase(langCode: 'ar', value: 'أكر أدراج و كابينات')
                ],
              ),
              KW(
                id: 'prd_furn_cabhard_knob',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cabinet & drawers knobs'),
                  Phrase(langCode: 'ar', value: 'مقابض أدراج و كابينات')
                ],
              ),
              KW(
                id: 'prd_furn_cabhard_hook',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall Cloth hooks'),
                  Phrase(langCode: 'ar', value: 'معلاق ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_cabhard_hinge',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cabinet hinges'),
                  Phrase(langCode: 'ar', value: 'مفصلات ضلف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Boxes
          Chain(
            id: 'sub_prd_furn_boxes',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Boxes'),
              Phrase(langCode: 'ar', value: 'صناديق ')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_boxes_bin',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Storage bins & boxes'),
                  Phrase(langCode: 'ar', value: 'سلات و صناديق تخزين')
                ],
              ),
              KW(
                id: 'prd_furn_boxes_outdoor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor boxes'),
                  Phrase(langCode: 'ar', value: 'صناديق تخزين خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_boxes_ice',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Coolers & ice chests'),
                  Phrase(langCode: 'ar', value: 'صناديق ثلج')
                ],
              ),
              KW(
                id: 'prd_furn_boxes_basket',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Baskets'),
                  Phrase(langCode: 'ar', value: 'سلات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Blinds & Curtains
          Chain(
            id: 'sub_prd_furn_blindsCurtains',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Blinds & Curtains'),
              Phrase(langCode: 'ar', value: 'ستائر')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_curtain_shower',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom shower curtains'),
                  Phrase(langCode: 'ar', value: 'ستائر دش استحمام')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_shade',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Blinds & shades'),
                  Phrase(langCode: 'ar', value: 'سواتر و ستائر شفافة')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_horizontal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Horizontal shades'),
                  Phrase(langCode: 'ar', value: 'ستائر شريطية عرضية')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_vertical',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vertical blinds'),
                  Phrase(langCode: 'ar', value: 'ستائر شريطية طولية')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_rod',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Curtain rods'),
                  Phrase(langCode: 'ar', value: 'قضبان ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_valance',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Valances'),
                  Phrase(langCode: 'ar', value: 'كرانيش ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_curtain',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Curtains'),
                  Phrase(langCode: 'ar', value: 'ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_tassel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tassels'),
                  Phrase(langCode: 'ar', value: 'شرابات ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_bendRail',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bendable curtain rails'),
                  Phrase(langCode: 'ar', value: 'قضبان ستائر قابلة للطي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Beds & Headboards
          Chain(
            id: 'sub_prd_furn_beds',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Beds & Headboards'),
              Phrase(langCode: 'ar', value: 'سرائر و ظهور سرائر')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_beds_bed',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Beds'),
                  Phrase(langCode: 'ar', value: 'سرائر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_board',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Headboards'),
                  Phrase(langCode: 'ar', value: 'ألواح سرائر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_mattress',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mattresses & Pads'),
                  Phrase(langCode: 'ar', value: 'مراتب')
                ],
              ),
              KW(
                id: 'prd_furn_beds_frame',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bed Frames'),
                  Phrase(langCode: 'ar', value: 'هياكل سرائر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_blanket',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Blankets, pillows & covers'),
                  Phrase(langCode: 'ar', value: 'بطانيات و مخدات')
                ],
              ),
              KW(
                id: 'prd_furn_beds_panel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Panel beds'),
                  Phrase(langCode: 'ar', value: 'سرائر بظهر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_platform',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Platform beds'),
                  Phrase(langCode: 'ar', value: 'سرائر على منصة منبسطة')
                ],
              ),
              KW(
                id: 'prd_furn_beds_sleigh',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sleigh beds'),
                  Phrase(langCode: 'ar', value: 'سرائر سلاي')
                ],
              ),
              KW(
                id: 'prd_furn_beds_bunk',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bunk beds'),
                  Phrase(langCode: 'ar', value: 'سرائر دورين')
                ],
              ),
              KW(
                id: 'prd_furn_beds_loft',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Loft beds'),
                  Phrase(langCode: 'ar', value: 'سرائر لوفت مرتفعة')
                ],
              ),
              KW(
                id: 'prd_furn_beds_day',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Day beds'),
                  Phrase(langCode: 'ar', value: 'سرائر النهار')
                ],
              ),
              KW(
                id: 'prd_furn_beds_murphy',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Murphy beds'),
                  Phrase(langCode: 'ar', value: 'سرائر ميرفي')
                ],
              ),
              KW(
                id: 'prd_furn_beds_folding',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Folding beds'),
                  Phrase(langCode: 'ar', value: 'سرائر قابلة للطي')
                ],
              ),
              KW(
                id: 'prd_furn_beds_adjustable',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Adjustable beds'),
                  Phrase(langCode: 'ar', value: 'سرائر قابلة للضبط')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bathroom Storage
          Chain(
            id: 'sub_prd_furn_bathStorage',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Bathroom Storage'),
              Phrase(langCode: 'ar', value: 'خزائن حمام')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_bathStore_medicine',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Medicine cabinet'),
                  Phrase(langCode: 'ar', value: 'كابينات دواء')
                ],
              ),
              KW(
                id: 'prd_furn_bathStore_cabinet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom cabinet'),
                  Phrase(langCode: 'ar', value: 'كابينات حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathStore_shelf',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom shelves'),
                  Phrase(langCode: 'ar', value: 'أرفف حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathStore_sink',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Under sink cabinets'),
                  Phrase(langCode: 'ar', value: 'كابينات حمام سفلية')
                ],
              ),
              KW(
                id: 'prd_furn_bedStore_nightstand',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Nightstands & bedside tables'),
                  Phrase(langCode: 'ar', value: 'طاولات سرير جانبية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bathroom Hardware
          Chain(
            id: 'sub_prd_furn_bathHardware',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Bathroom Hardware'),
              Phrase(langCode: 'ar', value: 'اكسسوارات حمامات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_bathHard_towelBar',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Towel bars & holders'),
                  Phrase(langCode: 'ar', value: 'قضيب فوط')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_mirror',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom mirrors'),
                  Phrase(langCode: 'ar', value: 'مرايا حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_makeup',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Makeup mirrors'),
                  Phrase(langCode: 'ar', value: 'مرايا مكياج')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_rack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom racks'),
                  Phrase(langCode: 'ar', value: 'أرفف حمامات')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_grab',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Grab bars'),
                  Phrase(langCode: 'ar', value: 'قضبان اتكاء')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_caddy',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower Caddies'),
                  Phrase(langCode: 'ar', value: 'أرفف دش استحمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_safetyRail',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Toilet safety rails'),
                  Phrase(langCode: 'ar', value: 'قضبان أمان مرحاض')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_toiletHolder',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Toilet paper holder'),
                  Phrase(langCode: 'ar', value: 'حاملة مناديل')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_commode',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Toilet Commode'),
                  Phrase(langCode: 'ar', value: 'مرحاض متنقل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Artworks
          Chain(
            id: 'sub_prd_furn_artworks',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Artworks'),
              Phrase(langCode: 'ar', value: 'أعمال فنية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_furn_art_painting',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Paintings'),
                  Phrase(langCode: 'ar', value: 'رسومات فنية')
                ],
              ),
              KW(
                id: 'prd_furn_art_photo',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Photographs'),
                  Phrase(langCode: 'ar', value: 'صور')
                ],
              ),
              KW(
                id: 'prd_furn_art_illustration',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drawings & Illustrations'),
                  Phrase(langCode: 'ar', value: 'تصاميم')
                ],
              ),
              KW(
                id: 'prd_furn_art_print',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Prints & posters'),
                  Phrase(langCode: 'ar', value: 'مطبوعات و ملصقات')
                ],
              ),
              KW(
                id: 'prd_furn_art_sculpture',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sculptures'),
                  Phrase(langCode: 'ar', value: 'تماثيل')
                ],
              ),
              KW(
                id: 'prd_furn_art_letter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall Letters'),
                  Phrase(langCode: 'ar', value: 'حروف حائطية')
                ],
              ),
              KW(
                id: 'prd_furn_art_frame',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Picture frames & accents'),
                  Phrase(langCode: 'ar', value: 'إطارات صور ز هياكل')
                ],
              ),
              KW(
                id: 'prd_furn_art_bulletin',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bulletin boards'),
                  Phrase(langCode: 'ar', value: 'لوحات دبابيس')
                ],
              ),
              KW(
                id: 'prd_furn_art_decals',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall Decals'),
                  Phrase(langCode: 'ar', value: 'ملصقات حائطية')
                ],
              ),
              KW(
                id: 'prd_furn_art_tapestry',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tapestries'),
                  Phrase(langCode: 'ar', value: 'بساط و أنسجة حائطية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Heating Ventilation Air Conditioning
      Chain(
        id: 'group_prd_hvac',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Heating Ventilation Air Conditioning'),
          Phrase(langCode: 'ar', value: 'تدفئة تهوية تكييف')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Ventilation
          Chain(
            id: 'sub_prd_hvac_ventilation',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Ventilation'),
              Phrase(langCode: 'ar', value: 'تهوية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_hvac_vent_fan',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fans'),
                  Phrase(langCode: 'ar', value: 'مراوح')
                ],
              ),
              KW(
                id: 'prd_hvac_vent_exhaust',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Exhaust fans'),
                  Phrase(langCode: 'ar', value: 'مراوح شفط و شفاطات')
                ],
              ),
              KW(
                id: 'prd_hvac_vent_curtain',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Air curtains'),
                  Phrase(langCode: 'ar', value: 'ستائر هوائية')
                ],
              ),
              KW(
                id: 'prd_hvac_vent_ceilingFan',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ceiling fan'),
                  Phrase(langCode: 'ar', value: 'مراوح سقف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Heating
          Chain(
            id: 'sub_prd_hvac_heating',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Heating'),
              Phrase(langCode: 'ar', value: 'تدفئة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_hvac_heating_electric',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Electric heaters'),
                  Phrase(langCode: 'ar', value: 'أجهزة تدفئة')
                ],
              ),
              KW(
                id: 'prd_hvac_heating_radiators',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Radiators'),
                  Phrase(langCode: 'ar', value: 'مشعاع حراري')
                ],
              ),
              KW(
                id: 'prd_hvac_heating_floor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Floor heating systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة تدفئة أرضية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fireplaces
          Chain(
            id: 'sub_prd_hvac_fireplaces',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Fireplaces'),
              Phrase(langCode: 'ar', value: 'مواقد نار')
            ],
            sons: <KW>[
              KW(
                id: 'prd_fireplace_fire_mantle',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fireplace mantels'),
                  Phrase(langCode: 'ar', value: 'دفايات نار مبنية')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_tabletop',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tabletop fireplaces'),
                  Phrase(langCode: 'ar', value: 'دفايات نار طاولة')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_freeStove',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Freestanding stoves'),
                  Phrase(langCode: 'ar', value: 'مواقد قائمة')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_outdoor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor fireplaces'),
                  Phrase(langCode: 'ar', value: 'دفايات نار خارجية')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_chiminea',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Chimineas'),
                  Phrase(langCode: 'ar', value: 'مداخن')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_pit',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire pits'),
                  Phrase(langCode: 'ar', value: 'حفرة نار')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fireplace Equipment
          Chain(
            id: 'sub_prd_hvac_fireplaceEquip',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Fireplace Equipment'),
              Phrase(langCode: 'ar', value: 'أدوات مواقد نار')
            ],
            sons: <KW>[
              KW(
                id: 'prd_fireplace_equip_tools',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fireplace tools'),
                  Phrase(langCode: 'ar', value: 'أدوات دفايات نار')
                ],
              ),
              KW(
                id: 'prd_fireplace_equip_rack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire wood racks'),
                  Phrase(langCode: 'ar', value: 'أرفف حطب')
                ],
              ),
              KW(
                id: 'prd_fireplace_equip_fuel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire starters & fuel'),
                  Phrase(langCode: 'ar', value: 'مساعدات اشتعال و وقود')
                ],
              ),
              KW(
                id: 'prd_fireplace_equip_grate',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'fireplace grates & Andirons'),
                  Phrase(langCode: 'ar', value: 'فواصل و حوامل حطب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Air Conditioning
          Chain(
            id: 'sub_prd_hvac_ac',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Air Conditioning'),
              Phrase(langCode: 'ar', value: 'تكييف هواء')
            ],
            sons: <KW>[
              KW(
                id: 'prd_hvac_ac_chiller',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Chillers'),
                  Phrase(langCode: 'ar', value: 'مبردات')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_ac',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Indoor AC units'),
                  Phrase(langCode: 'ar', value: 'تكييفات')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_vent',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Registers, grills & vents'),
                  Phrase(langCode: 'ar', value: 'فتحات تكييف، هوايات')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_humidifier',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Humidifiers'),
                  Phrase(langCode: 'ar', value: 'مرطبات هواء')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_dehumidifier',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dehumidifiers'),
                  Phrase(langCode: 'ar', value: 'مجففات هواء')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_purifier',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Air purifiers'),
                  Phrase(langCode: 'ar', value: 'منقيات هواء')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Planting & Landscape
      Chain(
        id: 'group_prd_landscape',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Planting & Landscape'),
          Phrase(langCode: 'ar', value: 'زراعات و لاندسكيب')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Pots & Vases
          Chain(
            id: 'sub_prd_scape_potsVases',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Pots & Vases'),
              Phrase(langCode: 'ar', value: 'أواني و مزهريات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_landscape_pots_vase',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vases'),
                  Phrase(langCode: 'ar', value: 'مزاهر')
                ],
              ),
              KW(
                id: 'prd_landscape_pots_indoorPlanter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Indoor pots & planters'),
                  Phrase(langCode: 'ar', value: 'أصيص زراعة داخلي')
                ],
              ),
              KW(
                id: 'prd_landscape_pots_outdoorPlanter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor pots & planters'),
                  Phrase(langCode: 'ar', value: 'أصيص زراعة خارجي')
                ],
              ),
              KW(
                id: 'prd_landscape_pots_bin',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Composite bins'),
                  Phrase(langCode: 'ar', value: 'براميل و صناديق سماد')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Live Plants
          Chain(
            id: 'sub_prd_scape_livePlants',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Live Plants'),
              Phrase(langCode: 'ar', value: 'نباتات حية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_landscape_live_tree',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Live Trees'),
                  Phrase(langCode: 'ar', value: 'شجر طبيعي')
                ],
              ),
              KW(
                id: 'prd_landscape_live_grass',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Live Grass lawn'),
                  Phrase(langCode: 'ar', value: 'نجيلة طبيعية')
                ],
              ),
              KW(
                id: 'prd_landscape_live_bush',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Plants, Bushes & Flowers'),
                  Phrase(langCode: 'ar', value: 'مزروعات، نباتات و ورود')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Hardscape
          Chain(
            id: 'sub_prd_scape_hardscape',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Hardscape'),
              Phrase(langCode: 'ar', value: 'هاردسكيب')
            ],
            sons: <KW>[
              KW(
                id: 'prd_landscape_hardscape_trellis',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Garden Trellises'),
                  Phrase(langCode: 'ar', value: 'تعريشات حديقة')
                ],
              ),
              KW(
                id: 'prd_landscape_hardscape_flag',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Flags & Poles'),
                  Phrase(langCode: 'ar', value: 'أعلام و عواميدها')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fountains & Ponds
          Chain(
            id: 'sub_prd_scape_fountainsPonds',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Fountains & Ponds'),
              Phrase(langCode: 'ar', value: 'نوافير و برك')
            ],
            sons: <KW>[
              KW(
                id: 'prd_landscape_fountain_indoor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor fountains'),
                  Phrase(langCode: 'ar', value: 'نافورة خارجية')
                ],
              ),
              KW(
                id: 'prd_landscape_fountain_outdoor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Indoor fountains'),
                  Phrase(langCode: 'ar', value: 'نافورة داخلية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Birds fixtures
          Chain(
            id: 'sub_prd_scape_birds',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Birds fixtures'),
              Phrase(langCode: 'ar', value: 'تجهيزات عصافير')
            ],
            sons: <KW>[
              KW(
                id: 'prd_landscape_birds_feeder',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bird feeders'),
                  Phrase(langCode: 'ar', value: 'مغذيات عصافير')
                ],
              ),
              KW(
                id: 'prd_landscape_birds_bath',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bird baths'),
                  Phrase(langCode: 'ar', value: 'أحواض عصافير')
                ],
              ),
              KW(
                id: 'prd_landscape_birds_house',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bird houses'),
                  Phrase(langCode: 'ar', value: 'بيوت عصافير')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Artificial plants
          Chain(
            id: 'sub_prd_scape_artificial',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Artificial plants'),
              Phrase(langCode: 'ar', value: 'نباتات صناعية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_landscape_artificial_tree',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Artificial Trees'),
                  Phrase(langCode: 'ar', value: 'شجر صناعي')
                ],
              ),
              KW(
                id: 'prd_landscape_artificial_plant',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Artificial Plants'),
                  Phrase(langCode: 'ar', value: 'نباتات صناعية')
                ],
              ),
              KW(
                id: 'prd_landscape_artificial_grass',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Artificial grass'),
                  Phrase(langCode: 'ar', value: 'نجيلة صناعية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Lighting
      Chain(
        id: 'group_prd_lighting',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Lighting'),
          Phrase(langCode: 'ar', value: 'إضاءة')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Wall Lighting
          Chain(
            id: 'sub_prd_light_wall',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Wall Lighting'),
              Phrase(langCode: 'ar', value: 'إضاءة حائطية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_lighting_wall_applique',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sconces & Appliques'),
                  Phrase(langCode: 'ar', value: 'أباليك')
                ],
              ),
              KW(
                id: 'prd_lighting_wall_vanity',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom vanity lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح وحدات حمام')
                ],
              ),
              KW(
                id: 'prd_lighting_wall_picture',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Display & Picture lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح عرض و صور')
                ],
              ),
              KW(
                id: 'prd_lighting_wall_swing',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Swing arm wall lamps'),
                  Phrase(langCode: 'ar', value: 'مصابيح ذراع متحرك')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Lighting
          Chain(
            id: 'sub_prd_light_outdoor',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Outdoor Lighting'),
              Phrase(langCode: 'ar', value: 'إضاءة خارجية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_lighting_outdoor_wall',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor wall lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح حوائط خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_flush',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Flush mounts'),
                  Phrase(langCode: 'ar', value: 'مصابيح ملتصقة بالسقف خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_hanging',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor Hanging lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح خارجية متدلية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_deck',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Deck post caps'),
                  Phrase(langCode: 'ar', value: 'أغطية مصابيح خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_inground',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Inground & well lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح مدفونة')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_path',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Path lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح ممرات خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_step',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Stairs and step lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح سلالم')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_floorSpot',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor floor & spot lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح سبوت أرضية خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_lamp',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor lamps'),
                  Phrase(langCode: 'ar', value: 'مصابيح خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_table',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor table lamps'),
                  Phrase(langCode: 'ar', value: 'مصابيح طاولة خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_string',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor String lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح سلسلة خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_post',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Post lights'),
                  Phrase(langCode: 'ar', value: 'عواميد إضاءة')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_torch',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor torches'),
                  Phrase(langCode: 'ar', value: 'شعلات إضاءة خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_gardenSpot',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Graden spotlights'),
                  Phrase(langCode: 'ar', value: 'إضاءات حدائق سبوت')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Lighting Accessories
          Chain(
            id: 'sub_prd_light_access',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Lighting Accessories'),
              Phrase(langCode: 'ar', value: 'اكسسوارات إضاءة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_lighting_accessories_shade',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lamp shades & bases'),
                  Phrase(langCode: 'ar', value: 'قواعد و أغطية مصابيح')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_timer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Timers & lighting controls'),
                  Phrase(langCode: 'ar', value: 'مواقيت و ضوابط إضاءة')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_lightingHardware',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lighting hardware & accessories'),
                  Phrase(langCode: 'ar', value: 'اكسسوارات إضاءة')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_flash',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Flash lights'),
                  Phrase(langCode: 'ar', value: 'كشافات يدوية')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_diffuser',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Light diffusers'),
                  Phrase(langCode: 'ar', value: 'مبددات أضواء')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Light bulbs
          Chain(
            id: 'sub_prd_light_bulbs',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Light bulbs'),
              Phrase(langCode: 'ar', value: 'لمبات إضاءة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_lighting_bulbs_fluorescent',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fluorescent bulbs'),
                  Phrase(langCode: 'ar', value: 'لمبة فلوريسينت')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_led',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Led bulbs'),
                  Phrase(langCode: 'ar', value: 'لمبة ليد')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_halogen',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Halogen bulbs'),
                  Phrase(langCode: 'ar', value: 'لمبة هالوجين')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_incandescent',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Incandescent bulbs'),
                  Phrase(langCode: 'ar', value: 'لمبة متوهجة')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_tube',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fluorescent tubes'),
                  Phrase(langCode: 'ar', value: 'عود نيون فلوريسينت')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_krypton',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Krypton & xenon bulbs'),
                  Phrase(langCode: 'ar', value: 'لمبة كريبتون و زينون')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Lamps
          Chain(
            id: 'sub_prd_light_lamps',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Lamps'),
              Phrase(langCode: 'ar', value: 'مصابيح')
            ],
            sons: <KW>[
              KW(
                id: 'prd_lighting_lamp_table',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Table lamps'),
                  Phrase(langCode: 'ar', value: 'مصابيح طاولة')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_floor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Floor lamps'),
                  Phrase(langCode: 'ar', value: 'مصابيح أرضية')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_desk',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Desk lamps'),
                  Phrase(langCode: 'ar', value: 'مصابيح مكتب')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_set',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lamp sets'),
                  Phrase(langCode: 'ar', value: 'أطقم مصابيح')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_piano',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Piano table Lights'),
                  Phrase(langCode: 'ar', value: 'مصباح بيانو')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_kids',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids lamps'),
                  Phrase(langCode: 'ar', value: 'مصابيح أطفال')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_emergency',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Emergency lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح طوارئ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Ceiling Lighting
          Chain(
            id: 'sub_prd_light_ceiling',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Ceiling Lighting'),
              Phrase(langCode: 'ar', value: 'إضاءة أسقف')
            ],
            sons: <KW>[
              KW(
                id: 'prd_lighting_ceiling_chandelier',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Chandeliers'),
                  Phrase(langCode: 'ar', value: 'نجف')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_pendant',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pendant lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح معلقة')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_flush',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Flush mount lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح ملتصقة بالسقف')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_kitchenIsland',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen Island lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح جزيرة مطبخ')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_underCabinet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Under cabinet lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح مطبخ سفلية')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_track',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Track lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح مضمار')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_recessed',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Recessed lighting'),
                  Phrase(langCode: 'ar', value: 'مصابيح مخفية')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_pool',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pool table lighting'),
                  Phrase(langCode: 'ar', value: 'مصباح طاولة بلياردو')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_spot',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Spot lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح سبوت')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_kids',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids ceiling lights'),
                  Phrase(langCode: 'ar', value: 'مصابيح سقف أطفال')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Construction Materials
      Chain(
        id: 'group_prd_materials',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Construction Materials'),
          Phrase(langCode: 'ar', value: 'مواد بناء')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Wood Coats
          Chain(
            id: 'sub_prd_mat_woodCoats',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Wood Coats'),
              Phrase(langCode: 'ar', value: 'دهانات خشب')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_woodPaint_lacquer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lacquer'),
                  Phrase(langCode: 'ar', value: 'لاكيه')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_polyurethane',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polyurethane'),
                  Phrase(langCode: 'ar', value: 'بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_polycrylic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polycrylic'),
                  Phrase(langCode: 'ar', value: 'بوليكريليك')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_varnish',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Varnish & Shellacs'),
                  Phrase(langCode: 'ar', value: 'ورنيش')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_polyester',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polyester Urethane'),
                  Phrase(langCode: 'ar', value: 'بولي استر ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Water Proofing
          Chain(
            id: 'sub_prd_mat_waterProofing',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Water Proofing'),
              Phrase(langCode: 'ar', value: 'عوازل رطوبة و مياه')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_waterProof_rubber',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'EPDM Rubber membranes'),
                  Phrase(langCode: 'ar', value: 'عزل ماء و رطوبة')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_bitumen',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bitumen membranes'),
                  Phrase(langCode: 'ar', value: 'لفائف بيتومين')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_pvc',
                names: <Phrase>[
                  Phrase(
                      langCode: 'en',
                      value: 'PVC membranes (Thermoplastic polyolefin)'),
                  Phrase(langCode: 'ar', value: 'لفائف بوليفيلين بي في سي')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_tpo',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'TPO membranes'),
                  Phrase(langCode: 'ar', value: 'لفائف تي بي أو')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_polyurethane',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polyurethane coating'),
                  Phrase(langCode: 'ar', value: 'طلاء بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_acrylic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Acrylic coating'),
                  Phrase(langCode: 'ar', value: 'طلاء أكريليك')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_cementitious',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cementitious coating'),
                  Phrase(langCode: 'ar', value: 'طلاء أسمنتي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Synthetic Heat Insulation
          Chain(
            id: 'sub_prd_mat_heatSynth',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Synthetic Heat Insulation'),
              Phrase(langCode: 'ar', value: 'عوازل حرارية مصنوعة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_heatSynth_reflective',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Reflective foam sheets'),
                  Phrase(langCode: 'ar', value: 'ألواح فوم عاكس')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_polystyrene',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'EPS Polystyrene sheets'),
                  Phrase(langCode: 'ar', value: 'ألواح إي بي إس بولي ستيرين')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_styro',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'XPS Styrofoam'),
                  Phrase(langCode: 'ar', value: 'ستايروفوم إكس بي إس')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_purSheet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polyurethane Foam sheets'),
                  Phrase(langCode: 'ar', value: 'ألواح فوم بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_purSpray',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polyurethane Foam spray'),
                  Phrase(langCode: 'ar', value: 'بولي يووريثان رش')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_purSection',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polyurethane piping sections'),
                  Phrase(langCode: 'ar', value: 'قطاعات عزل بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_phenolic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Phenolic foam boards'),
                  Phrase(langCode: 'ar', value: 'ألواح فوم فينول')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_aerogel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Aerogel blankets'),
                  Phrase(langCode: 'ar', value: 'بطانية عزل إيرو جيل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Stones
          Chain(
            id: 'sub_prd_mat_stones',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Stones'),
              Phrase(langCode: 'ar', value: 'حجر')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_stone_marble',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Marble'),
                  Phrase(langCode: 'ar', value: 'رخام')
                ],
              ),
              KW(
                id: 'prd_mat_stone_granite',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Granite'),
                  Phrase(langCode: 'ar', value: 'جرانيت')
                ],
              ),
              KW(
                id: 'prd_mat_stone_slate',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Slate'),
                  Phrase(langCode: 'ar', value: 'شرائح حجر')
                ],
              ),
              KW(
                id: 'prd_mat_stone_quartzite',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Quartzite'),
                  Phrase(langCode: 'ar', value: 'كوارتزيت')
                ],
              ),
              KW(
                id: 'prd_mat_stone_soap',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Soap stone'),
                  Phrase(langCode: 'ar', value: 'حجر أملس')
                ],
              ),
              KW(
                id: 'prd_mat_stone_travertine',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Travertine'),
                  Phrase(langCode: 'ar', value: 'حجر جيري ترافنتين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Steel
          Chain(
            id: 'sub_prd_mat_steel',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Steel'),
              Phrase(langCode: 'ar', value: 'حديد مسلح')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_steel_rebar',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Steel rebar'),
                  Phrase(langCode: 'ar', value: 'حديد تسليح')
                ],
              ),
              KW(
                id: 'prd_mat_steel_section',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Steel sections'),
                  Phrase(langCode: 'ar', value: 'قطاعات معدنية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Solid Wood
          Chain(
            id: 'sub_prd_mat_solidWood',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Solid Wood'),
              Phrase(langCode: 'ar', value: 'أخشاب طبيعية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_wood_oak',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Oak'),
                  Phrase(langCode: 'ar', value: 'خشب أرو')
                ],
              ),
              KW(
                id: 'prd_mat_wood_beech',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Beech'),
                  Phrase(langCode: 'ar', value: 'خشب زان')
                ],
              ),
              KW(
                id: 'prd_mat_wood_mahogany',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mahogany'),
                  Phrase(langCode: 'ar', value: 'خشب ماهوجني')
                ],
              ),
              KW(
                id: 'prd_mat_wood_beechPine',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Beech pine'),
                  Phrase(langCode: 'ar', value: 'خشب موسكي')
                ],
              ),
              KW(
                id: 'prd_mat_wood_ash',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ash'),
                  Phrase(langCode: 'ar', value: 'خشب بلوط')
                ],
              ),
              KW(
                id: 'prd_mat_wood_walnut',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Walnut'),
                  Phrase(langCode: 'ar', value: 'خشب الجوز')
                ],
              ),
              KW(
                id: 'prd_mat_wood_pine',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pine'),
                  Phrase(langCode: 'ar', value: 'خشب العزيزي')
                ],
              ),
              KW(
                id: 'prd_mat_wood_teak',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Teak'),
                  Phrase(langCode: 'ar', value: 'خشب تك')
                ],
              ),
              KW(
                id: 'prd_mat_wood_rose',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rosewood'),
                  Phrase(langCode: 'ar', value: 'خشب الورد')
                ],
              ),
              KW(
                id: 'prd_mat_wood_palisander',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Palisander'),
                  Phrase(langCode: 'ar', value: 'خشب البليسندر')
                ],
              ),
              KW(
                id: 'prd_mat_wood_sandal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sandalwood'),
                  Phrase(langCode: 'ar', value: 'خشب الصندل')
                ],
              ),
              KW(
                id: 'prd_mat_wood_cherry',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cherry wood'),
                  Phrase(langCode: 'ar', value: 'خشب الكريز')
                ],
              ),
              KW(
                id: 'prd_mat_wood_ebony',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ebony wood'),
                  Phrase(langCode: 'ar', value: 'خشب الابنوس')
                ],
              ),
              KW(
                id: 'prd_mat_wood_maple',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Maple wood'),
                  Phrase(langCode: 'ar', value: 'خشب الحور، القيقب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Sand & Rubble
          Chain(
            id: 'sub_prd_mat_sandRubble',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Sand & Rubble'),
              Phrase(langCode: 'ar', value: 'رمل و زلط')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_sand_sand',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sand & Rubble'),
                  Phrase(langCode: 'ar', value: 'رمل و حصى')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Paints
          Chain(
            id: 'sub_prd_mat_paints',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Paints'),
              Phrase(langCode: 'ar', value: 'دهانات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_paint_cement',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cement paints'),
                  Phrase(langCode: 'ar', value: 'دهانات أسمنتية')
                ],
              ),
              KW(
                id: 'prd_mat_paint_outdoor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor paints'),
                  Phrase(langCode: 'ar', value: 'دهانات خارجية')
                ],
              ),
              KW(
                id: 'prd_mat_paint_primer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Primer & sealer'),
                  Phrase(langCode: 'ar', value: 'معجون و سيلر')
                ],
              ),
              KW(
                id: 'prd_mat_paint_acrylic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Acrylic'),
                  Phrase(langCode: 'ar', value: 'أكريليك')
                ],
              ),
              KW(
                id: 'prd_mat_paint_duco',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Spray & Duco'),
                  Phrase(langCode: 'ar', value: 'رش و دوكو')
                ],
              ),
              KW(
                id: 'prd_mat_paint_heatproof',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Thermal insulation paints'),
                  Phrase(langCode: 'ar', value: 'دهانات حرارية')
                ],
              ),
              KW(
                id: 'prd_mat_paint_fire',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire retardant paints'),
                  Phrase(langCode: 'ar', value: 'دهانات مضادة للحريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Mineral Heat Insulation
          Chain(
            id: 'sub_prd_mat_heatIMin',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Mineral Heat Insulation'),
              Phrase(langCode: 'ar', value: 'عوازل حرارية من ألياف معدنية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_heatmin_vermiculite',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vermiculite Asbestos'),
                  Phrase(langCode: 'ar', value: 'أسبستوس فيرميكوليت')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_cellulose',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cellulose fibre'),
                  Phrase(langCode: 'ar', value: 'ألياف سيليولوز')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_perlite',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Perlite insulation boards'),
                  Phrase(langCode: 'ar', value: 'ألواح بيرلايت')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_foamGlass',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Foam glass boards'),
                  Phrase(langCode: 'ar', value: 'ألواح فوم زجاجي')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_fiberglassWool',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fiberglass wool'),
                  Phrase(langCode: 'ar', value: 'صوف زجاجي فايبر جلاس')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_fiberglassPipe',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fiberglass piping insulation'),
                  Phrase(langCode: 'ar', value: 'عزل صوف زجاجي خراطيم فايبر جلاس')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_rockWool',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rock wool'),
                  Phrase(langCode: 'ar', value: 'صوف صخري')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Metals
          Chain(
            id: 'sub_prd_mat_metals',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Metals'),
              Phrase(langCode: 'ar', value: 'معادن')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_metal_iron',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Iron'),
                  Phrase(langCode: 'ar', value: 'حديد')
                ],
              ),
              KW(
                id: 'prd_mat_metal_steel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Steel'),
                  Phrase(langCode: 'ar', value: 'حديد مسلح')
                ],
              ),
              KW(
                id: 'prd_mat_metal_aluminum',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Aluminum'),
                  Phrase(langCode: 'ar', value: 'ألمنيوم')
                ],
              ),
              KW(
                id: 'prd_mat_metal_copper',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Copper'),
                  Phrase(langCode: 'ar', value: 'نحاس')
                ],
              ),
              KW(
                id: 'prd_mat_metal_silver',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sliver'),
                  Phrase(langCode: 'ar', value: 'فضة')
                ],
              ),
              KW(
                id: 'prd_mat_metal_gold',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gold'),
                  Phrase(langCode: 'ar', value: 'ذهب')
                ],
              ),
              KW(
                id: 'prd_mat_metal_bronze',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bronze'),
                  Phrase(langCode: 'ar', value: 'برونز')
                ],
              ),
              KW(
                id: 'prd_mat_metal_stainless',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Stainless steel'),
                  Phrase(langCode: 'ar', value: 'ستانلس ستيل')
                ],
              ),
              KW(
                id: 'prd_mat_metal_chrome',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Chrome'),
                  Phrase(langCode: 'ar', value: 'كروم')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Manufactured Wood
          Chain(
            id: 'sub_prd_mat_manuWood',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Manufactured Wood'),
              Phrase(langCode: 'ar', value: 'أخشاب مصنعة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_manWood_mdf',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'MDF'),
                  Phrase(langCode: 'ar', value: 'خشب مضغوط إم دي إف')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_veneer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Veneer wood'),
                  Phrase(langCode: 'ar', value: 'قشرة خشب')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_compressed',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Compressed chip & fire board wood'),
                  Phrase(langCode: 'ar', value: 'خشب حبيبي')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_formica',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Formica'),
                  Phrase(langCode: 'ar', value: 'خشب فروميكا')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_engineered',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Engineered wood'),
                  Phrase(langCode: 'ar', value: 'خشب كونتر طبقات')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_ply',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Plywood'),
                  Phrase(langCode: 'ar', value: 'خشب أبلكاش')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_cork',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cork wood'),
                  Phrase(langCode: 'ar', value: 'خشب فلين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Gypsum
          Chain(
            id: 'sub_prd_mat_gypsum',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Gypsum'),
              Phrase(langCode: 'ar', value: 'جبس')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_gypsum_board',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gypsum boards & accessories'),
                  Phrase(langCode: 'ar', value: 'ألواح جبسية و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_mat_gypsum_powder',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gypsum powder'),
                  Phrase(langCode: 'ar', value: 'جبس أبيض')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Glass
          Chain(
            id: 'sub_prd_mat_glass',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Glass'),
              Phrase(langCode: 'ar', value: 'زجاج')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_glass_float',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Float glass'),
                  Phrase(langCode: 'ar', value: 'زجاج مصقول')
                ],
              ),
              KW(
                id: 'prd_mat_glass_bullet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bullet proof glass'),
                  Phrase(langCode: 'ar', value: 'زجاج مضاد للرصاص')
                ],
              ),
              KW(
                id: 'prd_mat_glass_block',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Glass blocks'),
                  Phrase(langCode: 'ar', value: 'طوب زجاجي')
                ],
              ),
              KW(
                id: 'prd_mat_glass_tempered',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tempered & Laminated glass'),
                  Phrase(langCode: 'ar', value: 'زجاج سيكوريت مقوى')
                ],
              ),
              KW(
                id: 'prd_mat_glass_obscured',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Obscured glass'),
                  Phrase(langCode: 'ar', value: 'زجاج منقوش')
                ],
              ),
              KW(
                id: 'prd_mat_glass_mirrored',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mirrored glass'),
                  Phrase(langCode: 'ar', value: 'زجاج عاكس')
                ],
              ),
              KW(
                id: 'prd_mat_glass_tinted',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: ' Tinted glass'),
                  Phrase(langCode: 'ar', value: 'زجاج ملون')
                ],
              ),
              KW(
                id: 'prd_mat_glass_wired',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wired glass'),
                  Phrase(langCode: 'ar', value: 'زجاج سلكي و شبكي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fabrics
          Chain(
            id: 'sub_prd_mat_fabrics',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Fabrics'),
              Phrase(langCode: 'ar', value: 'أنسجة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_fabric_wool',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wool'),
                  Phrase(langCode: 'ar', value: 'صوف')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_moquette',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Carpets'),
                  Phrase(langCode: 'ar', value: 'موكيت')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_leather',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Leather'),
                  Phrase(langCode: 'ar', value: 'جلود')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_upholstery',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Upholstery fabric'),
                  Phrase(langCode: 'ar', value: 'أنسجة تنجيد')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_polyester',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Polyester'),
                  Phrase(langCode: 'ar', value: 'بوليستر')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_silk',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Silk'),
                  Phrase(langCode: 'ar', value: 'حرير')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_rayon',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rayon'),
                  Phrase(langCode: 'ar', value: 'رايون')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_cotton',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cotton'),
                  Phrase(langCode: 'ar', value: 'قطن')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_linen',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Linen'),
                  Phrase(langCode: 'ar', value: 'كتان')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_velvet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Velvet'),
                  Phrase(langCode: 'ar', value: 'فيلفيت')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_voile',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Voile'),
                  Phrase(langCode: 'ar', value: 'فوال')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_lace',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lace'),
                  Phrase(langCode: 'ar', value: 'دانتيل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cement
          Chain(
            id: 'sub_prd_mat_cement',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Cement'),
              Phrase(langCode: 'ar', value: 'أسمنت')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_cement_white',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'White cement'),
                  Phrase(langCode: 'ar', value: 'أسمنت أبيض')
                ],
              ),
              KW(
                id: 'prd_mat_cement_portland',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Portland'),
                  Phrase(langCode: 'ar', value: 'أسمنت بورتلاندي')
                ],
              ),
              KW(
                id: 'prd_mat_cement_board',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cement boards'),
                  Phrase(langCode: 'ar', value: 'ألواح أسمنتية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bricks
          Chain(
            id: 'sub_prd_mat_bricks',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Bricks'),
              Phrase(langCode: 'ar', value: 'طوب')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_brick_cement',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cement brick'),
                  Phrase(langCode: 'ar', value: 'طوب أسمنتي')
                ],
              ),
              KW(
                id: 'prd_mat_brick_red',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Red brick'),
                  Phrase(langCode: 'ar', value: 'طوب أحمر')
                ],
              ),
              KW(
                id: 'prd_mat_brick_white',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lightweight White brick'),
                  Phrase(langCode: 'ar', value: 'طوب أبيض')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Acrylic
          Chain(
            id: 'sub_prd_mat_acrylic',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Acrylic'),
              Phrase(langCode: 'ar', value: 'أكريليك')
            ],
            sons: <KW>[
              KW(
                id: 'prd_mat_acrylic_tinted',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tinted acrylic'),
                  Phrase(langCode: 'ar', value: 'أكريليك شفاف')
                ],
              ),
              KW(
                id: 'prd_mat_acrylic_frosted',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Frosted acrylic'),
                  Phrase(langCode: 'ar', value: 'أكريليك نصف شفاف')
                ],
              ),
              KW(
                id: 'prd_mat_acrylic_opaque',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Opaque acrylic'),
                  Phrase(langCode: 'ar', value: 'أكريليك غير شفاف')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Plumbing & Sanitary ware
      Chain(
        id: 'group_prd_plumbing',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Plumbing & Sanitary ware'),
          Phrase(langCode: 'ar', value: 'سباكة و أدوات صحية')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Water Treatment
          Chain(
            id: 'sub_prd_plumb_treatment',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Water Treatment'),
              Phrase(langCode: 'ar', value: 'معالجة مياه')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_treatment_filter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Water filters'),
                  Phrase(langCode: 'ar', value: 'فلاتر مياه')
                ],
              ),
              KW(
                id: 'prd_plumbing_treatment_system',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Water treatment systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة معالجة مياه')
                ],
              ),
              KW(
                id: 'prd_plumbing_treatment_tank',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Water tanks'),
                  Phrase(langCode: 'ar', value: 'خزانات مياه')
                ],
              ),
              KW(
                id: 'prd_plumbing_treatment_heater',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Water Heater'),
                  Phrase(langCode: 'ar', value: 'سخانات مياه')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Tub Sanitary ware
          Chain(
            id: 'sub_prd_plumb_tub',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Tub Sanitary ware'),
              Phrase(langCode: 'ar', value: 'أدوات بانيو صحية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_tub_bathTubs',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathtubs'),
                  Phrase(langCode: 'ar', value: ' بانيوهات استحمام')
                ],
              ),
              KW(
                id: 'prd_plumbing_tub_faucet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathtub faucets'),
                  Phrase(langCode: 'ar', value: 'صنابير بانيوهات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Toilet Sanitary ware
          Chain(
            id: 'sub_prd_plumb_toilet',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Toilet Sanitary ware'),
              Phrase(langCode: 'ar', value: 'أدوات مراحيض صحية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_toilet_floorDrain',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom floor drains'),
                  Phrase(langCode: 'ar', value: 'مصارف و بلاعات أرضية للحمامات')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_urinal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Urinals'),
                  Phrase(langCode: 'ar', value: 'مباول')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_bidet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bidet'),
                  Phrase(langCode: 'ar', value: 'بيديه شطاف')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_bidetFaucet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bidet faucets'),
                  Phrase(langCode: 'ar', value: 'صنابير بيديه')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_toilet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Toilets & toilet seats'),
                  Phrase(langCode: 'ar', value: 'مراحيض و مجالس مراحيض')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_rinser',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Toilet rinsers'),
                  Phrase(langCode: 'ar', value: 'شطافات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Shower Sanitary ware
          Chain(
            id: 'sub_prd_plumb_shower',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Shower Sanitary ware'),
              Phrase(langCode: 'ar', value: 'أدوات استحمام صحية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_shower_head',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower heads & Body sprays'),
                  Phrase(langCode: 'ar', value: 'دش و رشاشات دش')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_panel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower panels'),
                  Phrase(langCode: 'ar', value: 'وحدات دش متكاملة')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_steam',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Steam shower cabins'),
                  Phrase(langCode: 'ar', value: 'كابينات دش بخار')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_faucet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tub & shower faucet sets'),
                  Phrase(langCode: 'ar', value: 'أطقم صنابير بانيوهات و دش')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_base',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower pans & bases'),
                  Phrase(langCode: 'ar', value: 'وحدات دش قدم و قواعد')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_accessory',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower accessories'),
                  Phrase(langCode: 'ar', value: 'اكسسوارات دش استحمام')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Sanitary ware
          Chain(
            id: 'sub_prd_plumb_sanitary',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Sanitary ware'),
              Phrase(langCode: 'ar', value: 'أدوات صحية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_sanitary_drain',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drains'),
                  Phrase(langCode: 'ar', value: 'بلاعات / مصارف')
                ],
              ),
              KW(
                id: 'prd_plumbing_sanitary_bibbs',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Hose bibbs'),
                  Phrase(langCode: 'ar', value: 'حنفيات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kitchen Sanitary ware
          Chain(
            id: 'sub_prd_plumb_kitchen',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Kitchen Sanitary ware'),
              Phrase(langCode: 'ar', value: 'أدوات مطبخ صحية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_kitchen_rinser',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rinsers'),
                  Phrase(langCode: 'ar', value: 'مغسلة أكواب')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_sink',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen sinks'),
                  Phrase(langCode: 'ar', value: 'أحواض مطابخ')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_faucet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen faucets'),
                  Phrase(langCode: 'ar', value: 'صنابير مطابخ')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_potFiller',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen pot fillers'),
                  Phrase(langCode: 'ar', value: 'صنابير ملئ وعاء')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_barSink',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bar sinks'),
                  Phrase(langCode: 'ar', value: 'أحواض بار')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_barFaucet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bar faucets'),
                  Phrase(langCode: 'ar', value: 'صنابير بار')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_floorDrain',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kitchen floor drains'),
                  Phrase(langCode: 'ar', value: 'مصارف أرضية مطبخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Handwash Sanitary ware
          Chain(
            id: 'sub_prd_plumb_handwash',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Handwash Sanitary ware'),
              Phrase(langCode: 'ar', value: 'أدوات غسيل أيدي صحية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_handwash_washBasins',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wash basins'),
                  Phrase(langCode: 'ar', value: 'أحواض أيدي')
                ],
              ),
              KW(
                id: 'prd_plumbing_handwash_faucet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom faucets'),
                  Phrase(langCode: 'ar', value: 'صنابير حمام')
                ],
              ),
              KW(
                id: 'prd_plumbing_handwash_accessories',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bathroom accessories'),
                  Phrase(langCode: 'ar', value: 'اكسسوارات حمام')
                ],
              ),
              KW(
                id: 'prd_plumbing_handwash_soap',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lotion & soap dispensers'),
                  Phrase(langCode: 'ar', value: 'حاوية صابون و لوشن')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Connections
          Chain(
            id: 'sub_prd_plumb_connections',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Connections'),
              Phrase(langCode: 'ar', value: 'وصلات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_plumbing_connections_pipes',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pipes'),
                  Phrase(langCode: 'ar', value: 'مواسير صرف و تغذية')
                ],
              ),
              KW(
                id: 'prd_plumbing_connections_fittings',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fittings'),
                  Phrase(langCode: 'ar', value: 'أكواع و وصلات مواسير')
                ],
              ),
              KW(
                id: 'prd_plumbing_connections_valve',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Valves'),
                  Phrase(langCode: 'ar', value: 'محابس')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Pools & Spa
      Chain(
        id: 'group_prd_poolSpa',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Pools & Spa'),
          Phrase(langCode: 'ar', value: 'حمامات سباحة و حمامات صحية')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Swimming Pools
          Chain(
            id: 'sub_prd_pool_pools',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Swimming Pools'),
              Phrase(langCode: 'ar', value: 'حمامات سباحة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_poolSpa_pools_fiberglass',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fiberglass pools'),
                  Phrase(langCode: 'ar', value: 'حمامات سباحة فايبرجلاس')
                ],
              ),
              KW(
                id: 'prd_poolSpa_pools_above',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Above ground  pools'),
                  Phrase(langCode: 'ar', value: 'حمامات سباحة فوق الأرض')
                ],
              ),
              KW(
                id: 'prd_poolSpa_pools_inflatable',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Inflatable pools'),
                  Phrase(langCode: 'ar', value: 'حمامات سباحة قابلة للنفخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Spa
          Chain(
            id: 'sub_prd_pool_spa',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Spa'),
              Phrase(langCode: 'ar', value: 'حمامات صحية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_poolSpa_spa_sauna',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sauna rooms'),
                  Phrase(langCode: 'ar', value: 'غرف ساونا')
                ],
              ),
              KW(
                id: 'prd_poolSpa_spa_steam',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Steam rooms'),
                  Phrase(langCode: 'ar', value: 'غرف بخار')
                ],
              ),
              KW(
                id: 'prd_poolSpa_spa_steamShower',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Steam shower cabins'),
                  Phrase(langCode: 'ar', value: 'وحدات دش استحمام بخار')
                ],
              ),
              KW(
                id: 'prd_poolSpa_spa_jacuzzi',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Jacuzzi & Hot tubs'),
                  Phrase(langCode: 'ar', value: 'جاكوزي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Pools Equipment
          Chain(
            id: 'sub_prd_pool_equipment',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Pools Equipment'),
              Phrase(langCode: 'ar', value: 'عدات حمامات سباحة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_poolSpa_equip_cleaning',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cleaning supplies'),
                  Phrase(langCode: 'ar', value: 'أدوات تنظيف حمام سباحة')
                ],
              ),
              KW(
                id: 'prd_poolSpa_equip_pump',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pumps'),
                  Phrase(langCode: 'ar', value: 'مضخات')
                ],
              ),
              KW(
                id: 'prd_poolSpa_equip_filter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Filters'),
                  Phrase(langCode: 'ar', value: 'فلاتر')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Pool Accessories
          Chain(
            id: 'sub_prd_pool_accessories',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Pool Accessories'),
              Phrase(langCode: 'ar', value: 'اكسسوارات حمامات سباحة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_poolSpa_access_handrail',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Handrails'),
                  Phrase(langCode: 'ar', value: 'درابزين')
                ],
              ),
              KW(
                id: 'prd_poolSpa_access_grate',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gutters & Grating'),
                  Phrase(langCode: 'ar', value: 'مصارف')
                ],
              ),
              KW(
                id: 'prd_poolSpa_access_light',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Lighting'),
                  Phrase(langCode: 'ar', value: 'إضاءة')
                ],
              ),
              KW(
                id: 'prd_poolSpa_access_shower',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Outdoor showers'),
                  Phrase(langCode: 'ar', value: 'وحدات دش استحمام خارجية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Roofing
      Chain(
        id: 'group_prd_roofing',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Roofing'),
          Phrase(langCode: 'ar', value: 'أسطح')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Roof Drainage
          Chain(
            id: 'sub_prd_roof_drainage',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Roof Drainage'),
              Phrase(langCode: 'ar', value: 'صرف أسطح')
            ],
            sons: <KW>[
              KW(
                id: 'prd_roof_drainage_gutter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gutters'),
                  Phrase(langCode: 'ar', value: 'مصارف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Roof Cladding
          Chain(
            id: 'sub_prd_roof_cladding',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Roof Cladding'),
              Phrase(langCode: 'ar', value: 'تجاليد أسطح')
            ],
            sons: <KW>[
              KW(
                id: 'prd_roof_cladding_brick',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Roof bricks & tiles'),
                  Phrase(langCode: 'ar', value: 'قرميد')
                ],
              ),
              KW(
                id: 'prd_roof_cladding_bitumen',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Corrugatedbitumen sheets'),
                  Phrase(langCode: 'ar', value: 'صفائح بيتومينية مموجة')
                ],
              ),
              KW(
                id: 'prd_roof_cladding_metal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Corrugated metal sheets'),
                  Phrase(langCode: 'ar', value: 'صفائح معدنية مموجة شينكو')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Safety
      Chain(
        id: 'group_prd_safety',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Safety'),
          Phrase(langCode: 'ar', value: 'أمن و سلامة')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Safety Equipment
          Chain(
            id: 'sub_prd_safety_equip',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Safety Equipment'),
              Phrase(langCode: 'ar', value: 'معدات سلامة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_safety_equip_gasDetector',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Portable gas detectors'),
                  Phrase(langCode: 'ar', value: 'كاشف غاز يدوي')
                ],
              ),
              KW(
                id: 'prd_safety_equip_rescue',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rescue tools & devices'),
                  Phrase(langCode: 'ar', value: 'أدوات و أجهزة إنقاذ')
                ],
              ),
              KW(
                id: 'prd_safety_equip_firstAid',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Emergency & first aid kits'),
                  Phrase(langCode: 'ar', value: 'أدوات طوارئ و إعافات أولية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Safety Clothes
          Chain(
            id: 'sub_prd_safety_clothes',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Safety Clothes'),
              Phrase(langCode: 'ar', value: 'ملابس أمن و سلامة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_safety_clothes_coverall',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Coveralls'),
                  Phrase(langCode: 'ar', value: 'معاطف عمل')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_chemicalSuit',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Chemical protection suits'),
                  Phrase(langCode: 'ar', value: 'بدلة واقية من الكيماويات')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_eyeProtection',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Eye protectors'),
                  Phrase(langCode: 'ar', value: 'واقيات عيون')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_earProtection',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ear protectors'),
                  Phrase(langCode: 'ar', value: 'واقيات أذن')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_helmet',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Helmets'),
                  Phrase(langCode: 'ar', value: 'خوذ')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_glove',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gloves'),
                  Phrase(langCode: 'ar', value: 'قفازات')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_shoe',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shoes'),
                  Phrase(langCode: 'ar', value: 'أحذية حامية')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_respirator',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Respirators'),
                  Phrase(langCode: 'ar', value: 'كمامات تنفس')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Protection
          Chain(
            id: 'sub_prd_safety_floorProtection',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Floor Protection'),
              Phrase(langCode: 'ar', value: 'حماية أرضيات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_safety_floorProtection_cardboard',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Cardboard roll'),
                  Phrase(langCode: 'ar', value: 'لفة كرتون')
                ],
              ),
              KW(
                id: 'prd_safety_floorProtection_plastic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'plastic roll'),
                  Phrase(langCode: 'ar', value: 'لفة بلاستيك')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Security
      Chain(
        id: 'group_prd_security',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Security'),
          Phrase(langCode: 'ar', value: 'الحماية و الأمان')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Surveillance Systems
          Chain(
            id: 'sub_prd_security_surveillance',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Surveillance Systems'),
              Phrase(langCode: 'ar', value: 'أنظمة مراقبة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_security_surv_camera',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Video surveillance systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة مراقبة فيديو')
                ],
              ),
              KW(
                id: 'prd_security_surv_thermal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Thermal imaging systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة تصوير حراري')
                ],
              ),
              KW(
                id: 'prd_security_surv_motion',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Motion sensors'),
                  Phrase(langCode: 'ar', value: 'حساسات حركة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Security Safes
          Chain(
            id: 'sub_prd_security_safes',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Security Safes'),
              Phrase(langCode: 'ar', value: 'خزائن أمان')
            ],
            sons: <KW>[
              KW(
                id: 'prd_security_safes_wall',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall safes'),
                  Phrase(langCode: 'ar', value: 'خزن حائطية')
                ],
              ),
              KW(
                id: 'prd_security_safes_portable',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Portable safes'),
                  Phrase(langCode: 'ar', value: 'خزن متنقلة')
                ],
              ),
              KW(
                id: 'prd_security_safes_mini',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mini safes'),
                  Phrase(langCode: 'ar', value: 'خزن صغيرة')
                ],
              ),
              KW(
                id: 'prd_security_safes_vault',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Vaults'),
                  Phrase(langCode: 'ar', value: 'خزن سرداب')
                ],
              ),
              KW(
                id: 'prd_security_safes_fire',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Fire proof safes'),
                  Phrase(langCode: 'ar', value: 'خزن مضادة للحريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Road Control
          Chain(
            id: 'sub_prd_security_roadControl',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Road Control'),
              Phrase(langCode: 'ar', value: 'تحكم في الطرق')
            ],
            sons: <KW>[
              KW(
                id: 'prd_security_road_bollard',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bollards'),
                  Phrase(langCode: 'ar', value: 'بولارد فاصل حركة أرضي')
                ],
              ),
              KW(
                id: 'prd_security_road_tire',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tire killers'),
                  Phrase(langCode: 'ar', value: 'قاتل إطارات')
                ],
              ),
              KW(
                id: 'prd_security_road_barrier',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Road barriers'),
                  Phrase(langCode: 'ar', value: 'فاصل طريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Accessibility Systems
          Chain(
            id: 'sub_prd_security_accessibility',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Accessibility Systems'),
              Phrase(langCode: 'ar', value: 'أنظمة دخول')
            ],
            sons: <KW>[
              KW(
                id: 'prd_security_access_accessControl',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Access control systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة دخول')
                ],
              ),
              KW(
                id: 'prd_security_access_eas',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'EAS systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة أمن هوائي EAS')
                ],
              ),
              KW(
                id: 'prd_security_access_detector',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Metal detector portals'),
                  Phrase(langCode: 'ar', value: 'بوابات كشف معادن')
                ],
              ),
              KW(
                id: 'prd_security_access_turnstile',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Turnstiles'),
                  Phrase(langCode: 'ar', value: 'بوابات مرور فردية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Smart home
      Chain(
        id: 'group_prd_smartHome',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Smart home'),
          Phrase(langCode: 'ar', value: 'تجهيزات المنازل الذكية')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Automation Systems
          Chain(
            id: 'sub_prd_smart_automation',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Automation Systems'),
              Phrase(langCode: 'ar', value: 'أنظمة أوتوماتية')
            ],
            sons: <KW>[
              KW(
                id: 'prd_smart_auto_center',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Home automation centers'),
                  Phrase(langCode: 'ar', value: 'أنظمة تحكم منزلي آلية')
                ],
              ),
              KW(
                id: 'prd_smart_auto_system',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Automation systems'),
                  Phrase(langCode: 'ar', value: 'لوحات تحكم منزلي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Audio Systems
          Chain(
            id: 'sub_prd_smart_audio',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Audio Systems'),
              Phrase(langCode: 'ar', value: 'أنظمة صوت')
            ],
            sons: <KW>[
              KW(
                id: 'prd_smart_audio_system',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Audio systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة صوتية')
                ],
              ),
              KW(
                id: 'prd_smart_audio_theatre',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Home theatre systems'),
                  Phrase(langCode: 'ar', value: 'أنظمة مسرح منزلي')
                ],
              ),
              KW(
                id: 'prd_smart_audio_speaker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall & ceiling speakers'),
                  Phrase(langCode: 'ar', value: 'سماعات حوائط و أسقف')
                ],
              ),
              KW(
                id: 'prd_smart_audio_wirelessSpeaker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wireless speakers'),
                  Phrase(langCode: 'ar', value: 'سماعات لاسلكية')
                ],
              ),
              KW(
                id: 'prd_smart_audio_controller',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Audio controllers'),
                  Phrase(langCode: 'ar', value: 'متحكمات صوت')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Stairs
      Chain(
        id: 'group_prd_stairs',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Stairs'),
          Phrase(langCode: 'ar', value: 'سلالم')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Handrails
          Chain(
            id: 'sub_prd_stairs_handrails',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Handrails'),
              Phrase(langCode: 'ar', value: 'درابزين سلالم')
            ],
            sons: <KW>[
              KW(
                id: 'prd_stairs_handrails_wood',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wooden handrails'),
                  Phrase(langCode: 'ar', value: 'درابزين خشبي')
                ],
              ),
              KW(
                id: 'prd_stairs_handrails_metal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Metal handrails'),
                  Phrase(langCode: 'ar', value: 'درابزين معدني')
                ],
              ),
              KW(
                id: 'prd_stairs_handrails_parts',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Handrail parts'),
                  Phrase(langCode: 'ar', value: 'أجزاء درابزين')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Light Structures
      Chain(
        id: 'group_prd_structure',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Light Structures'),
          Phrase(langCode: 'ar', value: 'هياكل و منشآت خفيفة')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Shades
          Chain(
            id: 'sub_prd_struc_shades',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Shades'),
              Phrase(langCode: 'ar', value: 'مظلات')
            ],
            sons: <KW>[
              KW(
                id: 'prd_structure_shades_pergola',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pergola'),
                  Phrase(langCode: 'ar', value: 'برجولة')
                ],
              ),
              KW(
                id: 'prd_structure_shades_gazebo',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gazebos'),
                  Phrase(langCode: 'ar', value: 'جازيبو')
                ],
              ),
              KW(
                id: 'prd_structure_shades_sail',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shade sails'),
                  Phrase(langCode: 'ar', value: 'تغطيات شراعية')
                ],
              ),
              KW(
                id: 'prd_structure_shades_canopy',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Canopy'),
                  Phrase(langCode: 'ar', value: 'مظلة أرضية')
                ],
              ),
              KW(
                id: 'prd_structure_shades_awning',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Awning'),
                  Phrase(langCode: 'ar', value: 'مظلة حائطية')
                ],
              ),
              KW(
                id: 'prd_structure_shades_tent',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'tent'),
                  Phrase(langCode: 'ar', value: 'خيمة')
                ],
              ),
              KW(
                id: 'prd_structure_shades_umbrella',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Umbrella'),
                  Phrase(langCode: 'ar', value: 'شمسية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Light Structures
          Chain(
            id: 'sub_prd_struc_light',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Light Structures'),
              Phrase(langCode: 'ar', value: 'منشآت خفيفة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_structure_light_arbor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Garden Arbor'),
                  Phrase(langCode: 'ar', value: 'معرش شجري')
                ],
              ),
              KW(
                id: 'prd_structure_light_shed',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shed'),
                  Phrase(langCode: 'ar', value: 'كوخ')
                ],
              ),
              KW(
                id: 'prd_structure_light_kiosk',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kiosk'),
                  Phrase(langCode: 'ar', value: 'كشك')
                ],
              ),
              KW(
                id: 'prd_structure_light_playhouse',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Kids playhouse'),
                  Phrase(langCode: 'ar', value: 'بيت لعب أطفال')
                ],
              ),
              KW(
                id: 'prd_structure_light_greenHouse',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Greenhouse'),
                  Phrase(langCode: 'ar', value: 'صوبة')
                ],
              ),
              KW(
                id: 'prd_structure_light_glassHouse',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Glass house'),
                  Phrase(langCode: 'ar', value: 'بيت زجاجي')
                ],
              ),
              KW(
                id: 'prd_structure_light_trailer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Construction trailers & Caravans'),
                  Phrase(langCode: 'ar', value: 'كارافان و مقطورات')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Walls & Room Partitions
      Chain(
        id: 'group_prd_walls',
        icon: 'id',
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Walls & Room Partitions'),
          Phrase(langCode: 'ar', value: 'حوائط و فواصل غرف')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Wall Cladding
          Chain(
            id: 'sub_prd_walls_cladding',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Wall Cladding'),
              Phrase(langCode: 'ar', value: 'تبليط و تجلاليد حوائط')
            ],
            sons: <KW>[
              KW(
                id: 'prd_walls_cladding_mosaic',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mosaic tiling'),
                  Phrase(langCode: 'ar', value: 'موزايك حائط')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_murals',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tile mural'),
                  Phrase(langCode: 'ar', value: 'جدارية')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_borders',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Accent, trim & border tiles'),
                  Phrase(langCode: 'ar', value: 'حليات و زوايا')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_tiles',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall tiles'),
                  Phrase(langCode: 'ar', value: 'بلاطات حائط')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_veneer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Siding & stone veneer slices'),
                  Phrase(langCode: 'ar', value: 'شرائح صخرية')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_panels',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall panels'),
                  Phrase(langCode: 'ar', value: 'بانوهات')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_wood',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wood wall panels'),
                  Phrase(langCode: 'ar', value: 'تجاليد خشب')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_metal',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Metal cladding'),
                  Phrase(langCode: 'ar', value: 'تجاليد معدنية')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_wallpaper',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wall paper'),
                  Phrase(langCode: 'ar', value: 'ورق حائط')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Room Partitions
          Chain(
            id: 'sub_prd_walls_partitions',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Room Partitions'),
              Phrase(langCode: 'ar', value: 'فواصل غرف')
            ],
            sons: <KW>[
              KW(
                id: 'prd_walls_partitions_screens',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Screens & room divider'),
                  Phrase(langCode: 'ar', value: 'فاصل غرفة')
                ],
              ),
              KW(
                id: 'prd_walls_partitions_showerStalls',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Shower cabinet'),
                  Phrase(langCode: 'ar', value: 'وحدة دش استحمام')
                ],
              ),
              KW(
                id: 'prd_walls_partitions_doubleWalls',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Double wall section'),
                  Phrase(langCode: 'ar', value: 'قطاع حائط مزدوج')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Moldings & Millwork
          Chain(
            id: 'sub_prd_walls_moldings',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Moldings & Millwork'),
              Phrase(langCode: 'ar', value: 'قوالب و عواميد')
            ],
            sons: <KW>[
              KW(
                id: 'prd_walls_molding_rail',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Rails & trims'),
                  Phrase(langCode: 'ar', value: 'وزر حائطي')
                ],
              ),
              KW(
                id: 'prd_walls_molding_onlay',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Onlays & Appliques'),
                  Phrase(langCode: 'ar', value: 'منحوتات و زخرفيات')
                ],
              ),
              KW(
                id: 'prd_walls_molding_column',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Columns & Capitals'),
                  Phrase(langCode: 'ar', value: 'أعمدة و تيجان')
                ],
              ),
              KW(
                id: 'prd_walls_molding_medallion',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ceiling Medallions'),
                  Phrase(langCode: 'ar', value: 'مدالية سقف')
                ],
              ),
              KW(
                id: 'prd_walls_molding_corbel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Corbels'),
                  Phrase(langCode: 'ar', value: 'كرابيل أسقف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Ceiling Cladding
          Chain(
            id: 'sub_prd_walls_ceiling',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Ceiling Cladding'),
              Phrase(langCode: 'ar', value: 'تجاليد أسقف')
            ],
            sons: <KW>[
              KW(
                id: 'prd_walls_ceiling_tiles',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ceiling tiles'),
                  Phrase(langCode: 'ar', value: 'بلاطات تجليد أسقف')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------

       */

    ],
  );
}
