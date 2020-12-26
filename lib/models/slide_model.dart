import 'package:flutter/foundation.dart';

class SlideModel{
  final flyerID;
  final slideID;
  final slideIndex;
  final picture;
  final headline;
  final description;

  SlideModel({
    @required this.flyerID,
    @required this.slideID,
    @required this.slideIndex,
    @required this.picture,
    @required this.headline,
    this.description,
});
}
