import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class PaginationController {
  /// -----------------------------------------------------------------------------
  const PaginationController({
    @required this.paginatorMaps,
    @required this.replaceMap,
    @required this.addMap,
    @required this.deleteMap,
    @required this.startAfter,
    @required this.addExtraMapsAtEnd,
  });
  /// -----------------------------------------------------------------------------
  final ValueNotifier<List<Map<String, dynamic>>> paginatorMaps;
  final ValueNotifier<Map<String, dynamic>> replaceMap;
  final ValueNotifier<Map<String, dynamic>> addMap;
  final ValueNotifier<Map<String, dynamic>> deleteMap;
  final ValueNotifier<dynamic> startAfter;
  final bool addExtraMapsAtEnd;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static PaginationController initialize({
    @required bool addExtraMapsAtEnd,
  }){

    return PaginationController(
      paginatorMaps: ValueNotifier(<Map<String, dynamic>>[]),
      replaceMap: ValueNotifier<Map<String, dynamic>>(null),
      addMap: ValueNotifier<Map<String, dynamic>>(null),
      deleteMap: ValueNotifier<Map<String, dynamic>>(null),
      startAfter: ValueNotifier<dynamic>(null),
      addExtraMapsAtEnd: addExtraMapsAtEnd,
    );

  }

  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    paginatorMaps.dispose();
    replaceMap.dispose();
    addMap.dispose();
    deleteMap.dispose();
    startAfter.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LISTENING

  // --------------------
  /// TESTED : WORKS PERFECT
  void activateListeners({
    @required bool mounted,
    @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
  }){

    _listenToPaginatorMapsChanges(
      onDataChanged: onDataChanged,
    );

    _listenToAddMap(
      mounted: mounted,
      addAtEnd: addExtraMapsAtEnd,
    );

    _listenToReplaceMap(
      mounted: mounted,
    );

    _listenToDeleteMap(
      mounted: mounted,
    );

  }
  // --------------------
  /// ADD MAP
  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToPaginatorMapsChanges({
    @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
  }){

    if (onDataChanged != null){

      paginatorMaps.addListener(() {
        onDataChanged(paginatorMaps.value);
      });

    }

  }
  // --------------------
  /// ADD MAP
  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToAddMap({
    @required bool addAtEnd,
    @required bool mounted,
  }){
    if (addMap != null){
      addMap.addListener(() {

        _addMapToPaginatorMaps(
          addAtEnd: addAtEnd,
          mounted: mounted,
        );

      });
    }
  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _addMapToPaginatorMaps({
    @required bool addAtEnd,
    @required bool mounted,
  }){

    List<Map<String, dynamic>> _combinedMaps = [...paginatorMaps.value];

    if (addMap != null){

      if (addAtEnd == true){
        _combinedMaps = [...paginatorMaps.value, addMap.value];
      }
      else {
        _combinedMaps = [addMap.value, ...paginatorMaps.value,];
      }

      setNotifier(
        notifier: paginatorMaps,
        mounted: mounted,
        value: _combinedMaps,
        addPostFrameCallBack: false,
      );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: _combinedMaps,
      );

    }

  }
  // --------------------
  /// REPLACE MAP
  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToReplaceMap({
    @required bool mounted,
  }){

    if (replaceMap != null){

      replaceMap.addListener(() {

        // blog('mapOverride : is : ${widget.replaceMap.value}');

        _replaceExistingMap(
          mounted: mounted,
        );

      });
    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _replaceExistingMap({
    @required bool mounted,
  }){

    if (replaceMap.value != null){

      final List<Map<String, dynamic>> _updatedMaps = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: paginatorMaps.value,
        mapToReplace: replaceMap.value,
      );

      setNotifier(
        notifier: paginatorMaps,
        mounted: mounted,
        value: _updatedMaps,
        addPostFrameCallBack: false,
      );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: paginatorMaps.value,
      );

    }

  }
  // --------------------
  /// DELETE MAP
  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToDeleteMap({
    @required bool mounted,
  }){

    if (deleteMap != null){

      deleteMap.addListener(() {

        _deleteExistingMap(
          mounted: mounted,
        );

      });
    }


  }
  // ---------
  /// TESTED : WORKS PERFECT
  void _deleteExistingMap({
    @required bool mounted,
  }){

    if (deleteMap.value != null){

      final List<Map<String, dynamic>> _updatedMaps = Mapper.removeMapFromMapsByIdField(
        baseMaps: paginatorMaps.value,
        mapToRemove: deleteMap.value,
      );

      setNotifier(
        notifier: paginatorMaps,
        mounted: mounted,
        value: _updatedMaps,
        addPostFrameCallBack: false,
      );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: paginatorMaps.value,
      );

    }


  }
  // ---------
  /// TESTED : WORKS PERFECT
  static void addMapsToLocalMaps({
    @required ValueNotifier<List<Map<String, dynamic>>> paginatorMaps,
    @required ValueNotifier<dynamic> startAfter,
    @required List<Map<String, dynamic>> mapsToAdd,
    @required bool addAtEnd,
    @required bool mounted,
  }){

    List<Map<String, dynamic>> _combinedMaps = [...paginatorMaps.value];

    if (mapsToAdd!= null){

      if (addAtEnd == true){
        _combinedMaps = [...paginatorMaps.value, ...mapsToAdd];
      }
      else {
        _combinedMaps = [ ...mapsToAdd, ...paginatorMaps.value,];
      }

      setNotifier(
        notifier: paginatorMaps,
        mounted: mounted,
        value: _combinedMaps,
        addPostFrameCallBack: false,
      );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: _combinedMaps,
      );

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static void _setStartAfter({
    @required ValueNotifier<dynamic> startAfter,
    @required List<Map<String, dynamic>> paginatorMaps,
  }){
    startAfter.value = paginatorMaps.last['docSnapshot'] ?? paginatorMaps.last;
  }
  // -----------------------------------------------------------------------------
}
