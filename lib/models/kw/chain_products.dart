import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/kw/chain.dart';
import 'package:bldrs/models/kw/kw.dart';

abstract class ChainProducts {

  static const Chain chain = const Chain(
    id: 'products',
    names: <Name>[
      Name(code: 'en', value: 'Products'),
      Name(code: 'ar', value: '')
    ],
    sons: <Chain>[
      // -----------------------------------------------
      /// Appliances
      const Chain(
        id: 'group_prd_appliances',
        names: <Name>[
          Name(code: 'en', value: 'Appliances'),
          Name(code: 'ar', value: 'أجهزة كهربائية')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Waste Disposal Appliances
          const Chain(
            id: 'sub_prd_app_wasteDisposal',
            names: <Name>[
              Name(code: 'en', value: 'Waste Disposal Appliances'),
              Name(code: 'ar', value: 'أجهزة تخلص من النفايات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_waste_compactor',
                names: <Name>[
                  Name(code: 'en', value: 'Trash compactor'),
                  Name(code: 'ar', value: 'حاويات ضغط قمامة')
                ],
              ),
              KW(
                id: 'prd_app_waste_disposer',
                names: <Name>[
                  Name(code: 'en', value: 'Food waste disposers'),
                  Name(code: 'ar', value: 'مطاحن فضلات طعام')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Snacks Appliances
          const Chain(
            id: 'sub_prd_app_snacks',
            names: <Name>[
              Name(code: 'en', value: 'Snacks Appliances'),
              Name(code: 'ar', value: 'أجهزة تحضير وجبات خفيفة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_snack_icecream',
                names: <Name>[
                  Name(code: 'en', value: 'Ice cream makers'),
                  Name(code: 'ar', value: 'ماكينات آيس كريم')
                ],
              ),
              KW(
                id: 'prd_app_snack_popcorn',
                names: <Name>[
                  Name(code: 'en', value: 'Popcorn makers'),
                  Name(code: 'ar', value: 'ماكينات فشار')
                ],
              ),
              KW(
                id: 'prd_app_snack_toaster',
                names: <Name>[
                  Name(code: 'en', value: 'Toasters'),
                  Name(code: 'ar', value: 'محمصة خبز')
                ],
              ),
              KW(
                id: 'prd_app_snack_waffle',
                names: <Name>[
                  Name(code: 'en', value: 'Waffle makers'),
                  Name(code: 'ar', value: 'ماكينات وافل')
                ],
              ),
              KW(
                id: 'prd_app_snack_bread',
                names: <Name>[
                  Name(code: 'en', value: 'Bread machine'),
                  Name(code: 'ar', value: 'ماكينات خبز')
                ],
              ),
              KW(
                id: 'prd_app_snack_canOpener',
                names: <Name>[
                  Name(code: 'en', value: 'Can opener'),
                  Name(code: 'ar', value: 'فواتح معلبات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Refrigeration
          const Chain(
            id: 'sub_prd_app_refrigeration',
            names: <Name>[
              Name(code: 'en', value: 'Refrigeration'),
              Name(code: 'ar', value: 'مبردات و ثلاجات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_ref_fridge',
                names: <Name>[
                  Name(code: 'en', value: 'Fridges'),
                  Name(code: 'ar', value: 'ثلاجات')
                ],
              ),
              KW(
                id: 'prd_app_ref_freezer',
                names: <Name>[
                  Name(code: 'en', value: 'Freezers'),
                  Name(code: 'ar', value: 'ثلاجات تجميد')
                ],
              ),
              KW(
                id: 'prd_app_ref_icemaker',
                names: <Name>[
                  Name(code: 'en', value: 'Ice makers'),
                  Name(code: 'ar', value: 'ماكينات ثلج')
                ],
              ),
              KW(
                id: 'prd_app_ref_water',
                names: <Name>[
                  Name(code: 'en', value: 'Water Dispensers'),
                  Name(code: 'ar', value: 'كولدير مياه')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Cooking
          const Chain(
            id: 'sub_prd_app_outdoorCooking',
            names: <Name>[
              Name(code: 'en', value: 'Outdoor Cooking'),
              Name(code: 'ar', value: 'أجهزة طبخ خارجي')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_outcook_grill',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Grills'),
                  Name(code: 'ar', value: 'شوايات و أفران خارجية')
                ],
              ),
              KW(
                id: 'prd_app_outcook_grillTools',
                names: <Name>[
                  Name(code: 'en', value: 'Grill tools and accessories'),
                  Name(code: 'ar', value: 'أدوات و اكسسوارات شوي')
                ],
              ),
              KW(
                id: 'prd_app_outcook_oven',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoors Ovens'),
                  Name(code: 'ar', value: 'أفران خارجية')
                ],
              ),
              KW(
                id: 'prd_app_outcook_smoker',
                names: <Name>[
                  Name(code: 'en', value: 'Smokers'),
                  Name(code: 'ar', value: 'أفران مدخنة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Media Appliances
          const Chain(
            id: 'sub_prd_app_media',
            names: <Name>[
              Name(code: 'en', value: 'Media Appliances'),
              Name(code: 'ar', value: 'أجهزة ميديا')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_media_tv',
                names: <Name>[
                  Name(code: 'en', value: 'Televisions'),
                  Name(code: 'ar', value: 'تلفزيونات و شاشات')
                ],
              ),
              KW(
                id: 'prd_app_media_soundSystem',
                names: <Name>[
                  Name(code: 'en', value: 'Sound systems'),
                  Name(code: 'ar', value: 'أنظمة صوت')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Indoor Cooking
          const Chain(
            id: 'sub_prd_app_indoorCooking',
            names: <Name>[
              Name(code: 'en', value: 'Indoor Cooking'),
              Name(code: 'ar', value: 'أجهزة طبخ داخلي')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_incook_microwave',
                names: <Name>[
                  Name(code: 'en', value: 'Microwave ovens'),
                  Name(code: 'ar', value: 'فرن مايكرويف')
                ],
              ),
              KW(
                id: 'prd_app_incook_fryer',
                names: <Name>[
                  Name(code: 'en', value: 'Fryers'),
                  Name(code: 'ar', value: 'قلايات')
                ],
              ),
              KW(
                id: 'prd_app_incook_elecGrill',
                names: <Name>[
                  Name(code: 'en', value: 'Electric grills'),
                  Name(code: 'ar', value: 'شوايات كهربائية')
                ],
              ),
              KW(
                id: 'prd_app_incook_cooktop',
                names: <Name>[
                  Name(code: 'en', value: 'Cooktops'),
                  Name(code: 'ar', value: 'بوتاجاز سطحي')
                ],
              ),
              KW(
                id: 'prd_app_incook_range',
                names: <Name>[
                  Name(code: 'en', value: 'Gas & Electric ranges'),
                  Name(code: 'ar', value: 'بوتاجاز كهربائي أو غاز')
                ],
              ),
              KW(
                id: 'prd_app_incook_oven',
                names: <Name>[
                  Name(code: 'en', value: 'Gas & Electric Ovens'),
                  Name(code: 'ar', value: 'فرن كهربائي أو غاز')
                ],
              ),
              KW(
                id: 'prd_app_incook_hood',
                names: <Name>[
                  Name(code: 'en', value: 'Range hoods & vents'),
                  Name(code: 'ar', value: 'شفاطات بوتاجاز')
                ],
              ),
              KW(
                id: 'prd_app_incook_skillet',
                names: <Name>[
                  Name(code: 'en', value: 'Electric skillets'),
                  Name(code: 'ar', value: 'مقلاه كهربائية')
                ],
              ),
              KW(
                id: 'prd_app_incook_rooster',
                names: <Name>[
                  Name(code: 'en', value: 'Electric roaster ovens'),
                  Name(code: 'ar', value: 'فرن شواء')
                ],
              ),
              KW(
                id: 'prd_app_incook_hotPlate',
                names: <Name>[
                  Name(code: 'en', value: 'Hot plates & burners'),
                  Name(code: 'ar', value: 'مواقد و لوحات ساخنة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// HouseKeeping Appliances
          const Chain(
            id: 'sub_prd_app_housekeeping',
            names: <Name>[
              Name(code: 'en', value: 'HouseKeeping Appliances'),
              Name(code: 'ar', value: 'أجهزة غسيل و نظافة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_hk_washingMachine',
                names: <Name>[
                  Name(code: 'en', value: 'Washing & Drying machines'),
                  Name(code: 'ar', value: 'مغاسل و مناشف ملابس')
                ],
              ),
              KW(
                id: 'prd_app_hk_dishWasher',
                names: <Name>[
                  Name(code: 'en', value: 'Dish washer'),
                  Name(code: 'ar', value: 'مغسلة صحون')
                ],
              ),
              KW(
                id: 'prd_app_hk_warmingDrawers',
                names: <Name>[
                  Name(code: 'en', value: 'Warming drawers'),
                  Name(code: 'ar', value: 'أدراج تدفئة')
                ],
              ),
              KW(
                id: 'prd_app_hk_vacuum',
                names: <Name>[
                  Name(code: 'en', value: 'Vacuum cleaner'),
                  Name(code: 'ar', value: 'مكانس كهربائية')
                ],
              ),
              KW(
                id: 'prd_app_hk_iron',
                names: <Name>[
                  Name(code: 'en', value: 'Irons'),
                  Name(code: 'ar', value: 'مكواه ')
                ],
              ),
              KW(
                id: 'prd_app_hk_steamer',
                names: <Name>[
                  Name(code: 'en', value: 'Garment steamers'),
                  Name(code: 'ar', value: 'مكواه بخارية')
                ],
              ),
              KW(
                id: 'prd_app_hk_carpet',
                names: <Name>[
                  Name(code: 'en', value: 'Carpet cleaners'),
                  Name(code: 'ar', value: 'مغاسل سجاد')
                ],
              ),
              KW(
                id: 'prd_app_hk_sewing',
                names: <Name>[
                  Name(code: 'en', value: 'Sewing machines'),
                  Name(code: 'ar', value: 'ماكينات خياطة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Food Processors
          const Chain(
            id: 'sub_prd_app_foodProcessors',
            names: <Name>[
              Name(code: 'en', value: 'Food Processors'),
              Name(code: 'ar', value: 'محضرات طعام')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_pro_slowCooker',
                names: <Name>[
                  Name(code: 'en', value: 'Slow cookers'),
                  Name(code: 'ar', value: 'مواقد بطيئة')
                ],
              ),
              KW(
                id: 'prd_app_pro_pro',
                names: <Name>[
                  Name(code: 'en', value: 'Food processor'),
                  Name(code: 'ar', value: 'أجهزة معالجة للطعام')
                ],
              ),
              KW(
                id: 'prd_app_pro_meat',
                names: <Name>[
                  Name(code: 'en', value: 'Meat grinders'),
                  Name(code: 'ar', value: 'مطاحن لحوم')
                ],
              ),
              KW(
                id: 'prd_app_pro_rice',
                names: <Name>[
                  Name(code: 'en', value: 'Rice cookers & steamers'),
                  Name(code: 'ar', value: 'حلل طهي أرز')
                ],
              ),
              KW(
                id: 'prd_app_pro_dehydrator',
                names: <Name>[
                  Name(code: 'en', value: 'Food Dehydrators'),
                  Name(code: 'ar', value: 'مجففات طعام')
                ],
              ),
              KW(
                id: 'prd_app_pro_mixer',
                names: <Name>[
                  Name(code: 'en', value: 'Food Mixers'),
                  Name(code: 'ar', value: 'آلة عجن و خلط')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Drinks Appliances
          const Chain(
            id: 'sub_prd_app_drinks',
            names: <Name>[
              Name(code: 'en', value: 'Drinks Appliances'),
              Name(code: 'ar', value: 'أجهزة تحضير مشروبات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_drink_coffeeMaker',
                names: <Name>[
                  Name(code: 'en', value: 'Coffee maker'),
                  Name(code: 'ar', value: 'ماكينات قهوة')
                ],
              ),
              KW(
                id: 'prd_app_drink_coffeeGrinder',
                names: <Name>[
                  Name(code: 'en', value: 'Coffee grinder'),
                  Name(code: 'ar', value: 'مطاحن قهوة')
                ],
              ),
              KW(
                id: 'prd_app_drink_espresso',
                names: <Name>[
                  Name(code: 'en', value: 'Espresso machine'),
                  Name(code: 'ar', value: 'ماكينات اسبريسو')
                ],
              ),
              KW(
                id: 'prd_app_drink_blender',
                names: <Name>[
                  Name(code: 'en', value: 'Blender'),
                  Name(code: 'ar', value: 'خلاطات')
                ],
              ),
              KW(
                id: 'prd_app_drink_juicer',
                names: <Name>[
                  Name(code: 'en', value: 'Juicers'),
                  Name(code: 'ar', value: 'عصارات')
                ],
              ),
              KW(
                id: 'prd_app_drink_kettle',
                names: <Name>[
                  Name(code: 'en', value: 'Boilers / Kettles'),
                  Name(code: 'ar', value: 'غلايات و سخانات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bathroom Appliances
          const Chain(
            id: 'sub_prd_app_bathroom',
            names: <Name>[
              Name(code: 'en', value: 'Bathroom Appliances'),
              Name(code: 'ar', value: 'أجهزة حمام كهربائية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_app_bath_handDryer',
                names: <Name>[
                  Name(code: 'en', value: 'Hand dryer'),
                  Name(code: 'ar', value: 'منشفة أيدي')
                ],
              ),
              KW(
                id: 'prd_app_bath_hairDryer',
                names: <Name>[
                  Name(code: 'en', value: 'Hair dryer'),
                  Name(code: 'ar', value: 'سشوار شعر')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Doors & Windows
      const Chain(
        id: 'group_prd_doors',
        names: <Name>[
          Name(code: 'en', value: 'Doors & Windows'),
          Name(code: 'ar', value: 'أبواب و شبابيك')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Windows
          const Chain(
            id: 'sub_prd_door_windows',
            names: <Name>[
              Name(code: 'en', value: 'Windows'),
              Name(code: 'ar', value: 'شبابيك')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_doors_win_glassPanel',
                names: <Name>[
                  Name(code: 'en', value: 'Window panels'),
                  Name(code: 'ar', value: 'قطاعات شبابيك')
                ],
              ),
              KW(
                id: 'prd_doors_win_skyLight',
                names: <Name>[
                  Name(code: 'en', value: 'Skylights'),
                  Name(code: 'ar', value: 'قطاعات شبابيك سقفية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Shutters
          const Chain(
            id: 'sub_prd_doors_shutters',
            names: <Name>[
              Name(code: 'en', value: 'Shutters'),
              Name(code: 'ar', value: 'شيش حصيرة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_doors_shutters_metal',
                names: <Name>[
                  Name(code: 'en', value: 'Metal shutters'),
                  Name(code: 'ar', value: 'شيش حصيرة معدني')
                ],
              ),
              KW(
                id: 'prd_doors_shutters_aluminum',
                names: <Name>[
                  Name(code: 'en', value: 'Aluminum shutters'),
                  Name(code: 'ar', value: 'شيش حصيرة ألومنيوم')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Hardware
          const Chain(
            id: 'sub_prd_door_hardware',
            names: <Name>[
              Name(code: 'en', value: 'Hardware'),
              Name(code: 'ar', value: 'اكسسوارات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_doors_hardware_hinges',
                names: <Name>[
                  Name(code: 'en', value: 'Hinges & Accessories'),
                  Name(code: 'ar', value: 'مفصلات و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_doorbell',
                names: <Name>[
                  Name(code: 'en', value: 'Door Chimes'),
                  Name(code: 'ar', value: 'أجراس أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_entrySet',
                names: <Name>[
                  Name(code: 'en', value: 'Door Entry sets'),
                  Name(code: 'ar', value: 'أطقم مقابض أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_lever',
                names: <Name>[
                  Name(code: 'en', value: 'Door levers'),
                  Name(code: 'ar', value: 'أكر أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_knob',
                names: <Name>[
                  Name(code: 'en', value: 'Door knobs'),
                  Name(code: 'ar', value: 'مقابض أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_knocker',
                names: <Name>[
                  Name(code: 'en', value: 'Door knockers'),
                  Name(code: 'ar', value: 'مطارق أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_lock',
                names: <Name>[
                  Name(code: 'en', value: 'Door locks'),
                  Name(code: 'ar', value: 'أقفال أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_stop',
                names: <Name>[
                  Name(code: 'en', value: 'Door stops & bumpers'),
                  Name(code: 'ar', value: 'مصدات أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_sliding',
                names: <Name>[
                  Name(code: 'en', value: 'Sliding doors systems'),
                  Name(code: 'ar', value: 'مجاري أبواب منزلقة')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_hook',
                names: <Name>[
                  Name(code: 'en', value: 'Door hooks'),
                  Name(code: 'ar', value: 'كلّاب أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_eye',
                names: <Name>[
                  Name(code: 'en', value: 'Door eye'),
                  Name(code: 'ar', value: 'عيون أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_sign',
                names: <Name>[
                  Name(code: 'en', value: 'Door signs'),
                  Name(code: 'ar', value: 'لافتات أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_dust',
                names: <Name>[
                  Name(code: 'en', value: 'Door dust draught'),
                  Name(code: 'ar', value: 'فرشاة تراب ')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_closer',
                names: <Name>[
                  Name(code: 'en', value: 'Door closers'),
                  Name(code: 'ar', value: 'غالقات أبواب')
                ],
              ),
              KW(
                id: 'prd_doors_hardware_tint',
                names: <Name>[
                  Name(code: 'en', value: 'Window tint films'),
                  Name(code: 'ar', value: 'أفلام زجاج شبابيك')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Doors
          const Chain(
            id: 'sub_prd_door_doors',
            names: <Name>[
              Name(code: 'en', value: 'Doors'),
              Name(code: 'ar', value: 'أبواب')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_doors_doors_front',
                names: <Name>[
                  Name(code: 'en', value: 'Front doors'),
                  Name(code: 'ar', value: 'أبواب أمامية')
                ],
              ),
              KW(
                id: 'prd_doors_doors_interior',
                names: <Name>[
                  Name(code: 'en', value: 'Interior doors'),
                  Name(code: 'ar', value: 'أبواب داخلية')
                ],
              ),
              KW(
                id: 'prd_doors_doors_folding',
                names: <Name>[
                  Name(code: 'en', value: 'Folding &  Accordion doors'),
                  Name(code: 'ar', value: 'أبواب قابلة للطي و أكورديون')
                ],
              ),
              KW(
                id: 'prd_doors_doors_shower',
                names: <Name>[
                  Name(code: 'en', value: 'Shower doors'),
                  Name(code: 'ar', value: 'أبواب دش استحمام')
                ],
              ),
              KW(
                id: 'prd_doors_doors_patio',
                names: <Name>[
                  Name(code: 'en', value: 'Patio & Sliding doors'),
                  Name(code: 'ar', value: 'أبواب تراس منزلقة')
                ],
              ),
              KW(
                id: 'prd_doors_doors_screen',
                names: <Name>[
                  Name(code: 'en', value: 'Screen & Mesh doors'),
                  Name(code: 'ar', value: 'أبواب سلك شبكي')
                ],
              ),
              KW(
                id: 'prd_doors_doors_garage',
                names: <Name>[
                  Name(code: 'en', value: 'Garage doors'),
                  Name(code: 'ar', value: 'أبواب جراج')
                ],
              ),
              KW(
                id: 'prd_doors_doors_metalGate',
                names: <Name>[
                  Name(code: 'en', value: 'Metal gates'),
                  Name(code: 'ar', value: 'بوابات معدنية')
                ],
              ),
              KW(
                id: 'prd_doors_doors_escape',
                names: <Name>[
                  Name(code: 'en', value: 'Escape doors'),
                  Name(code: 'ar', value: 'أبواب هروب')
                ],
              ),
              KW(
                id: 'prd_doors_doors_blast',
                names: <Name>[
                  Name(code: 'en', value: 'Blast proof doors'),
                  Name(code: 'ar', value: 'أبواب مقاومة للإنفجار')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Electricity
      const Chain(
        id: 'group_prd_electricity',
        names: <Name>[
          Name(code: 'en', value: 'Electricity'),
          Name(code: 'ar', value: 'كهرباء')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Power Storage
          const Chain(
            id: 'sub_prd_elec_powerStorage',
            names: <Name>[
              Name(code: 'en', value: 'Power Storage'),
              Name(code: 'ar', value: 'تخزين كهرباء')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_storage_rechargeable',
                names: <Name>[
                  Name(code: 'en', value: 'Rechargeable batteries'),
                  Name(code: 'ar', value: 'بطاريات قابلة للشحن')
                ],
              ),
              KW(
                id: 'prd_elec_storage_nonRechargeable',
                names: <Name>[
                  Name(code: 'en', value: 'Non Rechargeable batteries'),
                  Name(code: 'ar', value: 'بطاريات غير قابلة للشحن')
                ],
              ),
              KW(
                id: 'prd_elec_storage_accessories',
                names: <Name>[
                  Name(code: 'en', value: 'Battery accessories'),
                  Name(code: 'ar', value: 'اكسسوارات بطاريات')
                ],
              ),
              KW(
                id: 'prd_elec_storage_portable',
                names: <Name>[
                  Name(code: 'en', value: 'Portable power storage'),
                  Name(code: 'ar', value: 'تخزين طاقة متنقل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electricity Organizers
          const Chain(
            id: 'sub_prd_elec_organization',
            names: <Name>[
              Name(code: 'en', value: 'Electricity Organizers'),
              Name(code: 'ar', value: 'منسقات كهربائية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_org_load',
                names: <Name>[
                  Name(code: 'en', value: 'Load centers'),
                  Name(code: 'ar', value: 'مراكز حمل كهربي')
                ],
              ),
              KW(
                id: 'prd_elec_org_conduit',
                names: <Name>[
                  Name(code: 'en', value: 'Conduit & fittings'),
                  Name(code: 'ar', value: 'خراطيم كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_org_junction',
                names: <Name>[
                  Name(code: 'en', value: 'Junction boxes & covers'),
                  Name(code: 'ar', value: 'بواط توزيع كهرباء و أغطيتها')
                ],
              ),
              KW(
                id: 'prd_elec_org_hook',
                names: <Name>[
                  Name(code: 'en', value: 'Hooks & cable organizers'),
                  Name(code: 'ar', value: 'خطافات و منظمات أسلاك')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electricity Instruments
          const Chain(
            id: 'sub_prd_elec_instruments',
            names: <Name>[
              Name(code: 'en', value: 'Electricity Instruments'),
              Name(code: 'ar', value: 'أجهزة كهربائية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_instr_factor',
                names: <Name>[
                  Name(code: 'en', value: 'Power factor controllers'),
                  Name(code: 'ar', value: 'منظمات عامل طاقة')
                ],
              ),
              KW(
                id: 'prd_elec_instr_measure',
                names: <Name>[
                  Name(code: 'en', value: 'Power measurement devices'),
                  Name(code: 'ar', value: 'أجهزة قياس كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_instr_clamp',
                names: <Name>[
                  Name(code: 'en', value: 'Power clamp meters'),
                  Name(
                      code: 'ar', value: 'أجهزة قياس كهرباء كلّابة معلقة')
                ],
              ),
              KW(
                id: 'prd_elec_instr_powerMeter',
                names: <Name>[
                  Name(code: 'en', value: 'Power meters'),
                  Name(code: 'ar', value: 'عداد كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_instr_resistance',
                names: <Name>[
                  Name(code: 'en', value: 'Resistance testers'),
                  Name(code: 'ar', value: 'فاحص مقاومة')
                ],
              ),
              KW(
                id: 'prd_elec_instr_transformer',
                names: <Name>[
                  Name(code: 'en', value: 'Transformers'),
                  Name(code: 'ar', value: 'محولات كهربائية')
                ],
              ),
              KW(
                id: 'prd_elec_instr_frequency',
                names: <Name>[
                  Name(code: 'en', value: 'Frequency inverters'),
                  Name(code: 'ar', value: 'عاكس تردد')
                ],
              ),
              KW(
                id: 'prd_elec_instr_relay',
                names: <Name>[
                  Name(code: 'en', value: 'Current relays'),
                  Name(code: 'ar', value: 'ممررات تيار كهربي')
                ],
              ),
              KW(
                id: 'prd_elec_inst_dc',
                names: <Name>[
                  Name(code: 'en', value: 'Power supplies'),
                  Name(code: 'ar', value: 'مزودات طاقة')
                ],
              ),
              KW(
                id: 'prd_elec_inst_inverter',
                names: <Name>[
                  Name(code: 'en', value: 'Power inverters'),
                  Name(code: 'ar', value: 'محولات طاقة')
                ],
              ),
              KW(
                id: 'prd_elec_inst_regulator',
                names: <Name>[
                  Name(code: 'en', value: 'Voltage regulators'),
                  Name(code: 'ar', value: 'منظمات جهد كهربي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electricity Generators
          const Chain(
            id: 'sub_prd_elec_generators',
            names: <Name>[
              Name(code: 'en', value: 'Electricity Generators'),
              Name(code: 'ar', value: 'مولدات كهرباء')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_gen_solar',
                names: <Name>[
                  Name(code: 'en', value: 'Solar power'),
                  Name(code: 'ar', value: 'طاقة شمسية')
                ],
              ),
              KW(
                id: 'prd_elec_gen_wind',
                names: <Name>[
                  Name(code: 'en', value: 'Wind power'),
                  Name(code: 'ar', value: 'طاقة رياح')
                ],
              ),
              KW(
                id: 'prd_elec_gen_hydro',
                names: <Name>[
                  Name(code: 'en', value: 'Hydro power'),
                  Name(code: 'ar', value: 'طاقة تيارات')
                ],
              ),
              KW(
                id: 'prd_elec_gen_steam',
                names: <Name>[
                  Name(code: 'en', value: 'Steam power'),
                  Name(code: 'ar', value: 'طاقة بخار')
                ],
              ),
              KW(
                id: 'prd_elec_gen_diesel',
                names: <Name>[
                  Name(code: 'en', value: 'Diesel power'),
                  Name(code: 'ar', value: 'طاقة ديزل')
                ],
              ),
              KW(
                id: 'prd_elec_gen_gasoline',
                names: <Name>[
                  Name(code: 'en', value: 'Gasoline power'),
                  Name(code: 'ar', value: 'طاقة بنزين')
                ],
              ),
              KW(
                id: 'prd_elec_gen_gas',
                names: <Name>[
                  Name(code: 'en', value: 'Natural gas power'),
                  Name(code: 'ar', value: 'طاقة غاز طبيعي')
                ],
              ),
              KW(
                id: 'prd_elec_gen_hydrogen',
                names: <Name>[
                  Name(code: 'en', value: 'Hydrogen power'),
                  Name(code: 'ar', value: 'طاقة هيدروجين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electrical Switches
          const Chain(
            id: 'sub_prd_elec_switches',
            names: <Name>[
              Name(code: 'en', value: 'Electrical Switches'),
              Name(code: 'ar', value: 'مفاتيح كهربائية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_switches_outlet',
                names: <Name>[
                  Name(code: 'en', value: 'Wall switches & Outlets'),
                  Name(code: 'ar', value: 'مفاتيح كهربائية و إضاءة')
                ],
              ),
              KW(
                id: 'prd_elec_switches_thermostat',
                names: <Name>[
                  Name(code: 'en', value: 'Thermostats'),
                  Name(code: 'ar', value: 'ترموستات منظم حرارة')
                ],
              ),
              KW(
                id: 'prd_elec_switches_dimmer',
                names: <Name>[
                  Name(code: 'en', value: 'Dimmers'),
                  Name(code: 'ar', value: 'متحكم و معتم قوة الإضاءة')
                ],
              ),
              KW(
                id: 'prd_elec_switches_plate',
                names: <Name>[
                  Name(
                      code: 'en', value: 'Switch plates & outlet covers'),
                  Name(code: 'ar', value: 'لوحات و أغطية كهربائية')
                ],
              ),
              KW(
                id: 'prd_elec_switches_circuit',
                names: <Name>[
                  Name(code: 'en', value: 'Circuit breakers & fuses'),
                  Name(code: 'ar', value: 'قواطع و فيوزات كهربائية')
                ],
              ),
              KW(
                id: 'prd_elec_switches_doorbell',
                names: <Name>[
                  Name(code: 'en', value: 'Doorbells'),
                  Name(code: 'ar', value: 'أجراس أبواب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electrical Motors
          const Chain(
            id: 'sub_prd_elec_motors',
            names: <Name>[
              Name(code: 'en', value: 'Electrical Motors'),
              Name(code: 'ar', value: 'مواتير كهربائية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_motor_ac',
                names: <Name>[
                  Name(code: 'en', value: 'AC motors'),
                  Name(code: 'ar', value: 'مواتير تيار متردد')
                ],
              ),
              KW(
                id: 'prd_elec_motor_dc',
                names: <Name>[
                  Name(code: 'en', value: 'DC motors'),
                  Name(code: 'ar', value: 'مواتير تيار ثابت')
                ],
              ),
              KW(
                id: 'prd_elec_motor_vibro',
                names: <Name>[
                  Name(code: 'en', value: 'Vibration motors'),
                  Name(code: 'ar', value: 'مواتير اهتزاز')
                ],
              ),
              KW(
                id: 'prd_elec_motor_controller',
                names: <Name>[
                  Name(code: 'en', value: 'Motor controllers & drivers'),
                  Name(code: 'ar', value: 'متحكمات مواتير')
                ],
              ),
              KW(
                id: 'prd_elec_motor_part',
                names: <Name>[
                  Name(code: 'en', value: 'Motor parts'),
                  Name(code: 'ar', value: 'أجزاء مواتير')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Electrical Connectors
          const Chain(
            id: 'sub_prd_elec_connectors',
            names: <Name>[
              Name(code: 'en', value: 'Electrical Connectors'),
              Name(code: 'ar', value: 'وصلات كهربائية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_connectors_alligator',
                names: <Name>[
                  Name(code: 'en', value: 'Alligator clips'),
                  Name(code: 'ar', value: 'مقلمة تمساح')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_connector',
                names: <Name>[
                  Name(code: 'en', value: 'Power connectors'),
                  Name(code: 'ar', value: 'لقم توصيل')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_terminal',
                names: <Name>[
                  Name(code: 'en', value: 'Terminals & accessories'),
                  Name(code: 'ar', value: 'أقطاب و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_strip',
                names: <Name>[
                  Name(code: 'en', value: 'Power strips'),
                  Name(code: 'ar', value: 'مشترك كهربائي')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_socket',
                names: <Name>[
                  Name(code: 'en', value: 'Sockets & plugs'),
                  Name(code: 'ar', value: 'مقابس كهرباء')
                ],
              ),
              KW(
                id: 'prd_elec_connectors_adapter',
                names: <Name>[
                  Name(code: 'en', value: 'Adapters'),
                  Name(code: 'ar', value: 'محولات كهربائية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cables & Wires
          const Chain(
            id: 'sub_prd_elec_cables',
            names: <Name>[
              Name(code: 'en', value: 'Cables & Wires'),
              Name(code: 'ar', value: 'كابلات أسلاك')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_elec_cables_wire',
                names: <Name>[
                  Name(code: 'en', value: 'Cables & Wires'),
                  Name(code: 'ar', value: 'أسلاك')
                ],
              ),
              KW(
                id: 'prd_elec_cables_extension',
                names: <Name>[
                  Name(code: 'en', value: 'Extension cables'),
                  Name(code: 'ar', value: 'أسلاك إطالة')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Fire Fighting
      const Chain(
        id: 'group_prd_fireFighting',
        names: <Name>[
          Name(code: 'en', value: 'Fire Fighting'),
          Name(code: 'ar', value: 'مقاومة حريق')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Pumps & Controllers
          const Chain(
            id: 'sub_prd_fire_pumpsCont',
            names: <Name>[
              Name(code: 'en', value: 'Pumps & Controllers'),
              Name(code: 'ar', value: 'مضخات و متحكمات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_fireFighting_pump_pump',
                names: <Name>[
                  Name(code: 'en', value: 'Fire pumps'),
                  Name(code: 'ar', value: 'مضخات حريق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_filter',
                names: <Name>[
                  Name(code: 'en', value: 'Filtration systems'),
                  Name(code: 'ar', value: 'أنظمة تصفية مياه')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_system',
                names: <Name>[
                  Name(code: 'en', value: 'Wet systems'),
                  Name(code: 'ar', value: 'أنظمة إطفاء سائلة')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_foamSystems',
                names: <Name>[
                  Name(code: 'en', value: 'Foam & Powder based systems'),
                  Name(code: 'ar', value: 'أنظمة إطفاء فوم و بودرة')
                ],
              ),
              KW(
                id: 'prd_fireFighting_pump_gasSystems',
                names: <Name>[
                  Name(code: 'en', value: 'Gas based systems'),
                  Name(code: 'ar', value: 'أنظمة إطفاء غازية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fire Fighting Equipment
          const Chain(
            id: 'sub_prd_fire_equip',
            names: <Name>[
              Name(code: 'en', value: 'Fire Fighting Equipment'),
              Name(code: 'ar', value: 'معدات مكافحة حريق')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_fireFighting_equip_hydrant',
                names: <Name>[
                  Name(code: 'en', value: 'Fire hydrants'),
                  Name(code: 'ar', value: 'صنبور إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_extinguisher',
                names: <Name>[
                  Name(code: 'en', value: 'Fire Extinguishers'),
                  Name(code: 'ar', value: 'طفاية حريق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_pipe',
                names: <Name>[
                  Name(code: 'en', value: 'Pipes, Valves & Risers'),
                  Name(code: 'ar', value: 'مواسير، مفاتيح، صواعد')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_reel',
                names: <Name>[
                  Name(code: 'en', value: 'Reels & Cabinets'),
                  Name(code: 'ar', value: 'بكرة خرطوم حريق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_hose',
                names: <Name>[
                  Name(code: 'en', value: 'Hoses & Accessories'),
                  Name(code: 'ar', value: 'خراطيم حريق و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_curtains',
                names: <Name>[
                  Name(code: 'en', value: 'Fire curtains'),
                  Name(code: 'ar', value: 'ستائر حريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fire Fighting Cloth
          const Chain(
            id: 'sub_prd_fire_clothes',
            names: <Name>[
              Name(code: 'en', value: 'Fire Fighting Cloth'),
              Name(code: 'ar', value: 'ملابس مكافحة حريق')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_fireFighting_equip_suit',
                names: <Name>[
                  Name(code: 'en', value: 'Suits'),
                  Name(code: 'ar', value: 'بدلة إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_helmet',
                names: <Name>[
                  Name(code: 'en', value: 'Helmets & hoods'),
                  Name(code: 'ar', value: 'خوذة و أوشحة إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_glove',
                names: <Name>[
                  Name(code: 'en', value: 'Gloves'),
                  Name(code: 'ar', value: 'قفازات إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_boots',
                names: <Name>[
                  Name(code: 'en', value: 'Boots'),
                  Name(code: 'ar', value: 'أحذية إطفاء')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_torches',
                names: <Name>[
                  Name(code: 'en', value: 'Drip torches'),
                  Name(code: 'ar', value: 'شعلة تنقيط')
                ],
              ),
              KW(
                id: 'prd_fireFighting_equip_breathing',
                names: <Name>[
                  Name(code: 'en', value: 'Breathing apparatus'),
                  Name(code: 'ar', value: 'جهاز تنفس')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fire Detectors
          const Chain(
            id: 'sub_prd_fire_detectors',
            names: <Name>[
              Name(code: 'en', value: 'Fire Detectors'),
              Name(code: 'ar', value: 'كاشفات حريق')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_fireFighting_detectors_alarm',
                names: <Name>[
                  Name(
                      code: 'en',
                      value: 'Fire detection & Alarm systems'),
                  Name(code: 'ar', value: 'أنظمة كشف و إنذار حرائق')
                ],
              ),
              KW(
                id: 'prd_fireFighting_detectors_control',
                names: <Name>[
                  Name(
                      code: 'en', value: 'Extinguishing control systems'),
                  Name(code: 'ar', value: 'أنظمة تحكم إطفاء حرائق')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Floors & ٍSkirting
      const Chain(
        id: 'group_prd_floors',
        names: <Name>[
          Name(code: 'en', value: 'Floors & ٍSkirting'),
          Name(code: 'ar', value: 'أرضيات و وزر')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Skirting
          const Chain(
            id: 'sub_prd_floors_skirting',
            names: <Name>[
              Name(code: 'en', value: 'Skirting'),
              Name(code: 'ar', value: 'وزر')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_floors_skirting_skirting',
                names: <Name>[
                  Name(code: 'en', value: 'Floor skirting'),
                  Name(code: 'ar', value: 'وزر أرضيات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Tiles
          const Chain(
            id: 'sub_prd_floors_tiles',
            names: <Name>[
              Name(code: 'en', value: 'Floor Tiles'),
              Name(code: 'ar', value: 'بلاط أرضيات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_floors_tiles_ceramic',
                names: <Name>[
                  Name(code: 'en', value: 'Ceramic'),
                  Name(code: 'ar', value: 'سيراميك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_porcelain',
                names: <Name>[
                  Name(code: 'en', value: 'Porcelain'),
                  Name(code: 'ar', value: 'بورسلين')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_mosaic',
                names: <Name>[
                  Name(code: 'en', value: 'Mosaic'),
                  Name(code: 'ar', value: 'موزاييك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_stones',
                names: <Name>[
                  Name(code: 'en', value: 'Stones'),
                  Name(code: 'ar', value: 'حجر')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_marble',
                names: <Name>[
                  Name(code: 'en', value: 'Marble'),
                  Name(code: 'ar', value: 'رخام')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_granite',
                names: <Name>[
                  Name(code: 'en', value: 'Granite'),
                  Name(code: 'ar', value: 'جرانيت')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_interlock',
                names: <Name>[
                  Name(code: 'en', value: 'Interlock & brick tiles'),
                  Name(code: 'ar', value: 'إنترلوك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_cork',
                names: <Name>[
                  Name(code: 'en', value: 'Cork tiles'),
                  Name(code: 'ar', value: 'كورك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_parquet',
                names: <Name>[
                  Name(code: 'en', value: 'Parquet'),
                  Name(code: 'ar', value: 'باركيه')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_glass',
                names: <Name>[
                  Name(code: 'en', value: 'Acrylic & Glass tiles'),
                  Name(code: 'ar', value: 'زجاج و أكريليك')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_grc',
                names: <Name>[
                  Name(code: 'en', value: 'GRC tiles'),
                  Name(code: 'ar', value: 'جي آر سي')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_metal',
                names: <Name>[
                  Name(code: 'en', value: 'Metal tiles'),
                  Name(code: 'ar', value: 'معادن')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_terrazzo',
                names: <Name>[
                  Name(code: 'en', value: 'Terrazzo tiles'),
                  Name(code: 'ar', value: 'تيرازو')
                ],
              ),
              KW(
                id: 'prd_floors_tiles_medallions',
                names: <Name>[
                  Name(code: 'en', value: 'Floor Medallion & Inlays'),
                  Name(code: 'ar', value: 'ميدالية أرض')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Planks
          const Chain(
            id: 'sub_prd_floors_planks',
            names: <Name>[
              Name(code: 'en', value: 'Floor Planks'),
              Name(code: 'ar', value: 'ألواح أرضيات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_floors_planks_bamboo',
                names: <Name>[
                  Name(code: 'en', value: 'Bamboo flooring'),
                  Name(code: 'ar', value: 'بامبو')
                ],
              ),
              KW(
                id: 'prd_floors_planks_engineered',
                names: <Name>[
                  Name(code: 'en', value: 'Engineered wood plank'),
                  Name(code: 'ar', value: 'ألواح خشب هندسية')
                ],
              ),
              KW(
                id: 'prd_floors_planks_hardwood',
                names: <Name>[
                  Name(code: 'en', value: 'Hardwood plank'),
                  Name(code: 'ar', value: 'ألواح خب صلب')
                ],
              ),
              KW(
                id: 'prd_floors_planks_laminate',
                names: <Name>[
                  Name(code: 'en', value: 'Laminate plank'),
                  Name(code: 'ar', value: 'قشرة خشب')
                ],
              ),
              KW(
                id: 'prd_floors_planks_wpc',
                names: <Name>[
                  Name(code: 'en', value: 'WPC plank'),
                  Name(code: 'ar', value: 'ألواح دبليو بي سي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Paving
          const Chain(
            id: 'sub_prd_floors_paving',
            names: <Name>[
              Name(code: 'en', value: 'Floor Paving'),
              Name(code: 'ar', value: 'تمهيد أرضيات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_floors_paving_screed',
                names: <Name>[
                  Name(code: 'en', value: 'Cement screed'),
                  Name(code: 'ar', value: 'أرضية أسمنتية')
                ],
              ),
              KW(
                id: 'prd_floors_paving_epoxy',
                names: <Name>[
                  Name(code: 'en', value: 'Epoxy coating'),
                  Name(code: 'ar', value: 'إيبوكسي')
                ],
              ),
              KW(
                id: 'prd_floors_paving_asphalt',
                names: <Name>[
                  Name(code: 'en', value: 'Asphalt flooring'),
                  Name(code: 'ar', value: 'أسفلت')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Covering
          const Chain(
            id: 'sub_prd_floors_covering',
            names: <Name>[
              Name(code: 'en', value: 'Floor Covering'),
              Name(code: 'ar', value: 'تغطيات أرضيات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_floors_covering_vinyl',
                names: <Name>[
                  Name(code: 'en', value: 'Vinyl flooring'),
                  Name(code: 'ar', value: 'فينيل')
                ],
              ),
              KW(
                id: 'prd_floors_covering_carpet',
                names: <Name>[
                  Name(code: 'en', value: 'Carpet flooring'),
                  Name(code: 'ar', value: 'سجاد')
                ],
              ),
              KW(
                id: 'prd_floors_covering_raised',
                names: <Name>[
                  Name(code: 'en', value: 'Raised flooring'),
                  Name(code: 'ar', value: 'أرضية مرتفعة')
                ],
              ),
              KW(
                id: 'prd_floors_covering_rubber',
                names: <Name>[
                  Name(code: 'en', value: 'Rubber mats'),
                  Name(code: 'ar', value: 'أرضية مطاط')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Furniture
      const Chain(
        id: 'group_prd_furniture',
        names: <Name>[
          Name(code: 'en', value: 'Furniture'),
          Name(code: 'ar', value: 'أثاث و مفروشات')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Waste Disposal
          const Chain(
            id: 'sub_prd_furn_wasteDisposal',
            names: <Name>[
              Name(code: 'en', value: 'Waste Disposal'),
              Name(code: 'ar', value: 'تخلص من النفايات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_waste_small',
                names: <Name>[
                  Name(code: 'en', value: 'Small trash cans'),
                  Name(code: 'ar', value: 'سلات قمامة صغيرة')
                ],
              ),
              KW(
                id: 'prd_furn_waste_large',
                names: <Name>[
                  Name(code: 'en', value: 'Large trash cans'),
                  Name(code: 'ar', value: 'سلات قمامة كبيرة')
                ],
              ),
              KW(
                id: 'prd_furn_waste_pull',
                names: <Name>[
                  Name(code: 'en', value: 'Pullout trash bins'),
                  Name(code: 'ar', value: 'سلات قمامة منزلقة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Vanity Tops
          const Chain(
            id: 'sub_prd_furn_tops',
            names: <Name>[
              Name(code: 'en', value: 'Vanity Tops'),
              Name(code: 'ar', value: 'أسطح وحدات حمام و مطبخ')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_tops_bathVanity',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom vanity tops'),
                  Name(code: 'ar', value: 'مسطحات وحدات حمام')
                ],
              ),
              KW(
                id: 'prd_furn_tops_kit',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen counter tops'),
                  Name(code: 'ar', value: 'مسطحات و جوانب وحدات مطبخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Tables
          const Chain(
            id: 'sub_prd_furn_tables',
            names: <Name>[
              Name(code: 'en', value: 'Tables'),
              Name(code: 'ar', value: 'طاولات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_tables_dining',
                names: <Name>[
                  Name(code: 'en', value: 'Dining tables'),
                  Name(code: 'ar', value: 'طاولات طعام')
                ],
              ),
              KW(
                id: 'prd_furn_tables_bistro',
                names: <Name>[
                  Name(code: 'en', value: 'Pub & Bistro table'),
                  Name(code: 'ar', value: 'طاولات مقاهي')
                ],
              ),
              KW(
                id: 'prd_furn_tables_coffee',
                names: <Name>[
                  Name(code: 'en', value: 'Coffee table'),
                  Name(code: 'ar', value: 'طاولات قهوة')
                ],
              ),
              KW(
                id: 'prd_furn_tables_folding',
                names: <Name>[
                  Name(code: 'en', value: 'Folding table'),
                  Name(code: 'ar', value: 'طاولات قابلة للطي')
                ],
              ),
              KW(
                id: 'prd_furn_tables_console',
                names: <Name>[
                  Name(code: 'en', value: 'Console'),
                  Name(code: 'ar', value: 'كونسول')
                ],
              ),
              KW(
                id: 'prd_furn_tables_meeting',
                names: <Name>[
                  Name(code: 'en', value: 'Meeting tables'),
                  Name(code: 'ar', value: 'طاولات اجتماعات')
                ],
              ),
              KW(
                id: 'prd_furn_tables_side',
                names: <Name>[
                  Name(code: 'en', value: 'Side & End tables'),
                  Name(code: 'ar', value: 'طاولات جانبية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Seating Benches
          const Chain(
            id: 'sub_prd_furn_seatingBench',
            names: <Name>[
              Name(code: 'en', value: 'Seating Benches'),
              Name(code: 'ar', value: 'مجالس')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_bench_shower',
                names: <Name>[
                  Name(code: 'en', value: 'Shower benches & seats'),
                  Name(code: 'ar', value: 'مجالس دش استحمام')
                ],
              ),
              KW(
                id: 'prd_furn_bench_bedVanity',
                names: <Name>[
                  Name(code: 'en', value: 'Vanity stools & benches'),
                  Name(code: 'ar', value: 'كراسي وحدة حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bench_bedBench',
                names: <Name>[
                  Name(code: 'en', value: 'Bedroom benches'),
                  Name(code: 'ar', value: 'مجالس غرفة نوم')
                ],
              ),
              KW(
                id: 'prd_furn_bench_storage',
                names: <Name>[
                  Name(code: 'en', value: 'Accent & storage benches'),
                  Name(code: 'ar', value: 'مجالس تخزين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Planting
          const Chain(
            id: 'sub_prd_furn_planting',
            names: <Name>[
              Name(code: 'en', value: 'Planting'),
              Name(code: 'ar', value: 'زراعة منزلية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_planting_stand',
                names: <Name>[
                  Name(code: 'en', value: 'Plant stands'),
                  Name(code: 'ar', value: 'منصة نباتات')
                ],
              ),
              KW(
                id: 'prd_furn_planting_potting',
                names: <Name>[
                  Name(code: 'en', value: 'Potting tables'),
                  Name(code: 'ar', value: 'طاولات أصيص نبات')
                ],
              ),
              KW(
                id: 'prd_furn_planting_pot',
                names: <Name>[
                  Name(code: 'en', value: 'Plants pots'),
                  Name(code: 'ar', value: 'أصيص نبات')
                ],
              ),
              KW(
                id: 'prd_furn_planting_vase',
                names: <Name>[
                  Name(code: 'en', value: 'Vases'),
                  Name(code: 'ar', value: 'مزهريات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Tables
          const Chain(
            id: 'sub_prd_furn_outTables',
            names: <Name>[
              Name(code: 'en', value: 'Outdoor Tables'),
              Name(code: 'ar', value: 'طاولات خارجية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_outTable_coffee',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Coffee tables'),
                  Name(code: 'ar', value: 'طاولات قهوة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outTable_side',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor side tables'),
                  Name(code: 'ar', value: 'طاولات جانبية خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outTable_dining',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor dining tables'),
                  Name(code: 'ar', value: 'طاولات طعام خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outTable_cart',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor serving carts'),
                  Name(code: 'ar', value: 'عربة تقديم خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Seating
          const Chain(
            id: 'sub_prd_furn_outSeating',
            names: <Name>[
              Name(code: 'en', value: 'Outdoor Seating'),
              Name(code: 'ar', value: 'مقاعد خارجية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_outSeat_lounge',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor lounge chairs'),
                  Name(code: 'ar', value: 'كراسي معيشة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_dining',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor dining chairs'),
                  Name(code: 'ar', value: 'كراسي مائدة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_bar',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor bar stools'),
                  Name(code: 'ar', value: 'كراسي بار خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_chaise',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Chaise Lounges'),
                  Name(code: 'ar', value: 'شيزلونج خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_glider',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor gliders'),
                  Name(code: 'ar', value: 'جلايدر خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_rocking',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Rocking chairs'),
                  Name(code: 'ar', value: 'كراسي هزازة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_adirondack',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Adirondack chairs'),
                  Name(code: 'ar', value: 'كراسي أديرونداك خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_love',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor love seats'),
                  Name(code: 'ar', value: 'مجالس ثنائية خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_poolLounger',
                names: <Name>[
                  Name(code: 'en', value: 'Pool lounger'),
                  Name(code: 'ar', value: 'سرائر حمام سباحة')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_bench',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor benches'),
                  Name(code: 'ar', value: 'مجالس مسطحة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_swing',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor porch swings'),
                  Name(code: 'ar', value: 'كنب هزاز خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_outSeat_sofa',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor sofas'),
                  Name(code: 'ar', value: 'أريكة خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Organizers
          const Chain(
            id: 'sub_prd_furn_organizers',
            names: <Name>[
              Name(code: 'en', value: 'Organizers'),
              Name(code: 'ar', value: 'منظمات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_org_shelf',
                names: <Name>[
                  Name(code: 'en', value: 'Display & wall shelves'),
                  Name(code: 'ar', value: 'أرفف عرض حائطي')
                ],
              ),
              KW(
                id: 'prd_furn_org_drawer',
                names: <Name>[
                  Name(code: 'en', value: 'Drawer organizers'),
                  Name(code: 'ar', value: 'منظمات أدراج')
                ],
              ),
              KW(
                id: 'prd_furn_org_closet',
                names: <Name>[
                  Name(code: 'en', value: 'Closet Organizers'),
                  Name(code: 'ar', value: 'منظمات دولاب ملابس')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Office Furniture
          const Chain(
            id: 'sub_prd_furn_office',
            names: <Name>[
              Name(code: 'en', value: 'Office Furniture'),
              Name(code: 'ar', value: 'أثاث مكاتب')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_office_desk',
                names: <Name>[
                  Name(code: 'en', value: 'Office desks'),
                  Name(code: 'ar', value: 'مكاتب')
                ],
              ),
              KW(
                id: 'prd_furn_office_deskAccess',
                names: <Name>[
                  Name(code: 'en', value: 'Desk accessories'),
                  Name(code: 'ar', value: 'اكسسوارات مكاتب')
                ],
              ),
              KW(
                id: 'prd_furn_office_drafting',
                names: <Name>[
                  Name(code: 'en', value: 'Drafting tables'),
                  Name(code: 'ar', value: 'طاولات رسم')
                ],
              ),
              KW(
                id: 'prd_furn_officeStore_filing',
                names: <Name>[
                  Name(code: 'en', value: 'Filing cabinets'),
                  Name(code: 'ar', value: 'كابينات ملفات')
                ],
              ),
              KW(
                id: 'prd_furn_officeStore_cart',
                names: <Name>[
                  Name(code: 'en', value: 'Office carts & stands'),
                  Name(code: 'ar', value: 'عربات مكاتب و منصات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Living Storage
          const Chain(
            id: 'sub_prd_furn_livingStorage',
            names: <Name>[
              Name(code: 'en', value: 'Living Storage'),
              Name(code: 'ar', value: 'خزائن غرفة معيشة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_living_blanket',
                names: <Name>[
                  Name(code: 'en', value: 'Blanket & Quilt racks'),
                  Name(code: 'ar', value: 'وحدات بطانية و لحاف')
                ],
              ),
              KW(
                id: 'prd_furn_living_chest',
                names: <Name>[
                  Name(code: 'en', value: 'Accent chests'),
                  Name(code: 'ar', value: 'وحدات صندوقية')
                ],
              ),
              KW(
                id: 'prd_furn_living_bookcase',
                names: <Name>[
                  Name(code: 'en', value: 'Bookcases'),
                  Name(code: 'ar', value: 'مكاتب كتب')
                ],
              ),
              KW(
                id: 'prd_furn_living_media',
                names: <Name>[
                  Name(code: 'en', value: 'Media cabinets & TV tables'),
                  Name(code: 'ar', value: 'وحدات تلفزيون و ميديا')
                ],
              ),
              KW(
                id: 'prd_furn_living_mediaRack',
                names: <Name>[
                  Name(code: 'en', value: 'Media racks'),
                  Name(code: 'ar', value: 'أرفف ميديا')
                ],
              ),
              KW(
                id: 'prd_furn_living_hallTree',
                names: <Name>[
                  Name(code: 'en', value: 'Hall trees'),
                  Name(code: 'ar', value: 'شماعات القاعة')
                ],
              ),
              KW(
                id: 'prd_furn_living_barCart',
                names: <Name>[
                  Name(code: 'en', value: 'Bar carts'),
                  Name(code: 'ar', value: 'عربات بار')
                ],
              ),
              KW(
                id: 'prd_furn_living_umbrella',
                names: <Name>[
                  Name(code: 'en', value: 'Coat racks & umbrella stands'),
                  Name(code: 'ar', value: 'شماعات معاطف و شمسيات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Laundry
          const Chain(
            id: 'sub_prd_furn_laundry',
            names: <Name>[
              Name(code: 'en', value: 'Laundry'),
              Name(code: 'ar', value: 'تجهيزات مغسلة ملابس')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_laundry_dryingRack',
                names: <Name>[
                  Name(code: 'en', value: 'Drying racks'),
                  Name(code: 'ar', value: 'أرفف تجفيف ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_laundry_ironingTable',
                names: <Name>[
                  Name(code: 'en', value: 'Ironing table'),
                  Name(code: 'ar', value: 'طاولات كي ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_laundry_hamper',
                names: <Name>[
                  Name(code: 'en', value: 'Laundry hampers'),
                  Name(code: 'ar', value: 'سلات غسيل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kitchen Storage
          const Chain(
            id: 'sub_prd_furn_kitchenStorage',
            names: <Name>[
              Name(code: 'en', value: 'Kitchen Storage'),
              Name(code: 'ar', value: 'خزائن مطبخ')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_kitStore_cabinet',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen cabinet'),
                  Name(code: 'ar', value: 'كابينات مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_pantry',
                names: <Name>[
                  Name(code: 'en', value: 'Pantry cabinet'),
                  Name(code: 'ar', value: 'كابينات تخزين')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_baker',
                names: <Name>[
                  Name(code: 'en', value: 'Baker\'s racks'),
                  Name(code: 'ar', value: 'وحدة أرفف خباز')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_island',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen island'),
                  Name(code: 'ar', value: 'وحدات جزيرة مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_utilityShelf',
                names: <Name>[
                  Name(code: 'en', value: 'Utility shelves'),
                  Name(code: 'ar', value: 'أرفف خدمية')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_utilityCart',
                names: <Name>[
                  Name(code: 'en', value: 'Utility carts'),
                  Name(code: 'ar', value: 'عربات خدمية')
                ],
              ),
              KW(
                id: 'prd_furn_kitStore_kitCart',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen carts'),
                  Name(code: 'ar', value: 'عربات مطبخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kitchen Accessories
          const Chain(
            id: 'sub_prd_furn_Kitchen Accessories',
            names: <Name>[
              Name(code: 'en', value: 'Kitchen Accessories'),
              Name(code: 'ar', value: 'اكسسوارات مطبخ')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_kitaccess_rack',
                names: <Name>[
                  Name(code: 'en', value: 'Holders and racks'),
                  Name(code: 'ar', value: 'وحدات تنظيم مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_drawerOrg',
                names: <Name>[
                  Name(code: 'en', value: 'Drawer organizers'),
                  Name(code: 'ar', value: 'وحدات تنظيم أدراج مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_paperHolder',
                names: <Name>[
                  Name(code: 'en', value: 'Paper towel holders'),
                  Name(code: 'ar', value: 'حاملات مناديل مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_shelfLiner',
                names: <Name>[
                  Name(code: 'en', value: 'Drawer & shelf liners'),
                  Name(code: 'ar', value: 'بطانة أدراج و أرفف مطبخ')
                ],
              ),
              KW(
                id: 'prd_furn_kitaccess_bookstand',
                names: <Name>[
                  Name(code: 'en', value: 'Book stands'),
                  Name(code: 'ar', value: 'منصات كتب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kids Furniture
          const Chain(
            id: 'sub_prd_furn_kids',
            names: <Name>[
              Name(code: 'en', value: 'Kids Furniture'),
              Name(code: 'ar', value: 'أثاث أطفال')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_kids_set',
                names: <Name>[
                  Name(code: 'en', value: 'Kids bedroom sets'),
                  Name(code: 'ar', value: 'أطقم نوم أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_vanity',
                names: <Name>[
                  Name(code: 'en', value: 'Kids Vanities'),
                  Name(code: 'ar', value: 'تسريحات أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_highChair',
                names: <Name>[
                  Name(code: 'en', value: 'Kids high chairs'),
                  Name(code: 'ar', value: 'كراسي مرتفعة للأطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_chair',
                names: <Name>[
                  Name(code: 'en', value: 'Kids seating & chairs'),
                  Name(code: 'ar', value: 'كراسي أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_dresser',
                names: <Name>[
                  Name(code: 'en', value: 'Kids Dressers'),
                  Name(code: 'ar', value: 'وحدات تخزين أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_bookcase',
                names: <Name>[
                  Name(code: 'en', value: 'Kids Bookcases'),
                  Name(code: 'ar', value: 'مكاتب كتب أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_nightstand',
                names: <Name>[
                  Name(code: 'en', value: 'Kids nightstands'),
                  Name(code: 'ar', value: 'وحدات سرير أطفال جانبية')
                ],
              ),
              KW(
                id: 'prd_furn_kids_box',
                names: <Name>[
                  Name(code: 'en', value: 'Kids boxes & organizers'),
                  Name(code: 'ar', value: 'صناديق أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_rug',
                names: <Name>[
                  Name(code: 'en', value: 'Kids rugs'),
                  Name(code: 'ar', value: 'سجاد أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_bed',
                names: <Name>[
                  Name(code: 'en', value: 'Kids beds'),
                  Name(code: 'ar', value: 'سرير أطفال')
                ],
              ),
              KW(
                id: 'prd_furn_kids_cradle',
                names: <Name>[
                  Name(code: 'en', value: 'Toddler beds & cradles'),
                  Name(code: 'ar', value: 'سرير و مهد رضيع')
                ],
              ),
              KW(
                id: 'prd_furn_kids_desk',
                names: <Name>[
                  Name(code: 'en', value: 'Kids desks'),
                  Name(code: 'ar', value: 'مكاتب أطفال')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Furniture Parts
          const Chain(
            id: 'sub_prd_furn_parts',
            names: <Name>[
              Name(code: 'en', value: 'Furniture Parts'),
              Name(code: 'ar', value: 'أجزاء أثاث')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_parts_tableLeg',
                names: <Name>[
                  Name(code: 'en', value: 'Table legs'),
                  Name(code: 'ar', value: 'أرجل طاولات')
                ],
              ),
              KW(
                id: 'prd_furn_parts_tableTop',
                names: <Name>[
                  Name(code: 'en', value: 'Table tops'),
                  Name(code: 'ar', value: 'أسطح طاولات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Furniture Accessories
          const Chain(
            id: 'sub_prd_furn_accessories',
            names: <Name>[
              Name(code: 'en', value: 'Furniture Accessories'),
              Name(code: 'ar', value: 'اكسسوارات أثاث')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_access_mirror',
                names: <Name>[
                  Name(code: 'en', value: 'Wall Mirrors'),
                  Name(code: 'ar', value: 'مرايا حائط')
                ],
              ),
              KW(
                id: 'prd_furn_access_clock',
                names: <Name>[
                  Name(code: 'en', value: 'Wall clocks'),
                  Name(code: 'ar', value: 'ساعات حائط')
                ],
              ),
              KW(
                id: 'prd_furn_access_step',
                names: <Name>[
                  Name(code: 'en', value: 'Step ladders & stools'),
                  Name(code: 'ar', value: 'عتبات')
                ],
              ),
              KW(
                id: 'prd_furn_access_charging',
                names: <Name>[
                  Name(code: 'en', value: 'Charging station'),
                  Name(code: 'ar', value: 'محطات شحن')
                ],
              ),
              KW(
                id: 'prd_furn_access_magazine',
                names: <Name>[
                  Name(code: 'en', value: 'Magazine racks'),
                  Name(code: 'ar', value: 'أرفف مجلات')
                ],
              ),
              KW(
                id: 'prd_furn_org_wall',
                names: <Name>[
                  Name(code: 'en', value: 'Wall Organizers'),
                  Name(code: 'ar', value: 'منظمات حائطية')
                ],
              ),
              KW(
                id: 'prd_furn_access_furnProtector',
                names: <Name>[
                  Name(code: 'en', value: 'Furniture protectors'),
                  Name(code: 'ar', value: 'حاميات أثاث')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Dressing Storage
          const Chain(
            id: 'sub_prd_furn_dressingStorage',
            names: <Name>[
              Name(code: 'en', value: 'Dressing Storage'),
              Name(code: 'ar', value: 'خزائن ملابس')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_dressStore_wardrobe',
                names: <Name>[
                  Name(code: 'en', value: 'Armories & Wardrobes'),
                  Name(code: 'ar', value: 'دواليب ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_dresser',
                names: <Name>[
                  Name(code: 'en', value: 'Dresser'),
                  Name(code: 'ar', value: 'تسريحات')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_shoe',
                names: <Name>[
                  Name(code: 'en', value: 'Shoes closet'),
                  Name(code: 'ar', value: 'دولاب أحذية')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_clothRack',
                names: <Name>[
                  Name(code: 'en', value: 'Clothes racks'),
                  Name(code: 'ar', value: 'شماعات ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_valet',
                names: <Name>[
                  Name(code: 'en', value: 'Clothes Valets'),
                  Name(code: 'ar', value: 'فاليه ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_dressStore_jewelry',
                names: <Name>[
                  Name(code: 'en', value: 'Jewelry armories'),
                  Name(code: 'ar', value: 'وحدات مجوهرات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Dining Storage
          const Chain(
            id: 'sub_prd_furn_diningStorage',
            names: <Name>[
              Name(code: 'en', value: 'Dining Storage'),
              Name(code: 'ar', value: 'خزائن غرفة طعام')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_dinStore_china',
                names: <Name>[
                  Name(code: 'en', value: 'China cabinet & Hutches'),
                  Name(code: 'ar', value: 'نيش')
                ],
              ),
              KW(
                id: 'prd_furn_dinStore_buffet',
                names: <Name>[
                  Name(code: 'en', value: 'Buffet & sideboards'),
                  Name(code: 'ar', value: 'بوفيه')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cushions & Pillows
          const Chain(
            id: 'sub_prd_furn_cushions',
            names: <Name>[
              Name(code: 'en', value: 'Cushions & Pillows'),
              Name(code: 'ar', value: 'وسائد و مساند')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_cush_pillow',
                names: <Name>[
                  Name(code: 'en', value: 'Pillows'),
                  Name(code: 'ar', value: 'مخدات')
                ],
              ),
              KW(
                id: 'prd_furn_cush_seat',
                names: <Name>[
                  Name(code: 'en', value: 'Seats cushions'),
                  Name(code: 'ar', value: 'وسائد مقاعد')
                ],
              ),
              KW(
                id: 'prd_furn_cush_throw',
                names: <Name>[
                  Name(code: 'en', value: 'Throws'),
                  Name(code: 'ar', value: 'أغطية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_floorPillow',
                names: <Name>[
                  Name(code: 'en', value: 'Floor Pillows'),
                  Name(code: 'ar', value: 'وسائد أرضية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_pouf',
                names: <Name>[
                  Name(code: 'en', value: 'Pouf'),
                  Name(code: 'ar', value: 'بوف')
                ],
              ),
              KW(
                id: 'prd_furn_cush_cush',
                names: <Name>[
                  Name(code: 'en', value: 'Cushions'),
                  Name(code: 'ar', value: 'وسائد')
                ],
              ),
              KW(
                id: 'prd_furn_cush_ottoman',
                names: <Name>[
                  Name(code: 'en', value: 'Foot stools & Ottomans'),
                  Name(code: 'ar', value: 'مساند أقدام عثمانية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_beanbag',
                names: <Name>[
                  Name(code: 'en', value: 'Bean bags'),
                  Name(code: 'ar', value: 'بين باج')
                ],
              ),
              KW(
                id: 'prd_furn_cush_outOttoman',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Ottomans'),
                  Name(code: 'ar', value: 'مساند عثمانية خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_cush_outCushion',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor cushions & pillows'),
                  Name(code: 'ar', value: 'مخدات و وسائد خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Couches
          const Chain(
            id: 'sub_prd_furn_couch',
            names: <Name>[
              Name(code: 'en', value: 'Couches'),
              Name(code: 'ar', value: 'أرائك و كنب')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_couch_chaise',
                names: <Name>[
                  Name(code: 'en', value: 'Chaise lounge'),
                  Name(code: 'ar', value: 'شيزلونج')
                ],
              ),
              KW(
                id: 'prd_furn_couch_banquette',
                names: <Name>[
                  Name(code: 'en', value: 'Banquettes'),
                  Name(code: 'ar', value: 'بانكيت')
                ],
              ),
              KW(
                id: 'prd_furn_couch_sofa',
                names: <Name>[
                  Name(code: 'en', value: 'Sofas'),
                  Name(code: 'ar', value: 'أرائك')
                ],
              ),
              KW(
                id: 'prd_furn_couch_sectional',
                names: <Name>[
                  Name(code: 'en', value: 'Sectional sofas'),
                  Name(code: 'ar', value: 'أرائك منفصلة')
                ],
              ),
              KW(
                id: 'prd_furn_couch_futon',
                names: <Name>[
                  Name(code: 'en', value: 'Futons'),
                  Name(code: 'ar', value: 'فوتون')
                ],
              ),
              KW(
                id: 'prd_furn_couch_love',
                names: <Name>[
                  Name(code: 'en', value: 'Love seats'),
                  Name(code: 'ar', value: 'أرائك مزدوجة')
                ],
              ),
              KW(
                id: 'prd_furn_couch_sleeper',
                names: <Name>[
                  Name(code: 'en', value: 'Sleeper sofas'),
                  Name(code: 'ar', value: 'أرائك سرير')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Complete Sets
          const Chain(
            id: 'sub_prd_furn_sets',
            names: <Name>[
              Name(code: 'en', value: 'Complete Sets'),
              Name(code: 'ar', value: 'أطقم متكااملة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_sets_dining',
                names: <Name>[
                  Name(code: 'en', value: 'Dining set'),
                  Name(code: 'ar', value: 'أطقم غرفة طعام')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bistro',
                names: <Name>[
                  Name(code: 'en', value: 'Pub & Bistro set'),
                  Name(code: 'ar', value: 'أطقم مقاهي')
                ],
              ),
              KW(
                id: 'prd_furn_sets_living',
                names: <Name>[
                  Name(code: 'en', value: 'Living room set'),
                  Name(code: 'ar', value: 'أطقم غرفة معيشة')
                ],
              ),
              KW(
                id: 'prd_furn_sets_tv',
                names: <Name>[
                  Name(code: 'en', value: 'Tv set'),
                  Name(code: 'ar', value: 'أطقم تلفزيون')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bathVanity',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom vanities'),
                  Name(code: 'ar', value: 'وحدات حمام')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bedroom',
                names: <Name>[
                  Name(code: 'en', value: 'Bedroom sets'),
                  Name(code: 'ar', value: 'أطقم غرف نوم')
                ],
              ),
              KW(
                id: 'prd_furn_sets_bedVanity',
                names: <Name>[
                  Name(code: 'en', value: 'Bedroom vanities'),
                  Name(code: 'ar', value: 'أطقم تسريحة')
                ],
              ),
              KW(
                id: 'prd_furn_sets_outLounge',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor lounge sets'),
                  Name(code: 'ar', value: 'أطقم معيشة خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_sets_outDining',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Dining sets'),
                  Name(code: 'ar', value: 'أطقم غرفة طعام')
                ],
              ),
              KW(
                id: 'prd_furn_sets_outBistro',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor pub & bistro sets'),
                  Name(code: 'ar', value: 'أطقم مقاهي خارجية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Chairs
          const Chain(
            id: 'sub_prd_furn_chairs',
            names: <Name>[
              Name(code: 'en', value: 'Chairs'),
              Name(code: 'ar', value: 'كراسي')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_chair_bar',
                names: <Name>[
                  Name(code: 'en', value: 'Bar & Counter stools'),
                  Name(code: 'ar', value: 'كراسي بار')
                ],
              ),
              KW(
                id: 'prd_furn_chair_dining',
                names: <Name>[
                  Name(code: 'en', value: 'Dining Chairs'),
                  Name(code: 'ar', value: 'كراسي مائدة')
                ],
              ),
              KW(
                id: 'prd_furn_chair_diningBench',
                names: <Name>[
                  Name(code: 'en', value: 'Dining Benches'),
                  Name(code: 'ar', value: 'مجالس مائدة منبسطة')
                ],
              ),
              KW(
                id: 'prd_furn_chair_arm',
                names: <Name>[
                  Name(code: 'en', value: 'Arm chairs'),
                  Name(code: 'ar', value: 'كراسي بذراع')
                ],
              ),
              KW(
                id: 'prd_furn_chair_recliner',
                names: <Name>[
                  Name(code: 'en', value: 'Recliner chairs'),
                  Name(code: 'ar', value: 'كراسي ريكلاينر')
                ],
              ),
              KW(
                id: 'prd_furn_chair_glider',
                names: <Name>[
                  Name(code: 'en', value: 'Gliders'),
                  Name(code: 'ar', value: 'كراسي جلايدر')
                ],
              ),
              KW(
                id: 'prd_furn_chair_rocking',
                names: <Name>[
                  Name(code: 'en', value: 'Rocking chairs'),
                  Name(code: 'ar', value: 'كراسي هزازة')
                ],
              ),
              KW(
                id: 'prd_furn_chair_hanging',
                names: <Name>[
                  Name(code: 'en', value: 'Hammock & Swing chairs'),
                  Name(code: 'ar', value: 'كراسي متدلية')
                ],
              ),
              KW(
                id: 'prd_furn_chair_lift',
                names: <Name>[
                  Name(code: 'en', value: 'Lift chairs'),
                  Name(code: 'ar', value: 'كراسي رفع')
                ],
              ),
              KW(
                id: 'prd_furn_chair_massage',
                names: <Name>[
                  Name(code: 'en', value: 'Massage chairs'),
                  Name(code: 'ar', value: 'كراسي تدليك')
                ],
              ),
              KW(
                id: 'prd_furn_chair_sleeper',
                names: <Name>[
                  Name(code: 'en', value: 'Sleeper chairs'),
                  Name(code: 'ar', value: 'كراسي سرير')
                ],
              ),
              KW(
                id: 'prd_furn_chair_theatre',
                names: <Name>[
                  Name(code: 'en', value: 'Theatre seating'),
                  Name(code: 'ar', value: 'كراسي مسرح')
                ],
              ),
              KW(
                id: 'prd_furn_chair_folding',
                names: <Name>[
                  Name(code: 'en', value: 'Folding chairs & stools'),
                  Name(code: 'ar', value: 'كراسي قابلة للطي')
                ],
              ),
              KW(
                id: 'prd_furn_chair_office',
                names: <Name>[
                  Name(code: 'en', value: 'Office chairs'),
                  Name(code: 'ar', value: 'كراسي مكتب')
                ],
              ),
              KW(
                id: 'prd_furn_chair_gaming',
                names: <Name>[
                  Name(code: 'en', value: 'Gaming chairs'),
                  Name(code: 'ar', value: 'كراسي ألعاب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Carpets & Rugs
          const Chain(
            id: 'sub_prd_furn_carpetsRugs',
            names: <Name>[
              Name(code: 'en', value: 'Carpets & Rugs'),
              Name(code: 'ar', value: 'سجاد')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_carpet_bathMat',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom Mats'),
                  Name(code: 'ar', value: 'سجاد حمامات')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_rug',
                names: <Name>[
                  Name(code: 'en', value: 'Area rugs'),
                  Name(code: 'ar', value: 'بساط مساحات')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_doorMat',
                names: <Name>[
                  Name(code: 'en', value: 'Door mats'),
                  Name(code: 'ar', value: 'حصيرة أبواب')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_runner',
                names: <Name>[
                  Name(code: 'en', value: 'Hall & stairs runners'),
                  Name(code: 'ar', value: 'بساط سلالم')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_kitchen',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen mats'),
                  Name(code: 'ar', value: 'سجاد مطابخ')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_outdoor',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor rugs'),
                  Name(code: 'ar', value: 'سجاد خارجي')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_pad',
                names: <Name>[
                  Name(code: 'en', value: 'Rug pads'),
                  Name(code: 'ar', value: 'بطانة سجاد')
                ],
              ),
              KW(
                id: 'prd_furn_carpet_handmade',
                names: <Name>[
                  Name(code: 'en', value: 'Handmade rugs'),
                  Name(code: 'ar', value: 'سجاد يدوي الصنع')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cabinet Hardware
          const Chain(
            id: 'sub_prd_furn_cabinetHardware',
            names: <Name>[
              Name(code: 'en', value: 'Cabinet Hardware'),
              Name(code: 'ar', value: 'اكسسوارات كابينات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_cabhard_pull',
                names: <Name>[
                  Name(code: 'en', value: 'Cabinet & drawers pulls'),
                  Name(code: 'ar', value: 'أكر أدراج و كابينات')
                ],
              ),
              KW(
                id: 'prd_furn_cabhard_knob',
                names: <Name>[
                  Name(code: 'en', value: 'Cabinet & drawers knobs'),
                  Name(code: 'ar', value: 'مقابض أدراج و كابينات')
                ],
              ),
              KW(
                id: 'prd_furn_cabhard_hook',
                names: <Name>[
                  Name(code: 'en', value: 'Wall Cloth hooks'),
                  Name(code: 'ar', value: 'معلاق ملابس')
                ],
              ),
              KW(
                id: 'prd_furn_cabhard_hinge',
                names: <Name>[
                  Name(code: 'en', value: 'Cabinet hinges'),
                  Name(code: 'ar', value: 'مفصلات ضلف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Boxes
          const Chain(
            id: 'sub_prd_furn_boxes',
            names: <Name>[
              Name(code: 'en', value: 'Boxes'),
              Name(code: 'ar', value: 'صناديق ')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_boxes_bin',
                names: <Name>[
                  Name(code: 'en', value: 'Storage bins & boxes'),
                  Name(code: 'ar', value: 'سلات و صناديق تخزين')
                ],
              ),
              KW(
                id: 'prd_furn_boxes_outdoor',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor boxes'),
                  Name(code: 'ar', value: 'صناديق تخزين خارجية')
                ],
              ),
              KW(
                id: 'prd_furn_boxes_ice',
                names: <Name>[
                  Name(code: 'en', value: 'Coolers & ice chests'),
                  Name(code: 'ar', value: 'صناديق ثلج')
                ],
              ),
              KW(
                id: 'prd_furn_boxes_basket',
                names: <Name>[
                  Name(code: 'en', value: 'Baskets'),
                  Name(code: 'ar', value: 'سلات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Blinds & Curtains
          const Chain(
            id: 'sub_prd_furn_blindsCurtains',
            names: <Name>[
              Name(code: 'en', value: 'Blinds & Curtains'),
              Name(code: 'ar', value: 'ستائر')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_curtain_shower',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom shower curtains'),
                  Name(code: 'ar', value: 'ستائر دش استحمام')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_shade',
                names: <Name>[
                  Name(code: 'en', value: 'Blinds & shades'),
                  Name(code: 'ar', value: 'سواتر و ستائر شفافة')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_horizontal',
                names: <Name>[
                  Name(code: 'en', value: 'Horizontal shades'),
                  Name(code: 'ar', value: 'ستائر شريطية عرضية')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_vertical',
                names: <Name>[
                  Name(code: 'en', value: 'Vertical blinds'),
                  Name(code: 'ar', value: 'ستائر شريطية طولية')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_rod',
                names: <Name>[
                  Name(code: 'en', value: 'Curtain rods'),
                  Name(code: 'ar', value: 'قضبان ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_valance',
                names: <Name>[
                  Name(code: 'en', value: 'Valances'),
                  Name(code: 'ar', value: 'كرانيش ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_curtain',
                names: <Name>[
                  Name(code: 'en', value: 'Curtains'),
                  Name(code: 'ar', value: 'ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_tassel',
                names: <Name>[
                  Name(code: 'en', value: 'Tassels'),
                  Name(code: 'ar', value: 'شرابات ستائر')
                ],
              ),
              KW(
                id: 'prd_furn_curtain_bendRail',
                names: <Name>[
                  Name(code: 'en', value: 'Bendable curtain rails'),
                  Name(code: 'ar', value: 'قضبان ستائر قابلة للطي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Beds & Headboards
          const Chain(
            id: 'sub_prd_furn_beds',
            names: <Name>[
              Name(code: 'en', value: 'Beds & Headboards'),
              Name(code: 'ar', value: 'سرائر و ظهور سرائر')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_beds_bed',
                names: <Name>[
                  Name(code: 'en', value: 'Beds'),
                  Name(code: 'ar', value: 'سرائر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_board',
                names: <Name>[
                  Name(code: 'en', value: 'Headboards'),
                  Name(code: 'ar', value: 'ألواح سرائر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_mattress',
                names: <Name>[
                  Name(code: 'en', value: 'Mattresses & Pads'),
                  Name(code: 'ar', value: 'مراتب')
                ],
              ),
              KW(
                id: 'prd_furn_beds_frame',
                names: <Name>[
                  Name(code: 'en', value: 'Bed Frames'),
                  Name(code: 'ar', value: 'هياكل سرائر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_blanket',
                names: <Name>[
                  Name(code: 'en', value: 'Blankets, pillows & covers'),
                  Name(code: 'ar', value: 'بطانيات و مخدات')
                ],
              ),
              KW(
                id: 'prd_furn_beds_panel',
                names: <Name>[
                  Name(code: 'en', value: 'Panel beds'),
                  Name(code: 'ar', value: 'سرائر بظهر')
                ],
              ),
              KW(
                id: 'prd_furn_beds_platform',
                names: <Name>[
                  Name(code: 'en', value: 'Platform beds'),
                  Name(code: 'ar', value: 'سرائر على منصة منبسطة')
                ],
              ),
              KW(
                id: 'prd_furn_beds_sleigh',
                names: <Name>[
                  Name(code: 'en', value: 'Sleigh beds'),
                  Name(code: 'ar', value: 'سرائر سلاي')
                ],
              ),
              KW(
                id: 'prd_furn_beds_bunk',
                names: <Name>[
                  Name(code: 'en', value: 'Bunk beds'),
                  Name(code: 'ar', value: 'سرائر دورين')
                ],
              ),
              KW(
                id: 'prd_furn_beds_loft',
                names: <Name>[
                  Name(code: 'en', value: 'Loft beds'),
                  Name(code: 'ar', value: 'سرائر لوفت مرتفعة')
                ],
              ),
              KW(
                id: 'prd_furn_beds_day',
                names: <Name>[
                  Name(code: 'en', value: 'Day beds'),
                  Name(code: 'ar', value: 'سرائر النهار')
                ],
              ),
              KW(
                id: 'prd_furn_beds_murphy',
                names: <Name>[
                  Name(code: 'en', value: 'Murphy beds'),
                  Name(code: 'ar', value: 'سرائر ميرفي')
                ],
              ),
              KW(
                id: 'prd_furn_beds_folding',
                names: <Name>[
                  Name(code: 'en', value: 'Folding beds'),
                  Name(code: 'ar', value: 'سرائر قابلة للطي')
                ],
              ),
              KW(
                id: 'prd_furn_beds_adjustable',
                names: <Name>[
                  Name(code: 'en', value: 'Adjustable beds'),
                  Name(code: 'ar', value: 'سرائر قابلة للضبط')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bathroom Storage
          const Chain(
            id: 'sub_prd_furn_bathStorage',
            names: <Name>[
              Name(code: 'en', value: 'Bathroom Storage'),
              Name(code: 'ar', value: 'خزائن حمام')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_bathStore_medicine',
                names: <Name>[
                  Name(code: 'en', value: 'Medicine cabinet'),
                  Name(code: 'ar', value: 'كابينات دواء')
                ],
              ),
              KW(
                id: 'prd_furn_bathStore_cabinet',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom cabinet'),
                  Name(code: 'ar', value: 'كابينات حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathStore_shelf',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom shelves'),
                  Name(code: 'ar', value: 'أرفف حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathStore_sink',
                names: <Name>[
                  Name(code: 'en', value: 'Under sink cabinets'),
                  Name(code: 'ar', value: 'كابينات حمام سفلية')
                ],
              ),
              KW(
                id: 'prd_furn_bedStore_nightstand',
                names: <Name>[
                  Name(code: 'en', value: 'Nightstands & bedside tables'),
                  Name(code: 'ar', value: 'طاولات سرير جانبية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bathroom Hardware
          const Chain(
            id: 'sub_prd_furn_bathHardware',
            names: <Name>[
              Name(code: 'en', value: 'Bathroom Hardware'),
              Name(code: 'ar', value: 'اكسسوارات حمامات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_bathHard_towelBar',
                names: <Name>[
                  Name(code: 'en', value: 'Towel bars & holders'),
                  Name(code: 'ar', value: 'قضيب فوط')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_mirror',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom mirrors'),
                  Name(code: 'ar', value: 'مرايا حمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_makeup',
                names: <Name>[
                  Name(code: 'en', value: 'Makeup mirrors'),
                  Name(code: 'ar', value: 'مرايا مكياج')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_rack',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom racks'),
                  Name(code: 'ar', value: 'أرفف حمامات')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_grab',
                names: <Name>[
                  Name(code: 'en', value: 'Grab bars'),
                  Name(code: 'ar', value: 'قضبان اتكاء')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_caddy',
                names: <Name>[
                  Name(code: 'en', value: 'Shower Caddies'),
                  Name(code: 'ar', value: 'أرفف دش استحمام')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_safetyRail',
                names: <Name>[
                  Name(code: 'en', value: 'Toilet safety rails'),
                  Name(code: 'ar', value: 'قضبان أمان مرحاض')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_toiletHolder',
                names: <Name>[
                  Name(code: 'en', value: 'Toilet paper holder'),
                  Name(code: 'ar', value: 'حاملة مناديل')
                ],
              ),
              KW(
                id: 'prd_furn_bathHard_commode',
                names: <Name>[
                  Name(code: 'en', value: 'Toilet Commode'),
                  Name(code: 'ar', value: 'مرحاض متنقل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Artworks
          const Chain(
            id: 'sub_prd_furn_artworks',
            names: <Name>[
              Name(code: 'en', value: 'Artworks'),
              Name(code: 'ar', value: 'أعمال فنية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_furn_art_painting',
                names: <Name>[
                  Name(code: 'en', value: 'Paintings'),
                  Name(code: 'ar', value: 'رسومات فنية')
                ],
              ),
              KW(
                id: 'prd_furn_art_photo',
                names: <Name>[
                  Name(code: 'en', value: 'Photographs'),
                  Name(code: 'ar', value: 'صور')
                ],
              ),
              KW(
                id: 'prd_furn_art_illustration',
                names: <Name>[
                  Name(code: 'en', value: 'Drawings & Illustrations'),
                  Name(code: 'ar', value: 'تصاميم')
                ],
              ),
              KW(
                id: 'prd_furn_art_print',
                names: <Name>[
                  Name(code: 'en', value: 'Prints & posters'),
                  Name(code: 'ar', value: 'مطبوعات و ملصقات')
                ],
              ),
              KW(
                id: 'prd_furn_art_sculpture',
                names: <Name>[
                  Name(code: 'en', value: 'Sculptures'),
                  Name(code: 'ar', value: 'تماثيل')
                ],
              ),
              KW(
                id: 'prd_furn_art_letter',
                names: <Name>[
                  Name(code: 'en', value: 'Wall Letters'),
                  Name(code: 'ar', value: 'حروف حائطية')
                ],
              ),
              KW(
                id: 'prd_furn_art_frame',
                names: <Name>[
                  Name(code: 'en', value: 'Picture frames & accents'),
                  Name(code: 'ar', value: 'إطارات صور ز هياكل')
                ],
              ),
              KW(
                id: 'prd_furn_art_bulletin',
                names: <Name>[
                  Name(code: 'en', value: 'Bulletin boards'),
                  Name(code: 'ar', value: 'لوحات دبابيس')
                ],
              ),
              KW(
                id: 'prd_furn_art_decals',
                names: <Name>[
                  Name(code: 'en', value: 'Wall Decals'),
                  Name(code: 'ar', value: 'ملصقات حائطية')
                ],
              ),
              KW(
                id: 'prd_furn_art_tapestry',
                names: <Name>[
                  Name(code: 'en', value: 'Tapestries'),
                  Name(code: 'ar', value: 'بساط و أنسجة حائطية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Heating Ventilation Air Conditioning
      const Chain(
        id: 'group_prd_hvac',
        names: <Name>[
          Name(code: 'en', value: 'Heating Ventilation Air Conditioning'),
          Name(code: 'ar', value: 'تدفئة تهوية تكييف')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Ventilation
          const Chain(
            id: 'sub_prd_hvac_ventilation',
            names: <Name>[
              Name(code: 'en', value: 'Ventilation'),
              Name(code: 'ar', value: 'تهوية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_hvac_vent_fan',
                names: <Name>[
                  Name(code: 'en', value: 'Fans'),
                  Name(code: 'ar', value: 'مراوح')
                ],
              ),
              KW(
                id: 'prd_hvac_vent_exhaust',
                names: <Name>[
                  Name(code: 'en', value: 'Exhaust fans'),
                  Name(code: 'ar', value: 'مراوح شفط و شفاطات')
                ],
              ),
              KW(
                id: 'prd_hvac_vent_curtain',
                names: <Name>[
                  Name(code: 'en', value: 'Air curtains'),
                  Name(code: 'ar', value: 'ستائر هوائية')
                ],
              ),
              KW(
                id: 'prd_hvac_vent_ceilingFan',
                names: <Name>[
                  Name(code: 'en', value: 'Ceiling fan'),
                  Name(code: 'ar', value: 'مراوح سقف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Heating
          const Chain(
            id: 'sub_prd_hvac_heating',
            names: <Name>[
              Name(code: 'en', value: 'Heating'),
              Name(code: 'ar', value: 'تدفئة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_hvac_heating_electric',
                names: <Name>[
                  Name(code: 'en', value: 'Electric heaters'),
                  Name(code: 'ar', value: 'أجهزة تدفئة')
                ],
              ),
              KW(
                id: 'prd_hvac_heating_radiators',
                names: <Name>[
                  Name(code: 'en', value: 'Radiators'),
                  Name(code: 'ar', value: 'مشعاع حراري')
                ],
              ),
              KW(
                id: 'prd_hvac_heating_floor',
                names: <Name>[
                  Name(code: 'en', value: 'Floor heating systems'),
                  Name(code: 'ar', value: 'أنظمة تدفئة أرضية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fireplaces
          const Chain(
            id: 'sub_prd_hvac_fireplaces',
            names: <Name>[
              Name(code: 'en', value: 'Fireplaces'),
              Name(code: 'ar', value: 'مواقد نار')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_fireplace_fire_mantle',
                names: <Name>[
                  Name(code: 'en', value: 'Fireplace mantels'),
                  Name(code: 'ar', value: 'دفايات نار مبنية')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_tabletop',
                names: <Name>[
                  Name(code: 'en', value: 'Tabletop fireplaces'),
                  Name(code: 'ar', value: 'دفايات نار طاولة')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_freeStove',
                names: <Name>[
                  Name(code: 'en', value: 'Freestanding stoves'),
                  Name(code: 'ar', value: 'مواقد قائمة')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_outdoor',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor fireplaces'),
                  Name(code: 'ar', value: 'دفايات نار خارجية')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_chiminea',
                names: <Name>[
                  Name(code: 'en', value: 'Chimineas'),
                  Name(code: 'ar', value: 'مداخن')
                ],
              ),
              KW(
                id: 'prd_fireplace_fire_pit',
                names: <Name>[
                  Name(code: 'en', value: 'Fire pits'),
                  Name(code: 'ar', value: 'حفرة نار')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fireplace Equipment
          const Chain(
            id: 'sub_prd_hvac_fireplaceEquip',
            names: <Name>[
              Name(code: 'en', value: 'Fireplace Equipment'),
              Name(code: 'ar', value: 'أدوات مواقد نار')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_fireplace_equip_tools',
                names: <Name>[
                  Name(code: 'en', value: 'Fireplace tools'),
                  Name(code: 'ar', value: 'أدوات دفايات نار')
                ],
              ),
              KW(
                id: 'prd_fireplace_equip_rack',
                names: <Name>[
                  Name(code: 'en', value: 'Fire wood racks'),
                  Name(code: 'ar', value: 'أرفف حطب')
                ],
              ),
              KW(
                id: 'prd_fireplace_equip_fuel',
                names: <Name>[
                  Name(code: 'en', value: 'Fire starters & fuel'),
                  Name(code: 'ar', value: 'مساعدات اشتعال و وقود')
                ],
              ),
              KW(
                id: 'prd_fireplace_equip_grate',
                names: <Name>[
                  Name(code: 'en', value: 'fireplace grates & Andirons'),
                  Name(code: 'ar', value: 'فواصل و حوامل حطب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Air Conditioning
          const Chain(
            id: 'sub_prd_hvac_ac',
            names: <Name>[
              Name(code: 'en', value: 'Air Conditioning'),
              Name(code: 'ar', value: 'تكييف هواء')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_hvac_ac_chiller',
                names: <Name>[
                  Name(code: 'en', value: 'Chillers'),
                  Name(code: 'ar', value: 'مبردات')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_ac',
                names: <Name>[
                  Name(code: 'en', value: 'Indoor AC units'),
                  Name(code: 'ar', value: 'تكييفات')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_vent',
                names: <Name>[
                  Name(code: 'en', value: 'Registers, grills & vents'),
                  Name(code: 'ar', value: 'فتحات تكييف، هوايات')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_humidifier',
                names: <Name>[
                  Name(code: 'en', value: 'Humidifiers'),
                  Name(code: 'ar', value: 'مرطبات هواء')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_dehumidifier',
                names: <Name>[
                  Name(code: 'en', value: 'Dehumidifiers'),
                  Name(code: 'ar', value: 'مجففات هواء')
                ],
              ),
              KW(
                id: 'prd_hvac_ac_purifier',
                names: <Name>[
                  Name(code: 'en', value: 'Air purifiers'),
                  Name(code: 'ar', value: 'منقيات هواء')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Planting & Landscape
      const Chain(
        id: 'group_prd_landscape',
        names: <Name>[
          Name(code: 'en', value: 'Planting & Landscape'),
          Name(code: 'ar', value: 'زراعات و لاندسكيب')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Pots & Vases
          const Chain(
            id: 'sub_prd_scape_potsVases',
            names: <Name>[
              Name(code: 'en', value: 'Pots & Vases'),
              Name(code: 'ar', value: 'أواني و مزهريات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_landscape_pots_vase',
                names: <Name>[
                  Name(code: 'en', value: 'Vases'),
                  Name(code: 'ar', value: 'مزاهر')
                ],
              ),
              KW(
                id: 'prd_landscape_pots_indoorPlanter',
                names: <Name>[
                  Name(code: 'en', value: 'Indoor pots & planters'),
                  Name(code: 'ar', value: 'أصيص زراعة داخلي')
                ],
              ),
              KW(
                id: 'prd_landscape_pots_outdoorPlanter',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor pots & planters'),
                  Name(code: 'ar', value: 'أصيص زراعة خارجي')
                ],
              ),
              KW(
                id: 'prd_landscape_pots_bin',
                names: <Name>[
                  Name(code: 'en', value: 'Composite bins'),
                  Name(code: 'ar', value: 'براميل و صناديق سماد')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Live Plants
          const Chain(
            id: 'sub_prd_scape_livePlants',
            names: <Name>[
              Name(code: 'en', value: 'Live Plants'),
              Name(code: 'ar', value: 'نباتات حية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_landscape_live_tree',
                names: <Name>[
                  Name(code: 'en', value: 'Live Trees'),
                  Name(code: 'ar', value: 'شجر طبيعي')
                ],
              ),
              KW(
                id: 'prd_landscape_live_grass',
                names: <Name>[
                  Name(code: 'en', value: 'Live Grass lawn'),
                  Name(code: 'ar', value: 'نجيلة طبيعية')
                ],
              ),
              KW(
                id: 'prd_landscape_live_bush',
                names: <Name>[
                  Name(code: 'en', value: 'Plants, Bushes & Flowers'),
                  Name(code: 'ar', value: 'مزروعات، نباتات و ورود')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Hardscape
          const Chain(
            id: 'sub_prd_scape_hardscape',
            names: <Name>[
              Name(code: 'en', value: 'Hardscape'),
              Name(code: 'ar', value: 'هاردسكيب')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_landscape_hardscape_trellis',
                names: <Name>[
                  Name(code: 'en', value: 'Garden Trellises'),
                  Name(code: 'ar', value: 'تعريشات حديقة')
                ],
              ),
              KW(
                id: 'prd_landscape_hardscape_flag',
                names: <Name>[
                  Name(code: 'en', value: 'Flags & Poles'),
                  Name(code: 'ar', value: 'أعلام و عواميدها')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fountains & Ponds
          const Chain(
            id: 'sub_prd_scape_fountainsPonds',
            names: <Name>[
              Name(code: 'en', value: 'Fountains & Ponds'),
              Name(code: 'ar', value: 'نوافير و برك')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_landscape_fountain_indoor',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor fountains'),
                  Name(code: 'ar', value: 'نافورة خارجية')
                ],
              ),
              KW(
                id: 'prd_landscape_fountain_outdoor',
                names: <Name>[
                  Name(code: 'en', value: 'Indoor fountains'),
                  Name(code: 'ar', value: 'نافورة داخلية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Birds fixtures
          const Chain(
            id: 'sub_prd_scape_birds',
            names: <Name>[
              Name(code: 'en', value: 'Birds fixtures'),
              Name(code: 'ar', value: 'تجهيزات عصافير')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_landscape_birds_feeder',
                names: <Name>[
                  Name(code: 'en', value: 'Bird feeders'),
                  Name(code: 'ar', value: 'مغذيات عصافير')
                ],
              ),
              KW(
                id: 'prd_landscape_birds_bath',
                names: <Name>[
                  Name(code: 'en', value: 'Bird baths'),
                  Name(code: 'ar', value: 'أحواض عصافير')
                ],
              ),
              KW(
                id: 'prd_landscape_birds_house',
                names: <Name>[
                  Name(code: 'en', value: 'Bird houses'),
                  Name(code: 'ar', value: 'بيوت عصافير')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Artificial plants
          const Chain(
            id: 'sub_prd_scape_artificial',
            names: <Name>[
              Name(code: 'en', value: 'Artificial plants'),
              Name(code: 'ar', value: 'نباتات صناعية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_landscape_artificial_tree',
                names: <Name>[
                  Name(code: 'en', value: 'Artificial Trees'),
                  Name(code: 'ar', value: 'شجر صناعي')
                ],
              ),
              KW(
                id: 'prd_landscape_artificial_plant',
                names: <Name>[
                  Name(code: 'en', value: 'Artificial Plants'),
                  Name(code: 'ar', value: 'نباتات صناعية')
                ],
              ),
              KW(
                id: 'prd_landscape_artificial_grass',
                names: <Name>[
                  Name(code: 'en', value: 'Artificial grass'),
                  Name(code: 'ar', value: 'نجيلة صناعية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Lighting
      const Chain(
        id: 'group_prd_lighting',
        names: <Name>[
          Name(code: 'en', value: 'Lighting'),
          Name(code: 'ar', value: 'إضاءة')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Wall Lighting
          const Chain(
            id: 'sub_prd_light_wall',
            names: <Name>[
              Name(code: 'en', value: 'Wall Lighting'),
              Name(code: 'ar', value: 'إضاءة حائطية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_lighting_wall_applique',
                names: <Name>[
                  Name(code: 'en', value: 'Sconces & Appliques'),
                  Name(code: 'ar', value: 'أباليك')
                ],
              ),
              KW(
                id: 'prd_lighting_wall_vanity',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom vanity lighting'),
                  Name(code: 'ar', value: 'مصابيح وحدات حمام')
                ],
              ),
              KW(
                id: 'prd_lighting_wall_picture',
                names: <Name>[
                  Name(code: 'en', value: 'Display & Picture lighting'),
                  Name(code: 'ar', value: 'مصابيح عرض و صور')
                ],
              ),
              KW(
                id: 'prd_lighting_wall_swing',
                names: <Name>[
                  Name(code: 'en', value: 'Swing arm wall lamps'),
                  Name(code: 'ar', value: 'مصابيح ذراع متحرك')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Outdoor Lighting
          const Chain(
            id: 'sub_prd_light_outdoor',
            names: <Name>[
              Name(code: 'en', value: 'Outdoor Lighting'),
              Name(code: 'ar', value: 'إضاءة خارجية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_lighting_outdoor_wall',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor wall lights'),
                  Name(code: 'ar', value: 'مصابيح حوائط خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_flush',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Flush mounts'),
                  Name(code: 'ar', value: 'مصابيح ملتصقة بالسقف خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_hanging',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor Hanging lights'),
                  Name(code: 'ar', value: 'مصابيح خارجية متدلية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_deck',
                names: <Name>[
                  Name(code: 'en', value: 'Deck post caps'),
                  Name(code: 'ar', value: 'أغطية مصابيح خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_inground',
                names: <Name>[
                  Name(code: 'en', value: 'Inground & well lights'),
                  Name(code: 'ar', value: 'مصابيح مدفونة')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_path',
                names: <Name>[
                  Name(code: 'en', value: 'Path lights'),
                  Name(code: 'ar', value: 'مصابيح ممرات خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_step',
                names: <Name>[
                  Name(code: 'en', value: 'Stairs and step lights'),
                  Name(code: 'ar', value: 'مصابيح سلالم')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_floorSpot',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor floor & spot lights'),
                  Name(code: 'ar', value: 'مصابيح سبوت أرضية خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_lamp',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor lamps'),
                  Name(code: 'ar', value: 'مصابيح خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_table',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor table lamps'),
                  Name(code: 'ar', value: 'مصابيح طاولة خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_string',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor String lights'),
                  Name(code: 'ar', value: 'مصابيح سلسلة خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_post',
                names: <Name>[
                  Name(code: 'en', value: 'Post lights'),
                  Name(code: 'ar', value: 'عواميد إضاءة')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_torch',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor torches'),
                  Name(code: 'ar', value: 'شعلات إضاءة خارجية')
                ],
              ),
              KW(
                id: 'prd_lighting_outdoor_gardenSpot',
                names: <Name>[
                  Name(code: 'en', value: 'Graden spotlights'),
                  Name(code: 'ar', value: 'إضاءات حدائق سبوت')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Lighting Accessories
          const Chain(
            id: 'sub_prd_light_access',
            names: <Name>[
              Name(code: 'en', value: 'Lighting Accessories'),
              Name(code: 'ar', value: 'اكسسوارات إضاءة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_lighting_accessories_shade',
                names: <Name>[
                  Name(code: 'en', value: 'Lamp shades & bases'),
                  Name(code: 'ar', value: 'قواعد و أغطية مصابيح')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_timer',
                names: <Name>[
                  Name(code: 'en', value: 'Timers & lighting controls'),
                  Name(code: 'ar', value: 'مواقيت و ضوابط إضاءة')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_lightingHardware',
                names: <Name>[
                  Name(
                      code: 'en',
                      value: 'Lighting hardware & accessories'),
                  Name(code: 'ar', value: 'اكسسوارات إضاءة')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_flash',
                names: <Name>[
                  Name(code: 'en', value: 'Flash lights'),
                  Name(code: 'ar', value: 'كشافات يدوية')
                ],
              ),
              KW(
                id: 'prd_lighting_accessories_diffuser',
                names: <Name>[
                  Name(code: 'en', value: 'Light diffusers'),
                  Name(code: 'ar', value: 'مبددات أضواء')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Light bulbs
          const Chain(
            id: 'sub_prd_light_bulbs',
            names: <Name>[
              Name(code: 'en', value: 'Light bulbs'),
              Name(code: 'ar', value: 'لمبات إضاءة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_lighting_bulbs_fluorescent',
                names: <Name>[
                  Name(code: 'en', value: 'Fluorescent bulbs'),
                  Name(code: 'ar', value: 'لمبة فلوريسينت')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_led',
                names: <Name>[
                  Name(code: 'en', value: 'Led bulbs'),
                  Name(code: 'ar', value: 'لمبة ليد')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_halogen',
                names: <Name>[
                  Name(code: 'en', value: 'Halogen bulbs'),
                  Name(code: 'ar', value: 'لمبة هالوجين')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_incandescent',
                names: <Name>[
                  Name(code: 'en', value: 'Incandescent bulbs'),
                  Name(code: 'ar', value: 'لمبة متوهجة')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_tube',
                names: <Name>[
                  Name(code: 'en', value: 'Fluorescent tubes'),
                  Name(code: 'ar', value: 'عود نيون فلوريسينت')
                ],
              ),
              KW(
                id: 'prd_lighting_bulbs_krypton',
                names: <Name>[
                  Name(code: 'en', value: 'Krypton & xenon bulbs'),
                  Name(code: 'ar', value: 'لمبة كريبتون و زينون')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Lamps
          const Chain(
            id: 'sub_prd_light_lamps',
            names: <Name>[
              Name(code: 'en', value: 'Lamps'),
              Name(code: 'ar', value: 'مصابيح')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_lighting_lamp_table',
                names: <Name>[
                  Name(code: 'en', value: 'Table lamps'),
                  Name(code: 'ar', value: 'مصابيح طاولة')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_floor',
                names: <Name>[
                  Name(code: 'en', value: 'Floor lamps'),
                  Name(code: 'ar', value: 'مصابيح أرضية')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_desk',
                names: <Name>[
                  Name(code: 'en', value: 'Desk lamps'),
                  Name(code: 'ar', value: 'مصابيح مكتب')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_set',
                names: <Name>[
                  Name(code: 'en', value: 'Lamp sets'),
                  Name(code: 'ar', value: 'أطقم مصابيح')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_piano',
                names: <Name>[
                  Name(code: 'en', value: 'Piano table Lights'),
                  Name(code: 'ar', value: 'مصباح بيانو')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_kids',
                names: <Name>[
                  Name(code: 'en', value: 'Kids lamps'),
                  Name(code: 'ar', value: 'مصابيح أطفال')
                ],
              ),
              KW(
                id: 'prd_lighting_lamp_emergency',
                names: <Name>[
                  Name(code: 'en', value: 'Emergency lights'),
                  Name(code: 'ar', value: 'مصابيح طوارئ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Ceiling Lighting
          const Chain(
            id: 'sub_prd_light_ceiling',
            names: <Name>[
              Name(code: 'en', value: 'Ceiling Lighting'),
              Name(code: 'ar', value: 'إضاءة أسقف')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_lighting_ceiling_chandelier',
                names: <Name>[
                  Name(code: 'en', value: 'Chandeliers'),
                  Name(code: 'ar', value: 'نجف')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_pendant',
                names: <Name>[
                  Name(code: 'en', value: 'Pendant lighting'),
                  Name(code: 'ar', value: 'مصابيح معلقة')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_flush',
                names: <Name>[
                  Name(code: 'en', value: 'Flush mount lighting'),
                  Name(code: 'ar', value: 'مصابيح ملتصقة بالسقف')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_kitchenIsland',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen Island lighting'),
                  Name(code: 'ar', value: 'مصابيح جزيرة مطبخ')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_underCabinet',
                names: <Name>[
                  Name(code: 'en', value: 'Under cabinet lighting'),
                  Name(code: 'ar', value: 'مصابيح مطبخ سفلية')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_track',
                names: <Name>[
                  Name(code: 'en', value: 'Track lighting'),
                  Name(code: 'ar', value: 'مصابيح مضمار')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_recessed',
                names: <Name>[
                  Name(code: 'en', value: 'Recessed lighting'),
                  Name(code: 'ar', value: 'مصابيح مخفية')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_pool',
                names: <Name>[
                  Name(code: 'en', value: 'Pool table lighting'),
                  Name(code: 'ar', value: 'مصباح طاولة بلياردو')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_spot',
                names: <Name>[
                  Name(code: 'en', value: 'Spot lights'),
                  Name(code: 'ar', value: 'مصابيح سبوت')
                ],
              ),
              KW(
                id: 'prd_lighting_ceiling_kids',
                names: <Name>[
                  Name(code: 'en', value: 'Kids ceiling lights'),
                  Name(code: 'ar', value: 'مصابيح سقف أطفال')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Construction Materials
      const Chain(
        id: 'group_prd_materials',
        names: <Name>[
          Name(code: 'en', value: 'Construction Materials'),
          Name(code: 'ar', value: 'مواد بناء')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Wood Coats
          const Chain(
            id: 'sub_prd_mat_woodCoats',
            names: <Name>[
              Name(code: 'en', value: 'Wood Coats'),
              Name(code: 'ar', value: 'دهانات خشب')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_woodPaint_lacquer',
                names: <Name>[
                  Name(code: 'en', value: 'Lacquer'),
                  Name(code: 'ar', value: 'لاكيه')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_polyurethane',
                names: <Name>[
                  Name(code: 'en', value: 'Polyurethane'),
                  Name(code: 'ar', value: 'بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_polycrylic',
                names: <Name>[
                  Name(code: 'en', value: 'Polycrylic'),
                  Name(code: 'ar', value: 'بوليكريليك')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_varnish',
                names: <Name>[
                  Name(code: 'en', value: 'Varnish & Shellacs'),
                  Name(code: 'ar', value: 'ورنيش')
                ],
              ),
              KW(
                id: 'prd_mat_woodPaint_polyester',
                names: <Name>[
                  Name(code: 'en', value: 'Polyester Urethane'),
                  Name(code: 'ar', value: 'بولي استر ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Water Proofing
          const Chain(
            id: 'sub_prd_mat_waterProofing',
            names: <Name>[
              Name(code: 'en', value: 'Water Proofing'),
              Name(code: 'ar', value: 'عوازل رطوبة و مياه')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_waterProof_rubber',
                names: <Name>[
                  Name(code: 'en', value: 'EPDM Rubber membranes'),
                  Name(code: 'ar', value: 'عزل ماء و رطوبة')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_bitumen',
                names: <Name>[
                  Name(code: 'en', value: 'Bitumen membranes'),
                  Name(code: 'ar', value: 'لفائف بيتومين')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_pvc',
                names: <Name>[
                  Name(
                      code: 'en',
                      value: 'PVC membranes (Thermoplastic polyolefin)'),
                  Name(code: 'ar', value: 'لفائف بوليفيلين بي في سي')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_tpo',
                names: <Name>[
                  Name(code: 'en', value: 'TPO membranes'),
                  Name(code: 'ar', value: 'لفائف تي بي أو')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_polyurethane',
                names: <Name>[
                  Name(code: 'en', value: 'Polyurethane coating'),
                  Name(code: 'ar', value: 'طلاء بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_acrylic',
                names: <Name>[
                  Name(code: 'en', value: 'Acrylic coating'),
                  Name(code: 'ar', value: 'طلاء أكريليك')
                ],
              ),
              KW(
                id: 'prd_mat_waterProof_cementitious',
                names: <Name>[
                  Name(code: 'en', value: 'Cementitious coating'),
                  Name(code: 'ar', value: 'طلاء أسمنتي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Synthetic Heat Insulation
          const Chain(
            id: 'sub_prd_mat_heatSynth',
            names: <Name>[
              Name(code: 'en', value: 'Synthetic Heat Insulation'),
              Name(code: 'ar', value: 'عوازل حرارية مصنوعة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_heatSynth_reflective',
                names: <Name>[
                  Name(code: 'en', value: 'Reflective foam sheets'),
                  Name(code: 'ar', value: 'ألواح فوم عاكس')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_polystyrene',
                names: <Name>[
                  Name(code: 'en', value: 'EPS Polystyrene sheets'),
                  Name(code: 'ar', value: 'ألواح إي بي إس بولي ستيرين')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_styro',
                names: <Name>[
                  Name(code: 'en', value: 'XPS Styrofoam'),
                  Name(code: 'ar', value: 'ستايروفوم إكس بي إس')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_purSheet',
                names: <Name>[
                  Name(code: 'en', value: 'Polyurethane Foam sheets'),
                  Name(code: 'ar', value: 'ألواح فوم بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_purSpray',
                names: <Name>[
                  Name(code: 'en', value: 'Polyurethane Foam spray'),
                  Name(code: 'ar', value: 'بولي يووريثان رش')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_purSection',
                names: <Name>[
                  Name(code: 'en', value: 'Polyurethane piping sections'),
                  Name(code: 'ar', value: 'قطاعات عزل بولي يوريثان')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_phenolic',
                names: <Name>[
                  Name(code: 'en', value: 'Phenolic foam boards'),
                  Name(code: 'ar', value: 'ألواح فوم فينول')
                ],
              ),
              KW(
                id: 'prd_mat_heatSynth_aerogel',
                names: <Name>[
                  Name(code: 'en', value: 'Aerogel blankets'),
                  Name(code: 'ar', value: 'بطانية عزل إيرو جيل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Stones
          const Chain(
            id: 'sub_prd_mat_stones',
            names: <Name>[
              Name(code: 'en', value: 'Stones'),
              Name(code: 'ar', value: 'حجر')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_stone_marble',
                names: <Name>[
                  Name(code: 'en', value: 'Marble'),
                  Name(code: 'ar', value: 'رخام')
                ],
              ),
              KW(
                id: 'prd_mat_stone_granite',
                names: <Name>[
                  Name(code: 'en', value: 'Granite'),
                  Name(code: 'ar', value: 'جرانيت')
                ],
              ),
              KW(
                id: 'prd_mat_stone_slate',
                names: <Name>[
                  Name(code: 'en', value: 'Slate'),
                  Name(code: 'ar', value: 'شرائح حجر')
                ],
              ),
              KW(
                id: 'prd_mat_stone_quartzite',
                names: <Name>[
                  Name(code: 'en', value: 'Quartzite'),
                  Name(code: 'ar', value: 'كوارتزيت')
                ],
              ),
              KW(
                id: 'prd_mat_stone_soap',
                names: <Name>[
                  Name(code: 'en', value: 'Soap stone'),
                  Name(code: 'ar', value: 'حجر أملس')
                ],
              ),
              KW(
                id: 'prd_mat_stone_travertine',
                names: <Name>[
                  Name(code: 'en', value: 'Travertine'),
                  Name(code: 'ar', value: 'حجر جيري ترافنتين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Steel
          const Chain(
            id: 'sub_prd_mat_steel',
            names: <Name>[
              Name(code: 'en', value: 'Steel'),
              Name(code: 'ar', value: 'حديد مسلح')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_steel_rebar',
                names: <Name>[
                  Name(code: 'en', value: 'Steel rebar'),
                  Name(code: 'ar', value: 'حديد تسليح')
                ],
              ),
              KW(
                id: 'prd_mat_steel_section',
                names: <Name>[
                  Name(code: 'en', value: 'Steel sections'),
                  Name(code: 'ar', value: 'قطاعات معدنية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Solid Wood
          const Chain(
            id: 'sub_prd_mat_solidWood',
            names: <Name>[
              Name(code: 'en', value: 'Solid Wood'),
              Name(code: 'ar', value: 'أخشاب طبيعية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_wood_oak',
                names: <Name>[
                  Name(code: 'en', value: 'Oak'),
                  Name(code: 'ar', value: 'خشب أرو')
                ],
              ),
              KW(
                id: 'prd_mat_wood_beech',
                names: <Name>[
                  Name(code: 'en', value: 'Beech'),
                  Name(code: 'ar', value: 'خشب زان')
                ],
              ),
              KW(
                id: 'prd_mat_wood_mahogany',
                names: <Name>[
                  Name(code: 'en', value: 'Mahogany'),
                  Name(code: 'ar', value: 'خشب ماهوجني')
                ],
              ),
              KW(
                id: 'prd_mat_wood_beechPine',
                names: <Name>[
                  Name(code: 'en', value: 'Beech pine'),
                  Name(code: 'ar', value: 'خشب موسكي')
                ],
              ),
              KW(
                id: 'prd_mat_wood_ash',
                names: <Name>[
                  Name(code: 'en', value: 'Ash'),
                  Name(code: 'ar', value: 'خشب بلوط')
                ],
              ),
              KW(
                id: 'prd_mat_wood_walnut',
                names: <Name>[
                  Name(code: 'en', value: 'Walnut'),
                  Name(code: 'ar', value: 'خشب الجوز')
                ],
              ),
              KW(
                id: 'prd_mat_wood_pine',
                names: <Name>[
                  Name(code: 'en', value: 'Pine'),
                  Name(code: 'ar', value: 'خشب العزيزي')
                ],
              ),
              KW(
                id: 'prd_mat_wood_teak',
                names: <Name>[
                  Name(code: 'en', value: 'Teak'),
                  Name(code: 'ar', value: 'خشب تك')
                ],
              ),
              KW(
                id: 'prd_mat_wood_rose',
                names: <Name>[
                  Name(code: 'en', value: 'Rosewood'),
                  Name(code: 'ar', value: 'خشب الورد')
                ],
              ),
              KW(
                id: 'prd_mat_wood_palisander',
                names: <Name>[
                  Name(code: 'en', value: 'Palisander'),
                  Name(code: 'ar', value: 'خشب البليسندر')
                ],
              ),
              KW(
                id: 'prd_mat_wood_sandal',
                names: <Name>[
                  Name(code: 'en', value: 'Sandalwood'),
                  Name(code: 'ar', value: 'خشب الصندل')
                ],
              ),
              KW(
                id: 'prd_mat_wood_cherry',
                names: <Name>[
                  Name(code: 'en', value: 'Cherry wood'),
                  Name(code: 'ar', value: 'خشب الكريز')
                ],
              ),
              KW(
                id: 'prd_mat_wood_ebony',
                names: <Name>[
                  Name(code: 'en', value: 'Ebony wood'),
                  Name(code: 'ar', value: 'خشب الابنوس')
                ],
              ),
              KW(
                id: 'prd_mat_wood_maple',
                names: <Name>[
                  Name(code: 'en', value: 'Maple wood'),
                  Name(code: 'ar', value: 'خشب الحور، القيقب')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Sand & Rubble
          const Chain(
            id: 'sub_prd_mat_sandRubble',
            names: <Name>[
              Name(code: 'en', value: 'Sand & Rubble'),
              Name(code: 'ar', value: 'رمل و زلط')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_sand_sand',
                names: <Name>[
                  Name(code: 'en', value: 'Sand & Rubble'),
                  Name(code: 'ar', value: 'رمل و حصى')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Paints
          const Chain(
            id: 'sub_prd_mat_paints',
            names: <Name>[
              Name(code: 'en', value: 'Paints'),
              Name(code: 'ar', value: 'دهانات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_paint_cement',
                names: <Name>[
                  Name(code: 'en', value: 'Cement paints'),
                  Name(code: 'ar', value: 'دهانات أسمنتية')
                ],
              ),
              KW(
                id: 'prd_mat_paint_outdoor',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor paints'),
                  Name(code: 'ar', value: 'دهانات خارجية')
                ],
              ),
              KW(
                id: 'prd_mat_paint_primer',
                names: <Name>[
                  Name(code: 'en', value: 'Primer & sealer'),
                  Name(code: 'ar', value: 'معجون و سيلر')
                ],
              ),
              KW(
                id: 'prd_mat_paint_acrylic',
                names: <Name>[
                  Name(code: 'en', value: 'Acrylic'),
                  Name(code: 'ar', value: 'أكريليك')
                ],
              ),
              KW(
                id: 'prd_mat_paint_duco',
                names: <Name>[
                  Name(code: 'en', value: 'Spray & Duco'),
                  Name(code: 'ar', value: 'رش و دوكو')
                ],
              ),
              KW(
                id: 'prd_mat_paint_heatproof',
                names: <Name>[
                  Name(code: 'en', value: 'Thermal insulation paints'),
                  Name(code: 'ar', value: 'دهانات حرارية')
                ],
              ),
              KW(
                id: 'prd_mat_paint_fire',
                names: <Name>[
                  Name(code: 'en', value: 'Fire retardant paints'),
                  Name(code: 'ar', value: 'دهانات مضادة للحريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Mineral Heat Insulation
          const Chain(
            id: 'sub_prd_mat_heatIMin',
            names: <Name>[
              Name(code: 'en', value: 'Mineral Heat Insulation'),
              Name(code: 'ar', value: 'عوازل حرارية من ألياف معدنية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_heatmin_vermiculite',
                names: <Name>[
                  Name(code: 'en', value: 'Vermiculite Asbestos'),
                  Name(code: 'ar', value: 'أسبستوس فيرميكوليت')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_cellulose',
                names: <Name>[
                  Name(code: 'en', value: 'Cellulose fibre'),
                  Name(code: 'ar', value: 'ألياف سيليولوز')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_perlite',
                names: <Name>[
                  Name(code: 'en', value: 'Perlite insulation boards'),
                  Name(code: 'ar', value: 'ألواح بيرلايت')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_foamGlass',
                names: <Name>[
                  Name(code: 'en', value: 'Foam glass boards'),
                  Name(code: 'ar', value: 'ألواح فوم زجاجي')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_fiberglassWool',
                names: <Name>[
                  Name(code: 'en', value: 'Fiberglass wool'),
                  Name(code: 'ar', value: 'صوف زجاجي فايبر جلاس')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_fiberglassPipe',
                names: <Name>[
                  Name(code: 'en', value: 'Fiberglass piping insulation'),
                  Name(
                      code: 'ar',
                      value: 'عزل صوف زجاجي خراطيم فايبر جلاس')
                ],
              ),
              KW(
                id: 'prd_mat_heatmin_rockWool',
                names: <Name>[
                  Name(code: 'en', value: 'Rock wool'),
                  Name(code: 'ar', value: 'صوف صخري')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Metals
          const Chain(
            id: 'sub_prd_mat_metals',
            names: <Name>[
              Name(code: 'en', value: 'Metals'),
              Name(code: 'ar', value: 'معادن')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_metal_iron',
                names: <Name>[
                  Name(code: 'en', value: 'Iron'),
                  Name(code: 'ar', value: 'حديد')
                ],
              ),
              KW(
                id: 'prd_mat_metal_steel',
                names: <Name>[
                  Name(code: 'en', value: 'Steel'),
                  Name(code: 'ar', value: 'حديد مسلح')
                ],
              ),
              KW(
                id: 'prd_mat_metal_aluminum',
                names: <Name>[
                  Name(code: 'en', value: 'Aluminum'),
                  Name(code: 'ar', value: 'ألمنيوم')
                ],
              ),
              KW(
                id: 'prd_mat_metal_copper',
                names: <Name>[
                  Name(code: 'en', value: 'Copper'),
                  Name(code: 'ar', value: 'نحاس')
                ],
              ),
              KW(
                id: 'prd_mat_metal_silver',
                names: <Name>[
                  Name(code: 'en', value: 'Sliver'),
                  Name(code: 'ar', value: 'فضة')
                ],
              ),
              KW(
                id: 'prd_mat_metal_gold',
                names: <Name>[
                  Name(code: 'en', value: 'Gold'),
                  Name(code: 'ar', value: 'ذهب')
                ],
              ),
              KW(
                id: 'prd_mat_metal_bronze',
                names: <Name>[
                  Name(code: 'en', value: 'Bronze'),
                  Name(code: 'ar', value: 'برونز')
                ],
              ),
              KW(
                id: 'prd_mat_metal_stainless',
                names: <Name>[
                  Name(code: 'en', value: 'Stainless steel'),
                  Name(code: 'ar', value: 'ستانلس ستيل')
                ],
              ),
              KW(
                id: 'prd_mat_metal_chrome',
                names: <Name>[
                  Name(code: 'en', value: 'Chrome'),
                  Name(code: 'ar', value: 'كروم')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Manufactured Wood
          const Chain(
            id: 'sub_prd_mat_manuWood',
            names: <Name>[
              Name(code: 'en', value: 'Manufactured Wood'),
              Name(code: 'ar', value: 'أخشاب مصنعة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_manWood_mdf',
                names: <Name>[
                  Name(code: 'en', value: 'MDF'),
                  Name(code: 'ar', value: 'خشب مضغوط إم دي إف')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_veneer',
                names: <Name>[
                  Name(code: 'en', value: 'Veneer wood'),
                  Name(code: 'ar', value: 'قشرة خشب')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_compressed',
                names: <Name>[
                  Name(
                      code: 'en',
                      value: 'Compressed chip & fire board wood'),
                  Name(code: 'ar', value: 'خشب حبيبي')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_formica',
                names: <Name>[
                  Name(code: 'en', value: 'Formica'),
                  Name(code: 'ar', value: 'خشب فروميكا')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_engineered',
                names: <Name>[
                  Name(code: 'en', value: 'Engineered wood'),
                  Name(code: 'ar', value: 'خشب كونتر طبقات')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_ply',
                names: <Name>[
                  Name(code: 'en', value: 'Plywood'),
                  Name(code: 'ar', value: 'خشب أبلكاش')
                ],
              ),
              KW(
                id: 'prd_mat_manWood_cork',
                names: <Name>[
                  Name(code: 'en', value: 'Cork wood'),
                  Name(code: 'ar', value: 'خشب فلين')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Gypsum
          const Chain(
            id: 'sub_prd_mat_gypsum',
            names: <Name>[
              Name(code: 'en', value: 'Gypsum'),
              Name(code: 'ar', value: 'جبس')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_gypsum_board',
                names: <Name>[
                  Name(code: 'en', value: 'Gypsum boards & accessories'),
                  Name(code: 'ar', value: 'ألواح جبسية و اكسسوارات')
                ],
              ),
              KW(
                id: 'prd_mat_gypsum_powder',
                names: <Name>[
                  Name(code: 'en', value: 'Gypsum powder'),
                  Name(code: 'ar', value: 'جبس أبيض')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Glass
          const Chain(
            id: 'sub_prd_mat_glass',
            names: <Name>[
              Name(code: 'en', value: 'Glass'),
              Name(code: 'ar', value: 'زجاج')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_glass_float',
                names: <Name>[
                  Name(code: 'en', value: 'Float glass'),
                  Name(code: 'ar', value: 'زجاج مصقول')
                ],
              ),
              KW(
                id: 'prd_mat_glass_bullet',
                names: <Name>[
                  Name(code: 'en', value: 'Bullet proof glass'),
                  Name(code: 'ar', value: 'زجاج مضاد للرصاص')
                ],
              ),
              KW(
                id: 'prd_mat_glass_block',
                names: <Name>[
                  Name(code: 'en', value: 'Glass blocks'),
                  Name(code: 'ar', value: 'طوب زجاجي')
                ],
              ),
              KW(
                id: 'prd_mat_glass_tempered',
                names: <Name>[
                  Name(code: 'en', value: 'Tempered & Laminated glass'),
                  Name(code: 'ar', value: 'زجاج سيكوريت مقوى')
                ],
              ),
              KW(
                id: 'prd_mat_glass_obscured',
                names: <Name>[
                  Name(code: 'en', value: 'Obscured glass'),
                  Name(code: 'ar', value: 'زجاج منقوش')
                ],
              ),
              KW(
                id: 'prd_mat_glass_mirrored',
                names: <Name>[
                  Name(code: 'en', value: 'Mirrored glass'),
                  Name(code: 'ar', value: 'زجاج عاكس')
                ],
              ),
              KW(
                id: 'prd_mat_glass_tinted',
                names: <Name>[
                  Name(code: 'en', value: ' Tinted glass'),
                  Name(code: 'ar', value: 'زجاج ملون')
                ],
              ),
              KW(
                id: 'prd_mat_glass_wired',
                names: <Name>[
                  Name(code: 'en', value: 'Wired glass'),
                  Name(code: 'ar', value: 'زجاج سلكي و شبكي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Fabrics
          const Chain(
            id: 'sub_prd_mat_fabrics',
            names: <Name>[
              Name(code: 'en', value: 'Fabrics'),
              Name(code: 'ar', value: 'أنسجة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_fabric_wool',
                names: <Name>[
                  Name(code: 'en', value: 'Wool'),
                  Name(code: 'ar', value: 'صوف')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_moquette',
                names: <Name>[
                  Name(code: 'en', value: 'Carpets'),
                  Name(code: 'ar', value: 'موكيت')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_leather',
                names: <Name>[
                  Name(code: 'en', value: 'Leather'),
                  Name(code: 'ar', value: 'جلود')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_upholstery',
                names: <Name>[
                  Name(code: 'en', value: 'Upholstery fabric'),
                  Name(code: 'ar', value: 'أنسجة تنجيد')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_polyester',
                names: <Name>[
                  Name(code: 'en', value: 'Polyester'),
                  Name(code: 'ar', value: 'بوليستر')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_silk',
                names: <Name>[
                  Name(code: 'en', value: 'Silk'),
                  Name(code: 'ar', value: 'حرير')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_rayon',
                names: <Name>[
                  Name(code: 'en', value: 'Rayon'),
                  Name(code: 'ar', value: 'رايون')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_cotton',
                names: <Name>[
                  Name(code: 'en', value: 'Cotton'),
                  Name(code: 'ar', value: 'قطن')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_linen',
                names: <Name>[
                  Name(code: 'en', value: 'Linen'),
                  Name(code: 'ar', value: 'كتان')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_velvet',
                names: <Name>[
                  Name(code: 'en', value: 'Velvet'),
                  Name(code: 'ar', value: 'فيلفيت')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_voile',
                names: <Name>[
                  Name(code: 'en', value: 'Voile'),
                  Name(code: 'ar', value: 'فوال')
                ],
              ),
              KW(
                id: 'prd_mat_fabric_lace',
                names: <Name>[
                  Name(code: 'en', value: 'Lace'),
                  Name(code: 'ar', value: 'دانتيل')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cement
          const Chain(
            id: 'sub_prd_mat_cement',
            names: <Name>[
              Name(code: 'en', value: 'Cement'),
              Name(code: 'ar', value: 'أسمنت')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_cement_white',
                names: <Name>[
                  Name(code: 'en', value: 'White cement'),
                  Name(code: 'ar', value: 'أسمنت أبيض')
                ],
              ),
              KW(
                id: 'prd_mat_cement_portland',
                names: <Name>[
                  Name(code: 'en', value: 'Portland'),
                  Name(code: 'ar', value: 'أسمنت بورتلاندي')
                ],
              ),
              KW(
                id: 'prd_mat_cement_board',
                names: <Name>[
                  Name(code: 'en', value: 'Cement boards'),
                  Name(code: 'ar', value: 'ألواح أسمنتية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Bricks
          const Chain(
            id: 'sub_prd_mat_bricks',
            names: <Name>[
              Name(code: 'en', value: 'Bricks'),
              Name(code: 'ar', value: 'طوب')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_brick_cement',
                names: <Name>[
                  Name(code: 'en', value: 'Cement brick'),
                  Name(code: 'ar', value: 'طوب أسمنتي')
                ],
              ),
              KW(
                id: 'prd_mat_brick_red',
                names: <Name>[
                  Name(code: 'en', value: 'Red brick'),
                  Name(code: 'ar', value: 'طوب أحمر')
                ],
              ),
              KW(
                id: 'prd_mat_brick_white',
                names: <Name>[
                  Name(code: 'en', value: 'Lightweight White brick'),
                  Name(code: 'ar', value: 'طوب أبيض')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Acrylic
          const Chain(
            id: 'sub_prd_mat_acrylic',
            names: <Name>[
              Name(code: 'en', value: 'Acrylic'),
              Name(code: 'ar', value: 'أكريليك')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_mat_acrylic_tinted',
                names: <Name>[
                  Name(code: 'en', value: 'Tinted acrylic'),
                  Name(code: 'ar', value: 'أكريليك شفاف')
                ],
              ),
              KW(
                id: 'prd_mat_acrylic_frosted',
                names: <Name>[
                  Name(code: 'en', value: 'Frosted acrylic'),
                  Name(code: 'ar', value: 'أكريليك نصف شفاف')
                ],
              ),
              KW(
                id: 'prd_mat_acrylic_opaque',
                names: <Name>[
                  Name(code: 'en', value: 'Opaque acrylic'),
                  Name(code: 'ar', value: 'أكريليك غير شفاف')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Plumbing & Sanitary ware
      const Chain(
        id: 'group_prd_plumbing',
        names: <Name>[
          Name(code: 'en', value: 'Plumbing & Sanitary ware'),
          Name(code: 'ar', value: 'سباكة و أدوات صحية')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Water Treatment
          const Chain(
            id: 'sub_prd_plumb_treatment',
            names: <Name>[
              Name(code: 'en', value: 'Water Treatment'),
              Name(code: 'ar', value: 'معالجة مياه')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_treatment_filter',
                names: <Name>[
                  Name(code: 'en', value: 'Water filters'),
                  Name(code: 'ar', value: 'فلاتر مياه')
                ],
              ),
              KW(
                id: 'prd_plumbing_treatment_system',
                names: <Name>[
                  Name(code: 'en', value: 'Water treatment systems'),
                  Name(code: 'ar', value: 'أنظمة معالجة مياه')
                ],
              ),
              KW(
                id: 'prd_plumbing_treatment_tank',
                names: <Name>[
                  Name(code: 'en', value: 'Water tanks'),
                  Name(code: 'ar', value: 'خزانات مياه')
                ],
              ),
              KW(
                id: 'prd_plumbing_treatment_heater',
                names: <Name>[
                  Name(code: 'en', value: 'Water Heater'),
                  Name(code: 'ar', value: 'سخانات مياه')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Tub Sanitary ware
          const Chain(
            id: 'sub_prd_plumb_tub',
            names: <Name>[
              Name(code: 'en', value: 'Tub Sanitary ware'),
              Name(code: 'ar', value: 'أدوات بانيو صحية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_tub_bathTubs',
                names: <Name>[
                  Name(code: 'en', value: 'Bathtubs'),
                  Name(code: 'ar', value: ' بانيوهات استحمام')
                ],
              ),
              KW(
                id: 'prd_plumbing_tub_faucet',
                names: <Name>[
                  Name(code: 'en', value: 'Bathtub faucets'),
                  Name(code: 'ar', value: 'صنابير بانيوهات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Toilet Sanitary ware
          const Chain(
            id: 'sub_prd_plumb_toilet',
            names: <Name>[
              Name(code: 'en', value: 'Toilet Sanitary ware'),
              Name(code: 'ar', value: 'أدوات مراحيض صحية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_toilet_floorDrain',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom floor drains'),
                  Name(code: 'ar', value: 'مصارف و بلاعات أرضية للحمامات')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_urinal',
                names: <Name>[
                  Name(code: 'en', value: 'Urinals'),
                  Name(code: 'ar', value: 'مباول')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_bidet',
                names: <Name>[
                  Name(code: 'en', value: 'Bidet'),
                  Name(code: 'ar', value: 'بيديه شطاف')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_bidetFaucet',
                names: <Name>[
                  Name(code: 'en', value: 'Bidet faucets'),
                  Name(code: 'ar', value: 'صنابير بيديه')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_toilet',
                names: <Name>[
                  Name(code: 'en', value: 'Toilets & toilet seats'),
                  Name(code: 'ar', value: 'مراحيض و مجالس مراحيض')
                ],
              ),
              KW(
                id: 'prd_plumbing_toilet_rinser',
                names: <Name>[
                  Name(code: 'en', value: 'Toilet rinsers'),
                  Name(code: 'ar', value: 'شطافات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Shower Sanitary ware
          const Chain(
            id: 'sub_prd_plumb_shower',
            names: <Name>[
              Name(code: 'en', value: 'Shower Sanitary ware'),
              Name(code: 'ar', value: 'أدوات استحمام صحية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_shower_head',
                names: <Name>[
                  Name(code: 'en', value: 'Shower heads & Body sprays'),
                  Name(code: 'ar', value: 'دش و رشاشات دش')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_panel',
                names: <Name>[
                  Name(code: 'en', value: 'Shower panels'),
                  Name(code: 'ar', value: 'وحدات دش متكاملة')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_steam',
                names: <Name>[
                  Name(code: 'en', value: 'Steam shower cabins'),
                  Name(code: 'ar', value: 'كابينات دش بخار')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_faucet',
                names: <Name>[
                  Name(code: 'en', value: 'Tub & shower faucet sets'),
                  Name(code: 'ar', value: 'أطقم صنابير بانيوهات و دش')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_base',
                names: <Name>[
                  Name(code: 'en', value: 'Shower pans & bases'),
                  Name(code: 'ar', value: 'وحدات دش قدم و قواعد')
                ],
              ),
              KW(
                id: 'prd_plumbing_shower_accessory',
                names: <Name>[
                  Name(code: 'en', value: 'Shower accessories'),
                  Name(code: 'ar', value: 'اكسسوارات دش استحمام')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Sanitary ware
          const Chain(
            id: 'sub_prd_plumb_sanitary',
            names: <Name>[
              Name(code: 'en', value: 'Sanitary ware'),
              Name(code: 'ar', value: 'أدوات صحية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_sanitary_drain',
                names: <Name>[
                  Name(code: 'en', value: 'Drains'),
                  Name(code: 'ar', value: 'بلاعات / مصارف')
                ],
              ),
              KW(
                id: 'prd_plumbing_sanitary_bibbs',
                names: <Name>[
                  Name(code: 'en', value: 'Hose bibbs'),
                  Name(code: 'ar', value: 'حنفيات')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Kitchen Sanitary ware
          const Chain(
            id: 'sub_prd_plumb_kitchen',
            names: <Name>[
              Name(code: 'en', value: 'Kitchen Sanitary ware'),
              Name(code: 'ar', value: 'أدوات مطبخ صحية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_kitchen_rinser',
                names: <Name>[
                  Name(code: 'en', value: 'Rinsers'),
                  Name(code: 'ar', value: 'مغسلة أكواب')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_sink',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen sinks'),
                  Name(code: 'ar', value: 'أحواض مطابخ')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_faucet',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen faucets'),
                  Name(code: 'ar', value: 'صنابير مطابخ')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_potFiller',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen pot fillers'),
                  Name(code: 'ar', value: 'صنابير ملئ وعاء')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_barSink',
                names: <Name>[
                  Name(code: 'en', value: 'Bar sinks'),
                  Name(code: 'ar', value: 'أحواض بار')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_barFaucet',
                names: <Name>[
                  Name(code: 'en', value: 'Bar faucets'),
                  Name(code: 'ar', value: 'صنابير بار')
                ],
              ),
              KW(
                id: 'prd_plumbing_kitchen_floorDrain',
                names: <Name>[
                  Name(code: 'en', value: 'Kitchen floor drains'),
                  Name(code: 'ar', value: 'مصارف أرضية مطبخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Handwash Sanitary ware
          const Chain(
            id: 'sub_prd_plumb_handwash',
            names: <Name>[
              Name(code: 'en', value: 'Handwash Sanitary ware'),
              Name(code: 'ar', value: 'أدوات غسيل أيدي صحية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_handwash_washBasins',
                names: <Name>[
                  Name(code: 'en', value: 'Wash basins'),
                  Name(code: 'ar', value: 'أحواض أيدي')
                ],
              ),
              KW(
                id: 'prd_plumbing_handwash_faucet',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom faucets'),
                  Name(code: 'ar', value: 'صنابير حمام')
                ],
              ),
              KW(
                id: 'prd_plumbing_handwash_accessories',
                names: <Name>[
                  Name(code: 'en', value: 'Bathroom accessories'),
                  Name(code: 'ar', value: 'اكسسوارات حمام')
                ],
              ),
              KW(
                id: 'prd_plumbing_handwash_soap',
                names: <Name>[
                  Name(code: 'en', value: 'Lotion & soap dispensers'),
                  Name(code: 'ar', value: 'حاوية صابون و لوشن')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Connections
          const Chain(
            id: 'sub_prd_plumb_connections',
            names: <Name>[
              Name(code: 'en', value: 'Connections'),
              Name(code: 'ar', value: 'وصلات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_plumbing_connections_pipes',
                names: <Name>[
                  Name(code: 'en', value: 'Pipes'),
                  Name(code: 'ar', value: 'مواسير صرف و تغذية')
                ],
              ),
              KW(
                id: 'prd_plumbing_connections_fittings',
                names: <Name>[
                  Name(code: 'en', value: 'Fittings'),
                  Name(code: 'ar', value: 'أكواع و وصلات مواسير')
                ],
              ),
              KW(
                id: 'prd_plumbing_connections_valve',
                names: <Name>[
                  Name(code: 'en', value: 'Valves'),
                  Name(code: 'ar', value: 'محابس')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Pools & Spa
      const Chain(
        id: 'group_prd_poolSpa',
        names: <Name>[
          Name(code: 'en', value: 'Pools & Spa'),
          Name(code: 'ar', value: 'حمامات سباحة و حمامات صحية')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Swimming Pools
          const Chain(
            id: 'sub_prd_pool_pools',
            names: <Name>[
              Name(code: 'en', value: 'Swimming Pools'),
              Name(code: 'ar', value: 'حمامات سباحة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_poolSpa_pools_fiberglass',
                names: <Name>[
                  Name(code: 'en', value: 'Fiberglass pools'),
                  Name(code: 'ar', value: 'حمامات سباحة فايبرجلاس')
                ],
              ),
              KW(
                id: 'prd_poolSpa_pools_above',
                names: <Name>[
                  Name(code: 'en', value: 'Above ground  pools'),
                  Name(code: 'ar', value: 'حمامات سباحة فوق الأرض')
                ],
              ),
              KW(
                id: 'prd_poolSpa_pools_inflatable',
                names: <Name>[
                  Name(code: 'en', value: 'Inflatable pools'),
                  Name(code: 'ar', value: 'حمامات سباحة قابلة للنفخ')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Spa
          const Chain(
            id: 'sub_prd_pool_spa',
            names: <Name>[
              Name(code: 'en', value: 'Spa'),
              Name(code: 'ar', value: 'حمامات صحية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_poolSpa_spa_sauna',
                names: <Name>[
                  Name(code: 'en', value: 'Sauna rooms'),
                  Name(code: 'ar', value: 'غرف ساونا')
                ],
              ),
              KW(
                id: 'prd_poolSpa_spa_steam',
                names: <Name>[
                  Name(code: 'en', value: 'Steam rooms'),
                  Name(code: 'ar', value: 'غرف بخار')
                ],
              ),
              KW(
                id: 'prd_poolSpa_spa_steamShower',
                names: <Name>[
                  Name(code: 'en', value: 'Steam shower cabins'),
                  Name(code: 'ar', value: 'وحدات دش استحمام بخار')
                ],
              ),
              KW(
                id: 'prd_poolSpa_spa_jacuzzi',
                names: <Name>[
                  Name(code: 'en', value: 'Jacuzzi & Hot tubs'),
                  Name(code: 'ar', value: 'جاكوزي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Pools Equipment
          const Chain(
            id: 'sub_prd_pool_equipment',
            names: <Name>[
              Name(code: 'en', value: 'Pools Equipment'),
              Name(code: 'ar', value: 'عدات حمامات سباحة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_poolSpa_equip_cleaning',
                names: <Name>[
                  Name(code: 'en', value: 'Cleaning supplies'),
                  Name(code: 'ar', value: 'أدوات تنظيف حمام سباحة')
                ],
              ),
              KW(
                id: 'prd_poolSpa_equip_pump',
                names: <Name>[
                  Name(code: 'en', value: 'Pumps'),
                  Name(code: 'ar', value: 'مضخات')
                ],
              ),
              KW(
                id: 'prd_poolSpa_equip_filter',
                names: <Name>[
                  Name(code: 'en', value: 'Filters'),
                  Name(code: 'ar', value: 'فلاتر')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Pool Accessories
          const Chain(
            id: 'sub_prd_pool_accessories',
            names: <Name>[
              Name(code: 'en', value: 'Pool Accessories'),
              Name(code: 'ar', value: 'اكسسوارات حمامات سباحة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_poolSpa_access_handrail',
                names: <Name>[
                  Name(code: 'en', value: 'Handrails'),
                  Name(code: 'ar', value: 'درابزين')
                ],
              ),
              KW(
                id: 'prd_poolSpa_access_grate',
                names: <Name>[
                  Name(code: 'en', value: 'Gutters & Grating'),
                  Name(code: 'ar', value: 'مصارف')
                ],
              ),
              KW(
                id: 'prd_poolSpa_access_light',
                names: <Name>[
                  Name(code: 'en', value: 'Lighting'),
                  Name(code: 'ar', value: 'إضاءة')
                ],
              ),
              KW(
                id: 'prd_poolSpa_access_shower',
                names: <Name>[
                  Name(code: 'en', value: 'Outdoor showers'),
                  Name(code: 'ar', value: 'وحدات دش استحمام خارجية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Roofing
      const Chain(
        id: 'group_prd_roofing',
        names: <Name>[
          Name(code: 'en', value: 'Roofing'),
          Name(code: 'ar', value: 'أسطح')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Roof Drainage
          const Chain(
            id: 'sub_prd_roof_drainage',
            names: <Name>[
              Name(code: 'en', value: 'Roof Drainage'),
              Name(code: 'ar', value: 'صرف أسطح')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_roof_drainage_gutter',
                names: <Name>[
                  Name(code: 'en', value: 'Gutters'),
                  Name(code: 'ar', value: 'مصارف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Roof Cladding
          const Chain(
            id: 'sub_prd_roof_cladding',
            names: <Name>[
              Name(code: 'en', value: 'Roof Cladding'),
              Name(code: 'ar', value: 'تجاليد أسطح')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_roof_cladding_brick',
                names: <Name>[
                  Name(code: 'en', value: 'Roof bricks & tiles'),
                  Name(code: 'ar', value: 'قرميد')
                ],
              ),
              KW(
                id: 'prd_roof_cladding_bitumen',
                names: <Name>[
                  Name(code: 'en', value: 'Corrugatedbitumen sheets'),
                  Name(code: 'ar', value: 'صفائح بيتومينية مموجة')
                ],
              ),
              KW(
                id: 'prd_roof_cladding_metal',
                names: <Name>[
                  Name(code: 'en', value: 'Corrugated metal sheets'),
                  Name(code: 'ar', value: 'صفائح معدنية مموجة شينكو')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Safety
      const Chain(
        id: 'group_prd_safety',
        names: <Name>[
          Name(code: 'en', value: 'Safety'),
          Name(code: 'ar', value: 'أمن و سلامة')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Safety Equipment
          const Chain(
            id: 'sub_prd_safety_equip',
            names: <Name>[
              Name(code: 'en', value: 'Safety Equipment'),
              Name(code: 'ar', value: 'معدات سلامة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_safety_equip_gasDetector',
                names: <Name>[
                  Name(code: 'en', value: 'Portable gas detectors'),
                  Name(code: 'ar', value: 'كاشف غاز يدوي')
                ],
              ),
              KW(
                id: 'prd_safety_equip_rescue',
                names: <Name>[
                  Name(code: 'en', value: 'Rescue tools & devices'),
                  Name(code: 'ar', value: 'أدوات و أجهزة إنقاذ')
                ],
              ),
              KW(
                id: 'prd_safety_equip_firstAid',
                names: <Name>[
                  Name(code: 'en', value: 'Emergency & first aid kits'),
                  Name(code: 'ar', value: 'أدوات طوارئ و إعافات أولية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Safety Clothes
          const Chain(
            id: 'sub_prd_safety_clothes',
            names: <Name>[
              Name(code: 'en', value: 'Safety Clothes'),
              Name(code: 'ar', value: 'ملابس أمن و سلامة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_safety_clothes_coverall',
                names: <Name>[
                  Name(code: 'en', value: 'Coveralls'),
                  Name(code: 'ar', value: 'معاطف عمل')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_chemicalSuit',
                names: <Name>[
                  Name(code: 'en', value: 'Chemical protection suits'),
                  Name(code: 'ar', value: 'بدلة واقية من الكيماويات')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_eyeProtection',
                names: <Name>[
                  Name(code: 'en', value: 'Eye protectors'),
                  Name(code: 'ar', value: 'واقيات عيون')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_earProtection',
                names: <Name>[
                  Name(code: 'en', value: 'Ear protectors'),
                  Name(code: 'ar', value: 'واقيات أذن')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_helmet',
                names: <Name>[
                  Name(code: 'en', value: 'Helmets'),
                  Name(code: 'ar', value: 'خوذ')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_glove',
                names: <Name>[
                  Name(code: 'en', value: 'Gloves'),
                  Name(code: 'ar', value: 'قفازات')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_shoe',
                names: <Name>[
                  Name(code: 'en', value: 'Shoes'),
                  Name(code: 'ar', value: 'أحذية حامية')
                ],
              ),
              KW(
                id: 'prd_safety_clothes_respirator',
                names: <Name>[
                  Name(code: 'en', value: 'Respirators'),
                  Name(code: 'ar', value: 'كمامات تنفس')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Floor Protection
          const Chain(
            id: 'sub_prd_safety_floorProtection',
            names: <Name>[
              Name(code: 'en', value: 'Floor Protection'),
              Name(code: 'ar', value: 'حماية أرضيات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_safety_floorProtection_cardboard',
                names: <Name>[
                  Name(code: 'en', value: 'Cardboard roll'),
                  Name(code: 'ar', value: 'لفة كرتون')
                ],
              ),
              KW(
                id: 'prd_safety_floorProtection_plastic',
                names: <Name>[
                  Name(code: 'en', value: 'plastic roll'),
                  Name(code: 'ar', value: 'لفة بلاستيك')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Security
      const Chain(
        id: 'group_prd_security',
        names: <Name>[
          Name(code: 'en', value: 'Security'),
          Name(code: 'ar', value: 'الحماية و الأمان')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Surveillance Systems
          const Chain(
            id: 'sub_prd_security_surveillance',
            names: <Name>[
              Name(code: 'en', value: 'Surveillance Systems'),
              Name(code: 'ar', value: 'أنظمة مراقبة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_security_surv_camera',
                names: <Name>[
                  Name(code: 'en', value: 'Video surveillance systems'),
                  Name(code: 'ar', value: 'أنظمة مراقبة فيديو')
                ],
              ),
              KW(
                id: 'prd_security_surv_thermal',
                names: <Name>[
                  Name(code: 'en', value: 'Thermal imaging systems'),
                  Name(code: 'ar', value: 'أنظمة تصوير حراري')
                ],
              ),
              KW(
                id: 'prd_security_surv_motion',
                names: <Name>[
                  Name(code: 'en', value: 'Motion sensors'),
                  Name(code: 'ar', value: 'حساسات حركة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Security Safes
          const Chain(
            id: 'sub_prd_security_safes',
            names: <Name>[
              Name(code: 'en', value: 'Security Safes'),
              Name(code: 'ar', value: 'خزائن أمان')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_security_safes_wall',
                names: <Name>[
                  Name(code: 'en', value: 'Wall safes'),
                  Name(code: 'ar', value: 'خزن حائطية')
                ],
              ),
              KW(
                id: 'prd_security_safes_portable',
                names: <Name>[
                  Name(code: 'en', value: 'Portable safes'),
                  Name(code: 'ar', value: 'خزن متنقلة')
                ],
              ),
              KW(
                id: 'prd_security_safes_mini',
                names: <Name>[
                  Name(code: 'en', value: 'Mini safes'),
                  Name(code: 'ar', value: 'خزن صغيرة')
                ],
              ),
              KW(
                id: 'prd_security_safes_vault',
                names: <Name>[
                  Name(code: 'en', value: 'Vaults'),
                  Name(code: 'ar', value: 'خزن سرداب')
                ],
              ),
              KW(
                id: 'prd_security_safes_fire',
                names: <Name>[
                  Name(code: 'en', value: 'Fire proof safes'),
                  Name(code: 'ar', value: 'خزن مضادة للحريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Road Control
          const Chain(
            id: 'sub_prd_security_roadControl',
            names: <Name>[
              Name(code: 'en', value: 'Road Control'),
              Name(code: 'ar', value: 'تحكم في الطرق')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_security_road_bollard',
                names: <Name>[
                  Name(code: 'en', value: 'Bollards'),
                  Name(code: 'ar', value: 'بولارد فاصل حركة أرضي')
                ],
              ),
              KW(
                id: 'prd_security_road_tire',
                names: <Name>[
                  Name(code: 'en', value: 'Tire killers'),
                  Name(code: 'ar', value: 'قاتل إطارات')
                ],
              ),
              KW(
                id: 'prd_security_road_barrier',
                names: <Name>[
                  Name(code: 'en', value: 'Road barriers'),
                  Name(code: 'ar', value: 'فاصل طريق')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Accessibility Systems
          const Chain(
            id: 'sub_prd_security_accessibility',
            names: <Name>[
              Name(code: 'en', value: 'Accessibility Systems'),
              Name(code: 'ar', value: 'أنظمة دخول')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_security_access_accessControl',
                names: <Name>[
                  Name(code: 'en', value: 'Access control systems'),
                  Name(code: 'ar', value: 'أنظمة دخول')
                ],
              ),
              KW(
                id: 'prd_security_access_eas',
                names: <Name>[
                  Name(code: 'en', value: 'EAS systems'),
                  Name(code: 'ar', value: 'أنظمة أمن هوائي EAS')
                ],
              ),
              KW(
                id: 'prd_security_access_detector',
                names: <Name>[
                  Name(code: 'en', value: 'Metal detector portals'),
                  Name(code: 'ar', value: 'بوابات كشف معادن')
                ],
              ),
              KW(
                id: 'prd_security_access_turnstile',
                names: <Name>[
                  Name(code: 'en', value: 'Turnstiles'),
                  Name(code: 'ar', value: 'بوابات مرور فردية')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Smart home
      const Chain(
        id: 'group_prd_smartHome',
        names: <Name>[
          Name(code: 'en', value: 'Smart home'),
          Name(code: 'ar', value: 'تجهيزات المنازل الذكية')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Automation Systems
          const Chain(
            id: 'sub_prd_smart_automation',
            names: <Name>[
              Name(code: 'en', value: 'Automation Systems'),
              Name(code: 'ar', value: 'أنظمة أوتوماتية')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_smart_auto_center',
                names: <Name>[
                  Name(code: 'en', value: 'Home automation centers'),
                  Name(code: 'ar', value: 'أنظمة تحكم منزلي آلية')
                ],
              ),
              KW(
                id: 'prd_smart_auto_system',
                names: <Name>[
                  Name(code: 'en', value: 'Automation systems'),
                  Name(code: 'ar', value: 'لوحات تحكم منزلي')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Audio Systems
          const Chain(
            id: 'sub_prd_smart_audio',
            names: <Name>[
              Name(code: 'en', value: 'Audio Systems'),
              Name(code: 'ar', value: 'أنظمة صوت')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_smart_audio_system',
                names: <Name>[
                  Name(code: 'en', value: 'Audio systems'),
                  Name(code: 'ar', value: 'أنظمة صوتية')
                ],
              ),
              KW(
                id: 'prd_smart_audio_theatre',
                names: <Name>[
                  Name(code: 'en', value: 'Home theatre systems'),
                  Name(code: 'ar', value: 'أنظمة مسرح منزلي')
                ],
              ),
              KW(
                id: 'prd_smart_audio_speaker',
                names: <Name>[
                  Name(code: 'en', value: 'Wall & ceiling speakers'),
                  Name(code: 'ar', value: 'سماعات حوائط و أسقف')
                ],
              ),
              KW(
                id: 'prd_smart_audio_wirelessSpeaker',
                names: <Name>[
                  Name(code: 'en', value: 'Wireless speakers'),
                  Name(code: 'ar', value: 'سماعات لاسلكية')
                ],
              ),
              KW(
                id: 'prd_smart_audio_controller',
                names: <Name>[
                  Name(code: 'en', value: 'Audio controllers'),
                  Name(code: 'ar', value: 'متحكمات صوت')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Stairs
      const Chain(
        id: 'group_prd_stairs',
        names: <Name>[
          Name(code: 'en', value: 'Stairs'),
          Name(code: 'ar', value: 'سلالم')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Handrails
          const Chain(
            id: 'sub_prd_stairs_handrails',
            names: <Name>[
              Name(code: 'en', value: 'Handrails'),
              Name(code: 'ar', value: 'درابزين سلالم')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_stairs_handrails_wood',
                names: <Name>[
                  Name(code: 'en', value: 'Wooden handrails'),
                  Name(code: 'ar', value: 'درابزين خشبي')
                ],
              ),
              KW(
                id: 'prd_stairs_handrails_metal',
                names: <Name>[
                  Name(code: 'en', value: 'Metal handrails'),
                  Name(code: 'ar', value: 'درابزين معدني')
                ],
              ),
              KW(
                id: 'prd_stairs_handrails_parts',
                names: <Name>[
                  Name(code: 'en', value: 'Handrail parts'),
                  Name(code: 'ar', value: 'أجزاء درابزين')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Light Structures
      const Chain(
        id: 'group_prd_structure',
        names: <Name>[
          Name(code: 'en', value: 'Light Structures'),
          Name(code: 'ar', value: 'هياكل و منشآت خفيفة')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Shades
          const Chain(
            id: 'sub_prd_struc_shades',
            names: <Name>[
              Name(code: 'en', value: 'Shades'),
              Name(code: 'ar', value: 'مظلات')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_structure_shades_pergola',
                names: <Name>[
                  Name(code: 'en', value: 'Pergola'),
                  Name(code: 'ar', value: 'برجولة')
                ],
              ),
              KW(
                id: 'prd_structure_shades_gazebo',
                names: <Name>[
                  Name(code: 'en', value: 'Gazebos'),
                  Name(code: 'ar', value: 'جازيبو')
                ],
              ),
              KW(
                id: 'prd_structure_shades_sail',
                names: <Name>[
                  Name(code: 'en', value: 'Shade sails'),
                  Name(code: 'ar', value: 'تغطيات شراعية')
                ],
              ),
              KW(
                id: 'prd_structure_shades_canopy',
                names: <Name>[
                  Name(code: 'en', value: 'Canopy'),
                  Name(code: 'ar', value: 'مظلة أرضية')
                ],
              ),
              KW(
                id: 'prd_structure_shades_awning',
                names: <Name>[
                  Name(code: 'en', value: 'Awning'),
                  Name(code: 'ar', value: 'مظلة حائطية')
                ],
              ),
              KW(
                id: 'prd_structure_shades_tent',
                names: <Name>[
                  Name(code: 'en', value: 'tent'),
                  Name(code: 'ar', value: 'خيمة')
                ],
              ),
              KW(
                id: 'prd_structure_shades_umbrella',
                names: <Name>[
                  Name(code: 'en', value: 'Umbrella'),
                  Name(code: 'ar', value: 'شمسية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Light Structures
          const Chain(
            id: 'sub_prd_struc_light',
            names: <Name>[
              Name(code: 'en', value: 'Light Structures'),
              Name(code: 'ar', value: 'منشآت خفيفة')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_structure_light_arbor',
                names: <Name>[
                  Name(code: 'en', value: 'Garden Arbor'),
                  Name(code: 'ar', value: 'معرش شجري')
                ],
              ),
              KW(
                id: 'prd_structure_light_shed',
                names: <Name>[
                  Name(code: 'en', value: 'Shed'),
                  Name(code: 'ar', value: 'كوخ')
                ],
              ),
              KW(
                id: 'prd_structure_light_kiosk',
                names: <Name>[
                  Name(code: 'en', value: 'Kiosk'),
                  Name(code: 'ar', value: 'كشك')
                ],
              ),
              KW(
                id: 'prd_structure_light_playhouse',
                names: <Name>[
                  Name(code: 'en', value: 'Kids playhouse'),
                  Name(code: 'ar', value: 'بيت لعب أطفال')
                ],
              ),
              KW(
                id: 'prd_structure_light_greenHouse',
                names: <Name>[
                  Name(code: 'en', value: 'Greenhouse'),
                  Name(code: 'ar', value: 'صوبة')
                ],
              ),
              KW(
                id: 'prd_structure_light_glassHouse',
                names: <Name>[
                  Name(code: 'en', value: 'Glass house'),
                  Name(code: 'ar', value: 'بيت زجاجي')
                ],
              ),
              KW(
                id: 'prd_structure_light_trailer',
                names: <Name>[
                  Name(
                      code: 'en',
                      value: 'Construction trailers & Caravans'),
                  Name(code: 'ar', value: 'كارافان و مقطورات')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Walls & Room Partitions
      const Chain(
        id: 'group_prd_walls',
        names: <Name>[
          Name(code: 'en', value: 'Walls & Room Partitions'),
          Name(code: 'ar', value: 'حوائط و فواصل غرف')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Wall Cladding
          const Chain(
            id: 'sub_prd_walls_cladding',
            names: <Name>[
              Name(code: 'en', value: 'Wall Cladding'),
              Name(code: 'ar', value: 'تبليط و تجلاليد حوائط')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_walls_cladding_mosaic',
                names: <Name>[
                  Name(code: 'en', value: 'Mosaic tiling'),
                  Name(code: 'ar', value: 'موزايك حائط')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_murals',
                names: <Name>[
                  Name(code: 'en', value: 'Tile mural'),
                  Name(code: 'ar', value: 'جدارية')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_borders',
                names: <Name>[
                  Name(code: 'en', value: 'Accent, trim & border tiles'),
                  Name(code: 'ar', value: 'حليات و زوايا')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_tiles',
                names: <Name>[
                  Name(code: 'en', value: 'Wall tiles'),
                  Name(code: 'ar', value: 'بلاطات حائط')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_veneer',
                names: <Name>[
                  Name(code: 'en', value: 'Siding & stone veneer slices'),
                  Name(code: 'ar', value: 'شرائح صخرية')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_panels',
                names: <Name>[
                  Name(code: 'en', value: 'Wall panels'),
                  Name(code: 'ar', value: 'بانوهات')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_wood',
                names: <Name>[
                  Name(code: 'en', value: 'Wood wall panels'),
                  Name(code: 'ar', value: 'تجاليد خشب')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_metal',
                names: <Name>[
                  Name(code: 'en', value: 'Metal cladding'),
                  Name(code: 'ar', value: 'تجاليد معدنية')
                ],
              ),
              KW(
                id: 'prd_walls_cladding_wallpaper',
                names: <Name>[
                  Name(code: 'en', value: 'Wall paper'),
                  Name(code: 'ar', value: 'ورق حائط')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Room Partitions
          const Chain(
            id: 'sub_prd_walls_partitions',
            names: <Name>[
              Name(code: 'en', value: 'Room Partitions'),
              Name(code: 'ar', value: 'فواصل غرف')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_walls_partitions_screens',
                names: <Name>[
                  Name(code: 'en', value: 'Screens & room divider'),
                  Name(code: 'ar', value: 'فاصل غرفة')
                ],
              ),
              KW(
                id: 'prd_walls_partitions_showerStalls',
                names: <Name>[
                  Name(code: 'en', value: 'Shower cabinet'),
                  Name(code: 'ar', value: 'وحدة دش استحمام')
                ],
              ),
              KW(
                id: 'prd_walls_partitions_doubleWalls',
                names: <Name>[
                  Name(code: 'en', value: 'Double wall section'),
                  Name(code: 'ar', value: 'قطاع حائط مزدوج')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Moldings & Millwork
          const Chain(
            id: 'sub_prd_walls_moldings',
            names: <Name>[
              Name(code: 'en', value: 'Moldings & Millwork'),
              Name(code: 'ar', value: 'قوالب و عواميد')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_walls_molding_rail',
                names: <Name>[
                  Name(code: 'en', value: 'Rails & trims'),
                  Name(code: 'ar', value: 'وزر حائطي')
                ],
              ),
              KW(
                id: 'prd_walls_molding_onlay',
                names: <Name>[
                  Name(code: 'en', value: 'Onlays & Appliques'),
                  Name(code: 'ar', value: 'منحوتات و زخرفيات')
                ],
              ),
              KW(
                id: 'prd_walls_molding_column',
                names: <Name>[
                  Name(code: 'en', value: 'Columns & Capitals'),
                  Name(code: 'ar', value: 'أعمدة و تيجان')
                ],
              ),
              KW(
                id: 'prd_walls_molding_medallion',
                names: <Name>[
                  Name(code: 'en', value: 'Ceiling Medallions'),
                  Name(code: 'ar', value: 'مدالية سقف')
                ],
              ),
              KW(
                id: 'prd_walls_molding_corbel',
                names: <Name>[
                  Name(code: 'en', value: 'Corbels'),
                  Name(code: 'ar', value: 'كرابيل أسقف')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Ceiling Cladding
          const Chain(
            id: 'sub_prd_walls_ceiling',
            names: <Name>[
              Name(code: 'en', value: 'Ceiling Cladding'),
              Name(code: 'ar', value: 'تجاليد أسقف')
            ],
            sons: const <KW>[
              KW(
                id: 'prd_walls_ceiling_tiles',
                names: <Name>[
                  Name(code: 'en', value: 'Ceiling tiles'),
                  Name(code: 'ar', value: 'بلاطات تجليد أسقف')
                ],
              ),
            ],
          ),
        ],
      ),
      // -----------------------------------------------
    ],
  );

}