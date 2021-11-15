import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/raw_specs.dart';
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
        names: RawSpecs.propertyForm.names,
        canPickMany: false,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyForm
    ),
    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        names: RawSpecs.propertyLicense.names,
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyLicense
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
        specChain: RawSpecs.contractType
    ),
    /// PROPERTY PAYMENT METHOD
    SpecList(
        id: 'propertyPaymentMethod',
        names: RawSpecs.paymentMethod.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.paymentMethod
    ),
    /// PROPERTY SALE PRICE
    const SpecList(
        id: 'PropertySalePrice',
        names: <Name>[Name(code: 'en', value: 'Property sale price'), Name(code: 'ar', value: 'سعر بيع العقار')],
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price
    ),
    /// PROPERTY RENT PRICE
    const SpecList(
        id: 'propertyRentPrice',
        names: <Name>[Name(code: 'en', value: 'Property rent price'), Name(code: 'ar', value: 'سعر إيجار العقار')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price
    ),
    /// PROPERTY PRICE CURRENCY
    SpecList(
        id: 'propertyPriceCurrency',
        names: RawSpecs.currency.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.currency
    ),
    /// PROPERTY NUMBER OF INSTALLMENTS
    SpecList(
        id: 'propertyNumberOfInstallments',
        names: RawSpecs.numberOfInstallments.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.numberOfInstallments
    ),
    /// PROPERTY INSTALLMENTS DURATION
    SpecList(
        id: 'propertyInstallmentsDuration',
        names: RawSpecs.installmentsDuration.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.installmentsDuration
    ),
    /// PROPERTY INSTALLMENTS DURATION UNIT
    SpecList(
        id: 'propertyInstallmentsDurationUnit',
        names: RawSpecs.installmentsDurationUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.installmentsDurationUnit
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA SPECIFICATIONS
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        id: 'propertyArea',
        names: RawSpecs.propertyArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyArea
    ),
    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        names: RawSpecs.propertyAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyAreaUnit
    ),
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        names: RawSpecs.lotArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotArea
    ),
    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        names: RawSpecs.lotAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotAreaUnit
    ),
    // ------------------------------------------------------------
    /// - PROPERTY SPATIAL SPECIFICATION
    // ----------------------------
    /// PROPERTY SPACES
    SpecList(
        id: 'propertySpaces',
        names: RawSpecs.propertySpaces.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertySpaces
    ),
    /// PROPERTY FLOOR NUMBER
    SpecList(
        id: 'propertyFloorNumber',
        names: RawSpecs.propertyFloorNumber.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyFloorNumber
    ),
    /// PROPERTY DEDICATED PARKING LOTS COUNT
    SpecList(
        id: 'propertyDedicatedParkingLotsCount',
        names: RawSpecs.propertyDedicatedParkingLotsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyDedicatedParkingLotsCount
    ),
    /// PROPERTY NUMBER OF BEDROOMS
    SpecList(
        id: 'propertyNumberOfBedrooms',
        names: RawSpecs.propertyNumberOfBedrooms.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyNumberOfBedrooms,
    ),
    /// PROPERTY NUMBER OF BATHROOMS
    SpecList(
      id: 'propertyNumberOfBathrooms',
      names: RawSpecs.propertyNumberOfBathrooms.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.propertyNumberOfBathrooms,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY FEATURES SPECIFICATIONS
    // ----------------------------
    /// PROPERTY VIEW
    SpecList(
        id: 'propertyView',
        names: RawSpecs.propertyView.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyView
    ),
    /// PROPERTY INDOOR FEATURES
    SpecList(
        id: 'propertyIndoorFeatures',
        names: RawSpecs.propertyIndoorFeatures.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyIndoorFeatures
    ),
    /// PROPERTY FINISHING LEVEL
    SpecList(
        id: 'propertyFinishingLevel',
        names: RawSpecs.propertyFinishingLevel.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyFinishingLevel
    ),
    /// PROPERTY DECORATION STYLE
    const SpecList(
        id: 'propertyDecorationStyle',
        names: <Name>[Name(code: 'en', value: 'Property decoration style'), Name(code: 'ar', value: 'الطراز التصميمي لديكور العقار')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.style,
    ),
    // ------------------------------------------------------------
    /// - COMMUNITY FEATURES SPECIFICATIONS
    // ----------------------------
    /// IN  A COMPOUND
    SpecList(
        id: 'propertyInACompound',
        names: RawSpecs.inACompound.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.inACompound
    ),
    /// AMENITIES
    SpecList(
        id: 'propertyAmenities',
        names: RawSpecs.amenities.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.amenities
    ),
    /// COMMUNITY SERVICES
    SpecList(
        id: 'communityServices',
        names: RawSpecs.communityServices.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.communityServices
    ),
    // ------------------------------------------------------------
    /// - BUILDING FEATURES SPECIFICATIONS
    // ----------------------------
    /// BUILDING NUMBER OF FLOORS
    SpecList(
        id: 'buildingNumberOfFloors',
        names: RawSpecs.buildingNumberOfFloors.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingNumberOfFloors
    ),
    /// BUILDING AGE IN YEARS
    SpecList(
        id: 'buildingAgeInYears',
        names: RawSpecs.buildingAgeInYears.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingAgeInYears
    ),
    /// BUILDING TOTAL UNITS COUNTS
    SpecList(
        id: 'buildingTotalUnitsCount',
        names: RawSpecs.buildingTotalUnitsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingTotalUnitsCount
    ),
    /// BUILDING TOTAL PARKING LOTS COUNTS
    SpecList(
        id: 'buildingTotalParkingLotsCount',
        names: RawSpecs.buildingTotalParkingLotsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingTotalParkingLotsCount
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
        names: RawSpecs.propertyForm.names,
        canPickMany: false,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyForm
    ),
    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        names: RawSpecs.propertyLicense.names,
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyLicense
    ),
    /// PROPERTY SPACES
    const SpecList(
        id: 'designSpaces',
        names: <Name>[Name(code: 'en', value: 'Design spaces'), Name(code: 'ar', value: 'فراغات التصميم')],
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertySpaces
    ),
    // ------------------------------------------------------------
    /// - STYLE SPECIFICATIONS
    // ----------------------------
    /// DESIGN STYLE
    SpecList(
        id: 'designStyle',
        names: RawSpecs.style.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.style
    ),
    /// DESIGN COLORS
    SpecList(
        id: 'designColors',
        names: RawSpecs.color.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.color,
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
        specChain: RawSpecs.price
    ),
    /// PROJECT COST CURRENCY
    const SpecList(
        id: 'projectCostCurrency',
        names: <Name>[Name(code: 'en', value: 'Project cost currency'), Name(code: 'ar', value: 'عملة تكلفة المشروع')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.currency,
    ),
    /// Construction DURATION
    const SpecList(
        id: 'constructionDuration',
        names: <Name>[Name(code: 'en', value: 'Project duration'), Name(code: 'ar', value: 'زمن تنفيذ المشروع')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.duration,
    ),
    /// Construction DURATION UNIT
    const SpecList(
      id: 'constructionDurationUnit',
      names: <Name>[Name(code: 'en', value: 'Project duration unit'), Name(code: 'ar', value: 'وحدة قياس زمن تنفيذ المشروع')],
      canPickMany: false,
      isRequired: false,
      range: ['day', 'week', 'month', 'year'],
      specChain: RawSpecs.duration,
    ),
    /// NUMBER OF CONSTRUCTION ACTIVITIES
    const SpecList(
        id: 'numberOfConstructionActivities',
        names: <Name>[Name(code: 'en', value: 'Number of construction activities'), Name(code: 'ar', value: 'عدد بنود التنفيذ الإنشائية')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.count
    ),
    /// CONSTRUCTION ACTIVITIES
    SpecList(
        id: 'constructionActivities',
        names: RawSpecs.constructionActivities.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.constructionActivities,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA SPECIFICATIONS
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        id: 'propertyArea',
        names: RawSpecs.propertyArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyArea
    ),
    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        names: RawSpecs.propertyAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyAreaUnit
    ),
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        names: RawSpecs.lotArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotArea
    ),
    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        names: RawSpecs.lotAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotAreaUnit
    ),
    // ------------------------------------------------------------
  ];

  static List<SpecList> craftSpecLists = <SpecList>[
    /// CONSTRUCTION ACTIVITY PRICE
    SpecList(
        id: 'constructionActivityPrice',
        names: RawSpecs.price.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price
    ),
    /// CONSTRUCTION ACTIVITY PRICE CURRENCY
    SpecList(
      id: 'projectCostCurrency',
      names: RawSpecs.currency.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.currency,
    ),
    /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
    SpecList(
      id: 'constructionActivityMeasurementMethod',
      names: RawSpecs.constructionActivityMeasurementMethod.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.constructionActivityMeasurementMethod,
    ),
  ];

  static List<SpecList> productSpecLists = <SpecList>[];

  static List<SpecList> equipmentSpecLists = <SpecList>[];

}
