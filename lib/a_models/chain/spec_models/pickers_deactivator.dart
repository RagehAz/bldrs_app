import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/foundation.dart';

@immutable
class PickersDeactivator {
/// -----------------------------------------------------------------------------
  const PickersDeactivator({
    @required this.value,
    @required this.pickersIDsToDeactivate,
  });
  // -----------------------------------------------------------------------------
  /// 1. when this value is selected in selected specs list
  final dynamic value;
  /// 2. these below pickers Ids will be deactivated
  final List<String> pickersIDsToDeactivate;
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  PickersDeactivator copyWith({
    dynamic value,
    List<String> pickersIDsToDeactivate,
  }){
    return PickersDeactivator(
      value: value ?? this.value,
      pickersIDsToDeactivate: pickersIDsToDeactivate ?? this.pickersIDsToDeactivate,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHER

// -------------------------------------
  ///
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  ///
  static bool checkDeactivatorsAreIdentical({
    @required PickersDeactivator deAct1,
    @required PickersDeactivator deAct2,
  }){
    bool _areIdentical = false;

    if (deAct1 == null && deAct2 == null){
      _areIdentical = true;
    }
    else if (deAct1 != null && deAct2 != null){

      if (

          deAct1.value == deAct2.value &&

          Mapper.checkListsAreIdentical(
            list1: deAct1.pickersIDsToDeactivate,
            list2: deAct2.pickersIDsToDeactivate,
          ) == true

      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
// -------------------------------------
  ///
  static bool checkDeactivatorsListsAreIdentical({
    @required List<PickersDeactivator> deActs1,
    @required List<PickersDeactivator> deActs2,
  }){
    bool _listsAreIdentical = false;

    if (deActs1 == null && deActs2 == null){
      _listsAreIdentical = true;
    }
    else if (deActs1.isEmpty == true && deActs2.isEmpty == true){
      _listsAreIdentical = true;
    }
    else if (Mapper.checkCanLoopList(deActs1) == true && Mapper.checkCanLoopList(deActs2) == true){

      if (deActs1.length != deActs2.length){
        _listsAreIdentical = false;
      }
      else {

        for (int i = 0; i < deActs1.length; i++){

          final PickersDeactivator _deAct1 = deActs1[i];
          final PickersDeactivator _deAct2 = deActs2[i];

          final bool _areIdentical = checkDeactivatorsAreIdentical(
            deAct1: _deAct1,
            deAct2: _deAct2,
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
}
