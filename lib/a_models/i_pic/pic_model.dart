import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
/// => TAMAM
@immutable
class PicModel {
  // -----------------------------------------------------------------------------
  const PicModel({
    @required this.bytes,
    @required this.path,
    @required this.meta,
  });
      // :
      //   assert(bytes != null, 'bytes is null'),
      //   assert(path != null, 'path is null'),
      //   assert(meta != null, 'meta is null');
  // -----------------------------------------------------------------------------
  final Uint8List bytes;
  /// collectionName/subCollectionName/fileName
  final String path;
  final PicMetaModel meta;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PicModel copyWith({
    Uint8List bytes,
    String path,
    PicMetaModel meta,
  }){
    return PicModel(
      bytes: bytes ?? this.bytes,
      path: path ?? this.path,
      meta: meta ?? this.meta,
    );
  }
  // -----------------------------------------------------------------------------

  /// LDB CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherToLDB(PicModel picModel){
    Map<String, dynamic> _map;

    if (picModel != null){
      _map = {
        'bytes': Floaters.getIntsFromUint8List(picModel.bytes),
        'path': picModel.path,
        'meta': picModel.meta.cipherToLDB()
      };
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicModel decipherFromLDB(Map<String, dynamic> map){
    PicModel _picModel;

    if (map != null){

      _picModel = PicModel(
        bytes: Floaters.getBytesFromInts(map['bytes']),
        path: map['path'],
        meta: PicMetaModel.decipherFromLDB(map['meta']),
      );

    }


    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// ASSERTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void assertIsUploadable(PicModel picModel){
    assert(picModel != null, 'picModel is null');
    assert(picModel.bytes != null, 'bytes is null');
    assert(picModel.path != null, 'path is null');
    assert(picModel.meta != null, 'meta is null');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Dimensions> getDimensions(Uint8List bytes) async {
    final Dimensions _dim = await Dimensions.superDimensions(bytes);
    return _dim;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }){
    return Filers.calculateSize(bytes.length, fileSizeUnit);
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPic({
    String invoker = '',
  }){

    final double _mega = Filers.calculateSize(bytes?.length, FileSizeUnit.megaByte);
    final double _kilo = Filers.calculateSize(bytes?.length, FileSizeUnit.kiloByte);

    blog('=> $invoker :: path : $path : ${bytes?.length} Bytes | '
        '[ (${meta?.dimensions?.width})w x (${meta?.dimensions?.height})h ] | '
        'owners : ${meta.ownersIDs} | $_mega MB | $_kilo KB');

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicsAreIdentical({
    @required PicModel pic1,
    @required PicModel pic2,
  }){
    bool _identical = false;

    if (pic1 == null && pic2 == null){
      _identical = true;
    }
    else if (pic1 != null && pic2 != null){

      if (
          pic1.path == pic2.path &&
          Mapper.checkListsAreIdentical(list1: pic1.meta.ownersIDs, list2: pic2.meta.ownersIDs) == true &&
          pic1.meta.dimensions.width == pic2.meta.dimensions.width &&
          pic1.meta.dimensions.height == pic2.meta.dimensions.height &&
          pic1.bytes.length == pic2.bytes.length &&
          Mapper.checkListsAreIdentical(list1: pic1.bytes, list2: pic2.bytes) == true
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicsListsAreIdentical({
    @required List<PicModel> list1,
    @required List<PicModel> list2,
  }){

    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1?.isEmpty == true && list2?.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (Mapper.checkCanLoopList(list1) == true && Mapper.checkCanLoopList(list2) == true){

      if (list1.length != list2.length) {
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          final bool _pairAreIdentical = checkPicsAreIdentical(
              pic1: list1[i],
              pic2: list2[i]
          );

          if (_pairAreIdentical == false) {
            _listsAreIdentical = false;
            break;
          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    blog('checkPicsListsAreIdentical : _listsAreIdentical : $_listsAreIdentical');

    return _listsAreIdentical;

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
    if (other is PicModel){
      _areIdentical = checkPicsAreIdentical(
        pic1: this,
        pic2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      meta.hashCode^
      bytes.hashCode^
      path.hashCode;
  // -----------------------------------------------------------------------------
}
