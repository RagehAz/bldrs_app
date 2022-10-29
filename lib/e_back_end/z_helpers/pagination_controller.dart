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
    @required this.idFieldName,
    @required this.onDataChanged,
  });
  /// -----------------------------------------------------------------------------
  final ValueNotifier<List<Map<String, dynamic>>> paginatorMaps;
  final ValueNotifier<Map<String, dynamic>> replaceMap;
  final ValueNotifier<Map<String, dynamic>> addMap;
  final ValueNotifier<Map<String, dynamic>> deleteMap;
  final ValueNotifier<dynamic> startAfter;
  final bool addExtraMapsAtEnd;
  final String idFieldName;
  final ValueChanged<List<Map<String, dynamic>>> onDataChanged;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static PaginationController initialize({
    @required bool addExtraMapsAtEnd,
    ValueChanged<List<Map<String, dynamic>>> onDataChanged,
    String idFieldName = 'id',
  }){

    return PaginationController(
      paginatorMaps: ValueNotifier(<Map<String, dynamic>>[]),
      replaceMap: ValueNotifier<Map<String, dynamic>>(null),
      addMap: ValueNotifier<Map<String, dynamic>>(null),
      deleteMap: ValueNotifier<Map<String, dynamic>>(null),
      startAfter: ValueNotifier<dynamic>(null),
      addExtraMapsAtEnd: addExtraMapsAtEnd,
      idFieldName: idFieldName,
      onDataChanged: onDataChanged,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clear(){
    paginatorMaps.value = [];
    replaceMap.value = null;
    addMap.value = null;
    deleteMap.value = null;
    startAfter.value = null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void removeListeners(){
    paginatorMaps.removeListener(() { });
    replaceMap.removeListener(() { });
    addMap.removeListener(() { });
    deleteMap.removeListener(() { });
    startAfter.removeListener(() { });
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
    // @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
  }){

    _listenToPaginatorMapsChanges();

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

  /// MAP CHANGES LISTENER

  // ---------
  /// TESTED : WORKS PERFECT
  void _listenToPaginatorMapsChanges(){

    if (onDataChanged != null){

      paginatorMaps.addListener(() {
        onDataChanged(paginatorMaps.value);
      });

    }

  }
  // --------------------------------

  /// ADD MAP LISTENER

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
      );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: _combinedMaps,
      );

    }

  }
  // --------------------------------

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
          controller: this,
        );

      });
    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static void _replaceExistingMap({
    @required bool mounted,
    @required PaginationController controller,
  }){

    if (controller.replaceMap.value != null){

      final List<Map<String, dynamic>> _updatedMaps = Mapper.replaceMapInMapsWithSameIDField(
        baseMaps: controller.paginatorMaps.value,
        mapToReplace: controller.replaceMap.value,
        idFieldName: controller.idFieldName,
      );

      setNotifier(
        notifier: controller.paginatorMaps,
        mounted: mounted,
        value: _updatedMaps,
      );

      _setStartAfter(
        startAfter: controller.startAfter,
        paginatorMaps: controller.paginatorMaps.value,
      );

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  void replaceMapByID({
    @required Map<String, dynamic> map,
  }){

    replaceMap.value = map;

  }
  // --------------------------------

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
        mapIDToRemove: deleteMap.value[idFieldName],
        idFieldName: idFieldName,
      );

      setNotifier(
        notifier: paginatorMaps,
        mounted: mounted,
        value: _updatedMaps,
      );

      _setStartAfter(
        startAfter: startAfter,
        paginatorMaps: paginatorMaps.value,
      );

    }


  }
  // ---------
  /// TESTED : WORKS PERFECT
  void deleteMapByID({
    @required String id,
    String idFieldName = 'id',
  }){

    if (id != null){

      deleteMap.value = Mapper.getMapFromMapsByID(
        maps: paginatorMaps.value,
        id: id,
        idFieldName: idFieldName,
      );

    }

  }
  // ---------
  /// TESTED : WORKS PERFECT
  void removeMapsByIDs({
    @required List<String> ids,
    String idFieldName = 'id',
  }){

    if (Mapper.checkCanLoopList(ids) == true){

      if (paginatorMaps.value.isNotEmpty == true){

        List<Map<String, dynamic>> _maps = [];
        _maps = <Map<String, dynamic>>[...paginatorMaps.value];

       for (final String id in ids){
         _maps = Mapper.removeMapFromMapsByIdField(
           baseMaps: _maps,
           mapIDToRemove: id,
         );
       }

        paginatorMaps.value = _maps;

      }

    }

  }
  // --------------------------------

  /// START AFTER

  // ---------
  /// TESTED : WORKS PERFECT
  static void _setStartAfter({
    @required ValueNotifier<dynamic> startAfter,
    @required List<Map<String, dynamic>> paginatorMaps,
  }){

    if (Mapper.checkCanLoopList(paginatorMaps) == true){
      startAfter.value = paginatorMaps?.last['docSnapshot'] ?? paginatorMaps.last;
    }

    else {
      startAfter.value = null;
    }

  }
  // --------------------------------

  /// INSERTION

  // ---------
  /// TESTED : WORKS PERFECT
  static void insertMapsToPaginator({
    @required PaginationController controller,
    @required List<Map<String, dynamic>> mapsToAdd,
    @required bool mounted,
  }){

    List<Map<String, dynamic>> _combinedMaps = [...controller.paginatorMaps.value];

    for (final Map<String, dynamic> mapToInsert in mapsToAdd){

      final bool _contains = Mapper.checkMapsContainMapWithID(
        maps: _combinedMaps,
        map: mapToInsert,
        idFieldName: controller.idFieldName,
      );

      /// SHOULD REPLACE EXISTING MAP
      if (_contains == true){

        _combinedMaps = Mapper.replaceMapInMapsWithSameIDField(
          baseMaps: _combinedMaps,
          mapToReplace: mapToInsert,
          idFieldName: controller.idFieldName,
        );

      }

      /// SHOULD ADD NEW MAP
      else {

        if (controller.addExtraMapsAtEnd == true){
          _combinedMaps = [..._combinedMaps, mapToInsert];
        }

        else {
          _combinedMaps = [mapToInsert, ..._combinedMaps];
        }

      }

    }

    _setPaginatorMaps(
      controller: controller,
      mounted: mounted,
      maps: _combinedMaps,
    );

  }
  // ---------
  /// TESTED : WORKS PERFECT
  static void _setPaginatorMaps({
    @required PaginationController controller,
    @required List<Map<String, dynamic>> maps,
    @required bool mounted,
  }){

    setNotifier(
      notifier: controller.paginatorMaps,
      mounted: mounted,
      value: maps,
    );

    _setStartAfter(
      startAfter: controller.startAfter,
      paginatorMaps: maps,
    );

  }
  // -----------------------------------------------------------------------------
}
