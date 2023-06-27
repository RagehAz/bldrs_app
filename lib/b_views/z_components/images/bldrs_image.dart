import 'dart:ui' as ui;

import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image_path_to_ui_image.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/super_image/super_image.dart';

class BldrsImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsImage({
    required this.width,
    required this.height,
    required this.pic,
    this.fit = BoxFit.cover,
    this.scale = 1,
    this.iconColor,
    this.loading = false,
    this.backgroundColor,
    this.corners,
    this.greyscale = false,
    super.key
  });
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
    required String picture,
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
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Widget getChild({
    required BuildContext context,
    required dynamic theIcon,
    bool isLoading = false,
  }) {
    return SuperImage(
      width: width,
      height: height,
      fit: fit,
      scale: scale,
      backgroundColor: backgroundColor,
      corners: corners,
      greyscale: greyscale,
      pic: theIcon,
      iconColor: iconColor,
      loading: isLoading,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WITHOUT ICON
    if (pic == null) {
      return getChild(
        context: context,
        theIcon: null,
      );
    }

    /// WITH ICON
    else {

      final bool isPicPath = ObjectCheck.objectIsPicPath(pic);
      // final bool isURL = ObjectCheck.isAbsoluteURL(pic);
      // final bool isRaster = ObjectCheck.objectIsJPGorPNG(pic);
      // final bool isSVG = ObjectCheck.objectIsSVG(pic);
      // final bool isFile = ObjectCheck.objectIsFile(pic);
      // final bool isPicModel = pic is PicModel;
      // final bool _isBytes = ObjectCheck.objectIsUint8List(pic);
      // final bool _isBase64 = ObjectCheck.isBase64(pic);
      // final bool _isUiImage = ObjectCheck.objectIsUiImage(pic);
      // final bool _isImgImage = ObjectCheck.objectIsImgImage(pic);

      /// PIC PATH
      if (isPicPath == true) {
        return BldrsImagePathToUiImage(
          imagePath: pic,
          builder: (bool loading, ui.Image uiImage) {
            return getChild(
              context: context,
              theIcon: uiImage,
              isLoading: loading,
            );
          },
        );
      }

      // /// CAN VIEW
      // if (isURL ||
      //     isRaster ||
      //     isSVG ||
      //     isFile ||
      //     _isBytes ||
      //     _isBase64 ||
      //     _isUiImage ||
      //     _isImgImage ||
      //     isPicModel) {
      //   return getChild(
      //     context: context,
      //     theIcon: pic,
      //   );
      // }

      else {
        return getChild(
          context: context,
          theIcon: pic,
        );
      }
    }


  }
// -----------------------------------------------------------------------------
}
