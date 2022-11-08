import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMetaOps {
  /// --------------------------------------------------------------------------

  const StorageMetaOps();

  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TAMAM
  static Future<FullMetadata> getMetaByPath({
    @required String path,
  }) async {

    FullMetadata _meta;

    if (TextCheck.isEmpty(path) == false){

      await tryAndCatch(
        invoker: 'getMetaByPath',
        functions: () async {

          final Reference _ref = StorageRef.byPath(path);

          _meta = await _ref.getMetadata();

        },
      );

    }

    return _meta;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> getMetaByURL({
    @required String url,
  }) async {
    FullMetadata _meta;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      await tryAndCatch(
        invoker: 'getMetaByURL',
        functions: () async {

          final Reference _ref = await StorageRef.byURL(
            url: url,
          );

          _meta = await _ref.getMetadata();


        },
      );

    }

    return _meta;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> getMetaByNodes({
    @required String collName,
    @required String docName,
  }) async {

    FullMetadata _meta;

    blog('getMetaByNodes : $collName/$docName');

    if (collName != null && docName != null){

      await tryAndCatch(
        invoker: 'getMetaByNodes',
        functions: () async {

          final Reference _ref = StorageRef.byNodes(
            collName: collName,
            docName: docName,
          );

          _meta = await _ref?.getMetadata();

        },
      );


    }

    return _meta;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getOwnersIDsByURL({
    @required String url,
  }) async {
    final List<String> _ids = [];

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final FullMetadata _metaData = await StorageMetaOps.getMetaByURL(
        url: url,
      );

      final Map<String, String> _map = _metaData?.customMetadata;

      final List<String> _ownersIDs = Mapper.getKeysHavingThisValue(
        map: _map,
        value: 'cool',
      );

      _ids.addAll(_ownersIDs);

    }

    return _ids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getOwnersIDsByNodes({
    @required String collName,
    @required String docName,
  }) async {
    final List<String> _ids = [];

    if (docName != null && collName != null){

      final FullMetadata _metaData = await StorageMetaOps.getMetaByNodes(
        collName: collName,
        docName: docName,
      );

      final Map<String, String> _map = _metaData?.customMetadata;

      final List<String> _ownersIDs = Mapper.getKeysHavingThisValue(
        map: _map,
        value: 'cool',
      );

      _ids.addAll(_ownersIDs);

    }

    return _ids;
  }
  // --------------------
  ///
  static Future<List<String>> getOwnersIDsByPath({
    @required String path,
  }) async {
    final List<String> _ids = [];

    if (path != null){

      final FullMetadata _metaData = await StorageMetaOps.getMetaByPath(
        path: path,
      );

      final Map<String, String> _map = _metaData?.customMetadata;

      final List<String> _ownersIDs = Mapper.getKeysHavingThisValue(
        map: _map,
        value: 'cool',
      );

      _ids.addAll(_ownersIDs);

    }

    return _ids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getImageNameByURL({
    @required String url,
    // @required bool withExtension,
  }) async {
    blog('getImageNameByURL : START');
    String _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final Reference _ref = await StorageRef.byURL(
        url: url,
      );

      /// NAME WITH EXTENSION
      _output = _ref.name;

      // blog('getImageNameByURL : _output : $_output');

      // /// WITHOUT EXTENSION
      // if (withExtension == false){
      //   _output = TextMod.removeTextAfterLastSpecialCharacter(_output, '.');
      // }

      blog('getImageNameByURL :  _output : $_output');

    }


    blog('getImageNameByURL : END');
    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateMetaByURL({
    @required String picURL,
    Map<String, String> metaDataMap,
  }) async {

    /// Map<String, String> _dummyMap = <String, String>{
    ///   'width': _meta.customMetadata['width'],
    ///   'height': _meta.customMetadata['height'],
    ///   '$ownerID': 'cool,
    ///   '$ownerID': 'cool,
    ///   '$ownerID': 'cool,
    ///   ...
    ///   'owner': null, /// ASSIGNING NULL TO KEY DELETES PAIR AUTOMATICALLY.
    /// };

    blog('updatePicMetaData : START');

    if (ObjectCheck.isAbsoluteURL(picURL) == true && metaDataMap != null){

      final Reference _ref = await StorageRef.byURL(
        url: picURL,
      );

      // final FullMetadata _meta = await _ref.getMetadata();

      final SettableMetadata metaData = SettableMetadata(
        customMetadata: metaDataMap,
      );

      await _ref.updateMetadata(metaData);

      // Storage.blogFullMetaData(_meta);

    }

    blog('updatePicMetaData : END');

  }
  // -----------------------------------------------------------------------------
}
