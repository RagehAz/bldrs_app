import 'package:bldrs/a_models/chain/spec_models/spec_deactivator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';

List<SpecPicker> propertySpecsPickers = <SpecPicker>[

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
              specValue: 'phid_s_pf_land',
              specsListsIDsToDeactivate: <String>[
                'phid_s_propertyArea',
                'phid_s_propertyAreaUnit'
              ]),
          SpecDeactivator(
              specValue: 'phid_s_pf_mobile',
              specsListsIDsToDeactivate: <String>[
                'phid_s_lotArea',
                'phid_s_lotAreaUnit',
                'phid_s_propertyFloorNumber',
                'phid_s_propertyNumberOfBedrooms',
                'phid_s_propertyNumberOfBathrooms',
                'phid_s_propertyInACompound'
              ]),
        ],
        range: null,
        unitChainID: null,
    ),

    /// PROPERTY LICENSE
    SpecPicker(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Main Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
        unitChainID: null,
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
              specValue: 'phid_s_contractType_NewSale',
              specsListsIDsToDeactivate: <String>['phid_s_propertyRentPrice',]
          ),
          SpecDeactivator(
              specValue: 'phid_s_contractType_Resale',
              specsListsIDsToDeactivate: <String>['phid_s_propertyRentPrice',],
          ),
          SpecDeactivator(
              specValue: 'phid_s_contractType_Rent',
              specsListsIDsToDeactivate: <String>['phid_s_PropertySalePrice',]
          ),
        ],
        range: null,
        unitChainID: null,
    ),

    /// PROPERTY PAYMENT METHOD
    SpecPicker(
        chainID: 'phid_s_paymentMethod',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        range: null,
        deactivators: <SpecDeactivator>[
          SpecDeactivator(
              specValue: 'phid_s_payment_cash',
              specsListsIDsToDeactivate: <String>[
                'phid_s_numberOfInstallments',
                'phid_s_InstallmentsDuration',
                'phid_s_InstallmentsDurationUnit'
              ]
          ),
        ],
        unitChainID: null,
    ),

    /// PROPERTY SALE PRICE
    SpecPicker(
        chainID: 'phid_s_PropertySalePrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_currency',
    ),

    /// PROPERTY RENT PRICE
    SpecPicker(
        chainID: 'phid_s_propertyRentPrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_currency',
    ),

    // /// PROPERTY PRICE CURRENCY
    // SpecPicker(
    //     chainID: 'phid_s_currency',
    //     groupID: 'Pricing',
    //     canPickMany: false,
    //     isRequired: false,
    //     range: null,
    // ),

    // ------------------------------------------------------------
    /// - INSTALLMENTS
    // ----------------------------
    /// PROPERTY NUMBER OF INSTALLMENTS
    SpecPicker(
        chainID: 'phid_s_numberOfInstallments',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null,
    ),

    /// PROPERTY INSTALLMENTS DURATION
    SpecPicker(
        chainID: 'phid_s_installmentsDuration',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_installmentsDurationUnit'
    ),

    // /// PROPERTY INSTALLMENTS DURATION UNIT
    // SpecPicker(
    //     chainID: 'phid_s_installmentsDurationUnit',
    //     groupID: 'Installments',
    //     canPickMany: false,
    //     isRequired: false,
    //     range: null,
    // ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    SpecPicker(
        chainID: 'phid_s_propertyArea',
        groupID: 'Property Area',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_propertyAreaUnit',
    ),

    // /// PROPERTY AREA UNIT
    // SpecPicker(
    //     chainID: 'phid_s_propertyAreaUnit',
    //     groupID: 'Property Area',
    //     canPickMany: false,
    //     isRequired: false,
    //     range: null,
    // ),
    // ------------------------------------------------------------
    /// - LOT AREA
    // ----------------------------
    /// LOT AREA
    SpecPicker(
        chainID: 'phid_s_plotArea',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_lotAreaUnit',
    ),

    // /// LOT AREA UNIT
    // SpecPicker(
    //     chainID: 'phid_s_propertyAreaUnit',
    //     groupID: 'Lot Area',
    //     canPickMany: false,
    //     isRequired: false,
    //     range: null,
    // ),
    // ------------------------------------------------------------
    /// - PROPERTY SPATIAL SPECIFICATION
    // ----------------------------
    /// PROPERTY SPACES
    SpecPicker(
        chainID: 'phid_s_property_spaces', // phid_s_group_space_type has chain but translates (Space type)
        groupID: 'Spatial Specifications',
        canPickMany: true,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// PROPERTY FLOOR NUMBER
    SpecPicker(
        chainID: 'phid_s_propertyFloorNumber',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null,
    ),

    /// PROPERTY DEDICATED PARKING LOTS COUNT
    SpecPicker(
        chainID: 'phid_s_propertyDedicatedParkingSpaces',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null,
    ),

    /// PROPERTY NUMBER OF BEDROOMS
    SpecPicker(
        chainID: 'phid_s_propertyNumberOfBedrooms',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null,
    ),

    /// PROPERTY NUMBER OF BATHROOMS
    SpecPicker(
        chainID: 'phid_s_propertyNumberOfBathrooms',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null,
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
        range: null,
        unitChainID: null,
    ),

    /// PROPERTY INDOOR FEATURES
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_indoor',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// PROPERTY FINISHING LEVEL
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_finishing',
        groupID: 'Property Features',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// PROPERTY DECORATION STYLE
    SpecPicker(
        chainID: 'phid_s_propertyDecorationStyle',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false,
        range: null,
        unitChainID: null
    ),
    // ------------------------------------------------------------
    /// - COMMUNITY FEATURES SPECIFICATIONS
    // ----------------------------
    /// IN  A COMPOUND
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_compound',
        groupID: 'Community Features',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// AMENITIES
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_amenities',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// COMMUNITY SERVICES
    SpecPicker(
        chainID: 'phid_s_sub_ppt_feat_services',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false,
        range: null,
        unitChainID: null
    ),
    // ------------------------------------------------------------
    /// - BUILDING FEATURES SPECIFICATIONS
    // ----------------------------
    /// BUILDING NUMBER OF FLOORS
    SpecPicker(
        chainID: 'phid_s_buildingNumberOfFloors',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// BUILDING AGE IN YEARS
    SpecPicker(
        chainID: 'phid_s_buildingAge',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// BUILDING TOTAL UNITS COUNTS
    SpecPicker(
        chainID: 'phid_s_buildingTotalPropertiesCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null
    ),

    /// BUILDING TOTAL PARKING LOTS COUNTS
    SpecPicker(
        chainID: 'phid_s_buildingTotalParkingLotsCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null
    ),
    // ------------------------------------------------------------


];

List<SpecPicker> designSpecsPickers = <SpecPicker>[

    // ------------------------------------------------------------
    /// - DESIGN SPECIFICATIONS
    // ----------------------------
    /// DESIGN TYPE
    SpecPicker(
        chainID: 'phid_s_group_dz_type',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
        unitChainID: null
    ),

    /// DESIGN SPACES
    SpecPicker(
        chainID: 'phid_s_group_space_type',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
        unitChainID: null
    ),

    /// DESIGN STYLE
    SpecPicker(
        chainID: 'phid_s_style',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: false,
        range: null,
        unitChainID: null
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecPicker(
        chainID: 'phid_s_propertyForm',
        groupID: 'Property Specifications',
        canPickMany: false,
        isRequired: true,
        range: null,
        unitChainID: null
    ),

    /// PROPERTY LICENSE
    SpecPicker(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Property Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
        unitChainID: null
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
        range: null,
        unitChainID: 'phid_s_currency'
    ),

    // /// PROJECT COST CURRENCY
    // SpecPicker(
    //   chainID: 'phid_s_currency',
    //   groupID: 'Construction Cost',
    //   canPickMany: false,
    //   isRequired: false,
    //   range: null,
    // ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION DURATION
    // ----------------------------
    /// Construction DURATION
    SpecPicker(
        chainID: 'phid_s_constructionDuration',
        groupID: 'Construction Duration',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_constructionDurationUnit',
    ),

    // /// Construction DURATION UNIT
    // SpecPicker(
    //   chainID: 'phid_s_durationUnit',
    //   groupID: 'Construction Duration',
    //   canPickMany: false,
    //   isRequired: false,
    //   range: <String>['phid_s_day', 'phid_s_week', 'phid_s_month', 'phid_s_year'],
    // ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION ACTIVITIES
    // ----------------------------
    /// CONSTRUCTION ACTIVITIES
    SpecPicker(
        chainID: 'phid_k_flyer_type_crafts',
        groupID: 'Construction Activities',
        canPickMany: true,
        isRequired: false,
        range: null,
        unitChainID: null,
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
        range: null,
        unitChainID: 'phid_s_propertyAreaUnit',
    ),

    // /// PROPERTY AREA UNIT
    // SpecPicker(
    //     chainID: 'phid_s_propertyAreaUnit',
    //     groupID: 'Property Area',
    //     canPickMany: false,
    //     isRequired: false,
    //     range: null,
    // ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// LOT AREA
    SpecPicker(
        chainID: 'phid_s_plotArea',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_lotAreaUnit',
    ),

    // /// LOT AREA UNIT
    // SpecPicker(
    //     chainID: 'phid_s_lotAreaUnit',
    //     groupID: 'Lot Area',
    //     canPickMany: false,
    //     isRequired: false,
    //     range: null,
    // ),
    // ------------------------------------------------------------

];

List<SpecPicker> craftSpecsPickers = <SpecPicker>[

    /// CONSTRUCTION ACTIVITY PRICE
    SpecPicker(
        chainID: 'phid_s_price',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: 'phid_s_currency',
    ),

    // /// CONSTRUCTION ACTIVITY PRICE CURRENCY
    // SpecPicker(
    //     chainID: 'phid_s_currency',
    //     groupID: 'Cost',
    //     canPickMany: false,
    //     isRequired: false,
    //     range: null,
    // ),

    /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
    SpecPicker(
        chainID: 'phid_s_constructionActivityMeasurementMethod',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
        range: null,
        unitChainID: null,
    ),

];

List<SpecPicker> productSpecsPickers = <SpecPicker>[];

List<SpecPicker> equipmentSpecsPickers = <SpecPicker>[];
