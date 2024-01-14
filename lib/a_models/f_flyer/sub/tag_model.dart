import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:flutter/material.dart';

@immutable
class TagModel {
  // -----------------------------------------------------------------------------
  const TagModel({
    required this.modelID,
    required this.modelType,
    required this.coordinates,
  });
  // --------------------
  final String modelID;
  final ModelType modelType;
  final Dimensions coordinates;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap(){
    return {
      'modelID': modelID,
      'modelType': RecordTyper.cipherModelType(modelType),
      'coordinates': coordinates.toMap(),
    };
  }
  // --------------------
  ///
  static TagModel? decipherMap({
    required Map<String, dynamic>? map,
  }){
    TagModel? _tagModel;

    if (map != null){

      final ModelType? _modelType = RecordTyper.decipherModelType(map['modelType']);
      final Dimensions? _coordinates = Dimensions.decipherDimensions(map['coordinates']);

      if (_modelType != null && _coordinates != null){
        _tagModel = TagModel(
          modelID: map['modelID'],
          modelType: _modelType,
          coordinates: _coordinates,
        );
      }

    }

    return _tagModel;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  ///
  static bool checkTagModelsAreIdentical({
    required TagModel? tag1,
    required TagModel? tag2,
  }) {
    final Map<String, dynamic>? _tag1Map = tag1?.toMap();
    final Map<String, dynamic>? _tag2Map = tag2?.toMap();

    return Mapper.checkMapsAreIdentical(map1: _tag1Map, map2: _tag2Map);
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => '''
  TagModel(
    modelID: $modelID,
    modelType: ${RecordTyper.cipherModelType(modelType)},
    coordinates: $coordinates,
   )''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is TagModel){
      _areIdentical = checkTagModelsAreIdentical(
        tag1: this,
        tag2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      modelID.hashCode^
      modelType.hashCode^
      coordinates.hashCode;
  // -----------------------------------------------------------------------------
}
