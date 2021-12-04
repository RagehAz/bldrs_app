import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/kw/specs/data_creator.dart';
import 'package:bldrs/models/kw/specs/raw_specs.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/cupertino.dart';

enum SpecType {
    // propertyForm, // from a list
  // propertyLicense, // from a list
  // ------------------------------------------
  // PROPERTY PRICING
  // propertyContractType, // from a List (for sale or rent)
  // propertyPaymentMethod, // from a list
  // propertySalePrice, // double
  // propertyRentPrice, // double
  // propertyRentType, // from a list ( per day per week per month)
  // propertyPriceCurrency, // from a list
  // propertyNumberOfInstallments, // int
  // propertyInstallmentsDuration, // int
  // propertyInstallmentsDurationUnit, // form a list

  // ------------------------------------------
  // PROPERTY AREAS
  // propertyArea, // double
  // propertyAreaUnit, // from a List
  // lotArea,  // from double slider
  // lotAreaUnit, // from a List
  // ------------------------------------------
  // PROPERTY FEATURES
  // propertyView, // from a List
  // numberOfFloor, // int
  // indoorFeatures, // from a List
  // amenities, // from a List
  // additionalServices, // from a list
  // inACompound, // bool
  // finishingLevel, // from a List
  // buildingAgeInYears, // int
  // ------------------------------------------
  // PROPERTY SPACES
  // propertySpaces, // from a list
  // propertyNumberOfParkingLots, // int
  // propertyNumberOfBedrooms, // int
  // propertyNumberOfBathrooms, // int
  // -------------------------------------------------------------------------

  // DESIGNS

  // ------------------------------------------
  // STYLE
  // designArchitecturalStyle, // from a list
  // ------------------------------------------
  // PROPERTY TYPE
  // propertyForm, // from a list
  // propertyLicense, // from a list
  // ------------------------------------------
  /// SPACES
  // propertySpaces, // from a list
  // -------------------------------------------------------------------------

  /// CRAFTS

  // ------------------------------------------
  /// PRICING
  activityPrice, // double
  activityPriceCurrency, // from a list
  activityMeasurementUnit, // form a list (per piece, per unit length, per unit area, per day, per month, ...etc)
  // -------------------------------------------------------------------------

  /// PRODUCTS

  // ------------------------------------------
  /// PRICING
  productContractType, // from a list (for sale or rent)
  productSalePrice, // double
  productRentPrice, // double
  productPriceCurrency, // from a list
  productOldPrice, // double
  productPaymentMethod, // from a list
  productNumberOfInstallments, // int
  productInstallmentCost, // double
  productInstallmentCostCurrency, // from a list
  productInstallmentsDuration, // double
  productInstallmentsDurationUnit, // from a list
  // ------------------------------------------
  /// MEASUREMENTS
  width, // double
  length, // double
  height, // double
  thickness, // double
  diameter, // double
  radius, // double
  dimensionsUnit, // from a list
  volume, // double
  volumeUnit, // from a list
  footPrint, // double
  footPrintUnit, // from a list
  weight, // double
  weightUnit, // from a list
  count, // int
  size, // from list (3x, 2x, xs, s, m, l, xl, 2x, 3x)
  // ------------------------------------------
  /// ELECTRICITY
  wattage, // double
  voltage, // double
  ampere, // double

  // ------------------------------------------
  /// LOGISTICS
  inStock, // bool
  deliverable, // bool
  deliveryCost, // double
  deliveryCostUnit, // from list
  deliveryMinDuration, // double
  deliveryMaxDuration, // double
  deliveryDurationUnit, // from list
  // ------------------------------------------
  /// materials

  productColor, // from a list
  // -------------------------------------------------------------------------
  /// info
  madeIn, // from a list "counties IDs"
  insuranceDuration, // int
  insuranceDurationUnit, // from list
  // -------------------------------------------------------------------------

  /// EQUIPMENT

  // ------------------------------------------

}

/// specs are used only to describe and filter flyers or keywords
class Spec {
  /// specID is the specList's id value, and the key of firebase map
  final String specsListID;
  final dynamic value; // string, int, double, List<String>, List<double>, list<dynamic>

  const Spec({
    @required this.specsListID,
    @required this.value,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    /// shall be saved like this inside flyerModel
    /// specs : {
    /// 'specName' : 'value',
    /// 'weight' : 15,
    /// 'weightUnit' : 'Kg',
    /// 'price' : 160,
    /// 'priceUnit' : 'EGP',
    /// ...
    ///
    /// and should be saved like this in specs docs
    /// 'propertiesSpecs' : {
    ///   'xxx' : {},
    ///   'yyy' : {},
    /// }
    ///
    /// 'numberOfInstallments' : 12,
    /// 'installmentsDuration' : 12,
    /// 'installmentsDurationUnit' : 'months'
    /// },
    return <String, dynamic>{
      specsListID : value,
    };
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherSpecs(List<Spec> specs){
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.canLoopList(specs)){

      for (Spec spec in specs){

        _map = Mapper.insertPairInMap(
          map: _map,
          key: spec.specsListID,
          value: spec.value,
        );

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  Spec clone(){
    return
      Spec(
        specsListID: specsListID,
        value: value,
      );
  }
// -----------------------------------------------------------------------------
  static List<Spec> cloneSpecs(List<Spec> specs){
    final List<Spec> _specs = <Spec>[];

    if (specs != null){
      for (Spec spec in specs){
        _specs.add(spec.clone());
      }
    }

    return _specs;
  }
// -----------------------------------------------------------------------------
//   static String cipherSpecType(SpecType specType){
//     switch (specType) {
//       // case SpecType.width         : return 'width'        ; break;
//       // case SpecType.length        : return 'length'       ; break;
//       // case SpecType.height        : return 'height'       ; break;
//       // case SpecType.volume        : return 'volume'       ; break;
//       // case SpecType.area          : return 'area'         ; break;
//       // case SpecType.count         : return 'count'        ; break;
//       // case SpecType.weight        : return 'weight'       ; break;
//       // case SpecType.oldPrice      : return 'oldPrice'     ; break;
//       // case SpecType.currentPrice  : return 'currentPrice' ; break;
//       // case SpecType.inStock       : return 'inStock' ; break;
//       default :
//         return null;
//     }
//   }
// // -----------------------------------------------------------------------------
//   static SpecType decipherSpecType(String input) {
//     switch (input) {
//       // case 'width':return SpecType.width;break;
//       // case 'length':return SpecType.length;break;
//       // case 'height':return SpecType.height;break;
//       // case 'volume':return SpecType.volume;break;
//       // case 'area':return SpecType.area;break;
//       // case 'count':return SpecType.count;break;
//       // case 'weight':return SpecType.weight;break;
//       // case 'oldPrice' : return SpecType.oldPrice; break;
//       // case 'currentPrice' : return SpecType.currentPrice; break;
//       // case 'inStock' : return SpecType.inStock; break;
//       default :
//         return null;
//     }
//   }
// // -----------------------------------------------------------------------------
//   static String getDataTypeOfSpecType({SpecType specType}){
//     switch (specType) {
//       // case SpecType.width         : return 'double'     ; break;
//       // case SpecType.length        : return 'double'     ; break;
//       // case SpecType.height        : return 'double'     ; break;
//       // case SpecType.volume        : return 'double'     ; break;
//       // case SpecType.area          : return 'double'     ; break;
//       // case SpecType.count         : return 'int'        ; break;
//       // case SpecType.weight        : return 'double'     ; break;
//       // case SpecType.oldPrice      : return 'double'     ; break;
//       // case SpecType.currentPrice  : return 'double'     ; break;
//       // case SpecType.inStock       : return 'bool'     ; break;
//       default :
//         return null;
//     }
//   }
// -----------------------------------------------------------------------------
//   static dynamic assignValueDataTypeAccordingToSpecType({@required SpecType specType, @required String specValueString}){
//     final String _dataType = getDataTypeOfSpecType(specType: specType);
//     dynamic _output;
//
//     if(_dataType == 'double'){
//       final double _value = Numeric.stringToDouble(specValueString);
//       _output = _value;
//     }
//
//     else if (_dataType == 'int'){
//       final int _value = Numeric.stringToInt(specValueString);
//       _output = _value;
//     }
//
//     else if (_dataType == 'String'){
//       final String _value = specValueString;
//       _output = _value;
//     }
//
//     else if (_dataType == 'bool'){
//       final int _boolAsInt = Numeric.stringToInt(specValueString);
//       final bool _value = Numeric.decipherBool(_boolAsInt);
//       _output = _value;
//     }
//
//     return _output;
//   }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static List<Spec> decipherSpecs(Map<String, dynamic> map){
    final List<Spec> _specs = <Spec>[];

    final List<String> _keys = map.keys.toList();

    if(Mapper.canLoopList(_keys)){

      for (String key in _keys){

        final Spec _spec = Spec(
            specsListID: key,
            value: map[key],
        );

        _specs.add(_spec);

      }

    }

    return _specs;
  }
// -----------------------------------------------------------------------------
//   static String cipherSpecValue(Spec spec){
//     final String _dataType = getDataTypeOfSpecType(specType: spec.specType);
//     String _output;
//
//     if(_dataType == 'double'){
//       _output = spec.value.toString();
//     }
//
//     else if (_dataType == 'int'){
//       _output = spec.value.toString();
//     }
//
//     else if (_dataType == 'String'){
//       _output = spec.value;
//     }
//
//     else if (_dataType == 'bool'){
//       final int _valueAsInt = Numeric.cipherBool(spec.value);
//       _output = '$_valueAsInt';
//     }
//
//     return _output;
//
//   }
// -----------------------------------------------------------------------------
  static bool specsAreTheSame(Spec specA, Spec specB){
    bool _areTheSame = false;

    if (specA != null && specB != null){

      if (specA.specsListID == specB.specsListID){

        if (specA.value == specB.value){

          _areTheSame = true;

        }

      }

    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------
  static bool specsListsAreTheSame(List<Spec> specsA, List<Spec> specsB){

    Map<String, dynamic> specsAMap = cipherSpecs(specsA);
    Map<String, dynamic> specsBMap = cipherSpecs(specsB);

    final bool _listsAreTheSame = Mapper.mapsAreTheSame(specsAMap, specsBMap);


    print('specsListsAreTheSame : _listsAreTheSame : ${_listsAreTheSame}');

    return _listsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static List<Spec> dummySpecs(){

    return <Spec>[

      const Spec(specsListID: 'style', value: 'arch_style_arabian'),
      const Spec(specsListID: 'numberOfInstallments', value: 12),
      const Spec(specsListID: 'propertyForm', value: 'pf_fullFloor'),

    ];
  }
// -----------------------------------------------------------------------------
  void printSpec(){
    print('spec is : ${specsListID} : ${value.toString()}');
  }
// -----------------------------------------------------------------------------
  static void printSpecs(List<Spec> specs){
    print('SPECS-PRINT -------------------------------------------------- START');
    for (Spec spec in specs){
      print('${spec.specsListID} : ${spec.value}');
    }
    print('SPECS-PRINT -------------------------------------------------- END');
  }
// -----------------------------------------------------------------------------
  static bool specsContainThisSpec({@required List<Spec> specs, @required Spec spec}) {
    bool _contains = false;

    if (Mapper.canLoopList(specs) && spec != null) {
      final Spec _result = specs.firstWhere((Spec sp) =>
      Spec.specsAreTheSame(sp, spec) == true, orElse: () => null);

      if (_result == null){
        _contains = false;
      }
      else {
        _contains = true;
      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static bool specsContainThisSpecValue({@required List<Spec> specs, @required dynamic value}){

    bool _contains = false;

    if (Mapper.canLoopList(specs) && value != null){

      final List<Spec> _specs = specs.where((Spec spec) => spec.value == value).toList();

      if (_specs.length > 0){
        _contains = true;
      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static Spec getSpecFromKW({@required KW kw, @required String specsListID}){

    final Spec _spec = Spec(
      value: kw.id,
      specsListID: specsListID,
    );

    // _spec.printSpec();

    return _spec;
  }
// -----------------------------------------------------------------------------
  static List<Spec> getSpecsByListID({@required List<Spec> specs, @required String specsListID}){
    List<Spec> _result = <Spec>[];

    if (Mapper.canLoopList(specs) == true && specsListID != null){
      _result = specs.where((Spec spec) => spec.specsListID == specsListID,).toList();
    }

    return _result;
  }
// -----------------------------------------------------------------------------
  static bool specsContainOfSameListID({@required List<Spec> specs, @required String specsListID}){

    bool _contains = false;

    if (Mapper.canLoopList(specs) && specsListID != null){

      final Spec _result = specs.firstWhere((Spec sp) => sp.specsListID == specsListID, orElse: () => null);

      if (_result == null){
        _contains = false;
      }
      else {
        _contains = true;
      }

    }

    return _contains;

  }
// -----------------------------------------------------------------------------
  /// This considers if the specList can or can't pick many spec of same list, then adds if absent and updates or ignores if exists accordingly
  static List<Spec> putSpecsInSpecs({@required List<Spec> parentSpecs, @required List<Spec> inputSpecs, @required bool canPickMany}){
    List<Spec> _specs = parentSpecs;

    if (Mapper.canLoopList(inputSpecs)){

      for (Spec inputSpec in inputSpecs){

        /// A - CAN PICK MANY "of this list ID"
        if (canPickMany == true){

          final bool _alreadyThere = specsContainThisSpec(specs: _specs, spec: inputSpec);

          /// A1 - SPEC ALREADY SELECTED => do nothing
          if (_alreadyThere == true){

          }

          /// A2 - SPEC IS NOT SELECTED => add spec
          else {
            _specs.add(inputSpec);
          }

        }

        /// B - CAN NOT PICK MANY " of this list ID"
        else {

          final bool _specsContainOfSameListID = specsContainOfSameListID(specs: _specs, specsListID: inputSpec.specsListID);

          /// B1 - LIST ID IS ALREADY THERE in [_specs] => REPLACE
          if (_specsContainOfSameListID == true){
              final int _specOfSameListIDIndex = _specs.indexWhere((Spec sp) => sp.specsListID == inputSpec.specsListID);
              _specs[_specOfSameListIDIndex] = inputSpec;
          }

          /// B2 - LIST ID IS NOT THERE in [_specs] => ADD
          else {
              _specs.add(inputSpec);
          }

          // if (_alreadyThere == true){
          //   final int _specIndex = _specs.indexWhere((sp) => Spec.specsAreTheSame(sp, inputSpec));
          //   _specs[_specIndex] = inputSpec;
          // }
          //
          // else {
          //   _specs.add(inputSpec);
          // }

        }

      }

    }

    /// CLEAN SPECS
    _specs = Spec.cleanSpecs(_specs);

    return _specs;
  }
// -----------------------------------------------------------------------------
  static String getSpecNameFromSpecsLists({@required BuildContext context, @required Spec spec, @required List<SpecList> specsLists}){

    final String _specsListID = spec.specsListID;
    String _name = '${spec.value.toString()}';

    final SpecList _specList = specsLists.singleWhere((SpecList list) => list.id == _specsListID, orElse: () => null);

    if (_specList != null && spec.value.runtimeType == String && _specList.specChain.sons.runtimeType != DataCreator){

      final String _kwID = spec.value;

      final List<KW> _kws = KW.getKeywordsFromChain(_specList.specChain); //_specList.specChain.sons;

      if (Mapper.canLoopList(_kws)){
        final KW _kw = _kws.singleWhere((KW kw) => kw.id == _kwID, orElse: ()=> null);

        if (_kw != null){
          _name = Name.getNameByCurrentLingoFromNames(context, _kw.names);
        }
      }

    }

    return _name;
  }
// -----------------------------------------------------------------------------
  static List<Spec> cleanSpecs(List<Spec> specs){

    final List<Spec> _output = <Spec>[];

    if (Mapper.canLoopList(specs)){

      for (Spec spec in specs){

        if (spec != null && spec.value != null && spec.value != 0 && spec.value != '' && spec.specsListID != null && spec.specsListID != ''){
          _output.add(spec);
        }

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
/// ============================================================================

abstract class  SpecsValidator {

  static bool specsContainsNewSale(List<Spec> specs){
    const Spec _newSaleSpec = Spec(specsListID: 'propertyContractType', value: RawSpecs.newSaleID);
    final bool _containsNewSale = Spec.specsContainThisSpec(specs: specs, spec: _newSaleSpec);
    return _containsNewSale;
  }

}
