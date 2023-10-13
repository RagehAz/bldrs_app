import 'dart:typed_data';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

@immutable
class PDFModel {
  /// --------------------------------------------------------------------------
  const PDFModel({
    required this.name,
    required this.path,
    required this.ownersIDs,
    this.bytes,
    this.sizeMB,
  });
  /// --------------------------------------------------------------------------
  final String? name;
  final String? path;
  final Uint8List? bytes;
  final double? sizeMB;
  final List<String>? ownersIDs;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PDFModel copyWith({
    String? name,
    String? path,
    List<String>? ownersIDs,
    Uint8List? bytes,
    double? sizeMB,
  }){
    return PDFModel(
      name: name ?? this.name,
      path: path ?? this.path,
      ownersIDs: ownersIDs ?? this.ownersIDs,
      bytes: bytes ?? this.bytes,
      sizeMB: sizeMB ?? this.sizeMB,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  PDFModel nullifyField({
    bool name = false,
    bool path = false,
    bool ownersIDs = false,
    bool bytes = false,
    bool sizeMB = false,
  }){
    return PDFModel(
      name: name == true ? null : this.name,
      path: path == true ? null : this.path,
      ownersIDs: ownersIDs == true ? null : this.ownersIDs,
      bytes: bytes == true ? null : this.bytes,
      sizeMB: sizeMB == true ? null : this.sizeMB,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    bool includeBytes = false,
  }){

    Map<String, dynamic> _map = <String, dynamic>{
      'name': name,
      'path': path,
      'ownersIDs': ownersIDs,
      'sizeMB': sizeMB,
    };

    if (includeBytes == true){
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'bytes',
        value: Floaters.getIntsFromBytes(bytes),
        overrideExisting: true,
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PDFModel? decipherFromMap(Map<String, dynamic>? map){
    PDFModel? _output;

    if (map != null){

      _output = PDFModel(
        name: map['name'],
        path: map['path'],
        ownersIDs: Stringer.getStringsFromDynamics(map['ownersIDs']),
        bytes: Floaters.getBytesFromInts(map['bytes']),
        sizeMB: map['sizeMB'],
      );

    }

    return _output;
  }

  // --------------------
  /// TASK : TEST ME
  StorageMetaModel? createStorageMetaModel({
    Map<String, String>? extraData,
  }){

    return StorageMetaModel(
      ownersIDs: ownersIDs ?? [],
      name: name,
      sizeMB: sizeMB,
      data: Mapper.combineStringStringMap(
        baseMap: {},
        insert: extraData,
        replaceDuplicateKeys: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TASK : TEST ME
  static bool checkPDFModelsAreIdentical({
    required PDFModel? pdf1,
    required PDFModel? pdf2,
  }){
    bool _areIdentical = false;

    if (pdf1 == null && pdf2 == null){
      _areIdentical = true;
    }

    else if (pdf1 != null && pdf2 != null){

      if (

      pdf1.name == pdf2.name &&
      pdf1.path == pdf2.path &&
      Mapper.checkListsAreIdentical(list1: pdf1.ownersIDs, list2: pdf2.ownersIDs) &&
      Mapper.checkListsAreIdentical(list1: pdf1.bytes, list2: pdf2.bytes) == true &&
      pdf1.sizeMB == pdf2.sizeMB
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
    /// TESTED : WORKS PERFECT
  bool checkSizeLimitReached(){

    bool _bigger = false;

    if (sizeMB != null){
      _bigger = sizeMB! > Standards.maxFileSizeLimit;
    }

    return _bigger;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPDFModel({String invoker = ''}){
    blog('PDFModel ($invoker) : name : $name : path : $path : size : $sizeMB : '
        'bytes : ${bytes?.length} bytes : ownersIDs : $ownersIDs');
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse getSizeLine({
    required bool sizeLimitReached,
    required double? size,
    required int maxSize,
  }){

    // Mb / 3 Mb
    final String? _mb = getWord('phid_mb');

    if (sizeLimitReached == true){

      return Verse(
        id: '${getWord('phid_max_limit_reached')} : $size$_mb / $maxSize $_mb',
        translate: false,
      );

    }

    else {

      return Verse(
        id: '${getWord('phid_file_size')} : $size$_mb / $maxSize $_mb',
        translate: false,
      );


    }

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => 'PDFModel(name: $name, path: $path, ownersIDs: $ownersIDs, bytes: ''${bytes?.length}, sizeMB: $sizeMB)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PDFModel){
      _areIdentical = checkPDFModelsAreIdentical(
        pdf1: this,
        pdf2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      name.hashCode^
      path.hashCode^
      ownersIDs.hashCode^
      bytes.hashCode;
  // -----------------------------------------------------------------------------
}
