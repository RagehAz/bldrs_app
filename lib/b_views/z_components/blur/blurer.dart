

class Blurer {
// -----------------------------------------------------------------

  const Blurer();

// -----------------------------------------------------------------

/// CHECKERS

// ---------------------------------------
/*
  static bool slideBlurIsOn({
    required dynamic pic,
    required ImageSize imageSize,
    required BoxFit boxFit,
    required double flyerBoxWidth,
  }) {
    /// blur layer shall only be active if the height of image supplied is smaller
    /// than flyer height when image width = flyerWidth
    /// hangebha ezzay dih
    // picture == null ? false :
    // ObjectChecker.objectIsJPGorPNG(picture) ? false :
    // boxFit == BoxFit.cover ? true :
    // boxFit == BoxFit.fitWidth || boxFit == BoxFit.contain || boxFit == BoxFit.scaleDown ? true :
    //     false;

    bool _blurIsOn = false;

    bool _imageSizeIsValid;

    if (imageSize == null ||
        imageSize.width == null ||
        imageSize.height == null ||
        imageSize.width <= 0 ||
        imageSize.height <= 0) {
      _imageSizeIsValid = false;
    } else {
      _imageSizeIsValid = true;
    }

    if (_imageSizeIsValid == true) {
      /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
      final int _originalImageWidth = imageSize.width.toInt();
      final int _originalImageHeight = imageSize.height.toInt();
      final double _originalImageRatio =
          _originalImageWidth / _originalImageHeight;

      /// slide aspect ratio : 1 / 1.74 ~= 0.575
      final double _flyerZoneHeight = flyerBoxWidth * Ratioz.xxflyerZoneHeight;
      const double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

      double _fittedImageWidth;
      double _fittedImageHeight;

      /// if fit width
      if (boxFit == BoxFit.fitWidth) {
        _fittedImageWidth = flyerBoxWidth;
        _fittedImageHeight = flyerBoxWidth / _originalImageRatio;
      }

      /// if fit height
      else {
        _fittedImageWidth = _flyerZoneHeight * _originalImageRatio;
        _fittedImageHeight = _flyerZoneHeight;
      }

      final double _fittedImageRatio = _fittedImageWidth / _fittedImageHeight;

      /// so
      /// if _originalImageRatio < 0.575 image is narrower than slide,
      /// if ratio > 0.575 image is wider than slide
      const double _errorPercentage = Ratioz
          .slideFitWidthLimit; // ~= max limit from flyer width => flyerBoxWidth * 90%
      const double _maxRatioForBlur = _slideRatio / (_errorPercentage / 100);
      const double _minRatioForBlur = _slideRatio * (_errorPercentage / 100);

      /// so if narrower more than 10% or wider more than 10%, blur should be active and boxFit shouldn't be cover
      if (_minRatioForBlur > _fittedImageRatio ||
          _fittedImageRatio > _maxRatioForBlur) {
        _blurIsOn = true;
      } else {
        _blurIsOn = false;
      }

      // File _file = pic;
      // blog('A - pic : ${_file?.fileNameWithExtension?.toString()}');
      // blog('B - ratio : $_fittedImageRatio = W:$_fittedImageWidth / H:$_fittedImageHeight');
      // blog('C - Fit : $boxFit');
      // blog('C - blur : $_blurIsOn');

    }

    return _blurIsOn;
  }
   */
// -----------------------------------------------------------------

}
