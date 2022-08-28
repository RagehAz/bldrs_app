import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/cc_pickers_blocker.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';

class RawPickers {
// -----------------------------------------------------------------------------

    const RawPickers();

// -----------------------------------------------------------------------------

    /// maps look like this :-

    /// <String,dynamic>{
    ///      'docName' : cipherFlyerType(x),
    ///      'pickers : <PickerModel>[...],
    ///   }
// -----------------------------------------------------------------------------

    /// GET THE SHIT

// -------------------------
    /// TESTED : WORKS PERFECT
    static List<PickerModel> getPickersByFlyerType(FlyerType flyerType) {
        final List<PickerModel> _specPicker =
        flyerType == FlyerType.property ? propertiesPickers()
            :
        flyerType == FlyerType.design ? designsPickers()
            :
        flyerType == FlyerType.trade ? tradesPickers()
            :
        flyerType == FlyerType.project ? projectsPickers()
            :
        flyerType == FlyerType.product ? productsPickers()
            :
        flyerType == FlyerType.equipment ? equipmentPickers()
            :
        <PickerModel>[];

        return _specPicker;
    }
// -----------------------------------------------------------------------------

    /// PROPERTIES

// -------------------------
    static Map<String, dynamic> propertiesPickers(){

        return {
            'docName' : FlyerTyper.cipherFlyerType(FlyerType.property),
            'pickers' : const <PickerModel>[
                // ------------------------------------------------------------
                /// - TYPE SPECIFICATIONS
                // ----------------------------
                /// TYPE
                PickerModel(
                    chainID: Chain.propertyChainID,
                    groupID: 'Type',
                    canPickMany: true,
                    isRequired: true,
                    blockers: <PickersBlocker>[
                        // SpecDeactivator(
                        //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
                        //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
                        // ),
                    ],
                    index: 0,
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
                    index: 1,
                ),
                // -------------
                /// PROPERTY LICENSE
                PickerModel(
                    chainID: 'phid_s_propertyLicense',
                    groupID: 'Main Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 2,
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
                    index: 3,
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
                    index: 4,
                ),
                // -------------
                /// PROPERTY SALE PRICE
                PickerModel(
                    chainID: 'phid_s_PropertySalePrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 5,
                ),
                // -------------
                /// PROPERTY RENT PRICE
                PickerModel(
                    chainID: 'phid_s_propertyRentPrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 6,
                ),
                // ------------------------------------------------------------
                /// - INSTALLMENTS
                // ----------------------------
                /// PROPERTY NUMBER OF INSTALLMENTS
                PickerModel(
                    chainID: 'phid_s_numberOfInstallments',
                    groupID: 'Installments',
                    canPickMany: false,
                    isRequired: false,
                    index: 7,
                ),
                // -------------
                /// PROPERTY INSTALLMENTS DURATION
                PickerModel(
                    chainID: 'phid_s_installmentsDuration',
                    groupID: 'Installments',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_installmentsDurationUnit',
                    index: 8,
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
                    index: 9,
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
                    index: 10,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY SPATIAL SPECIFICATION
                // ----------------------------
                /// PROPERTY SPACES
                PickerModel(
                    chainID: 'phid_s_property_spaces', // phid_s_group_space_type has chain but translates (Space type)
                    groupID: 'Spatial Specifications',
                    canPickMany: true,
                    isRequired: false,
                    index: 11,
                ),
                // -------------
                /// PROPERTY FLOOR NUMBER
                PickerModel(
                    chainID: 'phid_s_propertyFloorNumber',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 12,
                ),
                // -------------
                /// PROPERTY DEDICATED PARKING LOTS COUNT
                PickerModel(
                    chainID: 'phid_s_propertyDedicatedParkingSpaces',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 13,
                ),
                // -------------
                /// PROPERTY NUMBER OF BEDROOMS
                PickerModel(
                    chainID: 'phid_s_propertyNumberOfBedrooms',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 14,
                ),
                // -------------
                /// PROPERTY NUMBER OF BATHROOMS
                PickerModel(
                    chainID: 'phid_s_propertyNumberOfBathrooms',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 15,
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
                    index: 16,
                ),
                // -------------
                /// PROPERTY INDOOR FEATURES
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_indoor',
                    groupID: 'Property Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 17,
                ),
                // -------------
                /// PROPERTY FINISHING LEVEL
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_finishing',
                    groupID: 'Property Features',
                    canPickMany: false,
                    isRequired: false,
                    index: 18,
                ),
                // -------------
                /// PROPERTY DECORATION STYLE
                PickerModel(
                    chainID: 'phid_s_propertyDecorationStyle',
                    groupID: 'Property Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 19,
                ),
                // ------------------------------------------------------------
                /// - COMMUNITY FEATURES SPECIFICATIONS
                // ----------------------------
                /// IN  A COMPOUND
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_compound',
                    groupID: 'Community Features',
                    canPickMany: false,
                    isRequired: false,
                    index: 20,
                ),
                // -------------
                /// AMENITIES
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_amenities',
                    groupID: 'Community Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 21,
                ),
                // -------------
                /// COMMUNITY SERVICES
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_services',
                    groupID: 'Community Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 22,
                ),
                // ------------------------------------------------------------
                /// - BUILDING FEATURES SPECIFICATIONS
                // ----------------------------
                /// BUILDING NUMBER OF FLOORS
                PickerModel(
                    chainID: 'phid_s_buildingNumberOfFloors',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 23,
                ),
                // -------------
                /// BUILDING AGE IN YEARS
                PickerModel(
                    chainID: 'phid_s_buildingAge',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 24,
                ),
                // -------------
                /// BUILDING TOTAL UNITS COUNTS
                PickerModel(
                    chainID: 'phid_s_buildingTotalPropertiesCount',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 25,
                ),
                // -------------
                /// BUILDING TOTAL PARKING LOTS COUNTS
                PickerModel(
                    chainID: 'phid_s_buildingTotalParkingLotsCount',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 26,
                ),
                // ------------------------------------------------------------
            ],
        };

    }
// -----------------------------------------------------------------------------

    /// DESIGNS

// -------------------------
    static Map<String, dynamic> designsPickers(){
        return {
            'docName' : FlyerTyper.cipherFlyerType(FlyerType.design),
            'pickers' : const <PickerModel>[
                // ------------------------------------------------------------
                /// - TYPE SPECIFICATIONS
                // ----------------------------
                /// TYPE
                PickerModel(
                    chainID: Chain.designChainID,
                    groupID: 'Type',
                    canPickMany: true,
                    isRequired: true,
                    blockers: <PickersBlocker>[
                        // SpecDeactivator(
                        //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
                        //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
                        // ),
                    ],
                    index: 0,
                ),
                // ------------------------------------------------------------
                /// - DESIGN SPECIFICATIONS
                // ----------------------------
                /// DESIGN TYPE
                PickerModel(
                    chainID: 'phid_s_group_dz_type',
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 1,
                ),
                // -------------
                /// DESIGN SPACES
                PickerModel(
                    chainID: 'phid_s_group_space_type',
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 2,
                ),
                // -------------
                /// DESIGN STYLE
                PickerModel(
                    chainID: 'phid_s_style',
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: false,
                    index: 3,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY SPECIFICATIONS
                // ----------------------------
                /// PROPERTY FORM
                PickerModel(
                    chainID: 'phid_s_propertyForm',
                    groupID: 'Property Specifications',
                    canPickMany: false,
                    isRequired: true,
                    index: 4,
                ),
                // -------------
                /// PROPERTY LICENSE
                PickerModel(
                    chainID: 'phid_s_propertyLicense',
                    groupID: 'Property Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 5,
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
                    unitChainID: 'phid_s_currency',
                    index: 6,
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
                    index: 7,
                ),
                // ------------------------------------------------------------
                /// - CONSTRUCTION ACTIVITIES
                // ----------------------------
                /// CONSTRUCTION ACTIVITIES
                PickerModel(
                    chainID: Chain.tradesChainID,
                    groupID: 'Construction Activities',
                    canPickMany: true,
                    isRequired: false,
                    index: 8,
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
                    index: 9,
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
                    index: 10,
                ),
                // ------------------------------------------------------------
            ],
        };
    }
// -----------------------------------------------------------------------------

    /// PROJECTS

// -------------------------
    static Map<String, dynamic> projectsPickers(){
        return {
            'docName' : FlyerTyper.cipherFlyerType(FlyerType.project),
            'pickers' : const <PickerModel>[






            ],
        };
    }
// -----------------------------------------------------------------------------

    /// TRADES

// -------------------------
    static Map<String, dynamic> tradesPickers() {
        return {
            'docName': FlyerTyper.cipherFlyerType(FlyerType.trade),
            'pickers': const <PickerModel>[
                // ------------------------------------------------------------
                /// - TYPE SPECIFICATIONS
                // ----------------------------
                /// TYPE
                PickerModel(
                    chainID: Chain.tradesChainID,
                    groupID: 'Type',
                    canPickMany: true,
                    isRequired: true,
                    blockers: <PickersBlocker>[
                        // SpecDeactivator(
                        //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
                        //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
                        // ),
                    ],
                    index: 0,
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
                    index: 1,
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
                    index: 2,
                ),
                // ------------------------------------------------------------
            ],
        };
    }
// -----------------------------------------------------------------------------

    /// PRODUCTS

// -------------------------
    static Map<String, dynamic> productsPickers() {
        return {
            'docName': FlyerTyper.cipherFlyerType(FlyerType.product),
            'pickers': const <PickerModel>[
                // ------------------------------------------------------------
                /// - TYPE SPECIFICATIONS
                // ----------------------------
                /// TYPE
                PickerModel(
                    chainID: Chain.productChainID,
                    groupID: 'Type',
                    canPickMany: true,
                    isRequired: true,
                    blockers: <PickersBlocker>[
                        // SpecDeactivator(
                        //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
                        //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
                        // ),
                    ],
                    index: 0,
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
                    index: 1,
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
                    index: 2,
                ),
                // -------------
                /// SALE PRICE
                PickerModel(
                    chainID: 'phid_s_salePrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 3,
                ),
                // -------------
                /// RENT PRICE
                PickerModel(
                    chainID: 'phid_s_rentPrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 4,
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
                    index: 5,
                ),
                // -------------
                /// INSTALLMENTS DURATION
                PickerModel(
                    chainID: 'phid_s_installmentsDuration',
                    groupID: 'Installments',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_installmentsDurationUnit',
                    index: 6,
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
                    index: 7,
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
                    index: 8,
                ),
                // -------------
                /// LENGTH
                PickerModel(
                    chainID: 'phid_s_length',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 9,
                ),
                // -------------
                /// HEIGHT
                PickerModel(
                    chainID: 'phid_s_height',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 10,
                ),
                // -------------
                /// THICKNESS
                PickerModel(
                    chainID: 'phid_s_thickness',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 11,
                ),
                // -------------
                /// DIAMETER
                PickerModel(
                    chainID: 'phid_s_diameter',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 12,
                ),
                // -------------
                /// RADIUS
                PickerModel(
                    chainID: 'phid_s_radius',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 13,
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
                    index: 14,
                ),
                // -------------
                /// VOLUME
                PickerModel(
                    chainID: 'phid_s_volume',
                    groupID: 'Size',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_volumeMeasurementUnit',
                    index: 15,
                ),
                // -------------
                /// WIGHT
                PickerModel(
                    chainID: 'phid_s_weight',
                    groupID: 'Size',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_weightMeasurementUnit',
                    index: 16,
                ),
                // -------------
                /// SIZE
                PickerModel(
                    chainID: 'phid_s_size',
                    groupID: 'Size',
                    canPickMany: false,
                    isRequired: false,
                    index: 17,
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
                    index: 18,
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
                    index: 19,
                ),
                // -------------
                /// WATTAGE
                PickerModel(
                    chainID: 'phid_s_voltage',
                    groupID: 'Electricity',
                    canPickMany: false,
                    isRequired: false,
                    index: 20,
                ),
                // -------------
                /// WATTAGE
                PickerModel(
                    chainID: 'phid_s_ampere',
                    groupID: 'Electricity',
                    canPickMany: false,
                    isRequired: false,
                    index: 21,
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
                    index: 22,
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
                    index: 23,
                ),
                // -------------
                /// DELIVERY AVAILABILITY
                PickerModel(
                    chainID: 'phid_s_deliveryMinDuration',
                    groupID: 'Availability',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_deliveryDurationUnit',
                    index: 24,
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
                    index: 25,
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
                    index: 26,
                ),
                // ----------------------------
            ],
        };
    }
// -----------------------------------------------------------------------------

    /// TRADES

// -------------------------
    static Map<String, dynamic> equipmentPickers() {
        return {
            'docName': FlyerTyper.cipherFlyerType(FlyerType.equipment),
            'pickers': const <PickerModel>[
                // ------------------------------------------------------------
                /// - TYPE SPECIFICATIONS
                // ----------------------------
                /// TYPE
                PickerModel(
                    chainID: Chain.equipmentChainID,
                    groupID: 'Type',
                    canPickMany: true,
                    isRequired: true,
                    blockers: <PickersBlocker>[
                        // SpecDeactivator(
                        //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
                        //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
                        // ),
                    ],
                    index: 0,
                ),
                // ------------------------------------------------------------
            ],
        };
    }
// -----------------------------------------------------------------------------
}
