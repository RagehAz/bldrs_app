import 'package:bldrs/a_models/chain/raw_data/specs/specs_pickers.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_deactivator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

class SpecPicker {
  /// --------------------------------------------------------------------------
  SpecPicker({
    @required this.chainID,
    @required this.groupID,
    @required this.canPickMany,
    @required this.isRequired,
    @required this.range,
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

    if (Mapper.canLoopList(sourceSpecsPickers)) {
      final List<String> _allPickersIDsToDeactivate = <String>[];

      /// GET DEACTIVATED PICKERS
      for (final SpecPicker picker in sourceSpecsPickers) {
        final List<SpecDeactivator> _deactivators = picker.deactivators;

        if (Mapper.canLoopList(_deactivators)) {
          for (final SpecDeactivator deactivator in _deactivators) {
            final bool _isSelected = SpecModel.specsContainThisSpecValue(
                specs: selectedSpecs,
                value: deactivator.specValue
            );

            if (_isSelected == true) {
              _allPickersIDsToDeactivate.addAll(deactivator.specsListsIDsToDeactivate);
            }
          }
        }
      }

      /// REFINE
      for (final SpecPicker picker in sourceSpecsPickers) {
        final bool _listShouldBeDeactivated = Mapper.stringsContainString(
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
  static SpecPicker getSpecPickerFromSpecsPickersByChainID({
    @required List<SpecPicker> specsPickers,
    @required String pickerChainID,
  }) {
    SpecPicker _specPicker;

    if (Mapper.canLoopList(specsPickers) && pickerChainID != null) {
      _specPicker = specsPickers.singleWhere(
              (SpecPicker list) => list.chainID == pickerChainID,
          orElse: () => null
      );
    }

    return _specPicker;
  }
// -------------------------------------
  static int _getSpecPickerIndexByID({
    @required List<SpecPicker> specsPickers,
    @required String specPickerChainID,
  }) {
    final int _index = specsPickers.indexWhere((SpecPicker pick) => pick.chainID == specPickerChainID);
    return _index;
  }
// -------------------------------------
  static List<SpecPicker> getSpecsPickersByGroupID({
    @required List<SpecPicker> specsPickers,
    @required String groupID,
  }) {
    final List<SpecPicker> _specsPicker = <SpecPicker>[];

    if (Mapper.canLoopList(specsPickers)) {
      for (final SpecPicker list in specsPickers) {
        if (list.groupID == groupID) {
          _specsPicker.add(list);
        }
      }
    }

    return _specsPicker;
  }
// -------------------------------------
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
  static List<SpecPicker> getSpecsPickersByFlyerType(FlyerTypeClass.FlyerType flyerType) {
    final List<SpecPicker> _specPicker =
    flyerType == FlyerTypeClass.FlyerType.property ? propertySpecsPickers
        :
    flyerType == FlyerTypeClass.FlyerType.design ? designSpecsPickers
        :
    flyerType == FlyerTypeClass.FlyerType.craft ? craftSpecsPickers
        :
    flyerType == FlyerTypeClass.FlyerType.project ? designSpecsPickers
        :
    flyerType == FlyerTypeClass.FlyerType.product ? productSpecsPickers
        :
    flyerType == FlyerTypeClass.FlyerType.equipment ? equipmentSpecsPickers
        :
    <SpecPicker>[];

    return _specPicker;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool specsPickersContainSpecPicker({
    @required SpecPicker specList,
    @required List<SpecPicker> specsLists,
  }) {
    bool _contains = false;

    if (Mapper.canLoopList(specsLists) == true && specList != null) {
      for (int i = 0; i < specsLists.length; i++) {
        if (specsLists[i].chainID == specList.chainID) {
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
  void blogSpecPicker() {
    blog('SPEC-PICKER-PRINT --------------------------------------------------START');

    blog('chainID : $chainID');
    blog('groupID : $groupID');
    blog('range : $range');
    blog('canPickMany : $canPickMany');
    blog('isRequired : $isRequired');
    blog('deactivators : $deactivators');

    blog('SPEC-PICKER-PRINT --------------------------------------------------END');
  }
// -------------------------------------
  static void blogSpecsPickers(List<SpecPicker> specsPickers) {
    if (Mapper.canLoopList(specsPickers)) {
      for (final SpecPicker _picker in specsPickers) {
        _picker.blogSpecPicker();
      }
    }
  }
// -----------------------------------------------------------------------------
}
