import 'package:bldrs/a_models/chain/spec_models/spec_deactivator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';

List<SpecPicker> propertySpecsPickers = const <SpecPicker>[
    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    SpecPicker(
        chainID: 'phid_k_flyer_type_property',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        deactivators: <SpecDeactivator>[
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
    SpecPicker(
        chainID: 'phid_s_propertyForm',
        groupID: 'Main Specifications', /// TASK : TRANSLATE THIS
        canPickMany: false,
        isRequired: true,
        deactivators: <SpecDeactivator>[
          SpecDeactivator(
              specValueThatDeactivatesSpecsLists: 'phid_s_pf_land',
              specsListsIDsToDeactivate: <String>[
                'phid_s_propertyArea',
                'phid_s_propertyAreaUnit'
              ]),
          SpecDeactivator(
              specValueThatDeactivatesSpecsLists: 'phid_s_pf_mobile',
              specsListsIDsToDeactivate: <String>[
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
    SpecPicker(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Main Specifications',
        canPickMany: true,
        isRequired: true,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY PRICING SPECIFICATIONS
    // ----------------------------
    /// PROPERTY CONTRACT TYPE
    SpecPicker(
        chainID: 'phid_s_contractType',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: true,
        deactivators: <SpecDeactivator>[
          SpecDeactivator(
              specValueThatDeactivatesSpecsLists: 'phid_s_contractType_NewSale',
              specsListsIDsToDeactivate: <String>['phid_s_propertyRentPrice',]
          ),
          SpecDeactivator(
              specValueThatDeactivatesSpecsLists: 'phid_s_contractType_Resale',
              specsListsIDsToDeactivate: <String>['phid_s_propertyRentPrice',],
          ),
          SpecDeactivator(
              specValueThatDeactivatesSpecsLists: 'phid_s_contractType_Rent',
              specsListsIDsToDeactivate: <String>['phid_s_PropertySalePrice',]
          ),
        ],
    ),
    // -------------
    /// PROPERTY PAYMENT METHOD
    SpecPicker(
        chainID: 'phid_s_paymentMethod',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        deactivators: <SpecDeactivator>[
          SpecDeactivator(
              specValueThatDeactivatesSpecsLists: 'phid_s_payment_cash',
              specsListsIDsToDeactivate: <String>[
                'phid_s_numberOfInstallments',
                'phid_s_InstallmentsDuration',
                'phid_s_InstallmentsDurationUnit'
              ]
          ),
        ],
    ),
    // -------------
    /// PROPERTY SALE PRICE
    SpecPicker(
        chainID: 'phid_s_PropertySalePrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency',
    ),
    // -------------
    /// PROPERTY RENT PRICE
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_numberOfInstallments',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY INSTALLMENTS DURATION
    SpecPicker(
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
    SpecPicker(
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
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_property_spaces', // phid_s_group_space_type has chain but translates (Space type)
        groupID: 'Spatial Specifications',
        canPickMany: true,
        isRequired: false
    ),
    // -------------
    /// PROPERTY FLOOR NUMBER
    SpecPicker(
        chainID: 'phid_s_propertyFloorNumber',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY DEDICATED PARKING LOTS COUNT
    SpecPicker(
        chainID: 'phid_s_propertyDedicatedParkingSpaces',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY NUMBER OF BEDROOMS
    SpecPicker(
        chainID: 'phid_s_propertyNumberOfBedrooms',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY NUMBER OF BATHROOMS
    SpecPicker(
        chainID: 'phid_s_propertyNumberOfBathrooms',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY FEATURES SPECIFICATIONS
    // ----------------------------
    /// PROPERTY VIEW
    SpecPicker(
        chainID: 'phid_s_propertyView',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false,
    ),
    // -------------
    /// PROPERTY INDOOR FEATURES
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_indoor',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false
    ),
    // -------------
    /// PROPERTY FINISHING LEVEL
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_finishing',
        groupID: 'Property Features',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// PROPERTY DECORATION STYLE
    SpecPicker(
        chainID: 'phid_s_propertyDecorationStyle',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false
    ),
    // ------------------------------------------------------------
    /// - COMMUNITY FEATURES SPECIFICATIONS
    // ----------------------------
    /// IN  A COMPOUND
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_compound',
        groupID: 'Community Features',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// AMENITIES
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_amenities',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false
    ),
    // -------------
    /// COMMUNITY SERVICES
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_services',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false
    ),
    // ------------------------------------------------------------
    /// - BUILDING FEATURES SPECIFICATIONS
    // ----------------------------
    /// BUILDING NUMBER OF FLOORS
    SpecPicker(
        chainID: 'phid_s_buildingNumberOfFloors',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// BUILDING AGE IN YEARS
    SpecPicker(
        chainID: 'phid_s_buildingAge',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// BUILDING TOTAL UNITS COUNTS
    SpecPicker(
        chainID: 'phid_s_buildingTotalPropertiesCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // -------------
    /// BUILDING TOTAL PARKING LOTS COUNTS
    SpecPicker(
        chainID: 'phid_s_buildingTotalParkingLotsCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false
    ),
    // ------------------------------------------------------------
];

List<SpecPicker> designSpecsPickers = const <SpecPicker>[
    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    SpecPicker(
        chainID: 'phid_k_flyer_type_design',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        deactivators: <SpecDeactivator>[
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
    SpecPicker(
        chainID: 'phid_s_group_dz_type',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true
    ),
    // -------------
    /// DESIGN SPACES
    SpecPicker(
        chainID: 'phid_s_group_space_type',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true
    ),
    // -------------
    /// DESIGN STYLE
    SpecPicker(
        chainID: 'phid_s_style',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: false
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecPicker(
        chainID: 'phid_s_propertyForm',
        groupID: 'Property Specifications',
        canPickMany: false,
        isRequired: true
    ),
    // -------------
    /// PROPERTY LICENSE
    SpecPicker(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Property Specifications',
        canPickMany: true,
        isRequired: true
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION COST
    // ----------------------------
    /// PROJECT COST
    SpecPicker(
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
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_k_flyer_type_trades',
        groupID: 'Construction Activities',
        canPickMany: true,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_plotArea',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_lotAreaUnit',
    ),
    // ------------------------------------------------------------
];

List<SpecPicker> tradeSpecsPickers = const <SpecPicker>[
    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    SpecPicker(
        chainID: 'phid_k_flyer_type_trades',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        deactivators: <SpecDeactivator>[
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
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_constructionActivityMeasurementMethod',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
    ),
    // ------------------------------------------------------------
];

List<SpecPicker> productSpecsPickers = const <SpecPicker>[

    // ------------------------------------------------------------
    /// - TYPE SPECIFICATIONS
    // ----------------------------
    /// TYPE
    SpecPicker(
        chainID: 'phid_k_flyer_type_product',
        groupID: 'Type',
        canPickMany: true,
        isRequired: true,
        deactivators: <SpecDeactivator>[
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
    SpecPicker(
        chainID: 'phid_s_contractType',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        deactivators: <SpecDeactivator>[
            SpecDeactivator(
                specValueThatDeactivatesSpecsLists: 'phid_s_contractType_NewSale',
                specsListsIDsToDeactivate: <String>['phid_s_rentPrice',]
            ),
            SpecDeactivator(
                specValueThatDeactivatesSpecsLists: 'phid_s_contractType_Resale',
                specsListsIDsToDeactivate: <String>['phid_s_rentPrice',],
            ),
            SpecDeactivator(
                specValueThatDeactivatesSpecsLists: 'phid_s_contractType_Rent',
                specsListsIDsToDeactivate: <String>['phid_s_salePrice',]
            ),
        ],
    ),
    // -------------
    /// PAYMENT METHOD
    SpecPicker(
        chainID: 'phid_s_paymentMethod',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        deactivators: <SpecDeactivator>[
            SpecDeactivator(
                specValueThatDeactivatesSpecsLists: 'phid_s_payment_cash',
                specsListsIDsToDeactivate: <String>[
                    'phid_s_numberOfInstallments',
                    'phid_s_InstallmentsDuration',
                    'phid_s_InstallmentsDurationUnit'
                ]
            ),
        ],
    ),
    // -------------
    /// SALE PRICE
    SpecPicker(
        chainID: 'phid_s_salePrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_currency',
    ),
    // -------------
    /// RENT PRICE
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_numberOfInstallments',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// INSTALLMENTS DURATION
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_color',
        groupID: 'Design',
        canPickMany: true,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - DIMENSIONS SPECIFICATIONS
    // ----------------------------
    /// WIDTH
    SpecPicker(
        chainID: 'phid_s_width',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// LENGTH
    SpecPicker(
        chainID: 'phid_s_length',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// HEIGHT
    SpecPicker(
        chainID: 'phid_s_height',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// THICKNESS
    SpecPicker(
        chainID: 'phid_s_thickness',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// DIAMETER
    SpecPicker(
        chainID: 'phid_s_diameter',
        groupID: 'Dimensions',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_linearMeasureUnit',
    ),
    // -------------
    /// RADIUS
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_footPrint',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_areaMeasureUnit',
    ),
    // -------------
    /// VOLUME
    SpecPicker(
        chainID: 'phid_s_volume',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_volumeMeasurementUnit',
    ),
    // -------------
    /// WIGHT
    SpecPicker(
        chainID: 'phid_s_weight',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_weightMeasurementUnit',
    ),
    // -------------
    /// SIZE
    SpecPicker(
        chainID: 'phid_s_size',
        groupID: 'Size',
        canPickMany: false,
        isRequired: false,
    ),
    // ------------------------------------------------------------
    /// - SIZE SPECIFICATIONS
    // ----------------------------
    /// QUANTITY
    SpecPicker(
        chainID: 'phid_s_count',
        groupID: 'Quantity',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - ELECTRIC SPECIFICATIONS
    // ----------------------------
    /// WATTAGE
    SpecPicker(
        chainID: 'phid_s_wattage',
        groupID: 'Electricity',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// WATTAGE
    SpecPicker(
        chainID: 'phid_s_voltage',
        groupID: 'Electricity',
        canPickMany: false,
        isRequired: false,
    ),
    // -------------
    /// WATTAGE
    SpecPicker(
        chainID: 'phid_s_ampere',
        groupID: 'Electricity',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - AVAILABILITY SPECIFICATIONS
    // ----------------------------
    /// WATTAGE
    SpecPicker(
        chainID: 'phid_s_inStock',
        groupID: 'Availability',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - DELIVERY SPECIFICATIONS
    // ----------------------------
    /// DELIVERY AVAILABILITY
    SpecPicker(
        chainID: 'phid_s_deliveryAvailable',
        groupID: 'Availability',
        canPickMany: false,
        isRequired: false,
        deactivators: <SpecDeactivator>[
            SpecDeactivator(
                specValueThatDeactivatesSpecsLists: false,
                specsListsIDsToDeactivate: <String>['phid_s_deliveryMinDuration'],
            ),
        ],
    ),
    // -------------
    /// DELIVERY AVAILABILITY
    SpecPicker(
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
    SpecPicker(
        chainID: 'phid_s_madeIn',
        groupID: 'Manufacturer Info',
        canPickMany: false,
        isRequired: false,
    ),
    // ----------------------------
    /// - WARRANTY SPECIFICATIONS
    // ----------------------------
    /// WARRANTY DURATION
    SpecPicker(
        chainID: 'phid_s_insuranceDuration',
        groupID: 'Warranty',
        canPickMany: false,
        isRequired: false,
        unitChainID: 'phid_s_warrantyDurationUnit',
    ),
    // ----------------------------
];

List<SpecPicker> equipmentSpecsPickers = <SpecPicker>[];
