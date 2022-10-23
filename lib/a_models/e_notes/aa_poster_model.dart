import 'dart:io';

import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

enum PosterType {
  flyer,
  bz,
  galleryImage,
  cameraImage,
  url,
}

@immutable
class PosterModel {
  /// --------------------------------------------------------------------------
  const PosterModel({
    @required this.modelID,
    @required this.type,
    @required this.url,
    this.file,
  });
  /// --------------------------------------------------------------------------
  final String modelID;
  final PosterType type;
  final String url;
  final File file;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static const List<PosterType> posterTypes = <PosterType>[
    PosterType.flyer,
    PosterType.bz,
    PosterType.galleryImage,
    PosterType.cameraImage,
    PosterType.url,
  ];
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PosterModel copyWith({
    String modelID,
    PosterType type,
    String url,
  }){
    return PosterModel(
      modelID: modelID ?? this.modelID,
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap(){
    return {
      'modelID': modelID,
      'type': cipherPosterType(type),
      'url': url,
    };
  }
  // --------------------
  ///
  static PosterModel decipher(Map<String, dynamic> map){
    PosterModel _model;

    if (map != null){
      _model = PosterModel(
        modelID: map['modelID'],
        type: decipherPosterType(map['type']),
        url: map['url'],
      );
    }

    return _model;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherPosterType(PosterType type){
    switch(type){
      case PosterType.bz:             return 'bz';    break;
      case PosterType.flyer:          return 'flyer'; break;
      case PosterType.cameraImage:    return 'cameraImage'; break;
      case PosterType.galleryImage:   return 'galleryImage'; break;
      case PosterType.url:            return 'url'; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PosterType decipherPosterType(String type){
    switch(type){
      case 'bz':            return PosterType.bz;           break;
      case 'flyer':         return PosterType.flyer;        break;
      case 'cameraImage':   return PosterType.cameraImage;  break;
      case 'galleryImage':  return PosterType.galleryImage; break;
      case 'url':           return PosterType.url;          break;

      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPoster(){
    blog('id: $modelID : type : ${cipherPosterType(type)} : url : $url');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPosterDifferences(PosterModel poster1, PosterModel poster2,){

    blog('blogPosterDifferences : START');

    if (poster1 == null){
      blog('poster1 is null');
    }

    if (poster2 == null){
      blog('poster2 is null');
    }

    if (poster1 != null && poster2 != null){

      if (poster1.modelID != poster2.modelID){
        blog('modelIDs are not identical');

      }

      if (poster1.url != poster2.url){
        blog('urls are not identical');
      }

      if (poster1.type != poster2.type){
        blog('types are not identical');
      }

    }

    blog('blogPosterDifferences : END');

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPostersAreIdentical({
    @required PosterModel poster1,
    @required PosterModel poster2,
  }){
    bool _areIdentical = false;

    // blogPosterDifferences(poster1, poster2);

    if (poster1 == null && poster2 == null){
      _areIdentical = true;
    }

    else if (poster1 != null && poster2 != null){

      if (
          poster1.modelID == poster2.modelID &&
          poster1.url == poster2.url &&
          poster1.type == poster2.type
      ){
        _areIdentical = true;
      }

    }

    if (_areIdentical == false){
      blogPosterDifferences(poster1, poster2);
    }

    return _areIdentical;
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
    if (other is PosterModel){
      _areIdentical = checkPostersAreIdentical(
        poster1: this,
        poster2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      modelID.hashCode^
      type.hashCode^
      url.hashCode;
  // -----------------------------------------------------------------------------
}
