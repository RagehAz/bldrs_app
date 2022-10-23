
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:flutter/material.dart';

@immutable
class PicModel {
  /// --------------------------------------------------------------------------
  const PicModel({
    @required this.pic,
    @required this.id,
    @required this.size,
    @required this.dimensions,
    @required this.owners,
  });
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final String id;
  final double size;
  final Dimensions dimensions;
  final List<String> owners;
  // -----------------------------------------------------------------------------
  void fuck(){}
}
