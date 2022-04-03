import 'package:bldrs/a_models/chain/raw_data/specs/specs_lists.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_deactivator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

class SpecList {
  /// --------------------------------------------------------------------------
  SpecList({
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
                specs: selectedSpecs,
                value: deactivator.specValue
            );

            if (_isSelected == true) {
              _allListsIDsToDeactivate.addAll(deactivator.specsListsIDsToDeactivate);
            }
          }
        }
      }

      /// REFINE
      for (final SpecList list in sourceSpecsLists) {
        final bool _listShouldBeDeactivated = Mapper.stringsContainString(
            strings: _allListsIDsToDeactivate,
            string: list.chainID
        );

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
              (SpecList list) => list.chainID == specListID,
          orElse: () => null
      );
    }

    return _specList;
  }
// -----------------------------------------------------------------------------
  static int getSpecsListIndexByID({
    @required List<SpecList> specsLists,
    @required String specsListID,
  }) {
    final int _index = specsLists.indexWhere((SpecList list) => list.chainID == specsListID);
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
  void blogSpecList() {
    blog('SPEC-LIST-PRINT --------------------------------------------------START');

    blog('id : $chainID');
    blog('range : $range');
    blog('canPickMany : $canPickMany');
    blog('isRequired : $isRequired');
    blog('groupID : $groupID');
    blog('deactivators : $deactivators');

    blog('SPEC-LIST-PRINT --------------------------------------------------END');
  }
// -----------------------------------------------------------------------------
  static void blogSpecsLists(List<SpecList> specsLists) {
    if (Mapper.canLoopList(specsLists)) {
      for (final SpecList _list in specsLists) {
        _list.blogSpecList();
      }
    }
  }
// -----------------------------------------------------------------------------
}
