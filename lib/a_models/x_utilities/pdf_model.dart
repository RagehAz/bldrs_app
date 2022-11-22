import 'dart:typed_data';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

@immutable
class PDFModel {
  /// --------------------------------------------------------------------------
  const PDFModel({
    @required this.name,
    @required this.path,
    @required this.ownersIDs,
    this.bytes,
    this.sizeMB,
  });
  /// --------------------------------------------------------------------------
  final String name;
  final String path;
  final Uint8List bytes;
  final double sizeMB;
  final List<String> ownersIDs;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TASK : TEST ME
  PDFModel copyWith({
    String name,
    String path,
    List<String> ownersIDs,
    Uint8List bytes,
    double sizeMB,
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
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
          value: Floaters.getIntsFromUint8List(bytes)
      );
    }

    return _map;
  }
  // --------------------
  /// TASK : TEST ME
  static PDFModel decipherFromMap(Map<String, dynamic> map){
    PDFModel _output;

    if (map != null){

      _output = PDFModel(
        name: map['name'],
        path: map['path'],
        ownersIDs: Stringer.getStringsFromDynamics(dynamics: map['ownersIDs']),
        bytes: Floaters.getBytesFromInts(map['bytes']),
        sizeMB: map['size'],
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  SettableMetadata createSettableMetadata({
    Map<String, String> extraData,
  }){

    Map<String, String> _metaDataMap = <String, String>{
      'sizeMB': sizeMB.toString(),
      'name': name,
    };

    /// ADD OWNERS IDS
    if (Mapper.checkCanLoopList(ownersIDs) == true){
      for (final String ownerID in ownersIDs) {
        _metaDataMap[ownerID] = 'cool';
      }
    }

    /// ADD EXTRA DATA MAP
    if (extraData != null) {
      _metaDataMap = Mapper.combineStringStringMap(
        baseMap: _metaDataMap,
        replaceDuplicateKeys: true,
        insert: extraData,
      );
    }

    return SettableMetadata(
      customMetadata: _metaDataMap,
      // cacheControl: ,
      // contentDisposition: ,
      // contentEncoding: ,
      // contentLanguage: ,
      // contentType: ,
    );


  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TASK : TEST ME
  static bool checkPDFModelsAreIdentical({
    @required PDFModel pdf1,
    @required PDFModel pdf2,
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
      _bigger = sizeMB > Standards.maxFileSizeLimit;
    }

    return _bigger;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TASK : TEST ME
  void blogPDFModel({String invoker = ''}){
    blog('PDFModel: name : $name : path : $path : size : $sizeMB : '
        'bytes : ${bytes?.length} bytes : ownersIDs : $ownersIDs');
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
