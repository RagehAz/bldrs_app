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
        final Map<String, dynamic> _map =
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
        null;

        return _map['pickers'];
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

                PickerModel(
                    chainID: 'headline_type',
                    groupID: 'Type',
                    index: 0,
                    isHeadline: true,
                ),

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
                    index: 1,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - MAIN SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_main_specs',
                    groupID: 'Main Specifications',
                    index: 2,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY FORM
                PickerModel(
                    chainID: 'phid_s_propertyForm',
                    groupID: 'Main Specifications',
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
                    index: 3,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY LICENSE
                PickerModel(
                    chainID: 'phid_s_propertyLicense',
                    groupID: 'Main Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 4,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY PRICING SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_pricing',
                    groupID: 'Pricing',
                    index: 5,
                    isHeadline: true,
                ),

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
                    index: 6,
                    isHeadline: false,
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
                    index: 7,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY SALE PRICE
                PickerModel(
                    chainID: 'phid_s_PropertySalePrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 8,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY RENT PRICE
                PickerModel(
                    chainID: 'phid_s_propertyRentPrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 9,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - INSTALLMENTS

                PickerModel(
                    chainID: 'headline_installments',
                    groupID: 'Installments',
                    index: 10,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY NUMBER OF INSTALLMENTS
                PickerModel(
                    chainID: 'phid_s_numberOfInstallments',
                    groupID: 'Installments',
                    canPickMany: false,
                    isRequired: false,
                    index: 11,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY INSTALLMENTS DURATION
                PickerModel(
                    chainID: 'phid_s_installmentsDuration',
                    groupID: 'Installments',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_installmentsDurationUnit',
                    index: 12,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY AREAS

                PickerModel(
                    chainID: 'headline_areas',
                    groupID: 'Property Areas',
                    index: 13,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY AREA
                PickerModel(
                    chainID: 'phid_s_propertyArea',
                    groupID: 'Property Areas',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_propertyAreaUnit',
                    index: 14,
                    isHeadline: false,
                ),
                // ----------------------------
                /// LOT AREA
                PickerModel(
                    chainID: 'phid_s_plotArea',
                    groupID: 'Property Areas',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_lotAreaUnit',
                    index: 15,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY SPATIAL SPECIFICATION

                PickerModel(
                    chainID: 'headline_spatial',
                    groupID: 'Spatial Specifications',
                    index: 16,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY SPACES
                PickerModel(
                    chainID: 'phid_s_property_spaces', // phid_s_group_space_type has chain but translates (Space type)
                    groupID: 'Spatial Specifications',
                    canPickMany: true,
                    isRequired: false,
                    index: 17,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY FLOOR NUMBER
                PickerModel(
                    chainID: 'phid_s_propertyFloorNumber',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 18,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY DEDICATED PARKING LOTS COUNT
                PickerModel(
                    chainID: 'phid_s_propertyDedicatedParkingSpaces',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 19,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY NUMBER OF BEDROOMS
                PickerModel(
                    chainID: 'phid_s_propertyNumberOfBedrooms',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 20,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY NUMBER OF BATHROOMS
                PickerModel(
                    chainID: 'phid_s_propertyNumberOfBathrooms',
                    groupID: 'Spatial Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 21,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY FEATURES SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_features',
                    groupID: 'Property Features',
                    index: 22,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY VIEW
                PickerModel(
                    chainID: 'phid_s_propertyView',
                    groupID: 'Property Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 23,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY INDOOR FEATURES
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_indoor',
                    groupID: 'Property Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 24,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY FINISHING LEVEL
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_finishing',
                    groupID: 'Property Features',
                    canPickMany: false,
                    isRequired: false,
                    index: 25,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY DECORATION STYLE
                PickerModel(
                    chainID: 'phid_s_propertyDecorationStyle',
                    groupID: 'Property Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 26,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - COMMUNITY FEATURES SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_community',
                    groupID: 'Community Features',
                    index: 27,
                    isHeadline: true,
                ),

                // ----------------------------
                /// IN  A COMPOUND
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_compound',
                    groupID: 'Community Features',
                    canPickMany: false,
                    isRequired: false,
                    index: 28,
                    isHeadline: false,
                ),
                // -------------
                /// AMENITIES
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_amenities',
                    groupID: 'Community Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 29,
                    isHeadline: false,
                ),
                // -------------
                /// COMMUNITY SERVICES
                PickerModel(
                    chainID: 'phid_s_sub_ppt_feat_services',
                    groupID: 'Community Features',
                    canPickMany: true,
                    isRequired: false,
                    index: 30,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - BUILDING FEATURES SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_building',
                    groupID: 'Building Specifications',
                    index: 31,
                    isHeadline: true,
                ),

                // ----------------------------
                /// BUILDING NUMBER OF FLOORS
                PickerModel(
                    chainID: 'phid_s_buildingNumberOfFloors',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 32,
                    isHeadline: false,
                ),
                // -------------
                /// BUILDING AGE IN YEARS
                PickerModel(
                    chainID: 'phid_s_buildingAge',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 33,
                    isHeadline: false,
                ),
                // -------------
                /// BUILDING TOTAL UNITS COUNTS
                PickerModel(
                    chainID: 'phid_s_buildingTotalPropertiesCount',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 34,
                    isHeadline: false,
                ),
                // -------------
                /// BUILDING TOTAL PARKING LOTS COUNTS
                PickerModel(
                    chainID: 'phid_s_buildingTotalParkingLotsCount',
                    groupID: 'Building Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 35,
                    isHeadline: false,
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
                /// - DESIGN SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_design_specs',
                    groupID: 'Design Specifications',
                    index: 0,
                    isHeadline: true,
                ),

                // ----------------------------
                /// DESIGN TYPE
                PickerModel(
                    chainID: Chain.designChainID,
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: true,
                    blockers: <PickersBlocker>[
                        // SpecDeactivator(
                        //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
                        //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
                        // ),
                    ],
                    index: 1,
                    isHeadline: false,
                ),
                // -------------
                /// DESIGN SPACES
                PickerModel(
                    chainID: 'phid_s_group_space_type',
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 2,
                    isHeadline: false,
                ),
                // -------------
                /// DESIGN STYLE
                PickerModel(
                    chainID: 'phid_s_style',
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: false,
                    index: 3,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_property_specs',
                    groupID: 'Property Specifications',
                    index: 4,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY FORM
                PickerModel(
                    chainID: 'phid_s_propertyForm',
                    groupID: 'Property Specifications',
                    canPickMany: false,
                    isRequired: true,
                    index: 5,
                    isHeadline: false,
                ),
                // -------------
                /// PROPERTY LICENSE
                PickerModel(
                    chainID: 'phid_s_propertyLicense',
                    groupID: 'Property Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 6,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - CONSTRUCTION COST

                PickerModel(
                    chainID: 'headline_cost',
                    groupID: 'Construction Cost',
                    index: 7,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROJECT COST
                PickerModel(
                    chainID: 'phid_s_projectCost',
                    groupID: 'Construction Cost',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 8,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - CONSTRUCTION DURATION

                PickerModel(
                    chainID: 'headline_duration',
                    groupID: 'Construction Duration',
                    index: 9,
                    isHeadline: true,
                ),

                // ----------------------------
                /// Construction DURATION
                PickerModel(
                    chainID: 'phid_s_constructionDuration',
                    groupID: 'Construction Duration',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_constructionDurationUnit',
                    index: 10,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - CONSTRUCTION ACTIVITIES

                PickerModel(
                    chainID: 'headline_activities',
                    groupID: 'Construction Activities',
                    index: 11,
                    isHeadline: true,
                ),

                // ----------------------------
                /// CONSTRUCTION ACTIVITIES
                PickerModel(
                    chainID: Chain.tradesChainID,
                    groupID: 'Construction Activities',
                    canPickMany: true,
                    isRequired: false,
                    index: 12,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PROPERTY AREAS

                PickerModel(
                    chainID: 'headline_areas',
                    groupID: 'Property Areas',
                    index: 13,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY AREA
                PickerModel(
                    chainID: 'phid_s_propertyArea',
                    groupID: 'Property Areas',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_propertyAreaUnit',
                    index: 14,
                    isHeadline: false,
                ),
                // ----------------------------
                /// LOT AREA
                PickerModel(
                    chainID: 'phid_s_plotArea',
                    groupID: 'Property Areas',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_lotAreaUnit',
                    index: 15,
                    isHeadline: false,
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
                // ------------------------------------------------------------
                /// - PROPERTY SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_property_specs',
                    groupID: 'Property Specifications',
                    index: 0,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY LICENSE
                PickerModel(
                    chainID: 'phid_s_propertyLicense',
                    groupID: 'Property Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 1,
                    isHeadline: false,
                ),
                // ----------------------------
                /// PROPERTY FORM
                PickerModel(
                    chainID: 'phid_s_propertyForm',
                    groupID: 'Property Specifications',
                    canPickMany: false,
                    isRequired: false,
                    index: 2,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - DESIGN SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_design_specs',
                    groupID: 'Design Specifications',
                    index: 3,
                    isHeadline: true,
                ),

                // ----------------------------
                /// DESIGN TYPE
                PickerModel(
                    chainID: 'phid_s_group_dz_type',
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: false,
                    index: 4,
                    isHeadline: false,
                ),
                // -------------
                /// DESIGN SPACES
                PickerModel(
                    chainID: 'phid_s_group_space_type',
                    groupID: 'Design Specifications',
                    canPickMany: true,
                    isRequired: true,
                    index: 5,
                    isHeadline: false,
                ),
                // -------------
                /// - CONSTRUCTION COST

                PickerModel(
                    chainID: 'headline_cost',
                    groupID: 'Construction Cost',
                    index: 6,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROJECT COST
                PickerModel(
                    chainID: 'phid_s_projectCost',
                    groupID: 'Construction Cost',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 7,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - CONSTRUCTION DURATION

                PickerModel(
                    chainID: 'headline_duration',
                    groupID: 'Construction Duration',
                    index: 8,
                    isHeadline: true,
                ),

                // ----------------------------
                /// Construction DURATION
                PickerModel(
                    chainID: 'phid_s_constructionDuration',
                    groupID: 'Construction Duration',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_constructionDurationUnit',
                    index: 9,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - CONSTRUCTION ACTIVITIES

                PickerModel(
                    chainID: 'headline_activities',
                    groupID: 'Construction Activities',
                    index: 10,
                    isHeadline: true,
                ),

                // ----------------------------
                /// CONSTRUCTION ACTIVITIES
                PickerModel(
                    chainID: Chain.tradesChainID,
                    groupID: 'Construction Activities',
                    canPickMany: true,
                    isRequired: false,
                    index: 11,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - CONSTRUCTION EQUIPMENT

                PickerModel(
                    chainID: 'headline_equipment',
                    groupID: 'Construction Equipment',
                    index: 12,
                    isHeadline: true,
                ),

                // ----------------------------
                /// TYPE
                PickerModel(
                    chainID: Chain.equipmentChainID,
                    groupID: 'Construction Equipment',
                    canPickMany: true,
                    isRequired: true,
                    blockers: <PickersBlocker>[
                        // SpecDeactivator(
                        //     specValueThatDeactivatesSpecsLists: 'xxxxxxxxx',
                        //     specsListsIDsToDeactivate: <String>['xxxxxxxxxx',]
                        // ),
                    ],
                    index: 13,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PROJECT AREAS

                PickerModel(
                    chainID: 'headline_areas',
                    groupID: 'Property Areas',
                    index: 14,
                    isHeadline: true,
                ),

                // ----------------------------
                /// PROPERTY AREA
                PickerModel(
                    chainID: 'phid_s_propertyArea',
                    groupID: 'Property Areas',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_propertyAreaUnit',
                    index: 15,
                    isHeadline: false,
                ),
                // ----------------------------
                /// LOT AREA
                PickerModel(
                    chainID: 'phid_s_plotArea',
                    groupID: 'Property Areas',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_lotAreaUnit',
                    index: 16,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------

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

                PickerModel(
                    chainID: 'headline_trade_type',
                    groupID: 'Type',
                    index: 0,
                    isHeadline: true,
                ),

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
                    index: 1,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PRICING

                PickerModel(
                    chainID: 'headline_cost',
                    groupID: 'Cost',
                    index: 2,
                    isHeadline: true,
                ),

                // ----------------------------
                /// CONSTRUCTION ACTIVITY PRICE
                PickerModel(
                    chainID: 'phid_s_price',
                    groupID: 'Cost',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 3,
                    isHeadline: false,
                ),
                // ----------------------------
                /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
                PickerModel(
                    chainID: 'phid_s_constructionActivityMeasurementMethod',
                    groupID: 'Cost',
                    canPickMany: false,
                    isRequired: false,
                    index: 4,
                    isHeadline: false,
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

                PickerModel(
                    chainID: 'headline_product_type',
                    groupID: 'Type',
                    index: 0,
                    isHeadline: true,
                ),

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
                    index: 1,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - PRICING SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_pricing',
                    groupID: 'Pricing',
                    index: 2,
                    isHeadline: true,
                ),

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
                    index: 3,
                    isHeadline: false,
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
                    index: 4,
                    isHeadline: false,
                ),
                // -------------
                /// SALE PRICE
                PickerModel(
                    chainID: 'phid_s_salePrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 5,
                    isHeadline: false,
                ),
                // -------------
                /// RENT PRICE
                PickerModel(
                    chainID: 'phid_s_rentPrice',
                    groupID: 'Pricing',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_currency',
                    index: 6,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - INSTALLMENTS

                PickerModel(
                    chainID: 'headline_installments',
                    groupID: 'Installments',
                    index: 7,
                    isHeadline: true,
                ),

                // ----------------------------
                /// NUMBER OF INSTALLMENTS
                PickerModel(
                    chainID: 'phid_s_numberOfInstallments',
                    groupID: 'Installments',
                    canPickMany: false,
                    isRequired: false,
                    index: 8,
                    isHeadline: false,
                ),
                // -------------
                /// INSTALLMENTS DURATION
                PickerModel(
                    chainID: 'phid_s_installmentsDuration',
                    groupID: 'Installments',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_installmentsDurationUnit',
                    index: 9,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - DESIGN SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_design',
                    groupID: 'Design',
                    index: 10,
                    isHeadline: true,
                ),

                // ----------------------------
                /// COLOR
                PickerModel(
                    chainID: 'phid_s_color',
                    groupID: 'Design',
                    canPickMany: true,
                    isRequired: false,
                    index: 11,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - DIMENSIONS SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_dimensions',
                    groupID: 'Dimensions',
                    index: 12,
                    isHeadline: true,
                ),

                // ----------------------------
                /// WIDTH
                PickerModel(
                    chainID: 'phid_s_width',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 13,
                    isHeadline: false,
                ),
                // -------------
                /// LENGTH
                PickerModel(
                    chainID: 'phid_s_length',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 14,
                    isHeadline: false,
                ),
                // -------------
                /// HEIGHT
                PickerModel(
                    chainID: 'phid_s_height',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 15,
                    isHeadline: false,
                ),
                // -------------
                /// THICKNESS
                PickerModel(
                    chainID: 'phid_s_thickness',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 16,
                    isHeadline: false,
                ),
                // -------------
                /// DIAMETER
                PickerModel(
                    chainID: 'phid_s_diameter',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 17,
                    isHeadline: false,
                ),
                // -------------
                /// RADIUS
                PickerModel(
                    chainID: 'phid_s_radius',
                    groupID: 'Dimensions',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_linearMeasureUnit',
                    index: 18,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - SIZE SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_size',
                    groupID: 'Size',
                    index: 19,
                    isHeadline: true,
                ),

                // ----------------------------
                /// FOOTPRINT
                PickerModel(
                    chainID: 'phid_s_footPrint',
                    groupID: 'Size',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_areaMeasureUnit',
                    index: 20,
                    isHeadline: false,
                ),
                // -------------
                /// VOLUME
                PickerModel(
                    chainID: 'phid_s_volume',
                    groupID: 'Size',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_volumeMeasurementUnit',
                    index: 21,
                    isHeadline: false,
                ),
                // -------------
                /// WIGHT
                PickerModel(
                    chainID: 'phid_s_weight',
                    groupID: 'Size',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_weightMeasurementUnit',
                    index: 22,
                    isHeadline: false,
                ),
                // -------------
                /// SIZE
                PickerModel(
                    chainID: 'phid_s_size',
                    groupID: 'Size',
                    canPickMany: false,
                    isRequired: false,
                    index: 23,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------
                /// - QUANTITY SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_quantity',
                    groupID: 'Quantity',
                    index: 24,
                    isHeadline: true,
                ),

                // ----------------------------
                /// QUANTITY
                PickerModel(
                    chainID: 'phid_s_count',
                    groupID: 'Quantity',
                    canPickMany: false,
                    isRequired: false,
                    index: 25,
                    isHeadline: false,
                ),
                // ----------------------------
                /// - ELECTRIC SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_electricity',
                    groupID: 'Electricity',
                    index: 26,
                    isHeadline: true,
                ),

                // ----------------------------
                /// WATTAGE
                PickerModel(
                    chainID: 'phid_s_wattage',
                    groupID: 'Electricity',
                    canPickMany: false,
                    isRequired: false,
                    index: 27,
                    isHeadline: false,
                ),
                // -------------
                /// VOLTAGE
                PickerModel(
                    chainID: 'phid_s_voltage',
                    groupID: 'Electricity',
                    canPickMany: false,
                    isRequired: false,
                    index: 28,
                    isHeadline: false,
                ),
                // -------------
                /// WATTAGE
                PickerModel(
                    chainID: 'phid_s_ampere',
                    groupID: 'Electricity',
                    canPickMany: false,
                    isRequired: false,
                    index: 29,
                    isHeadline: false,
                ),
                // ----------------------------
                /// - LOGISTICS SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_logistics',
                    groupID: 'Logistics',
                    index: 30,
                    isHeadline: true,
                ),

                // ----------------------------
                /// AVAILABILITY
                PickerModel(
                    chainID: 'phid_s_inStock',
                    groupID: 'Logistics',
                    canPickMany: false,
                    isRequired: false,
                    index: 31,
                    isHeadline: false,
                ),
                // ----------------------------
                /// DELIVERY AVAILABILITY
                PickerModel(
                    chainID: 'phid_s_deliveryAvailable',
                    groupID: 'Logistics',
                    canPickMany: false,
                    isRequired: false,
                    blockers: <PickersBlocker>[
                        PickersBlocker(
                            value: false,
                            pickersIDsToBlock: <String>['phid_s_deliveryMinDuration'],
                        ),
                    ],
                    index: 32,
                    isHeadline: false,
                ),
                // -------------
                /// DELIVERY AVAILABILITY
                PickerModel(
                    chainID: 'phid_s_deliveryMinDuration',
                    groupID: 'Logistics',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_deliveryDurationUnit',
                    index: 33,
                    isHeadline: false,
                ),
                // ----------------------------
                /// - MANUFACTURER SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_manufacturer',
                    groupID: 'Manufacturer Info',
                    index: 34,
                    isHeadline: true,
                ),

                // ----------------------------
                /// MADE IN
                PickerModel(
                    chainID: 'phid_s_madeIn',
                    groupID: 'Manufacturer Info',
                    canPickMany: false,
                    isRequired: false,
                    index: 35,
                    isHeadline: false,
                ),
                // ----------------------------
                /// - WARRANTY SPECIFICATIONS

                PickerModel(
                    chainID: 'headline_warranty',
                    groupID: 'Warranty',
                    index: 36,
                    isHeadline: true,
                ),

                // ----------------------------
                /// WARRANTY DURATION
                PickerModel(
                    chainID: 'phid_s_insuranceDuration',
                    groupID: 'Warranty',
                    canPickMany: false,
                    isRequired: false,
                    unitChainID: 'phid_s_warrantyDurationUnit',
                    index: 37,
                    isHeadline: false,
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

                PickerModel(
                    chainID: 'headline_equipment_type',
                    groupID: 'Type',
                    index: 0,
                    isHeadline: true,
                ),

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
                    index: 1,
                    isHeadline: false,
                ),
                // ------------------------------------------------------------

                /// pricing - contract type

            ],
        };
    }
// -----------------------------------------------------------------------------
}
