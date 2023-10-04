import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class PosterModel {
  /// --------------------------------------------------------------------------
  const PosterModel({
    required this.modelID,
    required this.type,
    required this.path,
    this.picModel,
  });
  /// --------------------------------------------------------------------------
  final String? modelID;
  final PosterType? type;
  final String? path;
  final PicModel? picModel;
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

  /// STANDARDS

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PosterModel copyWith({
    String? modelID,
    PosterType? type,
    String? path,
  }){
    return PosterModel(
      modelID: modelID ?? this.modelID,
      type: type ?? this.type,
      path: path ?? this.path,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'modelID': modelID,
      'type': cipherPosterType(type),
      'path': path,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PosterModel? decipher({
    required String? modelID,
    required String? posterType,
    required String? path,
}){
    PosterModel? _model;

    final PosterType? _type = PosterModel.decipherPosterType(posterType);

    if (modelID != null && _type != null){

      _model = PosterModel(
        modelID: modelID,
        type: _type,
        path: path,
      );

    }

    return _model;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherPosterType(PosterType? type){
    switch(type){
      case PosterType.bz:             return 'bz';
      case PosterType.flyer:          return 'flyer';
      case PosterType.cameraImage:    return 'cameraImage';
      case PosterType.galleryImage:   return 'galleryImage';
      case PosterType.url:            return 'url';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PosterType? decipherPosterType(String? type){
    switch(type){
      case 'bz':            return PosterType.bz;
      case 'flyer':         return PosterType.flyer;
      case 'cameraImage':   return PosterType.cameraImage;
      case 'galleryImage':  return PosterType.galleryImage;
      case 'url':           return PosterType.url;

      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogPoster(){
    blog('id: $modelID : type : ${cipherPosterType(type)} : url : $path');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPosterDifferences(PosterModel? poster1, PosterModel? poster2,){

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

      if (poster1.path != poster2.path){
        blog('paths are not identical');
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
    required PosterModel? poster1,
    required PosterModel? poster2,
  }){
    bool _areIdentical = false;

    // blogPosterDifferences(poster1, poster2);

    if (poster1 == null && poster2 == null){
      _areIdentical = true;
    }

    else if (poster1 != null && poster2 != null){

      if (
          poster1.modelID == poster2.modelID &&
          poster1.path == poster2.path &&
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
      path.hashCode;
  // -----------------------------------------------------------------------------
}
