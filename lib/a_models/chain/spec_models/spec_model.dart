import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

// enum SpecType {
//   // propertyForm, // from a list
//   // propertyLicense, // from a list
//   // ------------------------------------------
//   // PROPERTY PRICING
//   // propertyContractType, // from a List (for sale or rent)
//   // propertyPaymentMethod, // from a list
//   // propertySalePrice, // double
//   // propertyRentPrice, // double
//   // propertyRentType, // from a list ( per day per week per month)
//   // propertyPriceCurrency, // from a list
//   // propertyNumberOfInstallments, // int
//   // propertyInstallmentsDuration, // int
//   // propertyInstallmentsDurationUnit, // form a list
//
//   // ------------------------------------------
//   // PROPERTY AREAS
//   // propertyArea, // double
//   // propertyAreaUnit, // from a List
//   // lotArea,  // from double slider
//   // lotAreaUnit, // from a List
//   // ------------------------------------------
//   // PROPERTY FEATURES
//   // propertyView, // from a List
//   // numberOfFloor, // int
//   // indoorFeatures, // from a List
//   // amenities, // from a List
//   // additionalServices, // from a list
//   // inACompound, // bool
//   // finishingLevel, // from a List
//   // buildingAgeInYears, // int
//   // ------------------------------------------
//   // PROPERTY SPACES
//   // propertySpaces, // from a list
//   // propertyNumberOfParkingLots, // int
//   // propertyNumberOfBedrooms, // int
//   // propertyNumberOfBathrooms, // int
//   // -------------------------------------------------------------------------
//
//   // DESIGNS
//
//   // ------------------------------------------
//   // STYLE
//   // designArchitecturalStyle, // from a list
//   // ------------------------------------------
//   // PROPERTY TYPE
//   // propertyForm, // from a list
//   // propertyLicense, // from a list
//   // ------------------------------------------
//   /// SPACES
//   // propertySpaces, // from a list
//   // -------------------------------------------------------------------------
//
//   /// CRAFTS
//
//   // ------------------------------------------
//   /// PRICING
//   activityPrice, // double
//   activityPriceCurrency, // from a list
//   activityMeasurementUnit, // form a list (per piece, per unit length, per unit area, per day, per month, ...etc)
//   // -------------------------------------------------------------------------
//
//   /// PRODUCTS
//
//   // ------------------------------------------
//   /// PRICING
//   productContractType, // from a list (for sale or rent)
//   productSalePrice, // double
//   productRentPrice, // double
//   productPriceCurrency, // from a list
//   productOldPrice, // double
//   productPaymentMethod, // from a list
//   productNumberOfInstallments, // int
//   productInstallmentCost, // double
//   productInstallmentCostCurrency, // from a list
//   productInstallmentsDuration, // double
//   productInstallmentsDurationUnit, // from a list
//   // ------------------------------------------
//   /// MEASUREMENTS
//   width, // double
//   length, // double
//   height, // double
//   thickness, // double
//   diameter, // double
//   radius, // double
//   dimensionsUnit, // from a list
//   volume, // double
//   volumeUnit, // from a list
//   footPrint, // double
//   footPrintUnit, // from a list
//   weight, // double
//   weightUnit, // from a list
//   count, // int
//   size, // from list (3x, 2x, xs, s, m, l, xl, 2x, 3x)
//   // ------------------------------------------
//   /// ELECTRICITY
//   wattage, // double
//   voltage, // double
//   ampere, // double
//
//   // ------------------------------------------
//   /// LOGISTICS
//   inStock, // bool
//   deliverable, // bool
//   deliveryCost, // double
//   deliveryCostUnit, // from list
//   deliveryMinDuration, // double
//   deliveryMaxDuration, // double
//   deliveryDurationUnit, // from list
//   // ------------------------------------------
//   /// materials
//
//   productColor, // from a list
//   // -------------------------------------------------------------------------
//   /// info
//   madeIn, // from a list "counties IDs"
//   insuranceDuration, // int
//   insuranceDurationUnit, // from list
//   // -------------------------------------------------------------------------
//
//   /// EQUIPMENT
//
//   // ------------------------------------------
//
// }

class SpecModel {
// -----------------------------------------------------------------------------

  /// CONSTRUCTOR

// ------------------------------------------
  const SpecModel({
    @required this.pickerChainID,
    @required this.value,
  });
// ------------------------------------------
  /// specID is the specPicker's chain id , and the key of firebase map
  final String pickerChainID;
  /// string, int, double, List<String>, List<double>, list<dynamic>
  final dynamic value;
// -----------------------------------------------------------------------------

  /// CYPHERS

// ------------------------------------------
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
      pickerChainID: value,
    };
  }
// ------------------------------------------
  static Map<String, dynamic> cipherSpecs(List<SpecModel> specs) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.canLoopList(specs)) {
      for (final SpecModel spec in specs) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: spec.pickerChainID,
          value: spec.value,
        );
      }
    }

    return _map;
  }
// ------------------------------------------
  static List<SpecModel> decipherSpecs(Map<String, dynamic> map) {
    final List<SpecModel> _specs = <SpecModel>[];

    final List<String> _keys = map.keys.toList();

    if (Mapper.canLoopList(_keys)) {
      for (final String key in _keys) {
        final SpecModel _spec = SpecModel(
          pickerChainID: key,
          value: map[key],
        );

        _specs.add(_spec);
      }
    }

    return _specs;
  }
// -----------------------------------------------------------------------------

  /// CLONING

// ------------------------------------------
  SpecModel clone() {
    return SpecModel(
      pickerChainID: pickerChainID,
      value: value,
    );
  }
// ------------------------------------------
  static List<SpecModel> cloneSpecs(List<SpecModel> specs) {
    final List<SpecModel> _specs = <SpecModel>[];

    if (specs != null) {
      for (final SpecModel spec in specs) {
        _specs.add(spec.clone());
      }
    }

    return _specs;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// ------------------------------------------
  static bool specsAreTheSame(SpecModel specA, SpecModel specB) {
    bool _areTheSame = false;

    if (specA != null && specB != null) {
      if (specA.pickerChainID == specB.pickerChainID) {
        if (specA.value == specB.value) {
          _areTheSame = true;
        }
      }
    }

    return _areTheSame;
  }
// ------------------------------------------
  static bool specsListsAreTheSame(List<SpecModel> specsA, List<SpecModel> specsB) {
    final Map<String, dynamic> specsAMap = cipherSpecs(specsA);
    final Map<String, dynamic> specsBMap = cipherSpecs(specsB);

    final bool _listsAreTheSame = Mapper.mapsAreTheSame(
        map1: specsAMap,
        map2: specsBMap,
    );

    blog('specsListsAreTheSame : _listsAreTheSame : $_listsAreTheSame');

    return _listsAreTheSame;
  }
// ------------------------------------------
  static bool specsContainThisSpec({
    @required List<SpecModel> specs,
    @required SpecModel spec,
  }) {
    bool _contains = false;

    if (Mapper.canLoopList(specs) && spec != null) {
      final SpecModel _result = specs.firstWhere(
              (SpecModel sp) => SpecModel.specsAreTheSame(sp, spec) == true,
          orElse: () => null);

      if (_result == null) {
        _contains = false;
      } else {
        _contains = true;
      }
    }

    return _contains;
  }
// ------------------------------------------
  static bool specsContainThisSpecValue({
    @required List<SpecModel> specs,
    @required dynamic value,
  }) {
    bool _contains = false;

    if (Mapper.canLoopList(specs) && value != null) {
      final List<SpecModel> _specs =
      specs.where((SpecModel spec) => spec.value == value).toList();

      if (_specs.isNotEmpty) {
        _contains = true;
      }
    }

    return _contains;
  }
// ------------------------------------------
  static bool specsContainOfSamePickerChainID({
    @required List<SpecModel> specs,
    @required String pickerChainID,
  }) {
    bool _contains = false;

    if (Mapper.canLoopList(specs) && pickerChainID != null) {
      final SpecModel _result = specs.firstWhere(
              (SpecModel sp) => sp.pickerChainID == pickerChainID,
          orElse: () => null);

      if (_result == null) {
        _contains = false;
      } else {
        _contains = true;
      }
    }

    return _contains;
  }
// ------------------------------------------
  static bool specsContainsNewSale(List<SpecModel> specs) {
    const SpecModel _newSaleSpec = SpecModel(
      pickerChainID: 'propertyContractType',
      value: null,//RawSpecs.newSaleID
    );

    final bool _containsNewSale = SpecModel.specsContainThisSpec(
      specs: specs,
      spec: _newSaleSpec,
    );

    return _containsNewSale;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// ------------------------------------------
  static List<SpecModel> dummySpecs() {
    return <SpecModel>[
      const SpecModel(pickerChainID: 'phid_s_propertyLicense', value: 'phid_k_ppt_lic_residential'),
      const SpecModel(pickerChainID: 'phid_s_propertyView', value: 'phid_s_view_lake'),
      const SpecModel(pickerChainID: 'phid_s_propertyIndoorFeatures', value: 'phid_s_pFeature_builtinWardrobe'),
      const SpecModel(pickerChainID: 'phid_s_propertyIndoorFeatures', value: 'phid_s_pFeature_energyEfficient'),
      const SpecModel(pickerChainID: 'phid_s_propertyIndoorFeatures', value: 'phid_s_pFeature_elevator'),
      const SpecModel(pickerChainID: 'phid_s_propertyIndoorFeatures', value: 'phid_s_pFeature_intercom'),

      const SpecModel(pickerChainID: 'propertyForm', value: 'pf_halfFloor'),
    ];
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// ------------------------------------------
  void blogSpec() {
    blog('BLOGGING SPEC : specsListID : ( $pickerChainID ) : value : ( ${value.toString()} )');
  }
// -----------------------------------------------------------------------------
  static void blogSpecs(List<SpecModel> specs) {
    blog('SPECS-PRINT -------------------------------------------------- START');

    if (Mapper.canLoopList(specs) == true){
      for (final SpecModel spec in specs) {
        blog('${spec.pickerChainID} : ${spec.value}');
      }
    }
    else{
      blog('No specs to blog');
    }

    blog('SPECS-PRINT -------------------------------------------------- END');
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// ------------------------------------------
  static List<SpecModel> getSpecsRelatedToPicker({
    @required List<SpecModel> specs,
    @required SpecPicker picker,
}){
    List<SpecModel> _result = <SpecModel>[];

    if (Mapper.canLoopList(specs) == true && picker != null) {
      _result = specs
          .where(
            (SpecModel spec) =>
            spec.pickerChainID == picker.chainID
                ||
                spec.pickerChainID == picker.unitChainID,
      )
          .toList();
    }

    return _result;
  }
// ------------------------------------------
  static List<SpecModel> getSpecsByPickerChainID({
    @required List<SpecModel> specs,
    @required String pickerChainID,
  }) {
    List<SpecModel> _result = <SpecModel>[];

    if (Mapper.canLoopList(specs) == true && pickerChainID != null) {
      _result = specs
          .where(
            (SpecModel spec) => spec.pickerChainID == pickerChainID,
          )
          .toList();
    }

    return _result;
  }
// ------------------------------------------
  static SpecModel getFirstSpecFromSpecsByPickerChainID({
    @required List<SpecModel> specs,
    @required String pickerChainID,
}){
    SpecModel _result;

    if (Mapper.canLoopList(specs) == true && pickerChainID != null) {
      _result = specs
          .firstWhere(
            (SpecModel spec) => spec.pickerChainID == pickerChainID,
        orElse: () => null,
      );
    }

    return _result;
  }
// ------------------------------------------
  static String translateSpec({
    @required BuildContext context,
    @required SpecModel spec,
  }) {

    final String _name = spec.value is String ?
    superPhrase(context, spec.value)
        :
    spec.value.toString();

    return _name;
  }
// ------------------------------------------
  static List<String> getSpecsIDs(List<SpecModel> specs){
    final List<String> _output = <String>[];

    if (Mapper.canLoopList(specs) == true){
      for (final SpecModel spec in specs){

        if (spec.value is String){
          _output.add(spec.value);
        }

      }
    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ------------------------------------------
  static List<SpecModel> putSpecsInSpecs({
    @required List<SpecModel> parentSpecs,
    @required List<SpecModel> inputSpecs,
    @required bool canPickMany,
  }) {
  /// This considers if the specPicker can or can't pick many spec of same list,
  /// then adds if absent and updates or ignores if exists accordingly
    ///
    final List<SpecModel> _specs = parentSpecs;

    if (Mapper.canLoopList(inputSpecs)) {
      for (final SpecModel inputSpec in inputSpecs) {

        /// A - CAN PICK MANY "of this list ID"
        if (canPickMany == true) {
          final bool _alreadyThere =
              specsContainThisSpec(specs: _specs, spec: inputSpec);

          /// A1 - SPEC ALREADY SELECTED => do nothing
          if (_alreadyThere == true) {
          }

          /// A2 - SPEC IS NOT SELECTED => add spec
          else {
            _specs.add(inputSpec);
          }
        }

        /// B - CAN NOT PICK MANY " of this list ID"
        else {
          final bool _specsContainOfSamePickerChainID = specsContainOfSamePickerChainID(
              specs: _specs,
              pickerChainID: inputSpec.pickerChainID,
          );

          /// B1 - LIST ID IS ALREADY THERE in [_specs] => REPLACE
          if (_specsContainOfSamePickerChainID == true) {
            final int _specOfSameListIDIndex = _specs.indexWhere(
                (SpecModel sp) => sp.pickerChainID == inputSpec.pickerChainID);
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

    return SpecModel.cleanSpecs(_specs);
  }
// ------------------------------------------
  static List<SpecModel> cleanSpecs(List<SpecModel> specs) {
    final List<SpecModel> _output = <SpecModel>[];

    if (Mapper.canLoopList(specs)) {
      for (final SpecModel spec in specs) {
        if (spec != null &&
            spec.value != null &&
            spec.value != 0 &&
            spec.value != '' &&
            spec.pickerChainID != null &&
            spec.pickerChainID != '') {
          _output.add(spec);
        }
      }
    }

    return _output;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> removeSpecFromSpecs({
  @required List<SpecModel> specs,
  @required SpecModel spec,
}){

    List<SpecModel> _output = <SpecModel>[];

    if (Mapper.canLoopList(specs) == true){
      _output = <SpecModel>[...specs];

      _output.remove(spec);

    }

    return _output;

  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> removeSpecsFromSpecs({
    @required List<SpecModel> sourceSpecs,
    @required List<SpecModel> specsToRemove,
}){

    blog('removeSpecsFromSpecs : removing : ${specsToRemove.length}');

    List<SpecModel> _output = <SpecModel>[...sourceSpecs];

    if (
    Mapper.canLoopList(_output) == true
        &&
    Mapper.canLoopList(specsToRemove) == true
    ){

      blog('removeSpecsFromSpecs : can remove them');

      for (final SpecModel specToRemove in specsToRemove){

        blog('removeSpecsFromSpecs : removing : ${specToRemove.value} ');

        _output = removeSpecFromSpecs(
            specs: _output,
            spec: specToRemove
        );

      }

    }

    blog('and the output had become :-');
    SpecModel.blogSpecs(_output);

    return _output;
}
// -----------------------------------------------------------------------------
}

/*

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


 */
