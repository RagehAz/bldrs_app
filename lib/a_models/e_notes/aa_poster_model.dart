import 'dart:io';

import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

enum PosterType {
  flyer,
  bz,
  image,
}

@immutable
class PosterModel {
  /// --------------------------------------------------------------------------
  const PosterModel({
    @required this.id,
    @required this.type,
    @required this.url,
    this.file,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final PosterType type;
  final String url;
  final File file;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static const List<PosterType> posterTypes = <PosterType>[
    PosterType.flyer,
    PosterType.image,
    PosterType.bz,
  ];
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  PosterModel copyWith({
    String id,
    PosterType type,
    String url,
  }){
    return PosterModel(
      id: id ?? this.id,
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
      'id': id,
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
        id: map['id'],
        type: decipherPosterType(map['type']),
        url: map['url'],
      );
    }

    return _model;
  }
  // --------------------
  ///
  static String cipherPosterType(PosterType type){
    switch(type){
      case PosterType.image:  return 'image'; break;
      case PosterType.bz:     return 'bz';    break;
      case PosterType.flyer:  return 'flyer'; break;

      default: return null;
    }
  }
  // --------------------
  ///
  static PosterType decipherPosterType(String type){
    switch(type){
      case 'image': return PosterType.image;  break;
      case 'bz':    return PosterType.bz;     break;
      case 'flyer': return PosterType.flyer;  break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  ///
  void blogPoster(){
    blog('id: $id : type : ${cipherPosterType(type)} : url : $url');
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkPostersAreIdentical({
    @required PosterModel poster1,
    @required PosterModel poster2,
  }){
    bool _areIdentical = false;

    if (poster1 == null && poster2 == null){
      _areIdentical = true;
    }

    else if (poster1 != null && poster2 != null){

      if (
          poster1.id == poster2.id &&
          poster1.url == poster2.url &&
          poster1.type == poster2.type
      ){
        _areIdentical = true;
      }

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
      id.hashCode^
      type.hashCode^
      url.hashCode;
  // -----------------------------------------------------------------------------
}
