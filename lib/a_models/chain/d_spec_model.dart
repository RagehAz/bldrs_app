import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
//   /// Trades
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

// --------------------------------
  /// TESTED : WORKS PERFECT
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
// --------------------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherSpecs(List<SpecModel> specs) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.checkCanLoopList(specs)) {
      for (final SpecModel spec in specs) {

        final String _key = spec.pickerChainID;

        /// KEY IS NOT DEFINED
        if (_map[_key] == null){
          _map = Mapper.insertPairInMap(
            map: _map,
            key: spec.pickerChainID,
            value: spec.value,
          );
        }

        /// KEY ALREADY DEFINED
        else {

          final dynamic _existingValue = _map[_key];

          if (_existingValue is String){

            final List<String> _list = <String>[_existingValue, spec.value];
            _map[_key] = _list;

          }

          else if (_existingValue is List<String>){
            final List<String> _list = <String>[..._existingValue, spec.value];
            _map[_key] = _list;
          }


        }

      }
    }

    return _map;
  }
// --------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> decipherSpecs(Map<String, dynamic> map) {
    final List<SpecModel> _specs = <SpecModel>[];

    final List<String> _keys = map.keys.toList();

    if (Mapper.checkCanLoopList(_keys)) {
      for (final String key in _keys) {

        final dynamic _value = map[key];

        if (_value is List<dynamic>){

          for (final dynamic val in _value){
            final SpecModel _spec = SpecModel(
              pickerChainID: key,
              value: val,
            );
            _specs.add(_spec);
          }

        }

        else {
          final SpecModel _spec = SpecModel(
            pickerChainID: key,
            value: _value,
          );
          _specs.add(_spec);
        }

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

// --------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsAreIdentical(SpecModel spec1, SpecModel spec2) {
    bool _areIdentical = false;

    if (spec1 == null && spec2 == null){
      _areIdentical = true;
    }
    else if (spec1 != null && spec2 != null) {
      if (spec1.pickerChainID == spec2.pickerChainID) {
        if (spec1.value == spec2.value) {
          _areIdentical = true;
        }
      }
    }

    return _areIdentical;
  }
// --------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsListsAreIdentical(List<SpecModel> specs1, List<SpecModel> specs2) {

    bool _listsAreIdentical = false;

    if (specs1 == null && specs2 == null){
      _listsAreIdentical = true;
    }
    else if (specs1.isEmpty == true && specs2.isEmpty == true){
      _listsAreIdentical = true;
    }
    else if (Mapper.checkCanLoopList(specs1) == true && Mapper.checkCanLoopList(specs2) == true){

      if (specs1.length != specs2.length){
        _listsAreIdentical = false;
      }
      else {

        for (int i = 0; i < specs1.length; i++){

          final SpecModel _spec1 = specs1[i];
          final SpecModel _spec2 = specs2[i];

          final bool _areIdentical = checkSpecsAreIdentical(_spec1, _spec2);

          if (_areIdentical == false){
            _listsAreIdentical = false;
            break;
          }

          _listsAreIdentical = true;

        }

      }

    }

    // blog('specsListsAreIdentical : _listsAreIdentical : $_listsAreIdentical');

    return _listsAreIdentical;
  }
// --------------------------------
  static bool checkSpecsContainThisSpec({
    @required List<SpecModel> specs,
    @required SpecModel spec,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(specs) && spec != null) {
      final SpecModel _result = specs.firstWhere(
              (SpecModel sp) => SpecModel.checkSpecsAreIdentical(sp, spec) == true,
          orElse: () => null);

      if (_result == null) {
        _contains = false;
      } else {
        _contains = true;
      }
    }

    return _contains;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsContainThisSpecValue({
    @required List<SpecModel> specs,
    @required dynamic value,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(specs) && value != null) {
      final List<SpecModel> _specs =
      specs.where((SpecModel spec) => spec.value == value).toList();

      if (_specs.isNotEmpty) {
        _contains = true;
      }
    }

    return _contains;
  }
// --------------------------------
  static bool checkSpecsContainOfSamePickerChainID({
    @required List<SpecModel> specs,
    @required String pickerChainID,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(specs) && pickerChainID != null) {
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
// --------------------------------
  static bool specsContainsNewSale(List<SpecModel> specs) {
    const SpecModel _newSaleSpec = SpecModel(
      pickerChainID: 'propertyContractType',
      value: null,//RawSpecs.newSaleID
    );

    final bool _containsNewSale = SpecModel.checkSpecsContainThisSpec(
      specs: specs,
      spec: _newSaleSpec,
    );

    return _containsNewSale;
  }
// --------------------------------

// --------------------------------
  static bool checkSpecIsFromChainK({
    @required SpecModel spec,
  }){
    bool _isFromKeywords = false;

    if (spec != null){
      _isFromKeywords =  Chain.chainKSonsIDs.contains(spec.pickerChainID);
    }

    return _isFromKeywords;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// --------------------------------
  /// TESTED : WORKS PERFECT
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

// --------------------------------
  /// TESTED : WORKS PERFECT
  void blogSpec() {
    blog('BLOGGING SPEC : specsListID : ( $pickerChainID ) : value : ( ${value.toString()} )');
  }
// --------------------------------
  /// TESTED : WORKS PERFECT
  static void blogSpecs(List<SpecModel> specs) {
    blog('SPECS-PRINT -------------------------------------------------- START');

    if (Mapper.checkCanLoopList(specs) == true){
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

// --------------------------------
  static List<SpecModel> getSpecsRelatedToPicker({
    @required List<SpecModel> specs,
    @required PickerModel picker,
}){
    List<SpecModel> _result = <SpecModel>[];

    if (Mapper.checkCanLoopList(specs) == true && picker != null) {
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
// --------------------------------
  static List<SpecModel> getSpecsByPickerChainID({
    @required List<SpecModel> specs,
    @required String pickerChainID,
  }) {
    List<SpecModel> _result = <SpecModel>[];

    if (Mapper.checkCanLoopList(specs) == true && pickerChainID != null) {
      _result = specs
          .where(
            (SpecModel spec) => spec.pickerChainID == pickerChainID,
          )
          .toList();
    }

    return _result;
  }
// --------------------------------
  static SpecModel getFirstSpecFromSpecsByPickerChainID({
    @required List<SpecModel> specs,
    @required String pickerChainID,
}){
    SpecModel _result;

    if (Mapper.checkCanLoopList(specs) == true && pickerChainID != null) {
      _result = specs
          .firstWhere(
            (SpecModel spec) => spec.pickerChainID == pickerChainID,
        orElse: () => null,
      );
    }

    return _result;
  }
// --------------------------------
  /// TESTED : WORKS PERFECT
  static String translateSpec({
    @required BuildContext context,
    @required SpecModel spec,
  }) {

    final String _name = spec.value is String ?
    spec.value
        :
    spec.value.toString();

    return _name;
  }
// --------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getSpecsIDs(List<SpecModel> specs){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(specs) == true){
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

// --------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> putSpecsInSpecs({
    @required List<SpecModel> parentSpecs,
    @required List<SpecModel> inputSpecs,
    @required bool canPickMany,
  }) {
  /// This considers if the specPicker can or can't pick many spec of same list,
  /// then adds if absent and updates or ignores if exists accordingly
    ///
    final List<SpecModel> _specs = parentSpecs;

    if (Mapper.checkCanLoopList(inputSpecs)) {
      for (final SpecModel inputSpec in inputSpecs) {

        /// A - CAN PICK MANY "of this list ID"
        if (canPickMany == true) {
          final bool _alreadyThere = checkSpecsContainThisSpec(specs: _specs, spec: inputSpec);

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
          final bool _specsContainOfSamePickerChainID = checkSpecsContainOfSamePickerChainID(
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
// --------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> cleanSpecs(List<SpecModel> specs) {
    final List<SpecModel> _output = <SpecModel>[];

    if (Mapper.checkCanLoopList(specs)) {
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

    if (Mapper.checkCanLoopList(specs) == true){
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
    Mapper.checkCanLoopList(_output) == true
        &&
    Mapper.checkCanLoopList(specsToRemove) == true
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

  static List<SpecModel> generateSpecsByPhids({
    @required BuildContext context,
    @required List<String> phids,
  }){
    final List<SpecModel> _specs = <SpecModel>[];

    if (Mapper.checkCanLoopList(phids) == true){

      for (final String phid in phids){

        final String _pickerChainID = getPickerChainIDOfPhid(
          context: context,
          phid: phid,
        );

        if (_pickerChainID != null){


        final SpecModel _spec = SpecModel(
            pickerChainID: _pickerChainID,
            value: phid
        );

        _specs.add(_spec);

        }
      }

    }

    return _specs;
  }


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
