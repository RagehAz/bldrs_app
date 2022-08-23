import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/foundation.dart';

@immutable
class SpecDeactivator {
/// -----------------------------------------------------------------------------
  const SpecDeactivator({
    @required this.specValueThatDeactivatesSpecsLists,
    @required this.specsListsIDsToDeactivate,
  });
  /// -----------------------------------------------------------------------------
  final dynamic specValueThatDeactivatesSpecsLists;
  /// when this specValue is selected
  /// all lists with these listsIDs get deactivated
  final List<String> specsListsIDsToDeactivate;
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  ///
  static bool checkDeactivatorsAreIdentical({
    @required SpecDeactivator deAct1,
    @required SpecDeactivator deAct2,
  }){
    bool _areIdentical = false;

    if (deAct1 == null && deAct2 == null){
      _areIdentical = true;
    }
    else if (deAct1 != null && deAct2 != null){

      if (

          deAct1.specValueThatDeactivatesSpecsLists == deAct2.specValueThatDeactivatesSpecsLists &&

          Mapper.checkListsAreIdentical(
            list1: deAct1.specsListsIDsToDeactivate,
            list2: deAct2.specsListsIDsToDeactivate,
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
    @required List<SpecDeactivator> deActs1,
    @required List<SpecDeactivator> deActs2,
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

          final SpecDeactivator _deAct1 = deActs1[i];
          final SpecDeactivator _deAct2 = deActs2[i];

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
