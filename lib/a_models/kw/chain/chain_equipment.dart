import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainEquipment {

  static const Chain chain = Chain(
    id: 'equipment',
    icon: Iconz.bxEquipmentOff,
    phraseID: 'phid_k_equipment_keywords',
    sons: <Chain>[

      /*

      // -----------------------------------------------
      /// Handheld equipment & tools
      Chain(
        id: 'group_equip_handheld',
        icon: null,
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Handheld equipment & tools'),
          Phrase(langCode: 'ar', value: 'معدات و أدوات خفيفة')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Power tools
          Chain(
            id: 'sub_handheld_power',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Power tools'),
              Phrase(langCode: 'ar', value: 'أدوات كهربية')
            ],
            sons: <KW>[
              KW(
                id: 'equip_tool_power_drill',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Drills'),
                  Phrase(langCode: 'ar', value: 'ثاقب كهربائي')
                ],
              ),
              KW(
                id: 'equip_tool_power_saw',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Electric saw'),
                  Phrase(langCode: 'ar', value: 'منشار كهربائي')
                ],
              ),
              KW(
                id: 'equip_tool_power_router',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Router'),
                  Phrase(langCode: 'ar', value: 'راوتر')
                ],
              ),
              KW(
                id: 'equip_tool_power_grinder',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Grinder'),
                  Phrase(langCode: 'ar', value: 'صاروخ جارش')
                ],
              ),
              KW(
                id: 'equip_tool_power_compressor',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Air compressors'),
                  Phrase(langCode: 'ar', value: 'كباس هوائي')
                ],
              ),
              KW(
                id: 'equip_tool_power_sander',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sanders'),
                  Phrase(langCode: 'ar', value: 'ماكينات صنفرة')
                ],
              ),
              KW(
                id: 'equip_tool_power_heatGun',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Heat guns'),
                  Phrase(langCode: 'ar', value: 'مسدسات حرارية')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Measurement tools
          Chain(
            id: 'sub_handheld_measure',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Measurement tools'),
              Phrase(langCode: 'ar', value: 'أدوات قياسس')
            ],
            sons: <KW>[
              KW(
                id: 'equip_tool_measure_lasermeter',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Laser meters'),
                  Phrase(langCode: 'ar', value: 'متر قياس ليزر')
                ],
              ),
              KW(
                id: 'equip_tool_measure_tapMeasure',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tape measure'),
                  Phrase(langCode: 'ar', value: 'متر شريط قياس')
                ],
              ),
              KW(
                id: 'equip_tool_measure_theodolite',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Theodolite & Total stations'),
                  Phrase(langCode: 'ar', value: 'تيدوليت')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Handheld machinery
          Chain(
            id: 'sub_handheld_machinery',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Handheld machinery'),
              Phrase(langCode: 'ar', value: 'ماكينات يدوية')
            ],
            sons: <KW>[
              KW(
                id: 'equip_handheld_paver',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Roller Pavers'),
                  Phrase(langCode: 'ar', value: 'آلة رصف')
                ],
              ),
              KW(
                id: 'equip_handheld_rammer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tamper rammers'),
                  Phrase(langCode: 'ar', value: 'ماكينات دك هزاز')
                ],
              ),
              KW(
                id: 'equip_handheld_jack',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Jack Hammers'),
                  Phrase(langCode: 'ar', value: 'مطرقة ثاقبة هيلتي')
                ],
              ),
              KW(
                id: 'equip_handheld_troweller',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Trowellers'),
                  Phrase(langCode: 'ar', value: 'مجرفة أرض هليكوبتر')
                ],
              ),
              KW(
                id: 'equip_handheld_spray',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Plaster spray unit'),
                  Phrase(langCode: 'ar', value: 'وحدة رش محارة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Hand tools
          Chain(
            id: 'sub_handheld_handTools',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Hand tools'),
              Phrase(langCode: 'ar', value: 'أدوات يدوية')
            ],
            sons: <KW>[
              KW(
                id: 'equip_tool_hand_workbench',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tool storage & work benches'),
                  Phrase(langCode: 'ar', value: 'مخازن عدد و أسطح عمل')
                ],
              ),
              KW(
                id: 'equip_tool_hand_bits',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wood drill bits'),
                  Phrase(langCode: 'ar', value: 'بنط')
                ],
              ),
              KW(
                id: 'equip_tool_hand_screws',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Screws, nuts & bolts, fishers'),
                  Phrase(langCode: 'ar', value: 'براغي و صواميل و مسامير و فيشر')
                ],
              ),
              KW(
                id: 'equip_tool_hand_ladder',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Ladders & step stools'),
                  Phrase(langCode: 'ar', value: 'سلالم')
                ],
              ),
              KW(
                id: 'equip_tool_hand_paint',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Paint tools'),
                  Phrase(langCode: 'ar', value: 'أدوات دهانات')
                ],
              ),
              KW(
                id: 'equip_tool_hand_screwDriver',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Screw drivers'),
                  Phrase(langCode: 'ar', value: 'مفكات')
                ],
              ),
              KW(
                id: 'equip_tool_hand_clamp',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Clamps'),
                  Phrase(langCode: 'ar', value: 'مشابك')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Garden Tools
          Chain(
            id: 'sub_handheld_gardenTools',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Garden Tools'),
              Phrase(langCode: 'ar', value: 'أدوات زراعة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_tool_garden_fork',
                names: <Phrase>[
                  Phrase(
                      langCode: 'en',
                      value: 'Forks, Rakes, Hoes, Shovels & Spades'),
                  Phrase(langCode: 'ar', value: 'شوك و مجارف و معاول')
                ],
              ),
              KW(
                id: 'prd_tool_garden_pruning',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Pruning tools'),
                  Phrase(langCode: 'ar', value: 'أدوات تقليم')
                ],
              ),
              KW(
                id: 'prd_tool_garden_wheel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Wheelbarrows'),
                  Phrase(langCode: 'ar', value: 'عربة ركام')
                ],
              ),
              KW(
                id: 'prd_tool_garden_barrel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'barrels & cans'),
                  Phrase(langCode: 'ar', value: 'براميل')
                ],
              ),
              KW(
                id: 'prd_tool_garden_sprayer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sprayers & spreaders'),
                  Phrase(langCode: 'ar', value: 'رشاشات و موزعات')
                ],
              ),
              KW(
                id: 'prd_tool_garden_hose',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Garden hoses'),
                  Phrase(langCode: 'ar', value: 'خراطيم ري')
                ],
              ),
              KW(
                id: 'prd_tool_garden_hoseReel',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Garden hose reels'),
                  Phrase(langCode: 'ar', value: 'بكرات خراطيم ري')
                ],
              ),
              KW(
                id: 'prd_tool_garden_sprinkler',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Sprinklers'),
                  Phrase(langCode: 'ar', value: 'مرشات ري أرضية')
                ],
              ),
              KW(
                id: 'prd_tool_garden_glove',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Gardening gloves'),
                  Phrase(langCode: 'ar', value: 'قفازات زراعة')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Cleaning Tools
          Chain(
            id: 'sub_handheld_cleaning',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Cleaning Tools'),
              Phrase(langCode: 'ar', value: 'أدوات نظافة')
            ],
            sons: <KW>[
              KW(
                id: 'prd_tool_hk_floorcare',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Floor care Accessories'),
                  Phrase(langCode: 'ar', value: 'أدوات عناية بالأرضيات')
                ],
              ),
              KW(
                id: 'prd_tool_hk_mop',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mops, Brooms & dustpans'),
                  Phrase(langCode: 'ar', value: 'مماسح و مكانس و مجارف')
                ],
              ),
            ],
          ),
          // ----------------------------------
        ],
      ),
      // -----------------------------------------------
      /// Material handling equipment
      Chain(
        id: 'group_equip_handling',
        icon: null,
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Material handling equipment'),
          Phrase(langCode: 'ar', value: 'معدات نقل و تحميل')
        ],
        sons: <KW>[
          KW(
            id: 'equip_mat_crane',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Cranes'),
              Phrase(langCode: 'ar', value: 'رافعات')
            ],
          ),
          KW(
            id: 'equip_mat_conveyor',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Conveyors'),
              Phrase(langCode: 'ar', value: 'ناقلات')
            ],
          ),
          KW(
            id: 'equip_mat_forklift',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Forklifts'),
              Phrase(langCode: 'ar', value: 'عربة رافعة شوكية')
            ],
          ),
          KW(
            id: 'equip_mat_hoist',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Hoists'),
              Phrase(langCode: 'ar', value: 'ألات رافعة')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Heavy machinery
      Chain(
        id: 'group_equip_heavy',
        icon: null,
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Heavy machinery'),
          Phrase(langCode: 'ar', value: 'معدات ثقيلة')
        ],
        sons: <KW>[
          KW(
            id: 'equip_machinery_stoneCrusher',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Stone crushers'),
              Phrase(langCode: 'ar', value: 'كسارة حجر')
            ],
          ),
          KW(
            id: 'equip_machinery_tunneling',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Tunneling boring machine'),
              Phrase(langCode: 'ar', value: 'ألة حفر أنفاق')
            ],
          ),
          KW(
            id: 'equip_machinery_mixer',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Concrete mixers'),
              Phrase(langCode: 'ar', value: 'خلاطات خرسانة')
            ],
          ),
          KW(
            id: 'equip_machinery_mixPlant',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Hot mix plants'),
              Phrase(langCode: 'ar', value: 'محطات خلط ساخنة')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Construction preparations
      Chain(
        id: 'group_equip_prep',
        icon: null,
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Construction preparations'),
          Phrase(langCode: 'ar', value: 'تجهيزات الموقع')
        ],
        sons: <KW>[
          KW(
            id: 'equip_prep_scaffold',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Scaffold'),
              Phrase(langCode: 'ar', value: 'سقالات')
            ],
          ),
          KW(
            id: 'equip_prep_cone',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Cones & Barriers'),
              Phrase(langCode: 'ar', value: 'أقماع و حواجز')
            ],
          ),
          KW(
            id: 'equip_prep_signage',
            names: <Phrase>[
              Phrase(langCode: 'en', value: 'Safety signage'),
              Phrase(langCode: 'ar', value: 'لافتات أمان')
            ],
          ),
        ],
      ),
      // -----------------------------------------------
      /// Vehicles
      Chain(
        id: 'group_equip_vehicle',
        icon: null,
        titlePhraseID: <Phrase>[
          Phrase(langCode: 'en', value: 'Vehicles'),
          Phrase(langCode: 'ar', value: 'عربات')
        ],
        sons: <Chain>[
          // ----------------------------------
          /// Earth moving vehicles
          Chain(
            id: 'sub_vehicle_earthmoving',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Earth moving vehicles'),
              Phrase(langCode: 'ar', value: 'عربات تحريك الأرض')
            ],
            sons: <KW>[
              KW(
                id: 'equip_earth_excavator',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Excavators'),
                  Phrase(langCode: 'ar', value: 'حفارات')
                ],
              ),
              KW(
                id: 'equip_earth_backhoe',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Backhoe'),
                  Phrase(langCode: 'ar', value: 'جراف حفار')
                ],
              ),
              KW(
                id: 'equip_earth_loader',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Loaders'),
                  Phrase(langCode: 'ar', value: 'عربة تحميل لودر')
                ],
              ),
              KW(
                id: 'equip_earth_bulldozer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Bulldozers'),
                  Phrase(langCode: 'ar', value: 'جرافات')
                ],
              ),
              KW(
                id: 'equip_earth_trencher',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Trenchers'),
                  Phrase(langCode: 'ar', value: 'حفارات خنادق')
                ],
              ),
              KW(
                id: 'equip_earth_grader',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Graders'),
                  Phrase(langCode: 'ar', value: 'ممهدات طرق')
                ],
              ),
              KW(
                id: 'equip_earth_scrapper',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Scrappers'),
                  Phrase(langCode: 'ar', value: 'جرارات كاشطة')
                ],
              ),
              KW(
                id: 'equip_earth_crawlerLoader',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Crawler loader'),
                  Phrase(langCode: 'ar', value: 'محمل زاحف')
                ],
              ),
              KW(
                id: 'equip_earth_crawler',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Crawlers'),
                  Phrase(langCode: 'ar', value: 'حفار زاحف صغير')
                ],
              ),
              KW(
                id: 'equip_earth_excavator',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Excavators'),
                  Phrase(langCode: 'ar', value: 'حفار زاحف كبير')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Transporting vehicles
          Chain(
            id: 'sub_vehicle_transport',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Transporting vehicles'),
              Phrase(langCode: 'ar', value: 'عربات ناقلة')
            ],
            sons: <KW>[
              KW(
                id: 'equip_vehicle_dumper',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Dumpers & Tippers'),
                  Phrase(langCode: 'ar', value: 'شاحنات قلابة')
                ],
              ),
              KW(
                id: 'equip_vehicle_tanker',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Tankers'),
                  Phrase(langCode: 'ar', value: 'شاحنات سوائل')
                ],
              ),
              KW(
                id: 'equip_vehicle_mixer',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Mixer truck'),
                  Phrase(langCode: 'ar', value: 'شاحناط خلاط')
                ],
              ),
            ],
          ),
          // ----------------------------------
          /// Paving vehicles
          Chain(
            id: 'sub_vehicle_paving',
            icon: null,
            titlePhraseID: <Phrase>[
              Phrase(langCode: 'en', value: 'Paving vehicles'),
              Phrase(langCode: 'ar', value: 'عربات تمهيد طرق')
            ],
            sons: <KW>[
              KW(
                id: 'equip_paving_roller',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Road Rollers'),
                  Phrase(langCode: 'ar', value: 'مدحلة أسفلت')
                ],
              ),
              KW(
                id: 'equip_paving_asphalt',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Road making machine'),
                  Phrase(langCode: 'ar', value: 'ماكينات صناعة الطرق')
                ],
              ),
              KW(
                id: 'equip_paving_slurry',
                names: <Phrase>[
                  Phrase(langCode: 'en', value: 'Slurry seal machine'),
                  Phrase(langCode: 'ar', value: 'ماكينات أسفلت')
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
