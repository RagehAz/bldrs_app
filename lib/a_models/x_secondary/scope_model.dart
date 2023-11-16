import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:flutter/foundation.dart';
/// => TAMAM
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
  static ScopeModel emptyModel = const ScopeModel(
    map: {},
  );
  // -------------------
  static ScopeModel dummyScope = const ScopeModel(
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
  static int getScopePhidUsage({
    required ScopeModel? scope,
    required String? phid,
  }){
    int _output = 0;

    if (scope != null && phid != null){

      final List<String> _flyersIDs = getFlyersIDsByPhid(
          scope: scope,
          phid: phid
      );

      _output = _flyersIDs.length;

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

    return clean(_output);
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

    return clean(_output);
  }
  // -------------------
  /// TESTED : WORKS PERFECT
  static BzModel? removeFlyerFromBz({
    required BzModel? bzModel,
    required FlyerModel? flyerModel,
  }){
    BzModel? _output = bzModel;

    if (bzModel != null && flyerModel != null){

      final ScopeModel? _newScope = removeFlyer(
          scope: bzModel.scopes,
          flyer: flyerModel,
      );

      if (_newScope != null){
        _output = _output!.copyWith(
          scopes: _newScope,
        );
      }

    }

    return _output;
  }
  // -------------------
  /// AI TESTED
  static ScopeModel? clean(ScopeModel? scope){
    ScopeModel? _output = scope;

    if (scope != null){

      final List<String> _phids = getPhids(scope);

      if (Mapper.checkCanLoopList(_phids) == true){

        Map<String, dynamic> _map = {};

        for (final String phid in _phids){

          final List<String> _flyersIDs = getFlyersIDsByPhid(
              scope: scope,
              phid: phid,
          );

          if (Mapper.checkCanLoopList(_flyersIDs) == true){
            _map = Mapper.insertPairInMap(
                map: _map,
                key: phid,
                value: _flyersIDs,
                overrideExisting: true,
            );
          }

        }

        _output = decipher(_map);
      }

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

  /// OLD SCOPE

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static List<String> getScopePhids(Map<String, dynamic>? scope){
    final List<String> _output = [];

    if (scope != null){

      final List<String> _phids = scope.keys.toList();

      if (_phids.isNotEmpty == true){
        _output.addAll(_phids);
      }

    }

    return _output;
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> insertPhidToScope({
    required Map<String, dynamic>? scope,
    required String? phid,
  }){
    Map<String, dynamic> _output = scope ?? {};

    if (phid != null){

      final int _value = getScopePhidUsage(
          scope: _output,
          phid: phid
      );

      _output = Mapper.insertPairInMap(
        map: _output,
        key: phid,
        value: _value + 1,
        overrideExisting: true,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> removePhidFromScope({
    required Map<String, dynamic>? scope,
    required String? phid,
  }){
    Map<String, dynamic> _output = scope ?? {};

    if (phid != null){

      final int _value = getScopePhidUsage(
          scope: _output,
          phid: phid
      );

      if (_value > 0){

        _output = Mapper.insertPairInMap(
            map: _output,
            key: phid,
            value: _value - 1,
            overrideExisting: true,
        );

      }
      else {

        _output = Mapper.removePair(
            map: _output,
            fieldKey: phid,
        );

      }

    }

    return cleanScope(scope: _output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> insertPhidsToScope({
    required Map<String, dynamic>? scope,
    required List<String>? phids,
  }){
    Map<String, dynamic> _output = scope ?? {};

    if (Mapper.checkCanLoopList(phids) == true){

      for (final String phid in phids!){

        _output = insertPhidToScope(
          scope: _output,
          phid: phid,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> removePhidsFromScope({
    required Map<String, dynamic>? scope,
    required List<String>? phids,
  }){
    Map<String, dynamic> _output = scope ?? {};

    if (scope != null && Mapper.checkCanLoopList(phids) == true){

      for (final String phid in phids!){

        _output = removePhidFromScope(
          scope: _output,
          phid: phid,
        );

      }

    }

    return _output;
  }
  */
  // --------------------

  /// TESTED : WORKS PERFECT
  // static Map<String, dynamic> cleanScope({
  //   required Map<String, dynamic>? scope,
  // }){
  //   Map<String, dynamic> _output = {};
  //
  //   if (scope != null){
  //
  //     final List<String> _phids = scope.keys.toList();
  //
  //     if (Mapper.checkCanLoopList(_phids) == true){
  //
  //       for (final String phid in _phids){
  //
  //         final int _value = getScopePhidUsage(
  //             scope: scope,
  //             phid: phid
  //         );
  //
  //         if (_value > 0){
  //
  //           _output = Mapper.insertPairInMap(
  //               map: _output,
  //               key: phid,
  //               value: _value,
  //               overrideExisting: true,
  //           );
  //
  //         }
  //
  //       }
  //
  //     }
  //
  //   }
  //
  //   return _output;
  // }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static BzModel? removeFlyerPhidsFromBzScope({
    required BzModel? oldBz,
    required FlyerModel? flyer,
  }){
    BzModel? _output = oldBz;

    if (_output != null && flyer != null){

      Map<String, dynamic>? _scope = _output.scopeOld;

      _scope = removePhidsFromScope(
          scope: _scope,
          phids: flyer.phids,
      );

      _output = _output.copyWith(
        scopeOld: _scope,
      );

    }

    return _output;
  }
   */
  // -----------------------------------------------------------------------------
}
