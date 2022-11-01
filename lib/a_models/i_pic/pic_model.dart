import 'dart:typed_data';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:flutter/material.dart';

@immutable
class PicModel {
  // -----------------------------------------------------------------------------
  const PicModel({
    @required this.bytes,
    @required this.path,
    @required this.meta,
  })
      :
        assert(bytes != null, 'bytes is null'),
        assert(path != null, 'path is null'),
        assert(meta != null, 'meta is null');
  // -----------------------------------------------------------------------------
  final Uint8List bytes;
  /// collectionName/subCollectionName/fileName
  final String path;
  final PicMetaModel meta;
  // -----------------------------------------------------------------------------

  /// LDB CYPHERS

  // --------------------
  ///
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
  ///
  static PicModel decipherFromLDB(Map<String, dynamic> map){
    PicModel _picModel;

    if (map != null){
      _picModel = PicModel(
        bytes: Uint8List.fromList(map['bytes'].cast<int>()),
        path: map['path'],
        meta: PicMetaModel.decipherFromLDB(map['meta']),
      );
    }

    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// ASSERTIONS

  // --------------------
  ///
  static void assertIsUploadable(PicModel picModel){
    assert(picModel != null, 'picModel is null');
    assert(picModel.bytes != null, 'bytes is null');
    assert(picModel.path != null, 'path is null');
    assert(picModel.meta != null, 'meta is null');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static Future<Dimensions> getDimensions(Uint8List bytes) async {
    final Dimensions _dim = await Dimensions.superDimensions(bytes);
    return _dim;
  }
  // --------------------
  ///
  double getSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }){
    return Filers.calculateSize(bytes.length, fileSizeUnit);
  }
  // --------------------
  ///





























  void fuck(){}
}
