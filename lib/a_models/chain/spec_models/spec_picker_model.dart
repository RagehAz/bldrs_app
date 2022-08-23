import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/raw_data/specs/specs_pickers.dart';
import 'package:bldrs/a_models/chain/spec_models/pickers_deactivator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class SpecPicker {
  /// --------------------------------------------------------------------------
  const SpecPicker({
    @required this.chainID,
    @required this.groupID,
    @required this.canPickMany,
    @required this.isRequired,
    this.unitChainID,
    this.range,
    this.deactivators,
  });
  /// --------------------------------------------------------------------------
  final String chainID;
  final String groupID;

  /// can pick many allows selecting either only 1 value from the chain or multiple values
  final bool canPickMany;

  /// this dictates which specs are required for publishing the flyer, and which are optional
  final bool isRequired;
  final List<PickersDeactivator> deactivators;

  /// THE SELECTABLE RANGE allows selecting only parts of the original spec list
  /// if <KW>['id1', 'id2'] only these IDs will be included out of <KW>['id1', 'id2', 'id3', 'id4', 'id5'],
  /// if <int>[1, 5] then only this range is selectable
  final List<dynamic> range;
  /// FOR DATA CREATORS, they require measurement unit like day meter dollar
  final String unitChainID;
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  SpecPicker copyWith({
    String chainID,
    String groupID,
    bool canPickMany,
    bool isRequired,
    List<PickersDeactivator> deactivators,
    List<dynamic> range,
    String unitChainID,
  }){
    return SpecPicker(
      chainID: chainID ?? this.chainID,
      groupID: groupID ?? this.groupID,
      canPickMany: canPickMany ?? this.canPickMany,
      isRequired: isRequired ?? this.isRequired,
      unitChainID: unitChainID ?? this.unitChainID,
      deactivators: deactivators ?? this.deactivators,
      range: range ?? this.range,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHER

// -------------------------------------
///
// -----------------------------------------------------------------------------

  /// MODIFIERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecPicker> applyDeactivatorsToPickers({
    @required List<SpecPicker> sourcePickers,
    @required List<SpecModel> selectedSpecs,
  }) {
    final List<SpecPicker> _pickers = <SpecPicker>[];

    if (Mapper.checkCanLoopList(sourcePickers)) {
      final List<String> _allPickersIDsToDeactivate = <String>[];

      /// GET DEACTIVATED PICKERS
      for (final SpecPicker picker in sourcePickers) {
        final List<PickersDeactivator> _deactivators = picker.deactivators;

        if (Mapper.checkCanLoopList(_deactivators)) {
          for (final PickersDeactivator deactivator in _deactivators) {
            final bool _isSelected = SpecModel.checkSpecsContainThisSpecValue(
                specs: selectedSpecs,
                value: deactivator.value
            );

            if (_isSelected == true) {
              _allPickersIDsToDeactivate.addAll(deactivator.pickersIDsToDeactivate);
            }
          }
        }
      }

      /// REFINE
      for (final SpecPicker picker in sourcePickers) {
        final bool _listShouldBeDeactivated = Stringer.checkStringsContainString(
            strings: _allPickersIDsToDeactivate,
            string: picker.chainID
        );

        if (_listShouldBeDeactivated == false) {
          _pickers.add(picker);
        }
      }
    }

    return _pickers;
  }
// -------------------------------------

  static List<SpecPicker> replacePicker({
    @required List<SpecPicker> sourcePickers,
    @required String pickerChainIDtoReplace,
    @required SpecPicker updatedPicker,
  }){
    List<SpecPicker> _output = <SpecPicker>[];

    if (Mapper.checkCanLoopList(sourcePickers) == true){
      _output = <SpecPicker>[...sourcePickers];

      if (pickerChainIDtoReplace != null && updatedPicker != null){

        final int _index = _output.indexWhere((element){
          return element.chainID == pickerChainIDtoReplace;
        });

        if (_index != -1){

          blog('replacePicker : removing : $pickerChainIDtoReplace');
          _output.removeWhere((element){
            return element.chainID == pickerChainIDtoReplace;
          });

          blog('replacePicker : inserting : ${updatedPicker.chainID}');
          _output.insert(_index, updatedPicker);

        }

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static SpecPicker getPickerByChainIDOrUnitChainID({
    @required List<SpecPicker> pickers,
    @required String chainIDOrUnitChainID,
  }) {

    blog('getPickerFromPickersByChainIDOrUnitChainID : pickerChainID : $chainIDOrUnitChainID');
    // SpecPicker.blogSpecsPickers(specsPickers);

  /// gets the picker where chain ID is the main chain or unit chain ID

    SpecPicker _specPicker;

    if (Mapper.checkCanLoopList(pickers) && chainIDOrUnitChainID != null) {
      _specPicker = pickers.firstWhere(
              (SpecPicker picker) =>
              picker.chainID == chainIDOrUnitChainID
                  ||
              picker.unitChainID == chainIDOrUnitChainID,
          orElse: () => null
      );
    }

    return _specPicker;
  }
// -------------------------------------
  /*
  static int _getSpecPickerIndexByID({
    @required List<SpecPicker> specsPickers,
    @required String specPickerChainID,
  }) {
    final int _index = specsPickers.indexWhere((SpecPicker pick) => pick.chainID == specPickerChainID);
    return _index;
  }
   */
// -------------------------------------
  static List<SpecPicker> getPickersByGroupID({
    @required List<SpecPicker> pickers,
    @required String groupID,
  }) {
    final List<SpecPicker> _specsPicker = <SpecPicker>[];

    if (Mapper.checkCanLoopList(pickers)) {
      for (final SpecPicker list in pickers) {
        if (list.groupID == groupID) {
          _specsPicker.add(list);
        }
      }
    }

    return _specsPicker;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getGroupsIDs({
    @required List<SpecPicker> specsPickers,
  }) {
    List<String> _groups = <String>[];

    for (final SpecPicker picker in specsPickers) {
      _groups = Stringer.addStringToListIfDoesNotContainIt(
        strings: _groups,
        stringToAdd: picker.groupID,
      );
    }

    return _groups;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecPicker> getPickersByFlyerType(FlyerType flyerType) {
    final List<SpecPicker> _specPicker =
    flyerType == FlyerType.property ? propertySpecsPickers
        :
    flyerType == FlyerType.design ? designSpecsPickers
        :
    flyerType == FlyerType.trade ? tradeSpecsPickers
        :
    flyerType == FlyerType.project ? designSpecsPickers
        :
    flyerType == FlyerType.product ? productSpecsPickers
        :
    flyerType == FlyerType.equipment ? equipmentSpecsPickers
        :
    <SpecPicker>[];

    return _specPicker;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecPicker> getPickersByFlyerTypes(List<FlyerType> flyerTypes){
    final List<SpecPicker> _output = <SpecPicker>[];

    if (Mapper.checkCanLoopList(flyerTypes) == true){

      for (final FlyerType type in flyerTypes){

        final List<SpecPicker> _pickers = getPickersByFlyerType(type);
        _output.addAll(_pickers);

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  ///
  static bool checkPickersContainPicker({
    @required SpecPicker picker,
    @required List<SpecPicker> pickers,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(pickers) == true && picker != null) {
      for (int i = 0; i < pickers.length; i++) {

        final SpecPicker _picker = pickers[i];

        // blog('pickersContainPicker : (${pickers.length}) pickers and the index is ( $i ) for picker :-');
        // _picker.blogSpecPicker();

        if (_picker?.chainID == picker.chainID) {
          _contains = true;
          break;
        }
      }
    }

    return _contains;
  }
// -------------------------------------
  ///
  static bool checkPickersAreIdentical({
    @required SpecPicker picker1,
    @required SpecPicker picker2,
  }){
    bool _areIdentical = false;

    if (picker1 == null && picker2 == null){
      _areIdentical = true;
    }
    else if (picker1 != null && picker2 != null){

      if (
          picker1.groupID == picker2.groupID &&
          picker1.chainID == picker2.chainID &&
          picker1.canPickMany == picker2.canPickMany &&
          picker1.isRequired == picker2.isRequired &&
          picker1.unitChainID == picker2.unitChainID &&

          PickersDeactivator.checkDeactivatorsListsAreIdentical(
              deActs1: picker1.deactivators,
              deActs2: picker2.deactivators
          ) == true &&

          Mapper.checkListsAreIdentical(
              list1: picker1.range,
              list2: picker2.range,
          ) == true

      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
// -------------------------------------
  ///
  static bool checkSpecPickersListsAreIdentical({
    @required List<SpecPicker> pickers1,
    @required List<SpecPicker> pickers2,
  }){
    bool _listsAreIdentical = false;

    if (pickers1 == null && pickers2 == null){
      _listsAreIdentical = true;
    }
    else if (pickers1.isEmpty == true && pickers2.isEmpty == true){
      _listsAreIdentical = true;
    }
    else if (Mapper.checkCanLoopList(pickers1) == true && Mapper.checkCanLoopList(pickers2) == true){

      if (pickers1.length != pickers2.length){
        _listsAreIdentical = false;
      }
      else {

        for (int i = 0; i < pickers1.length; i++){

          final SpecPicker _picker1 = pickers1[i];
          final SpecPicker _picker2 = pickers2[i];

          final bool _areIdentical = checkPickersAreIdentical(
            picker1: _picker1,
            picker2: _picker2,
          );

          if (_areIdentical == false){
            _listsAreIdentical = false;
            break;
          }

          _listsAreIdentical = true;

        }

      }

    }

    return _listsAreIdentical;
  }
// -----------------------------------------------------------------------------

  /// BLOGGERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  void blogSpecPicker() {
    blog('SPEC-PICKER-PRINT --------------------------------------------------START');

    blog('chainID : $chainID');
    blog('groupID : $groupID');
    blog('range : $range');
    blog('canPickMany : $canPickMany');
    blog('isRequired : $isRequired');
    blog('unitChainID : $unitChainID');
    blog('deactivators : $deactivators');

    blog('SPEC-PICKER-PRINT --------------------------------------------------END');
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogSpecsPickers(List<SpecPicker> specsPickers) {
    if (Mapper.checkCanLoopList(specsPickers)) {
      for (final SpecPicker _picker in specsPickers) {
        _picker.blogSpecPicker();
      }
    }
  }
// -----------------------------------------------------------------------------

  /// CREATORS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecPicker> createPickersForChainK({
    @required BuildContext context,
    @required Chain chainK,
    @required bool canPickManyOfAPicker,
  }){
    final List<SpecPicker> _pickers = <SpecPicker>[];

    if (chainK != null && Mapper.checkCanLoopList(chainK.sons) == true){

      final List<String> chainKSonsIDs = Chain.getOnlyChainSonsIDs(
        chain: chainK,
      );

      for (final String subChainID in chainKSonsIDs){

        final SpecPicker _picker = SpecPicker(
          chainID: subChainID,
          groupID: FlyerTyper.getGroupIDByFlyerTypeChainID(
            context: context,
            chainID: subChainID,
          ),
          canPickMany: canPickManyOfAPicker,
          isRequired: false,
        );

        _pickers.add(_picker);

      }


    }

    return _pickers;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecPicker> createPickersFromAllChainKs({
    @required bool canPickManyOfAPicker,
    List<FlyerType> onlyUseTheseFlyerTypes,
  }) {

    final List<SpecPicker> allChainKPickers = createAllChainKPickers(
      canPickMany: canPickManyOfAPicker,
    );

    final List<SpecPicker> _specPickers = <SpecPicker>[];

    /// IF SPECIFIC TYPES ARE GIVEN, ADD WHATS ENLISTED
    if (Mapper.checkCanLoopList(onlyUseTheseFlyerTypes) == true){

      for (final SpecPicker picker in allChainKPickers){

        final FlyerType _flyerType = FlyerTyper.concludeFlyerTypeByChainID(
          chainID: picker.chainID,
        );

        final bool _useThisType = onlyUseTheseFlyerTypes.contains(_flyerType);

        if (_useThisType == true){
          _specPickers.add(picker);
        }

      }

    }

    /// IF NO SPECIFIC TYPE GIVEN, ADD ALL
    else {
      _specPickers.addAll(allChainKPickers);
    }

    return _specPickers;
  }

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SpecPicker> createAllChainKPickers({
  @required bool canPickMany,
}){

    return  <SpecPicker>[

      /// PROPERTIES
      SpecPicker(
        chainID: 'phid_k_flyer_type_property',
        groupID: 'RealEstate',
        canPickMany: canPickMany,
        isRequired: false,
      ),

      /// DESIGN
      SpecPicker(
        chainID: 'phid_k_flyer_type_design',
        groupID: 'Construction',
        canPickMany: canPickMany,
        isRequired: false,
      ),

      /// Trades
      SpecPicker(
        chainID: 'phid_k_flyer_type_trades',
        groupID: 'Construction',
        canPickMany: canPickMany,
        isRequired: false,
      ),

      /// PRODUCTS
      SpecPicker(
        chainID: 'phid_k_flyer_type_product',
        groupID: 'Supplies',
        canPickMany: canPickMany,
        isRequired: false,
      ),

      /// PRODUCTS
      SpecPicker(
        chainID: 'phid_k_flyer_type_equipment',
        groupID: 'Supplies',
        canPickMany: canPickMany,
        isRequired: false,
      ),

    ];

  }
// -----------------------------------------------------------------------------

  /// OVERRIDES

// ----------------------------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
// ----------------------------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is SpecPicker){
      _areIdentical = checkPickersAreIdentical(
        picker1: this,
        picker2: other,
      );
    }

    return _areIdentical;
  }
// ----------------------------------------
  @override
  int get hashCode =>
  chainID.hashCode ^
  groupID.hashCode ^
  canPickMany.hashCode ^
  isRequired.hashCode ^
  unitChainID.hashCode ^
  range.hashCode ^
  deactivators.hashCode;
// -----------------------------------------------------------------------------
}

String getSpecPickerChainIDOfPhid({
  @required String phid,
  @required BuildContext context,
}){

  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  final Chain _bigChainK = _chainsProvider.bigChainK;
  final Chain _bigChainS = _chainsProvider.bigChainS;

  final String _rooChainID = Chain.getRootChainIDOfPhid(
    allChains: <Chain>[..._bigChainK.sons, ..._bigChainS.sons],
    phid: phid,
  );

  return _rooChainID;
}

SpecPicker findSpecPickerByPhid({
  @required BuildContext context,
  @required String phid,
  @required List<SpecPicker> allSpecPickers,
}){

  final SpecPicker _picker = SpecPicker.getPickerByChainIDOrUnitChainID(
    pickers: allSpecPickers,
    chainIDOrUnitChainID: getSpecPickerChainIDOfPhid(
      context: context,
      phid: phid,
    ),
  );

  return _picker;
}

List<SpecPicker> findSpecPickersByPhids({
  @required BuildContext context,
  @required List<String> phids,
  @required List<SpecPicker> allSpecPickers,
}){

  final List<SpecPicker> _pickers = <SpecPicker>[];

  if (Mapper.checkCanLoopList(phids) == true && Mapper.checkCanLoopList(allSpecPickers) == true){

    for (final String phid in phids){

      final SpecPicker _picker = findSpecPickerByPhid(
        context: context,
        phid: phid,
        allSpecPickers: allSpecPickers,
      );

      if (_picker != null){
        _pickers.add(_picker);
      }

    }

  }

  return _pickers;
}
