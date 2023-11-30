import 'dart:ui' as ui;

import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image_path_to_ui_image.dart';
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

    /// WITHOUT ICON
    if (pic == null) {
      return getChild(
        context: context,
        isLoading: loading,
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

      /// IS PIC MODEL
      else if (pic is PicModel){
        final PicModel _picModel = pic;
        return getChild(
            context: context,
            theIcon: _picModel.bytes,
            isLoading: loading
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
          isLoading: loading,
        );
      }
    }


  }
// -----------------------------------------------------------------------------
}
