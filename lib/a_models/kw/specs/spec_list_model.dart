import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart'
    as FlyerTypeClass;
import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/specs/spec_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

class SpecList {
  /// --------------------------------------------------------------------------
  SpecList({
    @required this.id,
    @required this.groupID,
    @required this.names,
    @required this.canPickMany,
    @required this.isRequired,
    @required this.range,
    @required this.specChain,
    this.deactivators,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final List<Phrase> names;
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

  /// --------------------------------------------------------------------------
  static List<SpecList> generateRefinedSpecsLists({
    @required List<SpecList> sourceSpecsLists,
  @required List<SpecModel> selectedSpecs,
  }) {
    final List<SpecList> _lists = <SpecList>[];

    if (Mapper.canLoopList(sourceSpecsLists)) {
      final List<String> _allListsIDsToDeactivate = <String>[];

      /// GET DEACTIVATED LISTS
      for (final SpecList list in sourceSpecsLists) {
        final List<SpecDeactivator> _deactivators = list.deactivators;

        if (Mapper.canLoopList(_deactivators)) {
          for (final SpecDeactivator deactivator in _deactivators) {
            final bool _isSelected = SpecModel.specsContainThisSpecValue(
                specs: selectedSpecs, value: deactivator.specValue);

            if (_isSelected == true) {
              _allListsIDsToDeactivate
                  .addAll(deactivator.specsListsIDsToDeactivate);
            }
          }
        }
      }

      /// REFINE
      for (final SpecList list in sourceSpecsLists) {
        final bool _listShouldBeDeactivated = Mapper.stringsContainString(
            strings: _allListsIDsToDeactivate, string: list.id);

        if (_listShouldBeDeactivated == false) {
          _lists.add(list);
        }
      }
    }

    return _lists;
  }
// -----------------------------------------------------------------------------
  static SpecList getSpecListFromSpecsListsByID({
    @required List<SpecList> specsLists,
    @required String specListID,
  }) {

    SpecList _specList;

    if (Mapper.canLoopList(specsLists) && specListID != null) {
      _specList = specsLists.singleWhere(
          (SpecList list) => list.id == specListID,
          orElse: () => null);
    }

    return _specList;
  }

// -----------------------------------------------------------------------------
  static int getSpecsListIndexByID({
    @required List<SpecList> specsLists,
    @required String specsListID,
  }) {
    final int _index =
        specsLists.indexWhere((SpecList list) => list.id == specsListID);
    return _index;
  }
// -----------------------------------------------------------------------------
  static List<SpecList> getSpecsListsByGroupID({
    @required List<SpecList> specsLists,
    @required String groupID,
  }) {

    final List<SpecList> _specsLists = <SpecList>[];

    if (Mapper.canLoopList(specsLists)) {
      for (final SpecList list in specsLists) {
        if (list.groupID == groupID) {
          _specsLists.add(list);
        }
      }
    }

    return _specsLists;
  }

// -----------------------------------------------------------------------------
  static List<String> getGroupsFromSpecsLists({
    @required List<SpecList> specsLists,
  }) {
    List<String> _groups = <String>[];

    for (final SpecList list in specsLists) {
      _groups = TextMod.addStringToListIfDoesNotContainIt(
        strings: _groups,
        stringToAdd: list.groupID,
      );
    }

    return _groups;
  }

// -----------------------------------------------------------------------------
  static List<SpecList> getSpecsListsByFlyerType(FlyerTypeClass.FlyerType flyerType) {
    final List<SpecList> _specList =
    flyerType == FlyerTypeClass.FlyerType.property ? propertySpecLists
        :
    flyerType == FlyerTypeClass.FlyerType.design ? designSpecLists
        :
    flyerType == FlyerTypeClass.FlyerType.craft ? craftSpecLists
        :
    flyerType == FlyerTypeClass.FlyerType.project ? designSpecLists
        :
    flyerType == FlyerTypeClass.FlyerType.product ? productSpecLists
        :
    flyerType == FlyerTypeClass.FlyerType.equipment ? equipmentSpecLists
        :
    <SpecList>[];

    return _specList;
  }
// -----------------------------------------------------------------------------
  static bool specsListsContainSpecList({
    @required SpecList specList,
    @required List<SpecList> specsLists,
  }){
    bool _contains = false;

    if (Mapper.canLoopList(specsLists) == true && specList != null){

      for (int i = 0; i < specsLists.length; i++){

        if (specsLists[i].id == specList.id){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  void blogSpecList(){
    blog('SPEC-LIST-PRINT --------------------------------------------------START');

    blog('id : $id');
    blog('names : $names');
    blog('range : $range');
    blog('specChain : $specChain');
    blog('canPickMany : $canPickMany');
    blog('isRequired : $isRequired');
    blog('groupID : $groupID');
    blog('deactivators : $deactivators');

    blog('SPEC-LIST-PRINT --------------------------------------------------END');
  }
// -----------------------------------------------------------------------------
  static void blogSpecsLists(List<SpecList> specsLists){

    if (Mapper.canLoopList(specsLists)){
      for (final SpecList _list in specsLists){

        _list.blogSpecList();

      }
    }

  }
// -----------------------------------------------------------------------------

  static List<SpecList> propertySpecLists = <SpecList>[

   /*

    // ------------------------------------------------------------
    /// - MAIN SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecList(
        id: 'propertyForm',
        groupID: 'Main Specifications',
        names: RawSpecs.propertyForm.titlePhraseID,
        canPickMany: false,
        isRequired: true,
        deactivators: <SpecDeactivator>[
          SpecDeactivator(
              specValue: 'pf_land',
              specsListsIDsToDeactivate: <String>[
                'propertyArea',
                'propertyAreaUnit'
              ]),
          SpecDeactivator(
              specValue: 'pf_mobile',
              specsListsIDsToDeactivate: <String>[
                'lotArea',
                'lotAreaUnit',
                'propertyFloorNumber',
                'propertyNumberOfBedrooms',
                'propertyNumberOfBathrooms',
                'propertyInACompound'
              ]),
        ],
        range: null,
        specChain: RawSpecs.propertyForm),

    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        groupID: 'Main Specifications',
        names: RawSpecs.propertyLicense.titlePhraseID,
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyLicense),
    // ------------------------------------------------------------
    /// - PROPERTY PRICING SPECIFICATIONS
    // ----------------------------
    /// PROPERTY CONTRACT TYPE
    SpecList(
        id: 'propertyContractType',
        groupID: 'Pricing',
        names: const <Phrase>[
          Phrase(langCode: 'en', value: 'Property contract Type'),
          Phrase(langCode: 'ar', value: 'نوع التعاقد على الغقار')
        ],
        canPickMany: false,
        isRequired: true,
        deactivators: <SpecDeactivator>[
          SpecDeactivator(
              specValue: 'contractType_NewSale',
              specsListsIDsToDeactivate: <String>[
                'propertyRentPrice',
              ]),
          SpecDeactivator(
              specValue: 'contractType_Resale',
              specsListsIDsToDeactivate: <String>[
                'propertyRentPrice',
              ]),
          SpecDeactivator(
              specValue: 'contractType_Rent',
              specsListsIDsToDeactivate: <String>[
                'PropertySalePrice',
              ]),
        ],
        range: null,
        specChain: RawSpecs.contractType),

    /// PROPERTY PAYMENT METHOD
    SpecList(
        id: 'propertyPaymentMethod',
        groupID: 'Pricing',
        names: RawSpecs.paymentMethod.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        deactivators: <SpecDeactivator>[
          SpecDeactivator(
              specValue: 'payment_cash',
              specsListsIDsToDeactivate: <String>[
                'propertyNumberOfInstallments',
                'propertyInstallmentsDuration',
                'propertyInstallmentsDurationUnit'
              ]),
        ],
        specChain: RawSpecs.paymentMethod),

    /// PROPERTY SALE PRICE
    SpecList(
        id: 'PropertySalePrice',
        groupID: 'Pricing',
        names: const <Phrase>[
          Phrase(langCode: 'en', value: 'Property sale price'),
          Phrase(langCode: 'ar', value: 'سعر بيع العقار')
        ],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price),

    /// PROPERTY RENT PRICE
    SpecList(
        id: 'propertyRentPrice',
        groupID: 'Pricing',
        names: const <Phrase>[
          Phrase(langCode: 'en', value: 'Property rent price'),
          Phrase(langCode: 'ar', value: 'سعر إيجار العقار')
        ],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price),

    /// PROPERTY PRICE CURRENCY
    SpecList(
        id: 'currency',
        groupID: 'Pricing',
        names: RawSpecs.currency.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.currency),
    // ------------------------------------------------------------
    /// - INSTALLMENTS
    // ----------------------------
    /// PROPERTY NUMBER OF INSTALLMENTS
    SpecList(
        id: 'propertyNumberOfInstallments',
        groupID: 'Installments',
        names: RawSpecs.numberOfInstallments.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.numberOfInstallments),

    /// PROPERTY INSTALLMENTS DURATION
    SpecList(
        id: 'propertyInstallmentsDuration',
        groupID: 'Installments',
        names: RawSpecs.installmentsDuration.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.installmentsDuration),

    /// PROPERTY INSTALLMENTS DURATION UNIT
    SpecList(
        id: 'propertyInstallmentsDurationUnit',
        groupID: 'Installments',
        names: RawSpecs.installmentsDurationUnit.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.installmentsDurationUnit),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        id: 'propertyArea',
        groupID: 'Property Area',
        names: RawSpecs.propertyArea.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyArea),

    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        groupID: 'Property Area',
        names: RawSpecs.propertyAreaUnit.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyAreaUnit),
    // ------------------------------------------------------------
    /// - LOT AREA
    // ----------------------------
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        groupID: 'Lot Area',
        names: RawSpecs.lotArea.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotArea),

    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        groupID: 'Lot Area',
        names: RawSpecs.lotAreaUnit.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotAreaUnit),
    // ------------------------------------------------------------
    /// - PROPERTY SPATIAL SPECIFICATION
    // ----------------------------
    /// PROPERTY SPACES
    SpecList(
        id: 'propertySpaces',
        groupID: 'Spatial Specifications',
        names: RawSpecs.propertySpaces.titlePhraseID,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertySpaces),

    /// PROPERTY FLOOR NUMBER
    SpecList(
        id: 'propertyFloorNumber',
        groupID: 'Spatial Specifications',
        names: RawSpecs.propertyFloorNumber.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyFloorNumber),

    /// PROPERTY DEDICATED PARKING LOTS COUNT
    SpecList(
        id: 'propertyDedicatedParkingLotsCount',
        groupID: 'Spatial Specifications',
        names: RawSpecs.propertyDedicatedParkingLotsCount.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyDedicatedParkingLotsCount),

    /// PROPERTY NUMBER OF BEDROOMS
    SpecList(
      id: 'propertyNumberOfBedrooms',
      groupID: 'Spatial Specifications',
      names: RawSpecs.propertyNumberOfBedrooms.titlePhraseID,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.propertyNumberOfBedrooms,
    ),

    /// PROPERTY NUMBER OF BATHROOMS
    SpecList(
      id: 'propertyNumberOfBathrooms',
      groupID: 'Spatial Specifications',
      names: RawSpecs.propertyNumberOfBathrooms.titlePhraseID,
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
        names: RawSpecs.propertyView.titlePhraseID,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyView),

    /// PROPERTY INDOOR FEATURES
    SpecList(
        id: 'propertyIndoorFeatures',
        groupID: 'Property Features',
        names: RawSpecs.propertyIndoorFeatures.titlePhraseID,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyIndoorFeatures),

    /// PROPERTY FINISHING LEVEL
    SpecList(
        id: 'propertyFinishingLevel',
        groupID: 'Property Features',
        names: RawSpecs.propertyFinishingLevel.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyFinishingLevel),

    /// PROPERTY DECORATION STYLE
    SpecList(
      id: 'propertyDecorationStyle',
      groupID: 'Property Features',
      names: const <Phrase>[
        Phrase(langCode: 'en', value: 'Property decoration style'),
        Phrase(langCode: 'ar', value: 'الطراز التصميمي لديكور العقار')
      ],
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
        names: RawSpecs.inACompound.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.inACompound),

    /// AMENITIES
    SpecList(
        id: 'propertyAmenities',
        groupID: 'Community Features',
        names: RawSpecs.amenities.titlePhraseID,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.amenities),

    /// COMMUNITY SERVICES
    SpecList(
        id: 'communityServices',
        groupID: 'Community Features',
        names: RawSpecs.communityServices.titlePhraseID,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.communityServices),
    // ------------------------------------------------------------
    /// - BUILDING FEATURES SPECIFICATIONS
    // ----------------------------
    /// BUILDING NUMBER OF FLOORS
    SpecList(
        id: 'buildingNumberOfFloors',
        groupID: 'Building Specifications',
        names: RawSpecs.buildingNumberOfFloors.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingNumberOfFloors),

    /// BUILDING AGE IN YEARS
    SpecList(
        id: 'buildingAgeInYears',
        groupID: 'Building Specifications',
        names: RawSpecs.buildingAgeInYears.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingAgeInYears),

    /// BUILDING TOTAL UNITS COUNTS
    SpecList(
        id: 'buildingTotalUnitsCount',
        groupID: 'Building Specifications',
        names: RawSpecs.buildingTotalUnitsCount.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingTotalUnitsCount),

    /// BUILDING TOTAL PARKING LOTS COUNTS
    SpecList(
        id: 'buildingTotalParkingLotsCount',
        groupID: 'Building Specifications',
        names: RawSpecs.buildingTotalParkingLotsCount.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.buildingTotalParkingLotsCount),
    // ------------------------------------------------------------

    */

  ];

  static List<SpecList> designSpecLists = <SpecList>[

    /*

    // ------------------------------------------------------------
    /// - DESIGN SPECIFICATIONS
    // ----------------------------
    /// DESIGN TYPE
    SpecList(
        id: 'designType',
        groupID: 'Design Specifications',
        names: const <Phrase>[
          Phrase(langCode: 'en', value: 'Design type'),
          Phrase(langCode: 'ar', value: 'نوع التصميم')
        ],
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: ChainDesigns.chain),

    /// DESIGN SPACES
    SpecList(
        id: 'designSpaces',
        groupID: 'Design Specifications',
        names: const <Phrase>[
          Phrase(langCode: 'en', value: 'Design spaces'),
          Phrase(langCode: 'ar', value: 'فراغات التصميم')
        ],
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertySpaces),

    /// DESIGN STYLE
    SpecList(
        id: 'designStyle',
        groupID: 'Design Specifications',
        names: RawSpecs.style.titlePhraseID,
        canPickMany: true,
        isRequired: false,
        range: null,
        specChain: RawSpecs.style),
    // ------------------------------------------------------------
    /// - PROPERTY SPECIFICATIONS
    // ----------------------------
    /// PROPERTY FORM
    SpecList(
        id: 'propertyForm',
        groupID: 'Property Specifications',
        names: RawSpecs.propertyForm.titlePhraseID,
        canPickMany: false,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyForm),

    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        groupID: 'Property Specifications',
        names: RawSpecs.propertyLicense.titlePhraseID,
        canPickMany: true,
        isRequired: true,
        range: null,
        specChain: RawSpecs.propertyLicense),
    // ------------------------------------------------------------
    /// - CONSTRUCTION COST
    // ----------------------------
    /// PROJECT COST
    SpecList(
        id: 'projectCost',
        groupID: 'Construction Cost',
        names: const <Phrase>[
          Phrase(langCode: 'en', value: 'Project cost'),
          Phrase(langCode: 'ar', value: 'تكلفة المشروع')
        ],
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price),

    /// PROJECT COST CURRENCY
    SpecList(
      id: 'currency',
      groupID: 'Construction Cost',
      names: const <Phrase>[
        Phrase(langCode: 'en', value: 'Project cost currency'),
        Phrase(langCode: 'ar', value: 'عملة تكلفة المشروع')
      ],
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.currency,
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION DURATION
    // ----------------------------
    /// Construction DURATION
    SpecList(
      id: 'constructionDuration',
      groupID: 'Construction Duration',
      names: const <Phrase>[
        Phrase(langCode: 'en', value: 'Project duration'),
        Phrase(langCode: 'ar', value: 'زمن تنفيذ المشروع')
      ],
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.duration,
    ),

    /// Construction DURATION UNIT
    SpecList(
      id: 'constructionDurationUnit',
      groupID: 'Construction Duration',
      names: const <Phrase>[
        Phrase(langCode: 'en', value: 'Project duration unit'),
        Phrase(langCode: 'ar', value: 'وحدة قياس زمن تنفيذ المشروع')
      ],
      canPickMany: false,
      isRequired: false,
      range: <String>['day', 'week', 'month', 'year'],
      specChain: RawSpecs.durationUnit,
    ),
    // ------------------------------------------------------------
    /// - CONSTRUCTION ACTIVITIES
    // ----------------------------
    /// CONSTRUCTION ACTIVITIES
    SpecList(
      id: 'constructionActivities',
      groupID: 'Construction Activities',
      names: RawSpecs.constructionActivities.titlePhraseID,
      canPickMany: true,
      isRequired: false,
      range: null,
      specChain: RawSpecs.constructionActivities,
    ),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// PROPERTY AREA
    SpecList(
        id: 'propertyArea',
        groupID: 'Property Area',
        names: RawSpecs.propertyArea.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyArea),

    /// PROPERTY AREA UNIT
    SpecList(
        id: 'propertyAreaUnit',
        groupID: 'Property Area',
        names: RawSpecs.propertyAreaUnit.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.propertyAreaUnit),
    // ------------------------------------------------------------
    /// - PROPERTY AREA
    // ----------------------------
    /// LOT AREA
    SpecList(
        id: 'lotArea',
        groupID: 'Lot Area',
        names: RawSpecs.lotArea.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotArea),

    /// LOT AREA UNIT
    SpecList(
        id: 'lotAreaUnit',
        groupID: 'Lot Area',
        names: RawSpecs.lotAreaUnit.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.lotAreaUnit),
    // ------------------------------------------------------------

     */

  ];

  static List<SpecList> craftSpecLists = <SpecList>[

    /*

    /// CONSTRUCTION ACTIVITY PRICE
    SpecList(
        id: 'constructionActivityPrice',
        groupID: 'Cost',
        names: RawSpecs.price.titlePhraseID,
        canPickMany: false,
        isRequired: false,
        range: null,
        specChain: RawSpecs.price),

    /// CONSTRUCTION ACTIVITY PRICE CURRENCY
    SpecList(
      id: 'currency',
      groupID: 'Cost',
      names: RawSpecs.currency.titlePhraseID,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.currency,
    ),

    /// CONSTRUCTION ACTIVITY MEASUREMENT METHOD
    SpecList(
      id: 'constructionActivityMeasurementMethod',
      groupID: 'Cost',
      names: RawSpecs.constructionActivityMeasurementMethod.titlePhraseID,
      canPickMany: false,
      isRequired: false,
      range: null,
      specChain: RawSpecs.constructionActivityMeasurementMethod,
    ),

  */

  ];

  static List<SpecList> productSpecLists = <SpecList>[];

  static List<SpecList> equipmentSpecLists = <SpecList>[];

}

class SpecDeactivator {
  /// --------------------------------------------------------------------------
  SpecDeactivator({
    @required this.specValue,
    @required this.specsListsIDsToDeactivate,
  });

  /// --------------------------------------------------------------------------
  final String specValue;

  /// when this specValue is selected
  final List<String> specsListsIDsToDeactivate;

  /// all lists with these listsIDs get deactivated
  /// --------------------------------------------------------------------------
}
