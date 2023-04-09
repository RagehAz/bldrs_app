import 'package:flutter/material.dart';
import 'package:super_image/super_image.dart';

class BldrsImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsImage({
    @required this.width,
    @required this.height,
    @required this.pic,
    this.fit = BoxFit.cover,
    this.scale = 1,
    this.iconColor,
    this.loading = false,
    this.backgroundColor,
    this.corners,
    this.greyscale = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double width;
  final double height;
  final BoxFit fit;
  final double scale;
  final Color iconColor;
  final bool loading;
  final Color backgroundColor;
  final dynamic corners;
  final bool greyscale;
  /// --------------------------------------------------------------------------
  static DecorationImage decorationImage({
    @required String picture,
    BoxFit boxFit
  }) {
    DecorationImage _image;

    if (picture != null && picture != '') {
      _image = DecorationImage(
        image: AssetImage(picture),
        fit: boxFit ?? BoxFit.cover,
      );
    }

    return picture == '' ? null : _image;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperImage(
      width: width,
      height: height,
      fit: fit,
      scale: scale,
      backgroundColor: backgroundColor,
      corners: corners,
      greyscale: greyscale,
      pic: pic,
      iconColor: iconColor,
      loading: loading,
    );

  }
// -----------------------------------------------------------------------------
}
