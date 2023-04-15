import 'package:filers/filers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


/// Note : use picName without file extension <---------------

class StorageRef {
  /// --------------------------------------------------------------------------

  const StorageRef();

  // -----------------------------------------------------------------------------

  /// BY PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Reference getRefByPath(String path){
    return FirebaseStorage.instance.ref(path);
  }
  // -----------------------------------------------------------------------------

  /// BY NODES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Reference getRefByNodes({
    @required String collName,
    @required String docName, // without extension
  }) {

    return FirebaseStorage.instance
        .ref()
        .child(collName)
        .child(docName);

  }
  // -----------------------------------------------------------------------------

  /// BY URL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Reference> getRefByURL({
    @required String url,
  }) async {
    Reference _ref;

    await tryAndCatch(
        invoker: 'StorageRef.byURL',
        functions: () {
          final FirebaseStorage _storage = FirebaseStorage.instance;
          _ref = _storage.refFromURL(url);
        },
    );

    return _ref;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> createURLByRef({
    @required Reference ref,
  }) async {

    String _url;

    await tryAndCatch(
        invoker: '',
        functions: () async {
          _url = await ref.getDownloadURL();
        }
    );

    return _url;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogRef(Reference ref){
    blog('BLOGGING STORAGE IMAGE REFERENCE ------------------------------- START');

    if (ref == null){
      blog('Reference is null');
    }
    else {
      blog('name : ${ref.name}');
      blog('fullPath : ${ref.fullPath}');
      blog('bucket : ${ref.bucket}');
      blog('hashCode : ${ref.hashCode}');
      blog('parent : ${ref.parent}');
      blog('root : ${ref.root}');
      blog('storage : ${ref.storage}');
    }

    blog('BLOGGING STORAGE IMAGE REFERENCE ------------------------------- END');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getPathByURL(String url) async {
    String _path;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final Reference _ref = await getRefByURL(url: url);
      _path = _ref.fullPath;

    }

    // blog('getPathByURL : _path : $_path');

    return _path;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<String> createURLByPath(String path) async {
    final Reference _ref = getRefByPath(path);
    final String _url = await createURLByRef(ref: _ref);
    return _url;
  }
  // -----------------------------------------------------------------------------
}
