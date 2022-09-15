import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/cc_pickers_blocker.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class PickerModel {
  /// --------------------------------------------------------------------------
  const PickerModel({
    @required this.chainID,
    @required this.groupID,
    @required this.index,
    @required this.isHeadline,
    this.canPickMany = false,
    this.isRequired = false,
    this.unitChainID,
    this.range,
    this.blockers,
  });
  /// --------------------------------------------------------------------------
  final String chainID;
  final String groupID;

  /// can pick many allows selecting either only 1 value from the chain or multiple values
  final bool canPickMany;

  /// this dictates which specs are required for publishing the flyer, and which are optional
  final bool isRequired;
  final List<PickersBlocker> blockers;

  /// THE SELECTABLE RANGE allows selecting only parts of the original spec list
  /// if <KW>['id1', 'id2'] only these IDs will be included out of <KW>['id1', 'id2', 'id3', 'id4', 'id5'],
  /// if <int>[1, 5] then only this range is selectable
  final List<String> range;
  /// FOR DATA CREATORS, they require measurement unit like day meter dollar
  final String unitChainID;
  final int index;
  final bool isHeadline;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PickerModel copyWith({
    String chainID,
    String groupID,
    bool canPickMany,
    bool isRequired,
    List<PickersBlocker> blockers,
    List<dynamic> range,
    String unitChainID,
    int index,
    bool isHeadline,
  }){
    return PickerModel(
      chainID: chainID ?? this.chainID,
      groupID: groupID ?? this.groupID,
      canPickMany: canPickMany ?? this.canPickMany,
      isRequired: isRequired ?? this.isRequired,
      unitChainID: unitChainID ?? this.unitChainID,
      blockers: blockers ?? this.blockers,
      range: range ?? this.range,
      index: index ?? this.index,
      isHeadline: isHeadline ?? this.isHeadline,
    );
  }
  // -----------------------------------------------------------------------------

  /// PICKER CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> _toMap({
    bool includeChainID = false,
  }){

    Map<String, dynamic> _output = {
      'groupID': groupID,
      'canPickMany': canPickMany,
      'isRequired': isRequired,
      'blockers': PickersBlocker.cipherBlockers(blockers),
      'range': cipherRange(range),
      'unitChainID': unitChainID,
      'index': index,
      'isHeadline': isHeadline,
    };

    if (includeChainID == true){
      _output = Mapper.insertPairInMap(
        map: _output,
        key: 'chainID',
        value: chainID,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PickerModel decipherPicker({
    @required Map<String, dynamic> map,
    @required String chainID,
  }){
    PickerModel _picker;

    if (map != null){
      _picker = PickerModel(
        chainID: chainID ?? map['chainID'],
        groupID: map['groupID'],
        canPickMany: map['canPickMany'],
        isRequired: map['isRequired'],
        range: decipherRange(map['range']),
        blockers: PickersBlocker.decipherBlockers(map['blockers']),
        unitChainID: map['unitChainID'],
        index: map['index'],
        isHeadline: map['isHeadline'],
      );
    }

    return _picker;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherPickers(List<PickerModel> pickers){
    Map<String, dynamic> _output;

    if (Mapper.checkCanLoopList(pickers) == true){
      _output = {};

      for (final PickerModel picker in pickers){

        _output = Mapper.insertPairInMap(
          map: _output,
          key: picker.chainID,
          value: picker._toMap(
            // includeChainID: false
          ),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> decipherPickers(Map<String, dynamic> bigMap){
    final List<PickerModel> _output = <PickerModel>[];

    if (bigMap != null){

      final List<String> _keys = bigMap.keys.toList();

      Stringer.blogStrings(strings: _keys);

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String chainID in _keys){

          final Map<String, dynamic> _pickerMap = Mapper.getMapFromInternalHashLinkedMapObjectObject(
            internalHashLinkedMapObjectObject: bigMap[chainID],
          );

          final PickerModel _model = decipherPicker(
              map: _pickerMap,
              chainID: chainID
          );

          _output.add(_model);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RANGE CYPHERS

  // --------------------
  static List<String> cipherRange(List<String> range){
    List<String> _output;

    if (Mapper.checkCanLoopList(range) == true){

      _output = <String>[];

      for (final String item in range){
        _output.add(item);
      }

    }

    return _output;
  }
  // --------------------
  static List<dynamic> decipherRange(List<dynamic> dynamics){
    List<dynamic> _output;

    if (Mapper.checkCanLoopList(dynamics) == true){

      _output = Stringer.getStringsFromDynamics(
        dynamics: dynamics,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPickersContainPicker({
    @required PickerModel picker,
    @required List<PickerModel> pickers,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(pickers) == true && picker != null) {
      for (int i = 0; i < pickers.length; i++) {

        final PickerModel _picker = pickers[i];

        if (_picker?.chainID == picker.chainID) {
          _contains = true;
          break;
        }
      }
    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPickersAreIdentical({
    @required PickerModel picker1,
    @required PickerModel picker2,
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

          PickersBlocker.checkBlockersListsAreIdentical(
              blockers1: picker1.blockers,
              blockers2: picker2.blockers
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPickersListsAreIdentical({
    @required List<PickerModel> pickers1,
    @required List<PickerModel> pickers2,
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

          final PickerModel _picker1 = pickers1[i];
          final PickerModel _picker2 = pickers2[i];

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

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPicker({String methodName = 'PICKER'}) {
    blog('PICKER-BLOG : $methodName --------------------------------------------------START');

    blog('isHeadline : $isHeadline');
    blog('index : $index');
    blog('chainID : $chainID');
    blog('groupID : $groupID');
    blog('range : $range');
    blog('canPickMany : $canPickMany');
    blog('isRequired : $isRequired');
    blog('unitChainID : $unitChainID');
    blog('blockers : $blockers');

    blog('PICKER-BLOG : $methodName --------------------------------------------------END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPickers(List<PickerModel> pickers, {String methodName = 'PICKER'}) {

    final List<PickerModel> _pickers = sortPickersByIndexes(pickers);

    if (Mapper.checkCanLoopList(pickers)) {
      for (final PickerModel _picker in _pickers) {
        _picker.blogPicker(methodName: methodName);
      }
    }
    else {
      blog('pickers are empty');
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogIndexes(List<PickerModel> pickers){
    blog('blogIndexes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~start');

    if (Mapper.checkCanLoopList(pickers)) {
      for (final PickerModel _picker in pickers) {

        final String _indent = _picker.isHeadline == true ? '->' : '---->';

        blog('$_indent ${_picker.index} : ${_picker.chainID} : ${_picker.chainID}');
      }
    }
    else {
      blog('pickers are empty');
    }

    blog('blogIndexes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~end');
  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /*
  static List<PickerModel> createPickersForHomeWall({
    @required BuildContext context,
    @required List<Chain> bldrsChains,
    @required bool canPickManyOfAPicker,
  }){
    final List<PickerModel> _pickers = <PickerModel>[];

    if (Mapper.checkCanLoopList(bldrsChains) == true){

      for (final FlyerType flyerType in FlyerTyper.flyerTypesList){

        final String _chainID = PickerModel.getPickersIDByFlyerType(flyerType);

      }

      final List<String> chainKSonsIDs = Chain.getOnlyChainSonsIDs(
        chain: bldrsChains,
      );

      int _index = 0;
      for (final String subChainID in chainKSonsIDs){
        _index++;

        final String _groupID = FlyerTyper.getGroupIDByChainKSonID(
          context: context,
          chainKSonID: subChainID,
        );


        final PickerModel _picker = PickerModel(
          chainID: subChainID,
          groupID: _groupID,
          canPickMany: canPickManyOfAPicker,
          isRequired: false,
          index: _index,
          isHeadline: false,
        );

        _pickers.add(_picker);

      }

    }

    return _pickers;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> createPickersFromAllChainKs({
    @required BuildContext context,
    @required bool canPickManyOfAPicker,
    List<FlyerType> onlyUseTheseFlyerTypes,
  }) {

    final List<PickerModel> allChainKPickers = createHomeWallPickers(
      context: context,
      canPickMany: canPickManyOfAPicker,
    );

    final List<PickerModel> _pickers = <PickerModel>[];

    /// IF SPECIFIC TYPES ARE GIVEN, ADD WHATS ENLISTED
    if (Mapper.checkCanLoopList(onlyUseTheseFlyerTypes) == true){

      for (final PickerModel picker in allChainKPickers){

        final FlyerType _flyerType = FlyerTyper.concludeFlyerTypeByChainID(
          chainID: picker.chainID,
        );

        final bool _useThisType = onlyUseTheseFlyerTypes.contains(_flyerType);

        if (_useThisType == true){
          _pickers.add(picker);
        }

      }

    }

    /// IF NO SPECIFIC TYPE GIVEN, ADD ALL
    else {
      _pickers.addAll(allChainKPickers);
    }

    return _pickers;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> createHomeWallPickers({
    @required BuildContext context,
    @required bool canPickMany,
  }){

    return  <PickerModel>[

      /// PROPERTIES
      PickerModel(
        chainID: FlyerTyper.propertyChainID,
        groupID: FlyerTyper.getGroupIDByChainKSonID(
          context: context,
          chainKSonID: FlyerTyper.propertyChainID,
        ),
        canPickMany: canPickMany,
        index: 0,
        isHeadline: false,
      ),

      /// DESIGN
      PickerModel(
        chainID: FlyerTyper.designChainID,
        groupID: FlyerTyper.getGroupIDByChainKSonID(
          context: context,
          chainKSonID: FlyerTyper.designChainID,
        ),
        canPickMany: canPickMany,
        index: 1,
        isHeadline: false,
      ),

      /// TRADES
      PickerModel(
        chainID: FlyerTyper.tradesChainID,
        groupID: FlyerTyper.getGroupIDByChainKSonID(
          context: context,
          chainKSonID: FlyerTyper.tradesChainID,
        ),
        canPickMany: canPickMany,
        index: 2,
        isHeadline: false,
      ),

      /// PRODUCTS
      PickerModel(
        chainID: FlyerTyper.productChainID,
        groupID: FlyerTyper.getGroupIDByChainKSonID(
          context: context,
          chainKSonID: FlyerTyper.productChainID,
        ),
        canPickMany: canPickMany,
        index: 3,
        isHeadline: false,
      ),

      /// EQUIPMENT
      PickerModel(
        chainID: FlyerTyper.equipmentChainID,
        groupID: FlyerTyper.getGroupIDByChainKSonID(
          context: context,
          chainKSonID: FlyerTyper.equipmentChainID,
        ),
        canPickMany: canPickMany,
        index: 4,
        isHeadline: false,
      ),

    ];

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static  String getPickersIDByFlyerType(FlyerType flyerType){
    return FlyerTyper.cipherFlyerType(flyerType);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PickerModel getPickerByChainIDOrUnitChainID({
    @required List<PickerModel> pickers,
    @required String chainIDOrUnitChainID,
  }) {

    blog('getPickerFromPickersByChainIDOrUnitChainID : pickerChainID : $chainIDOrUnitChainID');
    // SpecPicker.blogSpecsPickers(specsPickers);

    /// gets the picker where chain ID is the main chain or unit chain ID

    PickerModel _specPicker;

    if (Mapper.checkCanLoopList(pickers) && chainIDOrUnitChainID != null) {
      _specPicker = pickers.firstWhere(
              (PickerModel picker) =>
          picker.chainID == chainIDOrUnitChainID
              ||
              picker.unitChainID == chainIDOrUnitChainID,
          orElse: () => null
      );
    }

    return _specPicker;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> getPickersByGroupID({
    @required List<PickerModel> pickers,
    @required String groupID,
  }) {
    final List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(pickers)) {
      for (final PickerModel picker in pickers) {
        if (picker.groupID == groupID) {
          _output.add(picker);
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getGroupsIDs({
    @required List<PickerModel> pickers,
  }) {
    List<String> _groups = <String>[];

    for (final PickerModel picker in pickers) {
      _groups = Stringer.addStringToListIfDoesNotContainIt(
        strings: _groups,
        stringToAdd: picker.groupID,
      );
    }

    return _groups;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> applyBlockersAndSort({
    @required List<PickerModel> sourcePickers,
    @required List<SpecModel> selectedSpecs,
  }) {
    final List<PickerModel> _pickers = <PickerModel>[];

    if (Mapper.checkCanLoopList(sourcePickers)) {
      final List<String> _allPickersIDsToBlock = <String>[];

      /// GET BLOCKED PICKERS
      for (final PickerModel picker in sourcePickers) {
        final List<PickersBlocker> _blockers = picker.blockers;

        if (Mapper.checkCanLoopList(_blockers)) {
          for (final PickersBlocker blocker in _blockers) {
            final bool _isSelected = SpecModel.checkSpecsContainThisSpecValue(
                specs: selectedSpecs,
                value: blocker.value
            );

            if (_isSelected == true) {
              _allPickersIDsToBlock.addAll(blocker.pickersIDsToBlock);
            }
          }
        }
      }

      /// REFINE
      for (final PickerModel picker in sourcePickers) {
        final bool _listShouldBeBlocked = Stringer.checkStringsContainString(
            strings: _allPickersIDsToBlock,
            string: picker.chainID
        );

        if (_listShouldBeBlocked == false) {
          _pickers.add(picker);
        }
      }
    }

    return sortPickersByIndexes(_pickers);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> replacePicker({
    @required List<PickerModel> sourcePickers,
    @required String pickerChainIDtoReplace,
    @required PickerModel updatedPicker,
  }){
    List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(sourcePickers) == true){
      _output = <PickerModel>[...sourcePickers];

      if (pickerChainIDtoReplace != null && updatedPicker != null){

        final int _index = _output.indexWhere((element){
          return element.chainID == pickerChainIDtoReplace;
        });

        if (_index != -1){

          // blog('replacePicker : removing : $pickerChainIDtoReplace');
          _output.removeWhere((element){
            return element.chainID == pickerChainIDtoReplace;
          });

          // blog('replacePicker : inserting : ${updatedPicker.chainID}');
          _output.insert(_index, updatedPicker);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> replaceAGroupID({
    @required List<PickerModel> pickers,
    @required String oldGroupName,
    @required String newGroupName,
  }){
    List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(pickers) == true){

      _output = <PickerModel>[...pickers];

      /// GROUP NAMES ARE GIVEN
      if (
      TextCheck.isEmpty(oldGroupName) == false
          &&
          TextCheck.isEmpty(newGroupName) == false
      ){

        for (final PickerModel picker in pickers){

          if (picker.groupID == oldGroupName){

            final PickerModel _updatedPicker = picker.copyWith(
              groupID: newGroupName,
            );

            _output = replacePicker(
                sourcePickers: _output,
                pickerChainIDtoReplace: picker.chainID,
                updatedPicker: _updatedPicker
            );

          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> sortPickersByIndexes(List<PickerModel> pickers){

    final List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(pickers) == true){

      final List<PickerModel> _pickers = <PickerModel>[... pickers];

      /// SORT PICKERS BY GROUPS INDEXES
      _pickers.sort((PickerModel a, PickerModel b){
        final int _indexA = a.index ?? 0;
        final int _indexB = b.index ?? 0;
        return _indexA.compareTo(_indexB);
      });

      _output.addAll(_pickers);
    }

    return _output; // _correctIndexes(_output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> correctModelsIndexes(List<PickerModel> pickers){
    final List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(pickers) == true) {

      for (int i = 0; i < pickers.length; i++){

        // blog('${pickers[i].chainID} : was ${pickers[i].index} -> now ${i}');

        final PickerModel _picker = pickers[i].copyWith(
          index: i,
        );

        _output.add(_picker);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FINDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getPickerChainIDOfPhid({
    @required String phid,
    @required BuildContext context,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    final String _rooChainID = Chain.getRootChainIDOfPhid(
      allChains: _chainsProvider.bldrsChains,
      phid: phid,
    );

    return _rooChainID;
  }
  // --------------------
  /// FIND PICKERS BY PHIDS
  /*
  static PickerModel _findPickerByPhid({
    @required BuildContext context,
    @required String phid,
    @required List<PickerModel> allPickers,
  }){

    final PickerModel _picker = PickerModel.getPickerByChainIDOrUnitChainID(
      pickers: allPickers,
      chainIDOrUnitChainID: getPickerChainIDOfPhid(
        context: context,
        phid: phid,
      ),
    );

    return _picker;
  }
   */
  // --------------------
  /// FIND PICKER BY PHID
  /*
  static List<PickerModel> _findPickersByPhids({
    @required BuildContext context,
    @required List<String> phids,
    @required List<PickerModel> allPickers,
  }){

    final List<PickerModel> _pickers = <PickerModel>[];

    if (Mapper.checkCanLoopList(phids) == true && Mapper.checkCanLoopList(allPickers) == true){

      for (final String phid in phids){

        final PickerModel _picker = _findPickerByPhid(
          context: context,
          phid: phid,
          allPickers: allPickers,
        );

        if (_picker != null){
          _pickers.add(_picker);
        }

      }

    }

    return _pickers;
  }
   */
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PickerModel){
      _areIdentical = checkPickersAreIdentical(
        picker1: this,
        picker2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      chainID.hashCode ^
      groupID.hashCode ^
      canPickMany.hashCode ^
      isRequired.hashCode ^
      unitChainID.hashCode ^
      range.hashCode ^
      blockers.hashCode;
  // -----------------------------------------------------------------------------
}
