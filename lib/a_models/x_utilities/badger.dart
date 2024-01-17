import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

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
  /// TESTED : WORKS PERFECT
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
  dynamic getBadge(String key){
    return map[key];
  }
  // -----------------------------------------------------------------------------

  /// INSERT

  // --------------------
  ///
  static Badger insertBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    if (key != null && value != null){

      if (value is num){
        _output = _insertNumToBadge(
          value: value,
          key: key,
          badger: _output,
        );
      }

      else {
        _output = _insertStringToBadge(
          value: value.toString(),
          key: key,
          badger: _output,
        );
      }

    }

    return _output;
  }
  // --------------------
  ///
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
  ///
  static Badger _insertNumToBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    if (key != null && value != null && value is num){

      Map<String, dynamic> _map = _output.map;
      final num _oldValue = _map[key] ?? 0;
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
  ///
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
  ///
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
  ///
  static Badger _decrementBadge({
    required Badger badger,
    required String? key,
    required dynamic value,
  }){
    Badger _output = badger;

    if (key != null){

      Map<String, dynamic> _map = _output.map;
      final dynamic _oldValue = _map[key] ?? 0;

      if (value == null || value !is num || _oldValue !is num || _oldValue == 0){
        _output = _deleteBadge(
          key: key,
          badger: _output,
        );
      }

      else {
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

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CALCULATE

  // --------------------
  ///
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
  ///
  static int calculateAllMyBzz({
    required Badger badger,
    required BuildContext context,
    required bool listen,
    required bool onlyNumbers,
  }){

    final List<String> bzzBids = BldrsTabber.generateMyBzzBids(
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
  ///
  static int calculateBzTotal({
    required String bzID,
    required Badger badger,
    required bool onlyNumbers,
  }){

    final List<String> _bzBids = BldrsTabber.generateBzBids(
      bzID: bzID,
    );

    return _calculateThose(bids: _bzBids, badger: badger, onlyNumbers: onlyNumbers);
  }
  // --------------------
  ///
  static int _calculateThose({
    required List<String> bids,
    required Badger badger,
    required bool onlyNumbers,
  }){
    int _output = 0;

    if (onlyNumbers == true){

      for (final String key in bids){

        final dynamic _value = badger.map[key];

        if (_value is num){
          _output = _output + _value.toInt();
        }

        else if (onlyNumbers == false){
          _output = _output + 1;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  static Badger wipeAllRelatedToBzID({
    required String bzID,
    required Badger badger,
  }){

    Badger _output = badger;
    final List<String> _keys = badger.map.keys.toList();

    for (final String key in _keys){

      final String? _bzID = BldrsTabber.getBzIDFromBzBid(bzBid: key);
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
  ///
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
  ///
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
  ///
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
}
