import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/kw/chain.dart';
import 'package:bldrs/models/kw/kw.dart';

abstract class ChainEquipment{

  static const Chain chain = const Chain(
    id: 'equipment',
    icon: Iconz.BxEquipmentOff,
    names: <Name>[
      Name(code: 'en', value: 'Equipment'),
      Name(code: 'ar', value: '')
    ],
    sons: <Chain>[

      // -----------------------------------------------
      /// Handheld equipment & tools
      const Chain(
        id: 'group_equip_handheld',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Handheld equipment & tools'),
          Name(code: 'ar', value: 'معدات و أدوات خفيفة')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Power tools
          const Chain(
            id: 'sub_handheld_power',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Power tools'),
              Name(code: 'ar', value: 'أدوات كهربية')
            ],
            sons: const <KW>[
              KW(id: 'equip_tool_power_drill', names: <Name>[Name(code: 'en', value: 'Drills'), Name(code: 'ar', value: 'ثاقب كهربائي')],),
              KW(id: 'equip_tool_power_saw', names: <Name>[Name(code: 'en', value: 'Electric saw'), Name(code: 'ar', value: 'منشار كهربائي')],),
              KW(id: 'equip_tool_power_router', names: <Name>[Name(code: 'en', value: 'Router'), Name(code: 'ar', value: 'راوتر')],),
              KW(id: 'equip_tool_power_grinder', names: <Name>[Name(code: 'en', value: 'Grinder'), Name(code: 'ar', value: 'صاروخ جارش')],),
              KW(id: 'equip_tool_power_compressor', names: <Name>[Name(code: 'en', value: 'Air compressors'), Name(code: 'ar', value: 'كباس هوائي')],),
              KW(id: 'equip_tool_power_sander', names: <Name>[Name(code: 'en', value: 'Sanders'), Name(code: 'ar', value: 'ماكينات صنفرة')],),
              KW(id: 'equip_tool_power_heatGun', names: <Name>[Name(code: 'en', value: 'Heat guns'), Name(code: 'ar', value: 'مسدسات حرارية')],),
            ],
          ),
          // ----------------------------------
          /// Measurement tools
          const Chain(
            id: 'sub_handheld_measure',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Measurement tools'),
              Name(code: 'ar', value: 'أدوات قياسس')
            ],
            sons: const <KW>[
              KW(id: 'equip_tool_measure_lasermeter', names: <Name>[Name(code: 'en', value: 'Laser meters'), Name(code: 'ar', value: 'متر قياس ليزر')],),
              KW(id: 'equip_tool_measure_tapMeasure', names: <Name>[Name(code: 'en', value: 'Tape measure'), Name(code: 'ar', value: 'متر شريط قياس')],),
              KW(id: 'equip_tool_measure_theodolite', names: <Name>[Name(code: 'en', value: 'Theodolite & Total stations'), Name(code: 'ar', value: 'تيدوليت')],),
            ],
          ),
          // ----------------------------------
          /// Handheld machinery
          const Chain(
            id: 'sub_handheld_machinery',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Handheld machinery'),
              Name(code: 'ar', value: 'ماكينات يدوية')
            ],
            sons: const <KW>[
              KW(id: 'equip_handheld_paver', names: <Name>[Name(code: 'en', value: 'Roller Pavers'), Name(code: 'ar', value: 'آلة رصف')],),
              KW(id: 'equip_handheld_rammer', names: <Name>[Name(code: 'en', value: 'Tamper rammers'), Name(code: 'ar', value: 'ماكينات دك هزاز')],),
              KW(id: 'equip_handheld_jack', names: <Name>[Name(code: 'en', value: 'Jack Hammers'), Name(code: 'ar', value: 'مطرقة ثاقبة هيلتي')],),
              KW(id: 'equip_handheld_troweller', names: <Name>[Name(code: 'en', value: 'Trowellers'), Name(code: 'ar', value: 'مجرفة أرض هليكوبتر')],),
              KW(id: 'equip_handheld_spray', names: <Name>[Name(code: 'en', value: 'Plaster spray unit'), Name(code: 'ar', value: 'وحدة رش محارة')],),
            ],
          ),
          // ----------------------------------
          /// Hand tools
          const Chain(
            id: 'sub_handheld_handTools',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Hand tools'),
              Name(code: 'ar', value: 'أدوات يدوية')
            ],
            sons: const <KW>[
              KW(id: 'equip_tool_hand_workbench', names: <Name>[Name(code: 'en', value: 'Tool storage & work benches'), Name(code: 'ar', value: 'مخازن عدد و أسطح عمل')],),
              KW(id: 'equip_tool_hand_bits', names: <Name>[Name(code: 'en', value: 'Wood drill bits'), Name(code: 'ar', value: 'بنط')],),
              KW(id: 'equip_tool_hand_screws', names: <Name>[Name(code: 'en', value: 'Screws, nuts & bolts, fishers'), Name(code: 'ar', value: 'براغي و صواميل و مسامير و فيشر')],),
              KW(id: 'equip_tool_hand_ladder', names: <Name>[Name(code: 'en', value: 'Ladders & step stools'), Name(code: 'ar', value: 'سلالم')],),
              KW(id: 'equip_tool_hand_paint', names: <Name>[Name(code: 'en', value: 'Paint tools'), Name(code: 'ar', value: 'أدوات دهانات')],),
              KW(id: 'equip_tool_hand_screwDriver', names: <Name>[Name(code: 'en', value: 'Screw drivers'), Name(code: 'ar', value: 'مفكات')],),
              KW(id: 'equip_tool_hand_clamp', names: <Name>[Name(code: 'en', value: 'Clamps'), Name(code: 'ar', value: 'مشابك')],),
            ],
          ),
          // ----------------------------------
          /// Garden Tools
          const Chain(
            id: 'sub_handheld_gardenTools',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Garden Tools'),
              Name(code: 'ar', value: 'أدوات زراعة')
            ],
            sons: const <KW>[
              KW(id: 'prd_tool_garden_fork', names: <Name>[Name(code: 'en', value: 'Forks, Rakes, Hoes, Shovels & Spades'), Name(code: 'ar', value: 'شوك و مجارف و معاول')],),
              KW(id: 'prd_tool_garden_pruning', names: <Name>[Name(code: 'en', value: 'Pruning tools'), Name(code: 'ar', value: 'أدوات تقليم')],),
              KW(id: 'prd_tool_garden_wheel', names: <Name>[Name(code: 'en', value: 'Wheelbarrows'), Name(code: 'ar', value: 'عربة ركام')],),
              KW(id: 'prd_tool_garden_barrel', names: <Name>[Name(code: 'en', value: 'barrels & cans'), Name(code: 'ar', value: 'براميل')],),
              KW(id: 'prd_tool_garden_sprayer', names: <Name>[Name(code: 'en', value: 'Sprayers & spreaders'), Name(code: 'ar', value: 'رشاشات و موزعات')],),
              KW(id: 'prd_tool_garden_hose', names: <Name>[Name(code: 'en', value: 'Garden hoses'), Name(code: 'ar', value: 'خراطيم ري')],),
              KW(id: 'prd_tool_garden_hoseReel', names: <Name>[Name(code: 'en', value: 'Garden hose reels'), Name(code: 'ar', value: 'بكرات خراطيم ري')],),
              KW(id: 'prd_tool_garden_sprinkler', names: <Name>[Name(code: 'en', value: 'Sprinklers'), Name(code: 'ar', value: 'مرشات ري أرضية')],),
              KW(id: 'prd_tool_garden_glove', names: <Name>[Name(code: 'en', value: 'Gardening gloves'), Name(code: 'ar', value: 'قفازات زراعة')],),
            ],
          ),
          // ----------------------------------
          /// Cleaning Tools
          const Chain(
            id: 'sub_handheld_cleaning',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Cleaning Tools'),
              Name(code: 'ar', value: 'أدوات نظافة')
            ],
            sons: const <KW>[
              KW(id: 'prd_tool_hk_floorcare', names: <Name>[Name(code: 'en', value: 'Floor care Accessories'), Name(code: 'ar', value: 'أدوات عناية بالأرضيات')],),
              KW(id: 'prd_tool_hk_mop', names: <Name>[Name(code: 'en', value: 'Mops, Brooms & dustpans'), Name(code: 'ar', value: 'مماسح و مكانس و مجارف')],),
            ],
          ),
          // ----------------------------------
        ],
      ),
      // -----------------------------------------------
      /// Material handling equipment
      const Chain(
        id: 'group_equip_handling',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Material handling equipment'),
          Name(code: 'ar', value: 'معدات نقل و تحميل')
        ],
        sons: const <KW>[

          KW(id: 'equip_mat_crane', names: <Name>[Name(code: 'en', value: 'Cranes'), Name(code: 'ar', value: 'رافعات')],),
          KW(id: 'equip_mat_conveyor', names: <Name>[Name(code: 'en', value: 'Conveyors'), Name(code: 'ar', value: 'ناقلات')],),
          KW(id: 'equip_mat_forklift', names: <Name>[Name(code: 'en', value: 'Forklifts'), Name(code: 'ar', value: 'عربة رافعة شوكية')],),
          KW(id: 'equip_mat_hoist', names: <Name>[Name(code: 'en', value: 'Hoists'), Name(code: 'ar', value: 'ألات رافعة')],),

        ],),
      // -----------------------------------------------
      /// Heavy machinery
      const Chain(
        id: 'group_equip_heavy',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Heavy machinery'),
          Name(code: 'ar', value: 'معدات ثقيلة')
        ],
        sons: const <KW>[
          KW(id: 'equip_machinery_stoneCrusher', names: <Name>[Name(code: 'en', value: 'Stone crushers'), Name(code: 'ar', value: 'كسارة حجر')],),
          KW(id: 'equip_machinery_tunneling', names: <Name>[Name(code: 'en', value: 'Tunneling boring machine'), Name(code: 'ar', value: 'ألة حفر أنفاق')],),
          KW(id: 'equip_machinery_mixer', names: <Name>[Name(code: 'en', value: 'Concrete mixers'), Name(code: 'ar', value: 'خلاطات خرسانة')],),
          KW(id: 'equip_machinery_mixPlant', names: <Name>[Name(code: 'en', value: 'Hot mix plants'), Name(code: 'ar', value: 'محطات خلط ساخنة')],),
        ],
      ),
      // -----------------------------------------------
      /// Construction preparations
      const Chain(
        id: 'group_equip_prep',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Construction preparations'),
          Name(code: 'ar', value: 'تجهيزات الموقع')
        ],
        sons: const <KW>[
          KW(id: 'equip_prep_scaffold', names: <Name>[Name(code: 'en', value: 'Scaffold'), Name(code: 'ar', value: 'سقالات')],),
          KW(id: 'equip_prep_cone', names: <Name>[Name(code: 'en', value: 'Cones & Barriers'), Name(code: 'ar', value: 'أقماع و حواجز')],),
          KW(id: 'equip_prep_signage', names: <Name>[Name(code: 'en', value: 'Safety signage'), Name(code: 'ar', value: 'لافتات أمان')],),
        ],
      ),
      // -----------------------------------------------
      /// Vehicles
      const Chain(
        id: 'group_equip_vehicle',
        icon: null,
        names: <Name>[
          Name(code: 'en', value: 'Vehicles'),
          Name(code: 'ar', value: 'عربات')
        ],
        sons: const <Chain>[
          // ----------------------------------
          /// Earth moving vehicles
          const Chain(
            id: 'sub_vehicle_earthmoving',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Earth moving vehicles'),
              Name(code: 'ar', value: 'عربات تحريك الأرض')
            ],
            sons: const <KW>[
              KW(id: 'equip_earth_excavator', names: <Name>[Name(code: 'en', value: 'Excavators'), Name(code: 'ar', value: 'حفارات')],),
              KW(id: 'equip_earth_backhoe', names: <Name>[Name(code: 'en', value: 'Backhoe'), Name(code: 'ar', value: 'جراف حفار')],),
              KW(id: 'equip_earth_loader', names: <Name>[Name(code: 'en', value: 'Loaders'), Name(code: 'ar', value: 'عربة تحميل لودر')],),
              KW(id: 'equip_earth_bulldozer', names: <Name>[Name(code: 'en', value: 'Bulldozers'), Name(code: 'ar', value: 'جرافات')],),
              KW(id: 'equip_earth_trencher', names: <Name>[Name(code: 'en', value: 'Trenchers'), Name(code: 'ar', value: 'حفارات خنادق')],),
              KW(id: 'equip_earth_grader', names: <Name>[Name(code: 'en', value: 'Graders'), Name(code: 'ar', value: 'ممهدات طرق')],),
              KW(id: 'equip_earth_scrapper', names: <Name>[Name(code: 'en', value: 'Scrappers'), Name(code: 'ar', value: 'جرارات كاشطة')],),
              KW(id: 'equip_earth_crawlerLoader', names: <Name>[Name(code: 'en', value: 'Crawler loader'), Name(code: 'ar', value: 'محمل زاحف')],),
              KW(id: 'equip_earth_crawler', names: <Name>[Name(code: 'en', value: 'Crawlers'), Name(code: 'ar', value: 'حفار زاحف صغير')],),
              KW(id: 'equip_earth_excavator', names: <Name>[Name(code: 'en', value: 'Excavators'), Name(code: 'ar', value: 'حفار زاحف كبير')],),
            ],
          ),
          // ----------------------------------
          /// Transporting vehicles
          const Chain(
            id: 'sub_vehicle_transport',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Transporting vehicles'),
              Name(code: 'ar', value: 'عربات ناقلة')
            ],
            sons: const <KW>[
              KW(id: 'equip_vehicle_dumper', names: <Name>[Name(code: 'en', value: 'Dumpers & Tippers'), Name(code: 'ar', value: 'شاحنات قلابة')],),
              KW(id: 'equip_vehicle_tanker', names: <Name>[Name(code: 'en', value: 'Tankers'), Name(code: 'ar', value: 'شاحنات سوائل')],),
              KW(id: 'equip_vehicle_mixer', names: <Name>[Name(code: 'en', value: 'Mixer truck'), Name(code: 'ar', value: 'شاحناط خلاط')],),
            ],
          ),
          // ----------------------------------
          /// Paving vehicles
          const Chain(
            id: 'sub_vehicle_paving',
            icon: null,
            names: <Name>[
              Name(code: 'en', value: 'Paving vehicles'),
              Name(code: 'ar', value: 'عربات تمهيد طرق')
            ],
            sons: const <KW>[
              KW(id: 'equip_paving_roller', names: <Name>[Name(code: 'en', value: 'Road Rollers'), Name(code: 'ar', value: 'مدحلة أسفلت')],),
              KW(id: 'equip_paving_asphalt', names: <Name>[Name(code: 'en', value: 'Road making machine'), Name(code: 'ar', value: 'ماكينات صناعة الطرق')],),
              KW(id: 'equip_paving_slurry', names: <Name>[Name(code: 'en', value: 'Slurry seal machine'), Name(code: 'ar', value: 'ماكينات أسفلت')],),
            ],
          ),
        ],
      ),
      // -----------------------------------------------

    ],
  );

}