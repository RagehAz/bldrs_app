import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/specs_lists.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/foundation.dart';

class SpecList{
  final String id;
  final List<Name> names;
  /// can pick many allows selecting either only 1 value from the chain or multiple values
  final bool canPickMany;
  /// this dictates which specs are required for publishing the flyer, and which are optional
  final bool isRequired;
  /// THE SELECTABLE RANGE allows selecting only parts of the original spec list
  /// if <KW>['id1', 'id2'] only these IDs will be included,
  /// if <int>[1, 5] then only this range is selectable
  final List<dynamic> range;
  final Chain specChain;

  const SpecList({
    @required this.id,
    @required this.names,
    @required this.canPickMany,
    @required this.isRequired,
    @required this.range,
    @required this.specChain,
  });

  static List<SpecList> propertySpecLists = <SpecList>[
    // ------------------------------------------------------------
    /// - MAIN SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecList(
        id: 'propertyForm',
        names: SpecChain.propertyForm.names,
        canPickMany: false,
        isRequired: true,
        range: null,
        specChain: SpecChain.propertyForm
    ),
    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        names: SpecChain.propertyLicense.names,
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: SpecChain.propertyLicense
    ),
    // ------------------------------------------------------------
    /// - PROPERTY PRICING SPECIFICATIONS
    // ----------------------------
    /// PROPERTY CONTRACT TYPE
    const SpecList(
        id: 'propertyContractType',
        names: <Name>[Name(code: 'en', value: 'Property contract Type'), Name(code: 'ar', value: 'نوع التعاقد على الغقار')],
        canPickMany: false,
        isRequired: true,
        range: null,
        specChain: SpecChain.contractType
    ),
    /// PROPERTY PAYMENT METHOD
    SpecList(
        id: 'propertyPaymentMethod',
        names: SpecChain.paymentMethod.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.paymentMethod
    ),
    /// PROPERTY SALE PRICE
    const SpecList(
        id: 'PropertySalePrice',
        names: <Name>[Name(code: 'en', value: 'Property sale price'), Name(code: 'ar', value: 'سعر بيع العقار')],
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.price
    ),
    /// PROPERTY RENT PRICE
    const SpecList(
        id: 'propertyRentPrice',
        names: <Name>[Name(code: 'en', value: 'Property rent price'), Name(code: 'ar', value: 'سعر إيجار العقار')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.price
    ),
    /// PROPERTY PRICE CURRENCY
    SpecList(
        id: 'propertyPriceCurrency',
        names: SpecChain.currency.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.currency
    ),
    /// PROPERTY NUMBER OF INSTALLMENTS
    SpecList(
        id: 'propertyNumberOfInstallments',
        names: SpecChain.numberOfInstallments.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.numberOfInstallments
    ),
    /// PROPERTY INSTALLMENTS DURATION
    SpecList(
        id: 'propertyInstallmentsDuration',
        names: SpecChain.installmentsDuration.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.installmentsDuration
    ),
    /// PROPERTY INSTALLMENTS DURATION UNIT
    SpecList(
        id: 'propertyInstallmentsDurationUnit',
        names: SpecChain.installmentsDurationUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.installmentsDurationUnit
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA SPECIFICATIONS
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        id: 'propertyArea',
        names: SpecChain.propertyArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyArea
    ),
    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        names: SpecChain.propertyAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyAreaUnit
    ),
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        names: SpecChain.lotArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.lotArea
    ),
    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        names: SpecChain.lotAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.lotAreaUnit
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPATIAL SPECIFICATION
    // ----------------------------
    /// PROPERTY SPACES
    SpecList(
        id: 'propertySpaces',
        names: SpecChain.propertySpaces.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertySpaces
    ),
    /// PROPERTY FLOOR NUMBER
    SpecList(
        id: 'propertyFloorNumber',
        names: SpecChain.propertyFloorNumber.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyFloorNumber
    ),
    /// PROPERTY DEDICATED PARKING LOTS COUNT
    SpecList(
        id: 'propertyDedicatedParkingLotsCount',
        names: SpecChain.propertyDedicatedParkingLotsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyDedicatedParkingLotsCount
    ),
    /// PROPERTY NUMBER OF BEDROOMS
    SpecList(
        id: 'propertyNumberOfBedrooms',
        names: SpecChain.propertyNumberOfBedrooms.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyNumberOfBedrooms,
    ),
    /// PROPERTY NUMBER OF BATHROOMS
    SpecList(
      id: 'propertyNumberOfBathrooms',
      names: SpecChain.propertyNumberOfBathrooms.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: SpecChain.propertyNumberOfBathrooms,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY FEATURES SPECIFICATIONS
    // ----------------------------
    /// PROPERTY VIEW
    SpecList(
        id: 'propertyView',
        names: SpecChain.propertyView.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyView
    ),
    /// PROPERTY INDOOR FEATURES
    SpecList(
        id: 'propertyIndoorFeatures',
        names: SpecChain.propertyIndoorFeatures.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyIndoorFeatures
    ),
    /// PROPERTY FINISHING LEVEL
    SpecList(
        id: 'propertyFinishingLevel',
        names: SpecChain.propertyFinishingLevel.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyFinishingLevel
    ),
    /// PROPERTY DECORATION STYLE
    const SpecList(
        id: 'propertyDecorationStyle',
        names: <Name>[Name(code: 'en', value: 'Property decoration style'), Name(code: 'ar', value: 'الطراز التصميمي لديكور العقار')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.style,
    ),
    // ------------------------------------------------------------
    /// - COMMUNITY FEATURES SPECIFICATIONS
    // ----------------------------
    /// IN  A COMPOUND
    SpecList(
        id: 'propertyInACompound',
        names: SpecChain.inACompound.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.inACompound
    ),
    /// AMENITIES
    SpecList(
        id: 'propertyAmenities',
        names: SpecChain.amenities.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.amenities
    ),
    /// COMMUNITY SERVICES
    SpecList(
        id: 'communityServices',
        names: SpecChain.communityServices.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.communityServices
    ),
    // ------------------------------------------------------------
    /// - BUILDING FEATURES SPECIFICATIONS
    // ----------------------------
    /// BUILDING NUMBER OF FLOORS
    SpecList(
        id: 'buildingNumberOfFloors',
        names: SpecChain.buildingNumberOfFloors.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.buildingNumberOfFloors
    ),
    /// BUILDING AGE IN YEARS
    SpecList(
        id: 'buildingAgeInYears',
        names: SpecChain.buildingAgeInYears.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.buildingAgeInYears
    ),
    /// BUILDING TOTAL UNITS COUNTS
    SpecList(
        id: 'buildingTotalUnitsCount',
        names: SpecChain.buildingTotalUnitsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.buildingTotalUnitsCount
    ),
    /// BUILDING TOTAL PARKING LOTS COUNTS
    SpecList(
        id: 'buildingTotalParkingLotsCount',
        names: SpecChain.buildingTotalParkingLotsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.buildingTotalParkingLotsCount
    ),
    // ------------------------------------------------------------
  ];

  static List<SpecList> designSpecLists = <SpecList>[
    // ------------------------------------------------------------
    /// - PROPERTY SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecList(
        id: 'propertyForm',
        names: SpecChain.propertyForm.names,
        canPickMany: false,
        isRequired: true,
        range: null,
        specChain: SpecChain.propertyForm
    ),
    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        names: SpecChain.propertyLicense.names,
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: SpecChain.propertyLicense
    ),
    /// PROPERTY SPACES
    const SpecList(
        id: 'designSpaces',
        names: <Name>[Name(code: 'en', value: 'Design spaces'), Name(code: 'ar', value: 'فراغات التصميم')],
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: SpecChain.propertySpaces
    ),
    // ------------------------------------------------------------
    /// - STYLE SPECIFICATIONS
    // ----------------------------
    /// DESIGN STYLE
    SpecList(
        id: 'designStyle',
        names: SpecChain.style.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.style
    ),
    /// DESIGN COLORS
    SpecList(
        id: 'designColors',
        names: SpecChain.color.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.color,
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION SPECIFICATIONS
    // ----------------------------
    /// PROJECT COST
    const SpecList(
        id: 'projectCost',
        names: <Name>[Name(code: 'en', value: 'Project cost'), Name(code: 'ar', value: 'تكلفة المشروع')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.price
    ),
    /// PROJECT COST CURRENCY
    const SpecList(
        id: 'projectCostCurrency',
        names: <Name>[Name(code: 'en', value: 'Project cost currency'), Name(code: 'ar', value: 'عملة تكلفة المشروع')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.currency,
    ),
    /// Construction DURATION
    const SpecList(
        id: 'constructionDuration',
        names: <Name>[Name(code: 'en', value: 'Project duration'), Name(code: 'ar', value: 'زمن تنفيذ المشروع')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.duration,
    ),
    /// Construction DURATION UNIT
    const SpecList(
      id: 'constructionDurationUnit',
      names: <Name>[Name(code: 'en', value: 'Project duration unit'), Name(code: 'ar', value: 'وحدة قياس زمن تنفيذ المشروع')],
      canPickMany: false,
      isRequired: false,
      range: ['day', 'week', 'month', 'year'],
      specChain: SpecChain.duration,
    ),
    /// NUMBER OF CONSTRUCTION ACTIVITIES
    const SpecList(
        id: 'numberOfConstructionActivities',
        names: <Name>[Name(code: 'en', value: 'Number of construction activities'), Name(code: 'ar', value: 'عدد بنود التنفيذ الإنشائية')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.count
    ),
    /// CONSTRUCTION ACTIVITIES
    SpecList(
        id: 'constructionActivities',
        names: SpecChain.constructionActivities.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: SpecChain.constructionActivities,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA SPECIFICATIONS
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        id: 'propertyArea',
        names: SpecChain.propertyArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyArea
    ),
    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        names: SpecChain.propertyAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.propertyAreaUnit
    ),
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        names: SpecChain.lotArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.lotArea
    ),
    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        names: SpecChain.lotAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.lotAreaUnit
    ),
    // ------------------------------------------------------------
  ];

  static List<SpecList> craftSpecLists = <SpecList>[
    /// CONSTRUCTION ACTIVITY PRICE
    SpecList(
        id: 'constructionActivityPrice',
        names: SpecChain.price.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: SpecChain.price
    ),
    /// CONSTRUCTION ACTIVITY PRICE CURRENCY
    SpecList(
      id: 'projectCostCurrency',
      names: SpecChain.currency.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: SpecChain.currency,
    ),
    /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
    SpecList(
      id: 'constructionActivityMeasurementMethod',
      names: SpecChain.constructionActivityMeasurementMethod.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: SpecChain.constructionActivityMeasurementMethod,
    ),
  ];

  static List<SpecList> productSpecLists = <SpecList>[];

  static List<SpecList> equipmentSpecLists = <SpecList>[];

}
