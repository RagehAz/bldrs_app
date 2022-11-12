import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_ref.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
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
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> readMetaByPath({
    @required String path,
  }) async {

    FullMetadata _meta;

    if (TextCheck.isEmpty(path) == false){

      await tryAndCatch(
        invoker: 'getMetaByPath',
        functions: () async {

          final Reference _ref = StorageRef.getRefByPath(path);

          _meta = await _ref.getMetadata();

        },
      );

    }

    return _meta;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> readMetaByURL({
    @required String url,
  }) async {
    FullMetadata _meta;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      await tryAndCatch(
        invoker: 'getMetaByURL',
        functions: () async {

          final Reference _ref = await StorageRef.getRefByURL(
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
  static Future<FullMetadata> readMetaByNodes({
    @required String collName,
    @required String docName,
  }) async {

    FullMetadata _meta;

    blog('getMetaByNodes : $collName/$docName');

    if (collName != null && docName != null){

      await tryAndCatch(
        invoker: 'getMetaByNodes',
        functions: () async {

          final Reference _ref = StorageRef.getRefByNodes(
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
  static Future<List<String>> readOwnersIDsByURL({
    @required String url,
  }) async {
    final List<String> _ids = [];

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final FullMetadata _metaData = await readMetaByURL(
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
  static Future<List<String>> readOwnersIDsByNodes({
    @required String collName,
    @required String docName,
  }) async {
    final List<String> _ids = [];

    if (docName != null && collName != null){

      final FullMetadata _metaData = await readMetaByNodes(
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
  /// TASK : TEST ME
  static Future<List<String>> readOwnersIDsByPath({
    @required String path,
  }) async {
    final List<String> _ids = [];

    if (path != null){

      final FullMetadata _metaData = await readMetaByPath(
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
  static Future<String> readDocNameByURL({
    @required String url,
    // @required bool withExtension,
  }) async {
    blog('getImageNameByURL : START');
    String _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final Reference _ref = await StorageRef.getRefByURL(
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

      final Reference _ref = await StorageRef.getRefByURL(
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

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkCanDeleteDocByNodes({
    @required String collName,
    @required String docName,
  }) async {

    assert(docName != null && collName != null,
    'checkCanDeleteStorageFile : fileName or storageDocName can not be null');

    bool _canDelete = false;

    blog('checkCanDeleteStorageFile : START');

    if (docName != null && collName != null){

      final List<String> _ownersIDs = await readOwnersIDsByNodes(
        collName: collName,
        docName: docName,
      );

      blog('checkCanDeleteStorageFile : _ownersIDs : $_ownersIDs');

      if (Mapper.checkCanLoopList(_ownersIDs) == true){

        _canDelete = Stringer.checkStringsContainString(
          strings: _ownersIDs,
          string: AuthFireOps.superUserID(),
        );

        blog('checkCanDeleteStorageFile : _canDelete : $_canDelete');

      }

    }


    blog('checkCanDeleteStorageFile : END');
    return _canDelete;
  }
  // -----------------------------------------------------------------------------
}
