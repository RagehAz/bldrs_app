import 'package:flutter/foundation.dart';

class SlideModel{
  final String flyerID;
  final String slideID;
  final int slideIndex;
  final dynamic picture;
  final String headline;
  final String description;

  SlideModel({
    @required this.flyerID,
    @required this.slideID,
    @required this.slideIndex,
    @required this.picture,
    @required this.headline,
    this.description,
});
}
