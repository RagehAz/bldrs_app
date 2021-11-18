import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/raw_specs.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/foundation.dart';

class SpecList{
  final String id;
  final List<Name> names;
  final String groupID;
  /// can pick many allows selecting either only 1 value from the chain or multiple values
  final bool canPickMany;
  /// this dictates which specs are required for publishing the flyer, and which are optional
  final bool isRequired;
  final List<SpecDeactivator> deactivators;
  /// THE SELECTABLE RANGE allows selecting only parts of the original spec list
  /// if <KW>['id1', 'id2'] only these IDs will be included,
  /// if <int>[1, 5] then only this range is selectable
  final List<dynamic> range;
  final Chain specChain;

  SpecList({
    @required this.id,
    @required this.groupID,
    @required this.names,
    @required this.canPickMany,
    @required this.isRequired,
    this.deactivators,
    @required this.range,
    @required this.specChain,
  });
// -----------------------------------------------------------------------------
  static List<SpecList> generateRefinedSpecsLists({@required List<SpecList> sourceSpecsLists, @required List<Spec> selectedSpecs}){
    final List<SpecList> _lists = <SpecList>[];

    if (Mapper.canLoopList(sourceSpecsLists)){

      final List<String> _allListsIDsToDeactivate = <String>[];

      /// GET DEACTIVATED LISTS
      for (var list in sourceSpecsLists){
        final List<SpecDeactivator> _deactivators = list.deactivators;

        if (Mapper.canLoopList(_deactivators)){

          for (SpecDeactivator deactivator in _deactivators){

            bool _isSelected = Spec.specsContainThisSpecValue(specs: selectedSpecs, value: deactivator.specValue);

            if (_isSelected == true){
              _allListsIDsToDeactivate.addAll(deactivator.specsListsIDsToDeactivate);
            }

          }

        }

      }

      /// REFINE
      for (var list in sourceSpecsLists){

        final bool _listShouldBeDeactivated = Mapper.stringsContainString(strings: _allListsIDsToDeactivate, string: list.id);

        if (_listShouldBeDeactivated == false){

          _lists.add(list);

        }

      }

    }

    return _lists;
  }
// -----------------------------------------------------------------------------
  static SpecList getSpecListFromSpecsListsByID({@required List<SpecList> specsLists, @required String specListID}){

    SpecList _specList;

    if (Mapper.canLoopList(specsLists) && specListID != null){

      _specList = specsLists.singleWhere((list) => list.id == specListID, orElse: () => null);

    }

    return _specList;
  }
// -----------------------------------------------------------------------------
  static int getSpecsListIndexByID({@required List<SpecList> specsLists, @required String specsListID}){
    final int _index = specsLists.indexWhere((list) => list.id == specsListID);
    return _index;
  }
// -----------------------------------------------------------------------------
  static List<SpecList> getSpecsListsByGroupID({@required List<SpecList> specsLists, @required String groupID}){

    List<SpecList> _specsLists = <SpecList>[];

    if (Mapper.canLoopList(specsLists)){

      for (var list in specsLists){

        if (list.groupID == groupID){

          _specsLists.add(list);

        }

      }

    }


    return _specsLists;
  }
// -----------------------------------------------------------------------------
  static List<String> getGroupsFromSpecsLists({@required List<SpecList> specsLists}){

    List<String> _groups = <String>[];

    for (var list in specsLists){

      _groups = TextMod.addStringToListIfDoesNotContainIt(
        strings: _groups,
        stringToAdd: list.groupID,
      );

    }

    return _groups;
}
// -----------------------------------------------------------------------------
  static List<SpecList> propertySpecLists = <SpecList>[
    // ------------------------------------------------------------
    /// - MAIN SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecList(
        id: 'propertyForm',
        groupID: 'Main Specifications',
        names: RawSpecs.propertyForm.names,
        canPickMany: false,
        isRequired: true,
        deactivators: [
          SpecDeactivator(specValue: 'pf_land', specsListsIDsToDeactivate: ['propertyArea', 'propertyAreaUnit']),
          SpecDeactivator(specValue: 'pf_mobile', specsListsIDsToDeactivate: ['lotArea', 'lotAreaUnit', 'propertyFloorNumber', 'propertyNumberOfBedrooms', 'propertyNumberOfBathrooms', 'propertyInACompound']),
        ],
        range: null,
        specChain: RawSpecs.propertyForm
    ),
    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        groupID: 'Main Specifications',
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
    SpecList(
        id: 'propertyContractType',
        groupID: 'Pricing Specifications',
        names: <Name>[Name(code: 'en', value: 'Property contract Type'), Name(code: 'ar', value: 'نوع التعاقد على الغقار')],
        canPickMany: false,
        isRequired: true,
        deactivators: [
          SpecDeactivator(specValue: 'contractType_NewSale', specsListsIDsToDeactivate: ['propertyRentPrice', ]),
          SpecDeactivator(specValue: 'contractType_Resale', specsListsIDsToDeactivate: ['propertyRentPrice', ]),
          SpecDeactivator(specValue: 'contractType_Rent', specsListsIDsToDeactivate: ['PropertySalePrice', ]),
        ],
        range: null,
        specChain: RawSpecs.contractType
    ),
    /// PROPERTY PAYMENT METHOD
    SpecList(
        id: 'propertyPaymentMethod',
        groupID: 'Pricing Specifications',
        names: RawSpecs.paymentMethod.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        deactivators: [
          SpecDeactivator(specValue: 'payment_cash', specsListsIDsToDeactivate: ['propertyNumberOfInstallments', 'propertyInstallmentsDuration', 'propertyInstallmentsDurationUnit']),
        ],
        specChain: RawSpecs.paymentMethod
    ),
    /// PROPERTY SALE PRICE
    SpecList(
        id: 'PropertySalePrice',
        groupID: 'Pricing Specifications',
        names: <Name>[Name(code: 'en', value: 'Property sale price'), Name(code: 'ar', value: 'سعر بيع العقار')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price
    ),
    /// PROPERTY RENT PRICE
    SpecList(
        id: 'propertyRentPrice',
        groupID: 'Pricing Specifications',
        names: <Name>[Name(code: 'en', value: 'Property rent price'), Name(code: 'ar', value: 'سعر إيجار العقار')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price
    ),
    /// PROPERTY PRICE CURRENCY
    SpecList(
        id: 'propertyPriceCurrency',
        groupID: 'Pricing Specifications',
        names: RawSpecs.currency.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.currency
    ),
    /// PROPERTY NUMBER OF INSTALLMENTS
    SpecList(
        id: 'propertyNumberOfInstallments',
        groupID: 'Pricing Specifications',
        names: RawSpecs.numberOfInstallments.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.numberOfInstallments
    ),
    /// PROPERTY INSTALLMENTS DURATION
    SpecList(
        id: 'propertyInstallmentsDuration',
        groupID: 'Pricing Specifications',
        names: RawSpecs.installmentsDuration.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.installmentsDuration
    ),
    /// PROPERTY INSTALLMENTS DURATION UNIT
    SpecList(
        id: 'propertyInstallmentsDurationUnit',
        groupID: 'Pricing Specifications',
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
        groupID: 'Area Specifications',
        names: RawSpecs.propertyArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyArea
    ),
    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        groupID: 'Area Specifications',
        names: RawSpecs.propertyAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyAreaUnit
    ),
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        groupID: 'Area Specifications',
        names: RawSpecs.lotArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotArea
    ),
    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        groupID: 'Area Specifications',
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
        groupID: 'Spatial Specifications',
        names: RawSpecs.propertySpaces.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertySpaces
    ),
    /// PROPERTY FLOOR NUMBER
    SpecList(
        id: 'propertyFloorNumber',
        groupID: 'Spatial Specifications',
        names: RawSpecs.propertyFloorNumber.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyFloorNumber
    ),
    /// PROPERTY DEDICATED PARKING LOTS COUNT
    SpecList(
        id: 'propertyDedicatedParkingLotsCount',
        groupID: 'Spatial Specifications',
        names: RawSpecs.propertyDedicatedParkingLotsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyDedicatedParkingLotsCount
    ),
    /// PROPERTY NUMBER OF BEDROOMS
    SpecList(
      id: 'propertyNumberOfBedrooms',
      groupID: 'Spatial Specifications',
      names: RawSpecs.propertyNumberOfBedrooms.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.propertyNumberOfBedrooms,
    ),
    /// PROPERTY NUMBER OF BATHROOMS
    SpecList(
      id: 'propertyNumberOfBathrooms',
      groupID: 'Spatial Specifications',
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
        groupID: 'Property Features',
        names: RawSpecs.propertyView.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyView
    ),
    /// PROPERTY INDOOR FEATURES
    SpecList(
        id: 'propertyIndoorFeatures',
        groupID: 'Property Features',
        names: RawSpecs.propertyIndoorFeatures.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyIndoorFeatures
    ),
    /// PROPERTY FINISHING LEVEL
    SpecList(
        id: 'propertyFinishingLevel',
        groupID: 'Property Features',
        names: RawSpecs.propertyFinishingLevel.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyFinishingLevel
    ),
    /// PROPERTY DECORATION STYLE
    SpecList(
      id: 'propertyDecorationStyle',
      groupID: 'Property Features',
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
        groupID: 'Community Features',
        names: RawSpecs.inACompound.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.inACompound
    ),
    /// AMENITIES
    SpecList(
        id: 'propertyAmenities',
        groupID: 'Community Features',
        names: RawSpecs.amenities.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.amenities
    ),
    /// COMMUNITY SERVICES
    SpecList(
        id: 'communityServices',
        groupID: 'Community Features',
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
        groupID: 'Building Specifications',
        names: RawSpecs.buildingNumberOfFloors.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingNumberOfFloors
    ),
    /// BUILDING AGE IN YEARS
    SpecList(
        id: 'buildingAgeInYears',
        groupID: 'Building Specifications',
        names: RawSpecs.buildingAgeInYears.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingAgeInYears
    ),
    /// BUILDING TOTAL UNITS COUNTS
    SpecList(
        id: 'buildingTotalUnitsCount',
        groupID: 'Building Specifications',
        names: RawSpecs.buildingTotalUnitsCount.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingTotalUnitsCount
    ),
    /// BUILDING TOTAL PARKING LOTS COUNTS
    SpecList(
        id: 'buildingTotalParkingLotsCount',
        groupID: 'Building Specifications',
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
        groupID: 'Property Specifications',
        names: RawSpecs.propertyForm.names,
        canPickMany: false,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyForm
    ),
    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        groupID: 'Property Specifications',
        names: RawSpecs.propertyLicense.names,
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyLicense
    ),
    /// PROPERTY SPACES
    SpecList(
        id: 'designSpaces',
        groupID: 'Property Specifications',
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
        groupID: 'Styling',
        names: RawSpecs.style.names,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.style
    ),
    /// DESIGN COLORS
    SpecList(
      id: 'designColors',
      groupID: 'Styling',
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
    SpecList(
        id: 'projectCost',
        groupID: 'Construction Specifications',
        names: <Name>[Name(code: 'en', value: 'Project cost'), Name(code: 'ar', value: 'تكلفة المشروع')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price
    ),
    /// PROJECT COST CURRENCY
    SpecList(
      id: 'projectCostCurrency',
      groupID: 'Construction Specifications',
      names: <Name>[Name(code: 'en', value: 'Project cost currency'), Name(code: 'ar', value: 'عملة تكلفة المشروع')],
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.currency,
    ),
    /// Construction DURATION
    SpecList(
      id: 'constructionDuration',
      groupID: 'Construction Specifications',
      names: <Name>[Name(code: 'en', value: 'Project duration'), Name(code: 'ar', value: 'زمن تنفيذ المشروع')],
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.duration,
    ),
    /// Construction DURATION UNIT
    SpecList(
      id: 'constructionDurationUnit',
      groupID: 'Construction Specifications',
      names: <Name>[Name(code: 'en', value: 'Project duration unit'), Name(code: 'ar', value: 'وحدة قياس زمن تنفيذ المشروع')],
      canPickMany: false,
      isRequired: false,
      range: ['day', 'week', 'month', 'year'],
      specChain: RawSpecs.duration,
    ),
    /// NUMBER OF CONSTRUCTION ACTIVITIES
    SpecList(
        id: 'numberOfConstructionActivities',
        groupID: 'Construction Specifications',
        names: <Name>[Name(code: 'en', value: 'Number of construction activities'), Name(code: 'ar', value: 'عدد بنود التنفيذ الإنشائية')],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.count
    ),
    /// CONSTRUCTION ACTIVITIES
    SpecList(
      id: 'constructionActivities',
      groupID: 'Construction Specifications',
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
        groupID: 'Area Specifications',
        names: RawSpecs.propertyArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyArea
    ),
    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        groupID: 'Area Specifications',
        names: RawSpecs.propertyAreaUnit.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyAreaUnit
    ),
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        groupID: 'Area Specifications',
        names: RawSpecs.lotArea.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotArea
    ),
    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        groupID: 'Area Specifications',
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
        groupID: 'Cost',
        names: RawSpecs.price.names,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price
    ),
    /// CONSTRUCTION ACTIVITY PRICE CURRENCY
    SpecList(
      id: 'projectCostCurrency',
      groupID: 'Cost',
      names: RawSpecs.currency.names,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.currency,
    ),
    /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
    SpecList(
      id: 'constructionActivityMeasurementMethod',
      groupID: 'Cost',
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

class SpecDeactivator{
  /// when this specValue is selected
  final String specValue;
  /// all lists with these listsIDs get deactivated
  final List<String> specsListsIDsToDeactivate;

  SpecDeactivator({
    @required this.specValue,
    @required this.specsListsIDsToDeactivate,
});

}