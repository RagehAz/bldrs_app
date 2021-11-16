import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/kw/kw.dart';
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
    return {
      specsListID : value,
    };
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherSpecs(List<Spec> specs){
    Map<String, dynamic> _map = {};

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
    for (var spec in specs){
      print('${spec.specsListID} : ${spec.value}');
    }
    print('SPECS-PRINT -------------------------------------------------- END');
  }
// -----------------------------------------------------------------------------
  static bool specsContainThisSpec({@required List<Spec> specs, @required Spec spec}) {
    bool _contains = false;

    if (Mapper.canLoopList(specs) && spec != null) {
      final Spec _result = specs.firstWhere((sp) =>
      Spec.specsAreTheSame(sp, spec) == true, orElse: () => null);

      _contains = _result == null ? false : true;
    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static bool specsContainThisSpecValue({@required List<Spec> specs, @required dynamic value}){

    bool _contains = false;

    if (Mapper.canLoopList(specs) && value != null){

      final List<Spec> _specs = specs.where((spec) => spec.value == value).toList();

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
  static List<Spec> getSpecsByListID({@required List<Spec> specsList, @required String specsListID}){
    List<Spec> _result = [];

    if (Mapper.canLoopList(specsList) == true && specsListID != null){
      _result = specsList.where((spec) => spec.specsListID == specsListID,).toList();
    }

    return _result;
  }
// -----------------------------------------------------------------------------
  static bool specsContainOfSameListID({@required List<Spec> specs, @required String specsListID}){

    bool _contains = false;

    if (Mapper.canLoopList(specs) && specsListID != null){

      final Spec _result = specs.firstWhere((sp) => sp.specsListID == specsListID, orElse: () => null);

      _contains = _result == null ? false : true;

    }

    return _contains;

  }
// -----------------------------------------------------------------------------
  /// This inserts specs in Parent specs list if absent
  static List<Spec> putSpecsInSpecs({@required List<Spec> parentSpecs, @required List<Spec> childrenSpecs}){
    final List<Spec> _specs = parentSpecs;

    if (Mapper.canLoopList(childrenSpecs)){

      for (Spec spec in childrenSpecs){

        final bool _alreadyThere = specsContainThisSpec(specs: _specs, spec: spec);

        if (_alreadyThere == false){
          _specs.add(spec);
        }

      }

    }

    return _specs;
  }
// -----------------------------------------------------------------------------
  static String getSpecNameFromSpecsLists({@required BuildContext context, @required Spec spec, @required List<SpecList> specsLists}){

    final String _specsListID = spec.specsListID;
    String _name = '${spec.value.toString()}';

    final SpecList _specList = specsLists.singleWhere((list) => list.id == _specsListID, orElse: () => null);

    if (_specList != null){

      final String _kwID = spec.value;

      final List<KW> _kws = _specList.specChain.sons;
      final KW _kw = _kws.singleWhere((kw) => kw.id == _kwID, orElse: ()=> null);

      if (_kw != null){
        _name = Name.getNameByCurrentLingoFromNames(context, _kw.names);
      }

    }

    return _name;
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
