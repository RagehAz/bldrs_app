import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class Borderers {
  // -----------------------------------------------------------------------------

  const Borderers();

  // -----------------------------------------------------------------------------
  /// TASK : use clipBehaviour : Clip.antiAliasWithSaveLayer instead of ClipRRect
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const BorderRadius constantCornersAll5 = BorderRadius.all(Radius.circular(5));
  static const BorderRadius constantCornersAll10 = BorderRadius.all(Radius.circular(10));
  static const BorderRadius constantCornersAll12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius constantCornersAll15 = BorderRadius.all(Radius.circular(15));
  static const BorderRadius constantCornersAll20 = BorderRadius.all(Radius.circular(20));
  // -----------------------------------------------------------------------------
  /// BORDER RADIUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius superCorners({
    @required BuildContext context,
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = cornerAll(context, corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerOnly({
    @required BuildContext context,
    double enTopLeft,
    double enBottomLeft,
    double enBottomRight,
    double enTopRight
  }) {
    return Words.textDirection(context) == 'rtl' ?
    BorderRadius.only(
      topLeft: Radius.circular(enTopRight),
      topRight: Radius.circular(enTopLeft),
      bottomLeft: Radius.circular(enBottomRight),
      bottomRight: Radius.circular(enBottomLeft),
    )
        :
    BorderRadius.only(
      topLeft: Radius.circular(enTopLeft),
      topRight: Radius.circular(enTopRight),
      bottomLeft: Radius.circular(enBottomLeft),
      bottomRight: Radius.circular(enBottomRight),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerAll(BuildContext context, double corners) {
    return BorderRadius.all(Radius.circular(corners));
  }
  // -----------------------------------------------------------------------------

  /// OUTLINE BORDER

  // --------------------
  /// TESTED : WORKS PERFECT
  static OutlineInputBorder outlines(Color borderColor, double corner) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(corner),
      borderSide: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
      gapPadding: 0,
    );
  }
  // -----------------------------------------------------------------------------

  /// SHAPES

  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius shapeOfLogo({
    @required BuildContext context,
    bool zeroCornerEnIsRight,
    double corner,
  }) {

    final BorderRadius _superLogoShape = zeroCornerEnIsRight ?
    cornerOnly(
      context: context,
      enBottomLeft: corner,
      enBottomRight: 0,
      enTopLeft: corner,
      enTopRight: corner,
    )
        :
    cornerOnly(
      context: context,
      enBottomLeft: 0,
      enBottomRight: corner,
      enTopLeft: corner,
      enTopRight: corner,
    );

    return _superLogoShape;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius shapeOfOneSideCorners({
    @required BuildContext context,
    @required AxisDirection side,
    @required double corner
  }) {
    switch (side) {
      case AxisDirection.up:
        return cornerOnly(
          context: context,
          enTopLeft: corner,
          enTopRight: corner,
          enBottomLeft: 0,
          enBottomRight: 0,
        );
        break;

      case AxisDirection.down:
        return cornerOnly(
          context: context,
          enTopLeft: 0,
          enTopRight: 0,
          enBottomLeft: corner,
          enBottomRight: corner,
        );
        break;

      case AxisDirection.right:
        return cornerOnly(
          context: context,
          enTopLeft: 0,
          enTopRight: corner,
          enBottomLeft: 0,
          enBottomRight: corner,
        );
        break;

      case AxisDirection.left:
        return cornerOnly(
          context: context,
          enTopLeft: corner,
          enTopRight: 0,
          enBottomLeft: corner,
          enBottomRight: 0,
        );
        break;

      default:
        return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getCornersAsDouble(dynamic corners) {
    double _topLeftCorner = 0;

    if (corners != null){

      if (corners.runtimeType == BorderRadius) {
        final BorderRadius _cornerBorders = corners;
        final Radius _topLeftCornerRadius = _cornerBorders?.topLeft;
        _topLeftCorner = _topLeftCornerRadius?.x;
        // print('_topLeftCorner : $_topLeftCorner');
      }

      else {
        _topLeftCorner = corners?.toDouble();
      }


    }

    return _topLeftCorner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius getCornersAsBorderRadius(BuildContext context, dynamic corners) {
    BorderRadius _cornerBorders;

    if (corners == 0) {
      _cornerBorders = BorderRadius.zero;
    }

    else if (corners.runtimeType == BorderRadius) {
      _cornerBorders = corners;
    }

    else {
      _cornerBorders = cornerAll(context, corners?.toDouble());
    }

    return _cornerBorders;
  }
  // -----------------------------------------------------------------------------
}
