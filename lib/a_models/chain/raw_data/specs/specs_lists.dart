import 'package:bldrs/a_models/chain/spec_models/spec_deactivator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_list_model.dart';

List<SpecList> propertySpecLists = <SpecList>[

    // ------------------------------------------------------------
    /// - MAIN SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecList(
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
    ),

    /// PROPERTY LICENSE
    SpecList(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Main Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY PRICING SPECIFICATIONS
    // ----------------------------
    /// PROPERTY CONTRACT TYPE
    SpecList(
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
    ),

    /// PROPERTY PAYMENT METHOD
    SpecList(
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
    ),

    /// PROPERTY SALE PRICE
    SpecList(
        chainID: 'phid_s_PropertySalePrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY RENT PRICE
    SpecList(
        chainID: 'phid_s_propertyRentPrice',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY PRICE CURRENCY
    SpecList(
        chainID: 'phid_s_currency',
        groupID: 'Pricing',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - INSTALLMENTS
    // ----------------------------
    /// PROPERTY NUMBER OF INSTALLMENTS
    SpecList(
        chainID: 'phid_s_numberOfInstallments',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY INSTALLMENTS DURATION
    SpecList(
        chainID: 'phid_s_installmentsDuration',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY INSTALLMENTS DURATION UNIT
    SpecList(
        chainID: 'phid_s_installmentsDurationUnit',
        groupID: 'Installments',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        chainID: 'phid_s_propertyArea',
        groupID: 'Property Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY AREA UNIT
    SpecList(
        chainID: 'phid_s_propertyAreaUnit',
        groupID: 'Property Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - LOT AREA
    // ----------------------------
    /// LOT AREA
    SpecList(
        chainID: 'phid_s_plotArea',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// LOT AREA UNIT
    SpecList(
        chainID: 'phid_s_propertyAreaUnit',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPATIAL SPECIFICATION
    // ----------------------------
    /// PROPERTY SPACES
    SpecList(
        chainID: 'phid_s_property_spaces',
        groupID: 'Spatial Specifications',
        canPickMany: true,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY FLOOR NUMBER
    SpecList(
        chainID: 'phid_s_propertyFloorNumber',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY DEDICATED PARKING LOTS COUNT
    SpecList(
        chainID: 'phid_s_propertyDedicatedParkingSpaces',
        groupID: 'Spatial Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY NUMBER OF BEDROOMS
    SpecList(
      chainID: 'phid_s_propertyNumberOfBedrooms',
      groupID: 'Spatial Specifications',
      canPickMany: false,
      isRequired: false,
      range: null,
    ),

    /// PROPERTY NUMBER OF BATHROOMS
    SpecList(
      chainID: 'phid_s_propertyNumberOfBathrooms',
      groupID: 'Spatial Specifications',
      canPickMany: false,
      isRequired: false,
      range: null,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY FEATURES SPECIFICATIONS
    // ----------------------------
    /// PROPERTY VIEW
    SpecList(
        chainID: 'phid_s_propertyView',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY INDOOR FEATURES
    SpecList(
        chainID: 'phid_s_sub_ppt_feat_indoor',
        groupID: 'Property Features',
        canPickMany: true,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY FINISHING LEVEL
    SpecList(
        chainID: 'phid_s_sub_ppt_feat_finishing',
        groupID: 'Property Features',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY DECORATION STYLE
    SpecList(
      chainID: 'phid_s_propertyDecorationStyle',
      groupID: 'Property Features',
      canPickMany: false,
      isRequired: false,
      range: null,
    ),
    // ------------------------------------------------------------
    /// - COMMUNITY FEATURES SPECIFICATIONS
    // ----------------------------
    /// IN  A COMPOUND
    SpecList(
        chainID: 'phid_s_sub_ppt_feat_compound',
        groupID: 'Community Features',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// AMENITIES
    SpecList(
        chainID: 'phid_s_sub_ppt_feat_amenities',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false,
        range: null,
    ),

    /// COMMUNITY SERVICES
    SpecList(
        chainID: 'phid_s_sub_ppt_feat_services',
        groupID: 'Community Features',
        canPickMany: true,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - BUILDING FEATURES SPECIFICATIONS
    // ----------------------------
    /// BUILDING NUMBER OF FLOORS
    SpecList(
        chainID: 'phid_s_buildingNumberOfFloors',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// BUILDING AGE IN YEARS
    SpecList(
        chainID: 'phid_s_buildingAge',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// BUILDING TOTAL UNITS COUNTS
    SpecList(
        chainID: 'phid_s_buildingTotalPropertiesCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// BUILDING TOTAL PARKING LOTS COUNTS
    SpecList(
        chainID: 'phid_s_buildingTotalParkingLotsCount',
        groupID: 'Building Specifications',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------


];

List<SpecList> designSpecLists = <SpecList>[

    // ------------------------------------------------------------
    /// - DESIGN SPECIFICATIONS
    // ----------------------------
    /// DESIGN TYPE
    SpecList(
        chainID: 'phid_k_group_dz_type',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
    ),

    /// DESIGN SPACES
    SpecList(
        chainID: 'phid_s_property_spaces',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
    ),

    /// DESIGN STYLE
    SpecList(
        chainID: 'phid_s_style',
        groupID: 'Design Specifications',
        canPickMany: true,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecList(
        chainID: 'phid_s_propertyForm',
        groupID: 'Property Specifications',
        canPickMany: false,
        isRequired: true,
        range: null,
    ),

    /// PROPERTY LICENSE
    SpecList(
        chainID: 'phid_s_propertyLicense',
        groupID: 'Property Specifications',
        canPickMany: true,
        isRequired: true,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION COST
    // ----------------------------
    /// PROJECT COST
    SpecList(
        chainID: 'phid_s_projectCost',
        groupID: 'Construction Cost',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROJECT COST CURRENCY
    SpecList(
      chainID: 'phid_s_currency',
      groupID: 'Construction Cost',
      canPickMany: false,
      isRequired: false,
      range: null,
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION DURATION
    // ----------------------------
    /// Construction DURATION
    SpecList(
      chainID: 'phid_s_constructionDuration',
      groupID: 'Construction Duration',
      canPickMany: false,
      isRequired: false,
      range: null,
    ),

    /// Construction DURATION UNIT
    SpecList(
      chainID: 'phid_s_durationUnit',
      groupID: 'Construction Duration',
      canPickMany: false,
      isRequired: false,
      range: <String>['phid_s_day', 'phid_s_week', 'phid_s_month', 'phid_s_year'],
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION ACTIVITIES
    // ----------------------------
    /// CONSTRUCTION ACTIVITIES
    SpecList(
      chainID: 'phid_s_constructionActivities',
      groupID: 'Construction Activities',
      canPickMany: true,
      isRequired: false,
      range: null,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        chainID: 'phid_s_propertyArea',
        groupID: 'Property Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// PROPERTY AREA UNIT
    SpecList(
        chainID: 'phid_s_propertyAreaUnit',
        groupID: 'Property Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// LOT AREA
    SpecList(
        chainID: 'phid_s_plotArea',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// LOT AREA UNIT
    SpecList(
        chainID: 'phid_s_lotAreaUnit',
        groupID: 'Lot Area',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),
    // ------------------------------------------------------------

];

List<SpecList> craftSpecLists = <SpecList>[

    /// CONSTRUCTION ACTIVITY PRICE
    SpecList(
        chainID: 'phid_s_price',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// CONSTRUCTION ACTIVITY PRICE CURRENCY
    SpecList(
        chainID: 'phid_s_currency',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

    /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
    SpecList(
        chainID: 'phid_s_constructionActivityMeasurementMethod',
        groupID: 'Cost',
        canPickMany: false,
        isRequired: false,
        range: null,
    ),

];

List<SpecList> productSpecLists = <SpecList>[];

List<SpecList> equipmentSpecLists = <SpecList>[];
