import 'package:bldrs/a_models/chain/spec_models/pickers_blocker.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';

List<PickerModel> propertySpecsPickers = const <PickerModel>[
    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    PickerModel(
        chainID: 'phid_k_flyer_type_property',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        blockers: <PickersBlocker>[
            // SpecDeactivator(
            //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
            //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
            // ),
        ],
    ),
    // ------------------------------------------------------------
    /// - MAIN SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    PickerModel(
        chainID: 'phid_s_propertyForm',
        groupID: 'Main Specifications', /// TASK : TRANSLATE THIS
        canPickMany: false,
        isRequired: true,
        blockers: <PickersBlocker>[
          PickersBlocker(
              value: 'phid_s_pf_land',
              pickersIDsToBlock: <String>[
                'phid_s_propertyArea',
                'phid_s_propertyAreaUnit'
              ]),
          PickersBlocker(
              value: 'phid_s_pf_mobile',
              pickersIDsToBlock: <String>[
                'phid_s_lotArea',
                'phid_s_lotAreaUnit',
                'phid_s_propertyFloorNumber',
                'phid_s_propertyNumberOfBedrooms',
                'phid_s_propertyNumberOfBathrooms',
                'phid_s_propertyInACompound'
              ]),
        ],
    ),
    // -------------
    /// PROPERTY LICENSE
    PickerModel(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Main Specifications',
        canPickMany: true,
        isRequired: true,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY PRICING SPECIFICATIONS
    // ----------------------------
    /// PROPERTY CONTRACT TYPE
    PickerModel(
        chainID: 'phid_s_contractType',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: true,
        blockers: <PickersBlocker>[
          PickersBlocker(
              value: 'phid_s_contractType_NewSale',
              pickersIDsToBlock: <String>['phid_s_propertyRentPrice',]
          ),
          PickersBlocker(
              value: 'phid_s_contractType_Resale',
              pickersIDsToBlock: <String>['phid_s_propertyRentPrice',],
          ),
          PickersBlocker(
              value: 'phid_s_contractType_Rent',
              pickersIDsToBlock: <String>['phid_s_PropertySalePrice',]
          ),
        ],
    ),
    // -------------
    /// PROPERTY PAYMENT METHOD
    PickerModel(
        chainID: 'phid_s_paymentMethod',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        blockers: <PickersBlocker>[
          PickersBlocker(
              value: 'phid_s_payment_cash',
              pickersIDsToBlock: <String>[
                'phid_s_numberOfInstallments',
                'phid_s_InstallmentsDuration',
                'phid_s_InstallmentsDurationUnit'
              ]
          ),
        ],
    ),
    // -------------
    /// PROPERTY SALE PRICE
    PickerModel(
        chainID: 'phid_s_PropertySalePrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency',
    ),
    // -------------
    /// PROPERTY RENT PRICE
    PickerModel(
        chainID: 'phid_s_propertyRentPrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency',
    ),
    // ----------------------------
    /*
    /// PROPERTY PRICE CURRENCY
    SpecPicker(
        chainID: 'phid_s_currency',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
     */
    // ------------------------------------------------------------
    /// - INSTALLMENTS
    // ----------------------------
    /// PROPERTY NUMBER OF INSTALLMENTS
    PickerModel(
        chainID: 'phid_s_numberOfInstallments',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY INSTALLMENTS DURATION
    PickerModel(
        chainID: 'phid_s_installmentsDuration',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_installmentsDurationUnit'
    ),
    // -------------
    /*
    /// PROPERTY INSTALLMENTS DURATION UNIT
    SpecPicker(
        chainID: 'phid_s_installmentsDurationUnit',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
     */
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    PickerModel(
        chainID: 'phid_s_propertyArea',
        groupID: 'Property Area',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_propertyAreaUnit',
    ),
    // ------------------------------------------------------------
    /// - LOT AREA
    // ----------------------------
    /// LOT AREA
    PickerModel(
        chainID: 'phid_s_plotArea',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_lotAreaUnit',
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPATIAL SPECIFICATION
    // ----------------------------
    /// PROPERTY SPACES
    PickerModel(
        chainID: 'phid_s_property_spaces', // phid_s_group_space_type has chain but translates (Space type)
        groupID: 'Spatial Specifications',
        canPickMany: true,
        isRequired: false
    ),
    // -------------
    /// PROPERTY FLOOR NUMBER
    PickerModel(
        chainID: 'phid_s_propertyFloorNumber',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY DEDICATED PARKING LOTS COUNT
    PickerModel(
        chainID: 'phid_s_propertyDedicatedParkingSpaces',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY NUMBER OF BEDROOMS
    PickerModel(
        chainID: 'phid_s_propertyNumberOfBedrooms',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY NUMBER OF BATHROOMS
    PickerModel(
        chainID: 'phid_s_propertyNumberOfBathrooms',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY FEATURES SPECIFICATIONS
    // ----------------------------
    /// PROPERTY VIEW
    PickerModel(
        chainID: 'phid_s_propertyView',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY INDOOR FEATURES
    PickerModel(
        chainID: 'phid_s_sub_ppt_feat_indoor',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false
    ),
    // -------------
    /// PROPERTY FINISHING LEVEL
    PickerModel(
        chainID: 'phid_s_sub_ppt_feat_finishing',
        groupID: 'Property Features',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// PROPERTY DECORATION STYLE
    PickerModel(
        chainID: 'phid_s_propertyDecorationStyle',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false
    ),
    // ------------------------------------------------------------
    /// - COMMUNITY FEATURES SPECIFICATIONS
    // ----------------------------
    /// IN  A COMPOUND
    PickerModel(
        chainID: 'phid_s_sub_ppt_feat_compound',
        groupID: 'Community Features',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// AMENITIES
    PickerModel(
        chainID: 'phid_s_sub_ppt_feat_amenities',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false
    ),
    // -------------
    /// COMMUNITY SERVICES
    PickerModel(
        chainID: 'phid_s_sub_ppt_feat_services',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false
    ),
    // ------------------------------------------------------------
    /// - BUILDING FEATURES SPECIFICATIONS
    // ----------------------------
    /// BUILDING NUMBER OF FLOORS
    PickerModel(
        chainID: 'phid_s_buildingNumberOfFloors',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// BUILDING AGE IN YEARS
    PickerModel(
        chainID: 'phid_s_buildingAge',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// BUILDING TOTAL UNITS COUNTS
    PickerModel(
        chainID: 'phid_s_buildingTotalPropertiesCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// BUILDING TOTAL PARKING LOTS COUNTS
    PickerModel(
        chainID: 'phid_s_buildingTotalParkingLotsCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // ------------------------------------------------------------
];

List<PickerModel> designSpecsPickers = const <PickerModel>[
    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    PickerModel(
        chainID: 'phid_k_flyer_type_design',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        blockers: <PickersBlocker>[
            // SpecDeactivator(
            //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
            //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
            // ),
        ],
    ),
    // ------------------------------------------------------------
    /// - DESIGN SPECIFICATIONS
    // ----------------------------
    /// DESIGN TYPE
    PickerModel(
        chainID: 'phid_s_group_dz_type',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true
    ),
    // -------------
    /// DESIGN SPACES
    PickerModel(
        chainID: 'phid_s_group_space_type',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true
    ),
    // -------------
    /// DESIGN STYLE
    PickerModel(
        chainID: 'phid_s_style',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: false
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    PickerModel(
        chainID: 'phid_s_propertyForm',
        groupID: 'Property Specifications',
        canPickMany: false,
        isRequired: true
    ),
    // -------------
    /// PROPERTY LICENSE
    PickerModel(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Property Specifications',
        canPickMany: true,
        isRequired: true
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION COST
    // ----------------------------
    /// PROJECT COST
    PickerModel(
        chainID: 'phid_s_projectCost',
        groupID: 'Construction Cost',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency'
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION DURATION
    // ----------------------------
    /// Construction DURATION
    PickerModel(
        chainID: 'phid_s_constructionDuration',
        groupID: 'Construction Duration',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_constructionDurationUnit',
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION ACTIVITIES
    // ----------------------------
    /// CONSTRUCTION ACTIVITIES
    PickerModel(
        chainID: 'phid_k_flyer_type_trades',
        groupID: 'Construction Activities',
        canPickMany: true,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    PickerModel(
        chainID: 'phid_s_propertyArea',
        groupID: 'Property Area',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_propertyAreaUnit',
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// LOT AREA
    PickerModel(
        chainID: 'phid_s_plotArea',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_lotAreaUnit',
    ),
    // ------------------------------------------------------------
];

List<PickerModel> tradeSpecsPickers = const <PickerModel>[
    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    PickerModel(
        chainID: 'phid_k_flyer_type_trades',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        blockers: <PickersBlocker>[
            // SpecDeactivator(
            //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
            //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
            // ),
        ],
    ),
    // ------------------------------------------------------------
    /// - PRICING
    // ----------------------------
    /// CONSTRUCTION ACTIVITY PRICE
    PickerModel(
        chainID: 'phid_s_price',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency',
    ),
    // ------------------------------------------------------------
    /// - MEASUREMENTS
    // ----------------------------
    /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
    PickerModel(
        chainID: 'phid_s_constructionActivityMeasurementMethod',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
    ),
    // ------------------------------------------------------------
];

List<PickerModel> productSpecsPickers = const <PickerModel>[
    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    PickerModel(
        chainID: 'phid_k_flyer_type_product',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        blockers: <PickersBlocker>[
            // SpecDeactivator(
            //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
            //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
            // ),
        ],
    ),
    // ------------------------------------------------------------
    /// - PRICING SPECIFICATIONS
    // ----------------------------
    /// CONTRACT TYPE
    PickerModel(
        chainID: 'phid_s_contractType',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        blockers: <PickersBlocker>[
            PickersBlocker(
                value: 'phid_s_contractType_NewSale',
                pickersIDsToBlock: <String>['phid_s_rentPrice',]
            ),
            PickersBlocker(
                value: 'phid_s_contractType_Resale',
                pickersIDsToBlock: <String>['phid_s_rentPrice',],
            ),
            PickersBlocker(
                value: 'phid_s_contractType_Rent',
                pickersIDsToBlock: <String>['phid_s_salePrice',]
            ),
        ],
    ),
    // -------------
    /// PAYMENT METHOD
    PickerModel(
        chainID: 'phid_s_paymentMethod',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        blockers: <PickersBlocker>[
            PickersBlocker(
                value: 'phid_s_payment_cash',
                pickersIDsToBlock: <String>[
                    'phid_s_numberOfInstallments',
                    'phid_s_InstallmentsDuration',
                    'phid_s_InstallmentsDurationUnit'
                ]
            ),
        ],
    ),
    // -------------
    /// SALE PRICE
    PickerModel(
        chainID: 'phid_s_salePrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency',
    ),
    // -------------
    /// RENT PRICE
    PickerModel(
        chainID: 'phid_s_rentPrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency',
    ),
    // ------------------------------------------------------------
    /// - INSTALLMENTS
    // ----------------------------
    /// NUMBER OF INSTALLMENTS
    PickerModel(
        chainID: 'phid_s_numberOfInstallments',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// INSTALLMENTS DURATION
    PickerModel(
        chainID: 'phid_s_installmentsDuration',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_installmentsDurationUnit'
    ),
    // ------------------------------------------------------------
    /// - DESIGN SPECIFICATIONS
    // ----------------------------
    /// COLOR
    PickerModel(
        chainID: 'phid_s_color',
        groupID: 'Design',
        canPickMany: true,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - DIMENSIONS SPECIFICATIONS
    // ----------------------------
    /// WIDTH
    PickerModel(
        chainID: 'phid_s_width',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// LENGTH
    PickerModel(
        chainID: 'phid_s_length',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// HEIGHT
    PickerModel(
        chainID: 'phid_s_height',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// THICKNESS
    PickerModel(
        chainID: 'phid_s_thickness',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// DIAMETER
    PickerModel(
        chainID: 'phid_s_diameter',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// RADIUS
    PickerModel(
        chainID: 'phid_s_radius',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // ------------------------------------------------------------
    /// - SIZE SPECIFICATIONS
    // ----------------------------
    /// FOOTPRINT
    PickerModel(
        chainID: 'phid_s_footPrint',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_areaMeasureUnit',
    ),
    // -------------
    /// VOLUME
    PickerModel(
        chainID: 'phid_s_volume',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_volumeMeasurementUnit',
    ),
    // -------------
    /// WIGHT
    PickerModel(
        chainID: 'phid_s_weight',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_weightMeasurementUnit',
    ),
    // -------------
    /// SIZE
    PickerModel(
        chainID: 'phid_s_size',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - SIZE SPECIFICATIONS
    // ----------------------------
    /// QUANTITY
    PickerModel(
        chainID: 'phid_s_count',
        groupID: 'Quantity',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - ELECTRIC SPECIFICATIONS
    // ----------------------------
    /// WATTAGE
    PickerModel(
        chainID: 'phid_s_wattage',
        groupID: 'Electricity',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// WATTAGE
    PickerModel(
        chainID: 'phid_s_voltage',
        groupID: 'Electricity',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// WATTAGE
    PickerModel(
        chainID: 'phid_s_ampere',
        groupID: 'Electricity',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - AVAILABILITY SPECIFICATIONS
    // ----------------------------
    /// WATTAGE
    PickerModel(
        chainID: 'phid_s_inStock',
        groupID: 'Availability',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - DELIVERY SPECIFICATIONS
    // ----------------------------
    /// DELIVERY AVAILABILITY
    PickerModel(
        chainID: 'phid_s_deliveryAvailable',
        groupID: 'Availability',
        canPickMany: false,
        isRequired: false,
        blockers: <PickersBlocker>[
            PickersBlocker(
                value: false,
                pickersIDsToBlock: <String>['phid_s_deliveryMinDuration'],
            ),
        ],
    ),
    // -------------
    /// DELIVERY AVAILABILITY
    PickerModel(
        chainID: 'phid_s_deliveryMinDuration',
        groupID: 'Availability',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_deliveryDurationUnit',
    ),
    // ----------------------------
    /// - MANUFACTURER SPECIFICATIONS
    // ----------------------------
    /// MADE IN
    PickerModel(
        chainID: 'phid_s_madeIn',
        groupID: 'Manufacturer Info',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - WARRANTY SPECIFICATIONS
    // ----------------------------
    /// WARRANTY DURATION
    PickerModel(
        chainID: 'phid_s_insuranceDuration',
        groupID: 'Warranty',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_warrantyDurationUnit',
    ),
    // ----------------------------
];

List<PickerModel> equipmentSpecsPickers = <PickerModel>[];
