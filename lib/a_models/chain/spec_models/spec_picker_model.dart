import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/raw_data/specs/specs_pickers.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_deactivator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

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
  final List<SpecDeactivator> deactivators;

  /// THE SELECTABLE RANGE allows selecting only parts of the original spec list
  /// if <KW>['id1', 'id2'] only these IDs will be included,
  /// if <int>[1, 5] then only this range is selectable
  final List<dynamic> range;
  /// FOR DATA CREATORS, they require measurement unit like day meter dollar
  final String unitChainID;
// -----------------------------------------------------------------------------

  /// CYPHER

// -------------------------------------

// -----------------------------------------------------------------------------

  /// MODIFIERS

// -------------------------------------
  static List<SpecPicker> applyDeactivatorsToSpecsPickers({
    @required List<SpecPicker> sourceSpecsPickers,
    @required List<SpecModel> selectedSpecs,
  }) {
    final List<SpecPicker> _pickers = <SpecPicker>[];

    if (Mapper.checkCanLoopList(sourceSpecsPickers)) {
      final List<String> _allPickersIDsToDeactivate = <String>[];

      /// GET DEACTIVATED PICKERS
      for (final SpecPicker picker in sourceSpecsPickers) {
        final List<SpecDeactivator> _deactivators = picker.deactivators;

        if (Mapper.checkCanLoopList(_deactivators)) {
          for (final SpecDeactivator deactivator in _deactivators) {
            final bool _isSelected = SpecModel.checkSpecsContainThisSpecValue(
                specs: selectedSpecs,
                value: deactivator.specValueThatDeactivatesSpecsLists
            );

            if (_isSelected == true) {
              _allPickersIDsToDeactivate.addAll(deactivator.specsListsIDsToDeactivate);
            }
          }
        }
      }

      /// REFINE
      for (final SpecPicker picker in sourceSpecsPickers) {
        final bool _listShouldBeDeactivated = Mapper.checkStringsContainString(
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
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static SpecPicker getPickerFromPickersByChainIDOrUnitChainID({
    @required List<SpecPicker> specsPickers,
    @required String pickerChainID,
  }) {

  /// gets the picker where chain ID is the main chain or unit chain ID

    SpecPicker _specPicker;

    if (Mapper.checkCanLoopList(specsPickers) && pickerChainID != null) {
      _specPicker = specsPickers.firstWhere(
              (SpecPicker picker) =>
              picker.chainID == pickerChainID
                  ||
              picker.unitChainID == pickerChainID,
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
  static List<SpecPicker> getSpecsPickersByGroupID({
    @required List<SpecPicker> specsPickers,
    @required String groupID,
  }) {
    final List<SpecPicker> _specsPicker = <SpecPicker>[];

    if (Mapper.checkCanLoopList(specsPickers)) {
      for (final SpecPicker list in specsPickers) {
        if (list.groupID == groupID) {
          _specsPicker.add(list);
        }
      }
    }

    return _specsPicker;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getGroupsFromSpecsPickers({
    @required List<SpecPicker> specsPickers,
  }) {
    List<String> _groups = <String>[];

    for (final SpecPicker picker in specsPickers) {
      _groups = TextMod.addStringToListIfDoesNotContainIt(
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
    flyerType == FlyerType.craft ? craftSpecsPickers
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
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool pickersContainPicker({
    @required SpecPicker picker,
    @required List<SpecPicker> pickers,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(pickers) == true && picker != null) {
      for (int i = 0; i < pickers.length; i++) {

        final SpecPicker _picker = pickers[i];

        // blog('pickersContainPicker : (${pickers.length}) pickers and the index is ( $i ) for picker :-');
        // _picker.blogSpecPicker();

        if (_picker.chainID == picker.chainID) {
          _contains = true;
          break;
        }
      }
    }

    return _contains;
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
  static List<SpecPicker> createPickersForChainK({
    @required BuildContext context,
    @required Chain chainK,
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
          canPickMany: false,
          isRequired: false,
        );

        _pickers.add(_picker);

      }


    }

    return _pickers;
  }

  static List<SpecPicker> createPickersFromAllChainKs() {
    const List<SpecPicker> _specPicker = <SpecPicker>[

      /// PROPERTIES
      SpecPicker(
        chainID: 'phid_k_flyer_type_property',
        groupID: 'RealEstate',
        canPickMany: false,
        isRequired: false,
      ),

      /// DESIGN
      SpecPicker(
        chainID: 'phid_k_flyer_type_design',
        groupID: 'Construction',
        canPickMany: false,
        isRequired: false,
      ),

      /// CRAFTS
      SpecPicker(
        chainID: 'phid_k_flyer_type_crafts',
        groupID: 'Construction',
        canPickMany: false,
        isRequired: false,
      ),

      /// PRODUCTS
      SpecPicker(
        chainID: 'phid_k_flyer_type_product',
        groupID: 'Supplies',
        canPickMany: false,
        isRequired: false,
      ),

      /// PRODUCTS
      SpecPicker(
        chainID: 'phid_k_flyer_type_equipment',
        groupID: 'Supplies',
        canPickMany: false,
        isRequired: false,
      ),

    ];

    return _specPicker;

  }
// -----------------------------------------------------------------------------
}
