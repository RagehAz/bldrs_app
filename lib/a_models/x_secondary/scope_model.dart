import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class ScopeModel {
  // -----------------------------------------------------------------------------
  const ScopeModel({
    required this.map,
  });
  // --------------------
  final Map<String, List<String>> map;
  // -----------------------------------------------------------------------------

  /// DUMMY

  // -------------------
  static ScopeModel dummyScopeModel = const ScopeModel(
    map: {
      'phid_key': [
        'idA',
        'idB',
        'idC',
      ],
      'phid_key2': [
        'idD',
        'idE',
        'idF',
      ],
    },
  );
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // -------------------
  /// AI TESTED
  Map<String, dynamic> toMap(){
    return map;
  }
  // -------------------
  /// AI TESTED
  static ScopeModel? decipher(Map<String, dynamic>? map){

    ScopeModel? _output;

    if (map != null){

      final Map<String, List<String>> _maw = {};

      final List<String> _keys = map.keys.toList();

      for (final String key in _keys){

        final dynamic _value = map[key];

        if (_value is List){
          final List<String> _flyersIDs = Stringer.getStringsFromDynamics(map[key]);
          _maw[key] = _flyersIDs;
        }

      }

      if (_maw.isNotEmpty){
        _output = ScopeModel(
          map: _maw,
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // -------------------
  /// AI TESTED
  static List<String> getPhids(ScopeModel? scope){
    List<String> _output = [];

    if (scope != null){
      _output = scope.map.keys.toList();
    }

    return _output;
  }
  // -------------------
  /// AI TESTED
  static List<String> getFlyersIDsByPhid({
    required ScopeModel? scope,
    required String? phid,
  }){
    List<String> _output = [];

    if (scope != null && phid != null){

      _output = scope.map[phid] ?? [];

    }

    return _output;
  }
  // -------------------
  /// AI TESTED
  static List<String> getAllFlyersIDs(ScopeModel? scope){
    List<String> _output = [];

    if (scope != null){

      final List<String> _phids = getPhids(scope);

      if (Mapper.checkCanLoopList(_phids) == true){

        for (final String phid in _phids){

          final List<String> _flyersIDsByPhid = getFlyersIDsByPhid(
              scope: scope,
              phid: phid
          );

          _output = Stringer.addStringsToStringsIfDoNotContainThem(
              listToTake: _output,
              listToAdd: _flyersIDsByPhid,
          );

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // -------------------
  /// AI TESTED
  static ScopeModel? addFlyerIDToPhid({
    required String? flyerID,
    required String? phid,
    required ScopeModel? scope,
  }){
    ScopeModel? _output = scope;

    if (flyerID != null && phid != null && scope != null) {

      final Map<String, dynamic>? _newMap = Mapper.cloneMap(scope.map);

      if (_newMap != null) {
        final List<String> _oldList = getFlyersIDsByPhid(
            scope: scope,
            phid: phid
        );

        _newMap[phid] = Stringer.addStringToListIfDoesNotContainIt(
          strings: _oldList,
          stringToAdd: flyerID,
        );

        _output = decipher(_newMap);
      }

    }

    return _output;
  }
  // -------------------
  /// AI TESTED
  static ScopeModel? addFlyerToScope({
    required ScopeModel? scope,
    required FlyerModel? flyer,
  }){
    ScopeModel? _output = scope;

    if (scope != null && flyer?.id != null){

      final List<String> _flyerPhids = flyer?.phids ?? [];

      if (Mapper.checkCanLoopList(_flyerPhids) == true){

        for (final String _flyerPhid in _flyerPhids){

          _output = addFlyerIDToPhid(
              scope: _output,
              flyerID: flyer!.id!,
              phid: _flyerPhid,
          );

        }

      }

    }

    return _output;
  }
  // -------------------
  /// AI TESTED
  static ScopeModel? removeFlyer({
    required ScopeModel? scope,
    required FlyerModel? flyer,
  }){
    ScopeModel? _output = scope;

    if (scope != null && flyer?.id != null){

      final List<String> phids = getPhids(scope);
      final Map<String, dynamic> _newMap = Mapper.cloneMap(scope.toMap())!;

      if (Mapper.checkCanLoopList(phids) == true){

        for (final String phid in phids){

          final List<String> _oldIDs = _output!.map[phid] ?? [];
          final List<String> _newIDs = Stringer.removeStringsFromStrings(
              removeFrom: _oldIDs,
              removeThis: [flyer!.id!],
          );
          _newMap[phid] = _newIDs;

        }

      }

      _output = decipher(_newMap);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // -------------------
  /// AI TESTED
  static bool checkScopeContainPhid({
    required ScopeModel? scope,
    required String? phid,
  }){

    final List<String> _phids = getPhids(scope);

    return Stringer.checkStringsContainString(
        strings: _phids,
        string: phid,
    );

  }
  // -------------------
  /// AI TESTED
  static bool checkScopeContainsFlyerID({
    required ScopeModel scope,
    required String flyerID,
  }){

    final List<String> _flyersIDs = getAllFlyersIDs(scope);

    return Stringer.checkStringsContainString(
        strings: _flyersIDs,
        string: flyerID,
    );

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // -------------------
  /// AI TESTED
  static bool checkScopesAreIdentical({
    required ScopeModel? scope1,
    required ScopeModel? scope2,
  }){

    final Map<String, dynamic>? _map1 = scope1?.map;
    final Map<String, dynamic>? _map2 = scope2?.map;

    return Mapper.checkMapsAreIdentical(map1: _map1, map2: _map2);
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => 'ScopeModel(map: $map)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is ScopeModel){
      _areIdentical = checkScopesAreIdentical(
        scope1: this,
        scope2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      map.hashCode;
  // -----------------------------------------------------------------------------
}
