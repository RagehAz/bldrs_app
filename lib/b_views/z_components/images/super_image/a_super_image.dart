import 'package:bldrs/b_views/z_components/images/super_image/d_image_switcher.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:flutter/material.dart';

class SuperImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperImage({
    @required this.width,
    @required this.height,
    @required this.pic,
    this.boxFit = BoxFit.cover,
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
  final BoxFit boxFit;
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

    /// PIC IS NULL
    if (pic == null){
      return const SizedBox();
    }

    /// ON LOADING
    else if (loading == true){
      return Loading(
        size: height,
        loading: loading,
      );
    }

    /// IMAGE
    else {

      return ImageSwitcher(
        width: width,
        height: height,
        pic: pic,
        boxFit: boxFit,
        scale: scale,
        iconColor: iconColor,
        loading: loading,
        backgroundColor: backgroundColor,
        corners: corners,
        greyscale: greyscale,
      );

    }

  }
// -----------------------------------------------------------------------------
}
