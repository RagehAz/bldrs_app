import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/cc_pickers_blocker.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class PickerModel {
  /// --------------------------------------------------------------------------
  const PickerModel({
    required this.chainID,
    required this.index,
    required this.isHeadline,
    this.canPickMany = false,
    this.isRequired = false,
    this.unitChainID,
    this.range,
    this.blockers,
  });
  /// --------------------------------------------------------------------------
  final String? chainID;

  /// can pick many allows selecting either only 1 value from the chain or multiple values
  final bool? canPickMany;

  /// this dictates which specs are required for publishing the flyer, and which are optional
  final bool? isRequired;
  final List<PickersBlocker>? blockers;

  /// THE SELECTABLE RANGE allows selecting only parts of the original spec list
  /// if <KW>['id1', 'id2'] only these IDs will be included out of <KW>['id1', 'id2', 'id3', 'id4', 'id5'],
  /// if <int>[1, 5] then only this range is selectable
  final List<dynamic>? range;
  /// FOR DATA CREATORS, they require measurement unit like day meter dollar
  final String? unitChainID;
  final int? index;
  final bool? isHeadline;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PickerModel copyWith({
    String? chainID,
    String? groupID,
    bool? canPickMany,
    bool? isRequired,
    List<PickersBlocker>? blockers,
    List<dynamic>? range,
    String? unitChainID,
    int? index,
    bool? isHeadline,
  }){
    return PickerModel(
      chainID: chainID ?? this.chainID,
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
        overrideExisting: true,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PickerModel? decipherPicker({
    required Map<String, dynamic>? map,
    required String? chainID,
  }){
    PickerModel? _picker;

    if (map != null){
      _picker = PickerModel(
        chainID: chainID ?? map['chainID'],
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
  static Map<String, dynamic>? cipherPickers(List<PickerModel>? pickers){
    Map<String, dynamic>? _output;

    if (Lister.checkCanLoopList(pickers) == true){
      _output = {};

      for (final PickerModel picker in pickers!){

        _output = Mapper.insertPairInMap(
          map: _output,
          key: picker.chainID,
          value: picker._toMap(
            // includeChainID: false
          ),
          overrideExisting: true,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> decipherPickers(Map<String, dynamic>? bigMap){
    final List<PickerModel> _output = <PickerModel>[];

    if (bigMap != null){

      final List<String> _keys = bigMap.keys.toList();

      // Stringer.blogStrings(
      //   strings: _keys,
      //   invoker: decipherPickers,
      // );

      if (Lister.checkCanLoopList(_keys) == true){

        for (final String chainID in _keys){


          Map<String, dynamic>? _pickerMap;

          if (bigMap[chainID] is String){
          // blog('getMapFromIHLMOO : bigMap[chainID] : ${bigMap[chainID].runtimeType} : ${bigMap[chainID]}');
            _pickerMap = {chainID : bigMap[chainID]};
          }
          else {
            _pickerMap = Mapper.getMapFromIHLMOO(
              ihlmoo: bigMap[chainID],
            );
          }

          final PickerModel? _model = decipherPicker(
              map: _pickerMap,
              chainID: chainID
          );

          if (_model != null){
            _output.add(_model);
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// RANGE CYPHERS

  // --------------------
  /// TASK : TEST ME
  static List<dynamic> cipherRange(List<dynamic>? range){
    List<dynamic> _output = [];

    if (Lister.checkCanLoopList(range) == true){

      _output = <dynamic>[];

      for (final String item in range!){
        _output.add(item);
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<dynamic> decipherRange(List<dynamic>? dynamics){
    List<dynamic> _output = [];

    if (Lister.checkCanLoopList(dynamics) == true){

      _output = Stringer.getStringsFromDynamics(dynamics);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPickersContainPicker({
    required PickerModel? picker,
    required List<PickerModel>? pickers,
  }) {
    bool _contains = false;

    if (Lister.checkCanLoopList(pickers) == true && picker != null) {
      for (int i = 0; i < pickers!.length; i++) {

        final PickerModel _picker = pickers[i];

        if (_picker.chainID == picker.chainID) {
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
    required PickerModel? picker1,
    required PickerModel? picker2,
  }){
    bool _areIdentical = false;

    if (picker1 == null && picker2 == null){
      _areIdentical = true;
    }
    else if (picker1 != null && picker2 != null){

      if (
          picker1.chainID == picker2.chainID &&
          picker1.canPickMany == picker2.canPickMany &&
          picker1.isRequired == picker2.isRequired &&
          picker1.unitChainID == picker2.unitChainID &&

          PickersBlocker.checkBlockersListsAreIdentical(
              blockers1: picker1.blockers,
              blockers2: picker2.blockers
          ) == true &&

          Lister.checkListsAreIdentical(
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
    required List<PickerModel>? pickers1,
    required List<PickerModel>? pickers2,
  }){
    bool _listsAreIdentical = false;

    if (pickers1 == null && pickers2 == null){
      _listsAreIdentical = true;
    }
    else if (pickers1 != null && pickers1.isEmpty == true && pickers2 != null && pickers2.isEmpty== true){
      _listsAreIdentical = true;
    }
    else if (Lister.checkCanLoopList(pickers1) == true && Lister.checkCanLoopList(pickers2) == true){

      if (pickers1!.length != pickers2!.length){
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
  void blogPicker({String? invoker = 'PICKER'}) {
    blog('PICKER-BLOG : $invoker --------------------------------------------------START');

    blog('isHeadline : $isHeadline');
    blog('index : $index');
    blog('chainID : $chainID');
    blog('range : $range');
    blog('canPickMany : $canPickMany');
    blog('isRequired : $isRequired');
    blog('unitChainID : $unitChainID');
    blog('blockers : $blockers');

    blog('PICKER-BLOG : $invoker --------------------------------------------------END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPickers(List<PickerModel>? pickers, {String? invoker = 'PICKER'}) {


    if (Lister.checkCanLoopList(pickers) == true) {

      final List<PickerModel> _pickers = sortPickersByIndexes(pickers);

      for (final PickerModel _picker in _pickers) {
        _picker.blogPicker(invoker: invoker);
      }
    }
    else {
      blog('pickers are empty : $invoker');
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogIndexes(List<PickerModel> pickers){
    blog('blogIndexes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~start');

    if (Lister.checkCanLoopList(pickers)) {
      for (final PickerModel _picker in pickers) {

        final String _indent = Mapper.boolIsTrue(_picker.isHeadline) == true ? '->' : '---->';

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
    required BuildContext context,
    required List<Chain> bldrsChains,
    required bool canPickManyOfAPicker,
  }){
    final List<PickerModel> _pickers = <PickerModel>[];

    if (Lister.checkCanLoopList(bldrsChains) == true){

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
  /*
  /// TESTED : WORKS PERFECT
  static List<PickerModel> createPickersFromAllChainKs({
    required BuildContext context,
    required bool canPickManyOfAPicker,
    required List<FlyerType> onlyUseTheseFlyerTypes,
  }) {

    final List<PickerModel> allChainKPickers = createHomeWallPickers(
      context: context,
      canPickMany: canPickManyOfAPicker,
      onlyUseTheseFlyerTypes: onlyUseTheseFlyerTypes,
    );

    final List<PickerModel> _pickers = <PickerModel>[];

    /// IF SPECIFIC TYPES ARE GIVEN, ADD WHATS ENLISTED
    if (Lister.checkCanLoopList(onlyUseTheseFlyerTypes) == true){

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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> createHomeWallPickers({
    required bool canPickMany,
    required List<FlyerType> onlyUseTheseFlyerTypes,
  }){

    bool _canShow(FlyerType type){
      return onlyUseTheseFlyerTypes.contains(type);
    }

    return  <PickerModel>[

      /// ---> HEADLINE : PROPERTIES
      if (_canShow(FlyerType.property))
        PickerModel(
        index: 0,
        isHeadline: true,
        chainID: FlyerTyper.concludeSectionPhidByFlyerTypeChainID(
          flyerTypeChainID: FlyerTyper.propertyChainID,
        ),
      ),

      /// PROPERTIES
      if (_canShow(FlyerType.property))
      PickerModel(
        index: 1,
        chainID: FlyerTyper.propertyChainID,
        canPickMany: canPickMany,
        isHeadline: false,
      ),

      /// ---> HEADLINE : CONSTRUCTION
      if (_canShow(FlyerType.design) || _canShow(FlyerType.trade))
        PickerModel(
        index: 2,
        isHeadline: true,
        chainID: FlyerTyper.concludeSectionPhidByFlyerTypeChainID(
          flyerTypeChainID: FlyerTyper.designChainID,
        ),
      ),

      /// DESIGN
      if (_canShow(FlyerType.design))
        PickerModel(
        index: 3,
        chainID: FlyerTyper.designChainID,
        canPickMany: canPickMany,
        isHeadline: false,
      ),

      /// CONSTRUCTION
      /*
      if (_canShow(FlyerType.project))
        PickerModel(
          index: 3,
          chainID: FlyerTyper.designChainID,
          canPickMany: canPickMany,
          isHeadline: false,
        ),
       */

      /// TRADES
      if (_canShow(FlyerType.trade))
        PickerModel(
        index: 4,
        isHeadline: false,
        chainID: FlyerTyper.tradesChainID,
        canPickMany: canPickMany,
      ),

      /// ---> HEADLINE : SUPPLIES CONSTRUCTION
      if (_canShow(FlyerType.product) || _canShow(FlyerType.equipment))
        PickerModel(
        index: 5,
        isHeadline: true,
        chainID: FlyerTyper.concludeSectionPhidByFlyerTypeChainID(
          flyerTypeChainID: FlyerTyper.productChainID,
        ),
      ),

      /// PRODUCTS
      if (_canShow(FlyerType.product))
        PickerModel(
        index: 6,
        isHeadline: false,
        chainID: FlyerTyper.productChainID,
        canPickMany: canPickMany,
      ),

      /// EQUIPMENT
      if (_canShow(FlyerType.equipment))
        PickerModel(
        index: 7,
        isHeadline: false,
        chainID: FlyerTyper.equipmentChainID,
        canPickMany: canPickMany,
      ),

    ];

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static  String? getPickersIDByFlyerType(FlyerType? flyerType){
    return FlyerTyper.cipherFlyerType(flyerType);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PickerModel? getPickerByChainIDOrUnitChainID({
    required List<PickerModel>? pickers,
    required String? chainIDOrUnitChainID,
  }) {

    // blog('getPickerFromPickersByChainIDOrUnitChainID : pickerChainID : $chainIDOrUnitChainID');
    // SpecPicker.blogSpecsPickers(specsPickers);

    /// gets the picker where chain ID is the main chain or unit chain ID

    PickerModel? _specPicker;

    if (Lister.checkCanLoopList(pickers) == true && chainIDOrUnitChainID != null) {
      _specPicker = pickers!.firstWhereOrNull(
              (PickerModel picker) =>
              picker.chainID == chainIDOrUnitChainID
              ||
              picker.unitChainID == chainIDOrUnitChainID,
      );
    }

    return _specPicker;
  }
  // --------------------
  /// TASK : TEST ME
  static PickerModel? getPickerByChainID({
    required List<PickerModel>? pickers,
    required String? chainID,
  }) {

    // blog('getPickerByChainID : pickerChainID : $chainID');
    // SpecPicker.blogSpecsPickers(specsPickers);

    /// gets the picker where chain ID is the main chain or unit chain ID

    PickerModel? _specPicker;

    if (Lister.checkCanLoopList(pickers) == true && chainID != null) {
      _specPicker = pickers!.firstWhereOrNull((PickerModel picker) => picker.chainID == chainID);
    }

    return _specPicker;
  }
  // --------------------
  /// TASK : TEST ME
  static List<PickerModel> getPickersByChainsIDs({
    required List<String>? chainsIDs,
    required List<PickerModel>? pickers,
  }){
    final List<PickerModel> _output = <PickerModel>[];

    if (Lister.checkCanLoopList(pickers) == true && Lister.checkCanLoopList(chainsIDs) == true){

      for (final String chainID in chainsIDs!){

        final PickerModel? _picker = getPickerByChainID(
            pickers: pickers,
            chainID: chainID
        );

        if (_picker != null){
          _output.add(_picker);
        }

      }

    }

    return _output;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static List<PickerModel> getPickersByGroupID({
    required List<PickerModel> pickers,
    required String groupID,
  }) {
    final List<PickerModel> _output = <PickerModel>[];

    if (Lister.checkCanLoopList(pickers)) {
      for (final PickerModel picker in pickers) {
        if (picker.groupID == groupID) {
          _output.add(picker);
        }
      }
    }

    return _output;
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static List<String> getGroupsIDs({
    required List<PickerModel> pickers,
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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPickersChainsIDs(List<PickerModel> pickers){
    List<String> _chainsIDs = <String>[];

    if (Lister.checkCanLoopList(pickers) == true){

      for (final PickerModel picker in pickers) {
        _chainsIDs = Stringer.addStringToListIfDoesNotContainIt(
          strings: _chainsIDs,
          stringToAdd: picker.chainID,
        );
      }

    }

    return _chainsIDs;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> applyBlockersAndSort({
    required List<PickerModel>? sourcePickers,
    required List<SpecModel>? selectedSpecs,
    required bool sort,
  }) {
    final List<PickerModel> _pickers = <PickerModel>[];

    if (Lister.checkCanLoopList(sourcePickers) == true) {
      final List<String> _allPickersIDsToBlock = <String>[];

      /// GET BLOCKED PICKERS
      for (final PickerModel picker in sourcePickers!) {

        final List<PickersBlocker>? _blockers = picker.blockers;

        if (Lister.checkCanLoopList(_blockers) == true) {
          for (final PickersBlocker blocker in _blockers!) {
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

    return sort == true ? sortPickersByIndexes(_pickers) : _pickers;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> replacePicker({
    required List<PickerModel> sourcePickers,
    required String? pickerChainIDtoReplace,
    required PickerModel? updatedPicker,
  }){
    List<PickerModel> _output = <PickerModel>[];

    if (Lister.checkCanLoopList(sourcePickers) == true){
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
  /*
  /// TESTED : WORKS PERFECT
  static List<PickerModel> replaceAGroupID({
    required List<PickerModel> pickers,
    required String oldGroupName,
    required String newGroupName,
  }){
    List<PickerModel> _output = <PickerModel>[];

    if (Lister.checkCanLoopList(pickers) == true){

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
   */
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> sortPickersByIndexes(List<PickerModel>? pickers){

    final List<PickerModel> _output = <PickerModel>[];

    if (Lister.checkCanLoopList(pickers) == true){

      final List<PickerModel> _pickers = <PickerModel>[... pickers!];

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

    if (Lister.checkCanLoopList(pickers) == true) {

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
  static String? getPickerChainIDOfPhid({
    required String? phid,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);

    final String? _rooChainID = Chain.getRootChainIDOfPhid(
      allChains: _chainsProvider.bldrsChains,
      phid: phid,
    );

    return _rooChainID;
  }
  // --------------------
  /// FIND PICKERS BY PHIDS
  /*
  static PickerModel _findPickerByPhid({
    required BuildContext context,
    required String phid,
    required List<PickerModel> allPickers,
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
    required BuildContext context,
    required List<String> phids,
    required List<PickerModel> allPickers,
  }){

    final List<PickerModel> _pickers = <PickerModel>[];

    if (Lister.checkCanLoopList(phids) == true && Lister.checkCanLoopList(allPickers) == true){

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
      canPickMany.hashCode ^
      isRequired.hashCode ^
      unitChainID.hashCode ^
      range.hashCode ^
      blockers.hashCode;
  // -----------------------------------------------------------------------------
}
