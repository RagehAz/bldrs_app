import 'dart:ui' as ui;

import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:bldrs/z_components/images/bldrs_image_path_to_ui_image.dart';
import 'package:flutter/material.dart';

class BldrsImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsImage({
    required this.width,
    required this.height,
    required this.pic,
    this.loading = false,
    this.fit = BoxFit.cover,
    this.scale = 1,
    this.iconColor,
    this.backgroundColor,
    this.corners,
    this.greyscale = false,
    this.solidGreyScale = false,
    this.borderColor,
    super.key
  });
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double? width;
  final double height;
  final BoxFit fit;
  final double scale;
  final Color? iconColor;
  final bool loading;
  final Color? backgroundColor;
  final dynamic corners;
  final bool greyscale;
  final bool solidGreyScale;
  final Color? borderColor;
  /// --------------------------------------------------------------------------
  static DecorationImage? decorationImage({
    required String? picture,
    BoxFit? boxFit
  }) {
    DecorationImage? _image;

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
    required bool isLoading,
  }) {
    return SuperImage(
      width: width,
      height: height,
      fit: fit,
      scale: scale,
      backgroundColor: backgroundColor,
      corners: corners,
      greyscale: greyscale,
      solidGreyScale: solidGreyScale,
      pic: theIcon,
      iconColor: iconColor,
      borderColor: borderColor,
      loading: isLoading,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool isPicPath = ObjectCheck.objectIsFireStoragePicPath(pic);

    /// PIC PATH
    if (isPicPath == true) {
      return BldrsImagePathToUiImage(
        imagePath: pic,
        builder: (bool pathIsLoading, ui.Image? uiImage) {

          return SuperImage(
            loading: pathIsLoading || loading,
            width: width,
            height: height,
            fit: fit,
            scale: scale,
            backgroundColor: backgroundColor,
            corners: corners,
            greyscale: greyscale,
            pic: uiImage,
            iconColor: iconColor,
          );

        },
      );
    }

    /// OTHER WISE
    else {
      return getChild(
          context: context,
          theIcon: pic,
          isLoading: loading
      );
    }

  }
// -----------------------------------------------------------------------------
}
