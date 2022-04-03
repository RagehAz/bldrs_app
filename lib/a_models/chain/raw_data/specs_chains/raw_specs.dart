import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_crafts.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';

const String newSaleID = 'phid_s_contractType_NewSale';
const String resaleID = 'phid_s_contractType_Resale';
const String rentID = 'phid_s_contractType_Rent';

// -------------------------------------------------------------------------
/// STYLE ANATOMY
const Chain style = Chain(
  id: 'phid_s_style',
  icon: null,
  sons: <String>[
    'phid_s_arch_style_arabian',
    'phid_s_arch_style_andalusian',
    'phid_s_arch_style_asian',
    'phid_s_arch_style_chinese',
    'phid_s_arch_style_contemporary',
    'phid_s_arch_style_classic',
    'phid_s_arch_style_eclectic',
    'phid_s_arch_style_english',
    'phid_s_arch_style_farmhouse',
    'phid_s_arch_style_french',
    'phid_s_arch_style_gothic',
    'phid_s_arch_style_greek',
    'phid_s_arch_style_indian',
    'phid_s_arch_style_industrial',
    'phid_s_arch_style_japanese',
    'phid_s_arch_style_mediterranean',
    'phid_s_arch_style_midcentury',
    'phid_s_arch_style_medieval',
    'phid_s_arch_style_minimalist',
    'phid_s_arch_style_modern',
    'phid_s_arch_style_moroccan',
    'phid_s_arch_style_rustic',
    'phid_s_arch_style_scandinavian',
    'phid_s_arch_style_shabbyChic',
    'phid_s_arch_style_american',
    'phid_s_arch_style_spanish',
    'phid_s_arch_style_traditional',
    'phid_s_arch_style_transitional',
    'phid_s_arch_style_tuscan',
    'phid_s_arch_style_tropical',
    'phid_s_arch_style_victorian',
    'phid_s_arch_style_vintage',

  ],
);
const Chain color = Chain(
  id: 'phid_s_color',
  icon: null,
  sons: <String>[
    'phid_s_red',
    'phid_s_orange',
    'phid_s_yellow',
    'phid_s_green',
    'phid_s_blue',
    'phid_s_indigo',
    'phid_s_violet',
    'phid_s_black',
    'phid_s_white',
    'phid_s_grey',
  ],
);
// -------------------------------------------------------------------------
/// PRICING ANATOMY
const Chain contractType = Chain(
  id: 'phid_s_contractType',
  icon: null,
  sons: <String>[
    'phid_s_contractType_NewSale',
    'phid_s_contractType_Resale',
    'phid_s_contractType_Rent',
  ],
);
const Chain paymentMethod = Chain(
  id: 'phid_s_paymentMethod',
  icon: null,
  sons: <String>[
  'phid_s_payment_cash',
  'phid_s_payment_installments',
  ],
);
const Chain price = Chain(
  id: 'phid_s_price',
  icon: null,
  sons: DataCreator.price,
);
const Chain currency = Chain(
  id: 'phid_s_currency',
  icon: null,
  sons: DataCreator.currency,
);
const Chain unitPriceInterval = Chain(
  id: 'phid_s_unitPriceInterval',
  icon: null,
  sons: <String>[
    'phid_s_perHour',
    'phid_s_perDay',
    'phid_s_perWeek',
    'phid_s_perMonth',
    'phid_s_perYear',
  ],
);
const Chain numberOfInstallments = Chain(
  id: 'phid_s_numberOfInstallments',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain installmentsDuration = Chain(
  id: 'phid_s_installmentsDuration',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain installmentsDurationUnit = Chain(
  id: 'phid_s_installmentsDurationUnit',
  icon: null,
  sons: <String>[
    'phid_s_installmentsDurationUnit_day',
    'phid_s_installmentsDurationUnit_week',
    'phid_s_installmentsDurationUnit_month',
    'phid_s_installmentsDurationUnit_year',
  ],
);
// -------------------------------------------------------------------------
/// TIME ANATOMY
const Chain duration = Chain(
  id: 'phid_s_duration',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain durationUnit = Chain(
  id: 'phid_s_durationUnit',
  icon: null,
  sons: <String>[
    'phid_s_minute',
    'phid_s_hour',
    'phid_s_day',
    'phid_s_week',
    'phid_s_month',
    'phid_s_year',
  ],
);
// -------------------------------------------------------------------------
/// AREAL ANATOMY
const Chain propertyArea = Chain(
  id: 'phid_s_propertyArea',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain propertyAreaUnit = Chain(
  id: 'phid_s_propertyAreaUnit',
  icon: null,
  sons: <String>[
    'phid_s_square_meter',
    'phid_s_square_feet',
  ],
);
const Chain lotArea = Chain(
  id: 'phid_s_plotArea',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain lotAreaUnit = Chain(
  id: 'phid_s_lotAreaUnit',
  icon: null,
  sons: <String>[
    'phid_square_meter',
    'phid_square_Kilometer',
    'phid_square_feet',
    'phid_square_yard',
    'phid_acre',
    'phid_hectare',
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY GENERAL ANATOMY
const Chain propertyForm = Chain(
  id: 'phid_s_propertyForm',
  icon: null,
  sons: <String>[
    'phid_s_pf_fullFloor',
    'phid_s_pf_halfFloor',
    'phid_s_pf_partFloor',
    'phid_s_pf_building',
    'phid_s_pf_land',
    'phid_s_pf_mobile',
  ],
);
const Chain propertyLicense = Chain(
  id: 'phid_s_propertyLicense',
  icon: null,
  sons: <String>[
    'phid_s_ppt_lic_residential',
    'phid_s_ppt_lic_administration',
    'phid_s_ppt_lic_educational',
    'phid_s_ppt_lic_utilities',
    'phid_s_ppt_lic_sports',
    'phid_s_ppt_lic_entertainment',
    'phid_s_ppt_lic_medical',
    'phid_s_ppt_lic_retail',
    'phid_s_ppt_lic_hotel',
    'phid_s_ppt_lic_industrial',
  ],
);
// -------------------------------------------------------------------------
/// PROPERTY SPATIAL ANATOMY
const Chain propertySpaces = Chain(
  id: 'phid_s_group_space_type',
  icon: null,
  sons: <Chain>[
    // ----------------------------------
    /// Administration
    Chain(
      id: 'phid_s_ppt_lic_administration',
      icon: null,
      sons: <String>[
        'phid_s_pt_office',
        'phid_s_space_kitchenette',
        'phid_s_space_meetingRoom',
        'phid_s_space_seminarHall',
        'phid_s_space_conventionHall',
      ],
    ),
    // ----------------------------------
    /// Educational
    Chain(
      id: 'phid_s_ppt_lic_educational',
      icon: null,
      sons: <String>[
        'phid_s_space_lectureRoom',
        'phid_s_space_library',
      ],
    ),
    // ----------------------------------
    /// Entertainment
    Chain(
      id: 'phid_s_ppt_lic_entertainment',
      icon: null,
      sons: <String>[
        'phid_s_space_theatre',
        'phid_s_space_concertHall',
        'phid_s_space_homeCinema',
      ],
    ),
    // ----------------------------------
    /// Medical
    Chain(
      id: 'phid_s_ppt_lic_medical',
      icon: null,
      sons: <String>[
        'phid_s_space_spa',
      ],
    ),
    // ----------------------------------
    /// Residential
    Chain(
      id: 'phid_s_ppt_lic_residential',
      icon: null,
      sons: <String>[
        'phid_s_space_lobby',
        'phid_s_space_living',
        'phid_s_space_bedroom',
        'phid_s_space_kitchen',
        'phid_s_space_bathroom',
        'phid_s_space_reception',
        'phid_s_space_salon',
        'phid_s_space_laundry',
        'phid_s_space_balcony',
        'phid_s_space_toilet',
        'phid_s_space_dining',
        'phid_s_space_stairs',
        'phid_s_space_attic',
        'phid_s_space_corridor',
        'phid_s_space_garage',
        'phid_s_space_storage',
        'phid_s_space_maid',
        'phid_s_space_walkInCloset',
        'phid_s_space_barbecue',
        'phid_s_space_garden',
        'phid_s_space_privatePool',

      ],
    ),
    // ----------------------------------
    /// Retail
    Chain(
      id: 'phid_s_ppt_lic_retail',
      icon: null,
      sons: <String>[
        'phid_s_space_store',
      ],
    ),
    // ----------------------------------
    /// Sports
    Chain(
      id: 'phid_s_ppt_lic_sports',
      icon: null,
      sons: <String>[
        'phid_s_space_gymnasium',
        'phid_s_space_sportsCourt',
        'phid_s_space_sportStadium',
      ],
    ),
    // ----------------------------------
    /// Utilities
    Chain(
      id: 'phid_s_ppt_lic_utilities',
      icon: null,
      sons: <String>[
        'phid_s_pFeature_elevator',
        'phid_s_space_electricityRoom',
        'phid_s_space_plumbingRoom',
        'phid_s_space_mechanicalRoom',
      ],
    ),
  ],
);
const Chain propertyFloorNumber = Chain(
  id: 'phid_s_propertyFloorNumber',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain propertyDedicatedParkingLotsCount = Chain(
  id: 'phid_s_propertyDedicatedParkingSpaces',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain propertyNumberOfBedrooms = Chain(
  id: 'phid_s_propertyNumberOfBedrooms',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain propertyNumberOfBathrooms = Chain(
  id: 'phid_s_propertyNumberOfBathrooms',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// PROPERTY FEATURES ANATOMY
const Chain propertyView = Chain(
  id: 'phid_s_propertyView',
  icon: null,
  sons: <String>[
    'phid_s_view_golf',
    'phid_s_view_hill',
    'phid_s_view_ocean',
    'phid_s_view_city',
    'phid_s_view_lake',
    'phid_s_view_lagoon',
    'phid_s_view_river',
    'phid_s_view_mainStreet',
    'phid_s_view_sideStreet',
    'phid_s_view_corner',
    'phid_s_view_back',
    'phid_s_view_garden',
    'phid_s_view_pool',
  ],
);
const Chain propertyIndoorFeatures = Chain(
  id: 'phid_s_sub_ppt_feat_indoor',
  icon: null,
  sons: <String>[
    'phid_s_pFeature_disabilityFeatures',
    'phid_s_pFeature_fireplace',
    'phid_s_pFeature_energyEfficient',
    'phid_s_pFeature_electricityBackup',
    'phid_s_pFeature_centralAC',
    'phid_s_pFeature_centralHeating',
    'phid_s_pFeature_builtinWardrobe',
    'phid_s_pFeature_kitchenAppliances',
    'phid_s_pFeature_elevator',
    'phid_s_pFeature_intercom',
    'phid_s_pFeature_internet',
    'phid_s_pFeature_tv',
  ],
);
const Chain propertyFinishingLevel = Chain(
  id: 'phid_s_sub_ppt_feat_finishing',
  icon: null,
  sons: <String>[
    'phid_s_finish_coreAndShell',
    'phid_s_finish_withoutFinishing',
    'phid_s_finish_semiFinished',
    'phid_s_finish_lux',
    'phid_s_finish_superLux',
    'phid_s_finish_extraSuperLux',
  ],
);
// -------------------------------------------------------------------------
/// BUILDING FEATURES ANATOMY
const Chain buildingNumberOfFloors = Chain(
  id: 'phid_s_buildingNumberOfFloors',
  icon: null,
  sons: DataCreator.integerIncrementer, // TASK : define range 0 - g163
);
const Chain buildingAgeInYears = Chain(
  id: 'phid_s_buildingAge',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain buildingTotalParkingLotsCount = Chain(
  id: 'phid_s_buildingTotalParkingLotsCount',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain buildingTotalUnitsCount = Chain(
  id: 'phid_s_buildingTotalPropertiesCount',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
// -------------------------------------------------------------------------
/// COMMUNITY FEATURES ANATOMY
const Chain inACompound = Chain(
  id: 'phid_s_sub_ppt_feat_compound',
  icon: null,
  sons: <String>[
    'phid_s_in_compound',
    'phid_s_not_in_compound',
  ],
);
const Chain amenities = Chain(
  id: 'phid_s_sub_ppt_feat_amenities',
  icon: null,
  sons: <String>[
    'phid_s_am_laundry',
    'phid_s_am_swimmingPool',
    'phid_s_am_kidsPool',
    'phid_s_am_boatFacilities',
    'phid_s_am_gymFacilities',
    'phid_s_am_clubHouse',
    'phid_s_am_horseFacilities',
    'phid_s_am_sportsCourts',
    'phid_s_am_park',
    'phid_s_am_golfCourse',
    'phid_s_am_spa',
    'phid_s_am_kidsArea',
    'phid_s_am_cafeteria',
    'phid_s_am_businessCenter',
    'phid_s_am_lobby',
  ],
);
const Chain communityServices = Chain(
  id: 'phid_s_sub_ppt_feat_services',
  icon: null,
  sons: <String>[
    'phid_s_pService_houseKeeping',
    'phid_s_pService_laundryService',
    'phid_s_pService_concierge',
    'phid_s_pService_securityStaff',
    'phid_s_pService_securityCCTV',
    'phid_s_pService_petsAllowed',
    'phid_s_pService_doorMan',
    'phid_s_pService_maintenance',
    'phid_s_pService_wasteDisposal',
    'phid_s_pFeature_atm',
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
  id: 'phid_s_constructionActivities',
  icon: null,
  sons: ChainCrafts.chain.sons,
);
const Chain constructionActivityMeasurementMethod = Chain(
  id: 'phid_s_constructionActivityMeasurementMethod',
  icon: null,
  sons: <String>[
    'phid_s_byLength',
    'phid_s_byArea',
    'phid_s_byVolume',
    'phid_s_byCount',
    'phid_s_byTime',
    'phid_s_byLove',
  ],
);
// -------------------------------------------------------------------------
/// SIZING ANATOMY
const Chain width = Chain(
  id: 'phid_s_width',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain length = Chain(
  id: 'phid_s_length',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain height = Chain(
  id: 'phid_s_height',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain thickness = Chain(
  id: 'phid_s_thickness',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain diameter = Chain(
  id: 'phid_s_diameter',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain radius = Chain(
  id: 'phid_s_radius',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain linearMeasurementUnit = Chain(
  id: 'phid_s_linearMeasureUnit',
  icon: null,
  sons: <String>[
    'phid_s_micron',
    'phid_s_millimeter',
    'phid_s_centimeter',
    'phid_s_meter',
    'phid_s_kilometer',
    'phid_s_inch',
    'phid_s_feet',
    'phid_s_yard',
    'phid_s_mile',
  ],
);
const Chain footPrint = Chain(
  id: 'phid_s_footPrint',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain areaMeasureUnit = Chain(
  id: 'phid_s_areaMeasureUnit',
  icon: null,
  sons: <String>[
    'phid_s_square_meter',
    'phid_s_square_Kilometer',
    'phid_s_square_feet',
    'phid_s_square_yard',
    'phid_s_acre',
    'phid_s_hectare',
  ],
);
const Chain volume = Chain(
  id: 'phid_s_volume',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain volumeMeasurementUnit = Chain(
  id: 'phid_s_volumeMeasurementUnit',
  icon: null,
  sons: <String>[
    'phid_s_cubic_cm',
    'phid_s_cubic_m',
    'phid_s_millilitre',
    'phid_s_litre',
    'phid_s_fluidOunce',
    'phid_s_gallon',
    'phid_s_cubic_inch',
    'phid_s_cubic_feet',
  ],
);
const Chain weight = Chain(
  id: 'phid_s_weight',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain weightMeasurementUnit = Chain(
  id: 'phid_s_weightMeasurementUnit',
  icon: null,
  sons: <String>[
    'phid_s_ounce',
    'phid_s_pound',
    'phid_s_ton',
    'phid_s_gram',
    'phid_s_kilogram',
  ],
);
const Chain count = Chain(
  id: 'phid_s_count',
  icon: null,
  sons: DataCreator.integerIncrementer,
);
const Chain size = Chain(
  id: 'phid_s_size',
  icon: null,
  sons: <String>[
    'phid_s_xxxSmall',
    'phid_s_xxSmall',
    'phid_s_xSmall',
    'phid_s_small',
    'phid_s_medium',
    'phid_s_large',
    'phid_s_xLarge',
    'phid_s_xxLarge',
    'phid_s_xxxLarge',
  ],
);
// ------------------------------------------
/// ELECTRICAL ANATOMY
const Chain wattage = Chain(
  id: 'phid_s_wattage',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain voltage = Chain(
  id: 'phid_s_voltage',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain ampere = Chain(
  id: 'phid_s_ampere',
  icon: null,
  sons: DataCreator.doubleCreator,
);
// ------------------------------------------
/// LOGISTICS ANATOMY
const Chain inStock = Chain(
  id: 'phid_s_inStock',
  icon: null,
  sons: DataCreator.boolSwitch,
);
const Chain deliveryAvailable = Chain(
  id: 'phid_s_deliveryAvailable',
  icon: null,
  sons: DataCreator.boolSwitch,
);
const Chain deliveryDuration = Chain(
  id: 'phid_s_deliveryMinDuration',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain deliveryDurationUnit = Chain(
  id: 'phid_s_deliveryDurationUnit',
  icon: null,
  sons: <String>[
    'phid_s_hour',
    'phid_s_day',
    'phid_s_week',
  ],
);
// ------------------------------------------
/// PRODUCT INFO
const Chain madeIn = Chain(
  id: 'phid_s_madeIn',
  icon: null,
  sons: DataCreator.country,
);
const Chain warrantyDuration = Chain(
  id: 'phid_s_insuranceDuration',
  icon: null,
  sons: DataCreator.doubleCreator,
);
const Chain warrantyDurationUnit = Chain(
  id: 'phid_s_warrantyDurationUnit',
  icon: null,
  sons: <String>[
    'phid_s_hour',
    'phid_s_day',
    'phid_s_week',
    'phid_s_year',

  ],
);
// ------------------------------------------
