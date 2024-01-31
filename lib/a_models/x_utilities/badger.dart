import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class Badger {
  // -----------------------------------------------------------------------------
  /// THIS HOLDS NUMBERS AND TEXTS AS BADGES TO BUTTONS OF NAV BAR
  // --------------------
  /// MAP LOOKS LIKE THIS
  /// Map<String, dynamic> map = {
  ///   'bid1': 0,
  ///   'bid2 : 1,
  ///   'bid3' : 'new',
  ///   'bid4' : 'sign in',
  ///   ...
  /// };
  // --------------------
  /// EACH PAIR IS CALLED A BADGE
  // -----------------------------------------------------------------------------
  const Badger({
    required this.map,
  });
  // --------------------
  final Map<String, dynamic> map;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// AI TESTED
  Badger copyWith({
    Map<String, dynamic>? map,
  }){
    return Badger(
      map: map ?? this.map,
    );
  }
  // -----------------------------------------------------------------------------

  /// GETTER

  // --------------------
  /// AI TESTED
  dynamic getBadge(String key){
    return map[key];
  }
  // -----------------------------------------------------------------------------

  /// SET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Badger setBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    if (key != null){

      Map<String, dynamic> _newMap = Mapper.insertPairInMap(
          map: _output.map,
          key: key,
          value: value,
          overrideExisting: true,
      );

      _newMap = Mapper.cleanNullPairs(map: _newMap) ?? {};
      _newMap = Mapper.cleanZeroValuesPairs(map: _newMap) ?? {};

      _output = _output.copyWith(
        map: _newMap,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  /// AI TESTED
  static Badger insertBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    blog('insertBadge : $key : value : $value : badger : $badger');

    if (key != null && value != null){

      if (value is num){
        _output = _insertNumToBadge(
          value: value,
          key: key,
          badger: _output,
        );
      }

      else if (value is String){
        _output = _insertStringToBadge(
          value: value,
          key: key,
          badger: _output,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Badger _insertStringToBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    if (key != null && value != null && value is String){

      Map<String, dynamic> _map = _output.map;

      _map = Mapper.insertPairInMap(
          map: _map,
          key: key,
          value: value,
          overrideExisting: true,
      );

      _output = _output.copyWith(
        map: _map,
      );

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Badger _insertNumToBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    if (key != null && value != null && value is num){

      Map<String, dynamic> _map = _output.map;
      final num _oldValue = (_map[key] is num ? _map[key] : 0) ?? 0;
      final num _newValue = _oldValue + value;

      if (_newValue > 0){

        _map = Mapper.insertPairInMap(
          map: _map,
          key: key,
          value: _newValue,
          overrideExisting: true,
        );

        _output = _output.copyWith(
          map: _map,
        );

      }

      else {
        _output = removeBadge(
            badger: badger,
            key: key,
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// REMOVE

  // --------------------
  /// AI TESTED
  static Badger removeBadge({
    required Badger badger,
    required String? key,
    dynamic value,
  }){
    Badger _output = badger;

    if (key != null){

      final dynamic _oldValue = _output.map[key];

      if (_oldValue != null){

        /// REMOVE PAIR
        if (value == null || _oldValue is String){
          _output = _deleteBadge(
            badger: _output,
            key: key,
          );
        }

        /// DECREMENT PAIR
        else {
          _output = _decrementBadge(
            badger: _output,
            key: key,
            value: value,
          );
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Badger _deleteBadge({
    required Badger badger,
    required String? key,
  }){
    Badger _output = badger;

    if (key != null){

      Map<String, dynamic> _map = _output.map;

      _map = Mapper.removePair(
        map: _map,
        fieldKey: key,
      );

      _output = _output.copyWith(
        map: _map,
      );

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Badger _decrementBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    if (key != null){

      Map<String, dynamic> _map = _output.map;
      final dynamic _oldValue = _map[key] ?? 0;

        // blog('value == null : ${value == null}');
        // blog('value is int : ${value is int}');
        // blog('value is int : ${value is double}');
        // blog('_oldValue is int : ${_oldValue is int}');
        // blog('_oldValue is double : ${_oldValue is double}');
        // blog('_oldValue == 0 : ${_oldValue == 0}');

        if (
            value != null &&
            (value is int || value is double) &&
            (_oldValue is int || _oldValue is double) &&
            _oldValue != 0
        ){

          final num _oldNum = _oldValue;
          final num _newValue = _oldNum - value;

          if (_newValue > 0){
            _map = Mapper.insertPairInMap(
              map: _map,
              key: key,
              value: _newValue,
              overrideExisting: true,
            );
            _output = _output.copyWith(
              map: _map,
            );
          }

          else {
            _output = _deleteBadge(
              key: key,
              badger: _output,
            );
          }

        }

        else {
          _output = _deleteBadge(
            key: key,
            badger: _output,
          );
        }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CALCULATE

  // --------------------
  /// AI TESTED
  static int calculateGrandTotal({
    required Badger badger,
    required bool onlyNumbers,
  }){

    return _calculateThose(
      badger: badger,
      onlyNumbers: onlyNumbers,
      bids: badger.map.keys.toList(),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateAllMyBzz({
    required Badger badger,
    required BuildContext context,
    required bool listen,
    required bool onlyNumbers,
  }){

    final List<String> bzzBids = TabName.generateMyBzzBids(
      context: context,
      listen: listen,
    );

    return _calculateThose(
      badger: badger,
      onlyNumbers: onlyNumbers,
      bids: bzzBids,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateBzTotal({
    required String bzID,
    required Badger badger,
    required bool onlyNumbers,
  }){

    final List<String> _bzBids = TabName.generateBzBids(
      bzID: bzID,
    );

    return _calculateThose(bids: _bzBids, badger: badger, onlyNumbers: onlyNumbers);
  }
  // --------------------
  /// AI TESTED
  static int _calculateThose({
    required List<String> bids,
    required Badger badger,
    required bool onlyNumbers,
  }){
    int _output = 0;

    if (Lister.checkCanLoop(bids) == true){

      for (final String key in bids){

        final dynamic _value = badger.map[key];

        if (_value is int || _value is double){
          final int _addThis = _value.toInt();
          _output = _output + _addThis;
        }

        else if (onlyNumbers == false){
          _output = _output + 1;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static int calculateUserTotal({
    required Badger badger,
    required bool onlyNumbers,
  }){

    return _calculateThose(bids: TabName.userBids, badger: badger, onlyNumbers: onlyNumbers);
  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Badger wipeAllRelatedToBzID({
    required String bzID,
    required Badger badger,
  }){

    Badger _output = badger;
    final List<String> _keys = badger.map.keys.toList();

    for (final String key in _keys){

      final String? _bzID = TabName.getBzIDFromBidBz(bzBid: key);
      if (_bzID == bzID){
        _output = _deleteBadge(
          badger: _output,
          key: key,
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// AI TESTED
  static int? getBadgeCount({
    required String bid,
    required Badger badger,
  }){
    int? _output;

    final dynamic _value = badger.map[bid];

    if (_value != null && _value is int){
      _output = _value;
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static Verse? getBadgeVerse({
    required String bid,
    required Badger badger,
  }){
    Verse? _output;

    final dynamic _value = badger.map[bid];

    if (_value != null && _value is String){
      _output = Verse(
        id: _value,
        translate: false,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBadgeRedDotIsOn({
    required String bid,
    required Badger badger,
    bool forceRedDot = false,
  }){

    if (forceRedDot == true){
      return true;
    }

    else {
      return badger.map[bid] != null;
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// AI TESTED
  static bool checkBadgersAreIdentical({
    required Badger? badger1,
    required Badger? badger2,
  }){
    return Mapper.checkMapsAreIdentical(map1: badger1?.map, map2: badger2?.map);
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString(){

    final String _blog =
    '''
    Badger(
      map: $map,
    );
    ''';

    return _blog;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Badger){
      _areIdentical = checkBadgersAreIdentical(
        badger1: this,
        badger2: other,
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
