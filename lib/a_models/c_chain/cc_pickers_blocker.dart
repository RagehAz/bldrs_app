import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:flutter/foundation.dart';
/// => TAMAM
@immutable
class PickersBlocker {
  /// -----------------------------------------------------------------------------
  const PickersBlocker({
    required this.value,
    required this.pickersIDsToBlock,
  });
  // -----------------------------------------------------------------------------
  /// 1. when this value is selected in selected specs list
  final dynamic value;
  /// 2. these below pickers Ids will be deactivated
  final List<String> pickersIDsToBlock;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PickersBlocker copyWith({
    dynamic value,
    List<String>? pickersIDsToBlock,
  }){
    return PickersBlocker(
      value: value ?? this.value,
      pickersIDsToBlock: pickersIDsToBlock ?? this.pickersIDsToBlock,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> _toMap(){
    return {
      'value': value,
      'pickersIDsToBlock' : pickersIDsToBlock,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PickersBlocker? _decipherBlocker(Map<String, dynamic>? map){
    PickersBlocker? _blocker;

    if (map != null){
      _blocker = PickersBlocker(
        value: map['value'],
        pickersIDsToBlock: Stringer.getStringsFromDynamics(map['pickersIDsToBlock']),
      );
    }

    return _blocker;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherBlockers(List<PickersBlocker>? blockers){
    final List <Map<String, dynamic>> _maps  = <Map<String, dynamic>>[];

    if (Lister.checkCanLoop(blockers) == true){

      for (final PickersBlocker blocker in blockers!){

        _maps.add(blocker._toMap());

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickersBlocker> decipherBlockers(dynamic maps) {
    final List<PickersBlocker> _blockers = <PickersBlocker>[];

    if (maps != null) {

      if (maps is List) {
        for (final Object _linkedHashMap in maps) {
          final Map<String, dynamic>? map = Mapper.getMapFromIHLMOO(
            ihlmoo: _linkedHashMap,
          );

          final PickersBlocker? _blocker = _decipherBlocker(map);
          if (_blocker != null){
            _blockers.add(_blocker);
          }
        }
      }

      else if (maps is Map<String, dynamic>? || maps is Map<String, dynamic>) {
        final Map<String, dynamic>? _bigMap = maps;
        final List<String>? _keys = _bigMap?.keys.toList();
        if (Lister.checkCanLoop(_keys) == true){
          for (final String key in _keys!) {
            final dynamic _map = maps[key];
            final PickersBlocker? _blocker = _decipherBlocker(_map);
            if (_blocker != null){
              _blockers.add(_blocker);
            }
          }
        }

      }

    }

    return _blockers;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBlockersAreIdentical({
    required PickersBlocker? blocker1,
    required PickersBlocker? blocker2,
  }){
    bool _areIdentical = false;

    if (blocker1 == null && blocker2 == null){
      _areIdentical = true;
    }
    else if (blocker1 != null && blocker2 != null){

      final bool _blockersAreIdentical = Lister.checkListsAreIdentical(
        list1: blocker1.pickersIDsToBlock,
        list2: blocker2.pickersIDsToBlock,
      );

      if (
          blocker1.value  == blocker2.value
          &&
          _blockersAreIdentical == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBlockersListsAreIdentical({
    required List<PickersBlocker>? blockers1,
    required List<PickersBlocker>? blockers2,
  }){
    bool _listsAreIdentical = false;

    if (blockers1 == null && blockers2 == null){
      _listsAreIdentical = true;
    }
    else if (blockers1 != null && blockers1.isEmpty == true && blockers2 != null && blockers2.isEmpty == true){
      _listsAreIdentical = true;
    }
    else if (Lister.checkCanLoop(blockers1) == true && Lister.checkCanLoop(blockers2) == true){

      if (blockers1!.length != blockers2!.length){
        _listsAreIdentical = false;
      }
      else {

        for (int i = 0; i < blockers1.length; i++){

          final PickersBlocker _blocker1 = blockers1[i];
          final PickersBlocker _blocker2 = blockers2[i];

          final bool _areIdentical = checkBlockersAreIdentical(
            blocker1: _blocker1,
            blocker2: _blocker2,
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
    if (other is PickersBlocker){
      _areIdentical = checkBlockersAreIdentical(
        blocker1: this,
        blocker2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode => value.hashCode^ pickersIDsToBlock.hashCode;
  // -----------------------------------------------------------------------------
}
