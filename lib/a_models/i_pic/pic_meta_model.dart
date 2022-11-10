import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// TASK : DO IMMUTABLE AND OVERRIDES THING
class PicMetaModel {
  // -----------------------------------------------------------------------------
  const PicMetaModel({
    @required this.ownersIDs,
    @required this.dimensions,
  });
  // -----------------------------------------------------------------------------
  final List<String> ownersIDs;
  final Dimensions dimensions;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PicMetaModel copyWith({
    List<String> ownersIDs,
    Dimensions dimensions,
  }){
    return PicMetaModel(
      ownersIDs: ownersIDs ?? this.ownersIDs,
      dimensions: dimensions ?? this.dimensions,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> cipherToLDB(){
    return <String, dynamic>{
      'ownersIDs': ownersIDs,
      'dimensions': dimensions.toMap(),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel decipherFromLDB(Map<String, dynamic> map){
    return PicMetaModel(
        ownersIDs: Stringer.getStringsFromDynamics(dynamics: map['ownersIDs']),
        dimensions: Dimensions.decipherDimensions(map['dimensions']),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  SettableMetadata toSettableMetadata({
    Map<String, String> extraData,
  }){
    Map<String, String> _metaDataMap = <String, String>{};

    /// ADD OWNERS IDS
    if (Mapper.checkCanLoopList(ownersIDs) == true){
      for (final String ownerID in ownersIDs) {
        _metaDataMap[ownerID] = 'cool';
      }
    }

    /// ADD DIMENSIONS
    if (dimensions != null) {
      _metaDataMap = Mapper.mergeMaps(
        baseMap: _metaDataMap,
        replaceDuplicateKeys: true,
        insert: <String, String>{
          'width': '${dimensions.width}',
          'height': '${dimensions.height}',
        },
      );
    }

    /// ADD EXTRA DATA MAP
    if (extraData != null) {
      _metaDataMap = Mapper.mergeMaps(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel decipherSettableMetaData({
    @required SettableMetadata settableMetadata,
  }){
    PicMetaModel _output;

    if (settableMetadata != null){

      _output = _decipherMetaMap(
          customMetadata: settableMetadata.customMetadata
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel decipherFullMetaData({
    @required FullMetadata fullMetadata,
  }){
    PicMetaModel _output;

    if (fullMetadata != null){

      _output = _decipherMetaMap(
          customMetadata: fullMetadata.customMetadata
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PicMetaModel _decipherMetaMap({
    @required Map<String, String> customMetadata,
  }){
    PicMetaModel _output;

    if (customMetadata != null){
      _output = PicMetaModel(
        ownersIDs: Mapper.getKeysHavingThisValue(
          map: customMetadata,
          value: 'cool',
        ),
        dimensions: Dimensions(
          width: Numeric.transformStringToDouble(customMetadata['width']),
          height: Numeric.transformStringToDouble(customMetadata['height']),
        ),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSettableMetaData(SettableMetadata metaData){
    blog('BLOGGING SETTABLE META DATA ------------------------------- START');
    if (metaData == null){
      blog('Meta data is null');
    }
    else {
      blog('cacheControl : ${metaData.cacheControl}');
      blog('contentDisposition : ${metaData.contentDisposition}');
      blog('contentEncoding : ${metaData.contentEncoding}');
      blog('contentLanguage : ${metaData.contentLanguage}');
      blog('contentType : ${metaData.contentType}');
      blog('customMetadata : ${metaData.customMetadata}');
    }
    blog('BLOGGING SETTABLE META DATA ------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFullMetaData(FullMetadata metaData){

    blog('BLOGGING FULL META DATA ------------------------------- START');
    if (metaData == null){
      blog('Meta data is null');
    }
    else {
      blog('name : ${metaData.name}');
      blog('bucket : ${metaData.bucket}');
      blog('cacheControl : ${metaData.cacheControl}');
      blog('contentDisposition : ${metaData.contentDisposition}');
      blog('contentEncoding : ${metaData.contentEncoding}');
      blog('contentLanguage : ${metaData.contentLanguage}');
      blog('contentType : ${metaData.contentType}');
      blog('customMetadata : ${metaData.customMetadata}'); // map
      blog('fullPath : ${metaData.fullPath}');
      blog('generation : ${metaData.generation}');
      blog('md5Hash : ${metaData.md5Hash}');
      blog('metadataGeneration : ${metaData.metadataGeneration}');
      blog('metageneration : ${metaData.metageneration}');
      blog('size : ${metaData.size}');
      blog('timeCreated : ${metaData.timeCreated}'); // date time
      blog('updated : ${metaData.updated}'); // date time
    }
    blog('BLOGGING FULL META DATA ------------------------------- END');

  }
  // -----------------------------------------------------------------------------
}
