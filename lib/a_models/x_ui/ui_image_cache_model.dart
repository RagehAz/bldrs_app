import 'dart:ui' as ui;
import 'package:basics/helpers/maps/lister.dart';
import 'package:flutter/material.dart';

@immutable
class Cacher {
  // -----------------------------------------------------------------------------
  const Cacher({
    required this.id,
    required this.image,
  });
  // -----------------------------------------------------------------------------
  final String? id;
  final ui.Image? image;
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST ME
  static Cacher? getCacherFromCachers({
    required List<Cacher>? cachers,
    required String? cacherID,
  }){
    Cacher? _output;

    if (Lister.checkCanLoop(cachers) == true && cacherID != null){

      for (final Cacher cacher in cachers!){

        if (cacher.id == cacherID){
          _output = cacher;
          break;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED: WORKS PERFECT
  static List<Cacher> addCacherToCachers({
    required List<Cacher>? cachers,
    required Cacher? cacher,
    required bool overrideExisting,
  }) {
    List<Cacher> _output = <Cacher>[...?cachers];

    if (cacher != null){

      final bool _contains = cachersContainCacher(
        cachers: cachers,
        cacherID: cacher.id,
      );

      if (_contains == false){
        _output.add(cacher);
      }
      else {

        if (overrideExisting == true){
          _output = disposeCacherInCachers(
            cachers: cachers,
            cacherID: cacher.id,
          );
          _output.add(cacher);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Cacher> disposeCacherInCachers({
    required List<Cacher>? cachers,
    required String? cacherID,
  }){
    final List<Cacher> _output = <Cacher>[...?cachers];

    if (Lister.checkCanLoop(cachers) == true && cacherID != null){

      final Cacher? _cacher = Cacher.getCacherFromCachers(
        cachers: cachers,
        cacherID: cacherID,
      );

      if (_cacher != null){
        _output.removeWhere((c) => c.id == cacherID);
        // _cacher.image.dispose();
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED: WORKS PERFECT
  static bool cachersContainCacher({
    required List<Cacher>? cachers,
    required String? cacherID,
  }){
    bool _contains = false;

    if (Lister.checkCanLoop(cachers) == true && cacherID != null){

      for (final Cacher cacher in cachers!){

        if (cacher.id == cacherID){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static bool checkCachersAreIdentical({
    required Cacher? cacher1,
    required Cacher? cacher2,
  }){

    if (cacher1 == null && cacher2 == null){
      return true;
    }

    else if (cacher1 == null || cacher2 == null){
      return false;
    }
    else {

      if (
      cacher1.id == cacher2.id
      // => do not check ui.images
      ){
        return true;
      }
      else {
        return false;
      }

    }

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
    if (other is Cacher){
      _areIdentical = checkCachersAreIdentical(
        cacher1: this,
        cacher2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      image.hashCode;
  // -----------------------------------------------------------------------------
}
