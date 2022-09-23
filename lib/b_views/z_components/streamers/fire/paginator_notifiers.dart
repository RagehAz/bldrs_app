import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginatorNotifiers {
  /// -----------------------------------------------------------------------------
  const PaginatorNotifiers({
    @required this.paginatorMaps,
    @required this.replaceMap,
    @required this.addMap,
    @required this.deleteMap,
    @required this.startAfter,
  });
  /// -----------------------------------------------------------------------------
  final ValueNotifier<List<Map<String, dynamic>>> paginatorMaps;
  final ValueNotifier<Map<String, dynamic>> replaceMap;
  final ValueNotifier<Map<String, dynamic>> addMap;
  final ValueNotifier<Map<String, dynamic>> deleteMap;
  final ValueNotifier<QueryDocumentSnapshot> startAfter;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  static PaginatorNotifiers initialize(){

    return PaginatorNotifiers(
      paginatorMaps: ValueNotifier(<Map<String, dynamic>>[]),
      replaceMap: ValueNotifier<Map<String, dynamic>>(null),
      addMap: ValueNotifier<Map<String, dynamic>>(null),
      deleteMap: ValueNotifier<Map<String, dynamic>>(null),
      startAfter: ValueNotifier<QueryDocumentSnapshot>(null),
    );

  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
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
  void activateListeners({
    @required bool addAtEnd,
    @required bool mounted,
    @required ValueChanged<List<Map<String, dynamic>>> onDataChanged,
  }){

    _listenToPaginatorMapsChanges(
      onDataChanged: onDataChanged,
    );

    _listenToAddMap(
      mounted: mounted,
      addAtEnd: addAtEnd,
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
// --------------------
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
// --------------------
  void _listenToAddMap({
    @required bool addAtEnd,
    @required bool mounted,
  }){
    if (addMap != null){
      addMap.addListener(() {

        addMapToPaginatorMaps(
          addAtEnd: addAtEnd,
          mounted: mounted,
        );

      });
    }
  }
// --------------------
  void addMapToPaginatorMaps({
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

      startAfter.value = _combinedMaps.last['docSnapshot'];

    }

  }
  // --------------------
  /// REPLACE MAP
// --------------------
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
// --------------------
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

      startAfter.value = paginatorMaps.value.last['docSnapshot'];

    }

  }
  // --------------------
  /// DELETE MAP
// --------------------
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
// --------------------
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

      startAfter.value = paginatorMaps.value.last['docSnapshot'];

    }


  }
// --------------------
  static void addMapsToLocalMaps({
    @required ValueNotifier<List<Map<String, dynamic>>> paginatorMaps,
    @required ValueNotifier<QueryDocumentSnapshot> startAfter,
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

      startAfter.value = _combinedMaps.last['docSnapshot'];

    }

  }
  // -----------------------------------------------------------------------------
}
