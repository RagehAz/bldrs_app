import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class Borderers {
  // -----------------------------------------------------------------------------

  const Borderers();

  // -----------------------------------------------------------------------------
  /// TASK : use clipBehaviour : Clip.antiAliasWithSaveLayer instead of ClipRRect
  // -----------------------------------------------------------------------------
  static BorderRadius superBorderOnly({
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
  // -----------------------------------------------------------------------------
  static OutlineInputBorder superOutlineInputBorder(Color borderColor, double corner) {
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
  static BorderRadius superBorderAll(BuildContext context, double corners) {
    return BorderRadius.all(Radius.circular(corners));
  }
  // -----------------------------------------------------------------------------
  static BorderRadius superLogoShape({
    @required BuildContext context,
    bool zeroCornerEnIsRight,
    double corner,
  }) {

    final BorderRadius _superLogoShape = zeroCornerEnIsRight ?
    superBorderOnly(
      context: context,
      enBottomLeft: corner,
      enBottomRight: 0,
      enTopLeft: corner,
      enTopRight: corner,
    )
        :
    superBorderOnly(
      context: context,
      enBottomLeft: 0,
      enBottomRight: corner,
      enTopLeft: corner,
      enTopRight: corner,
    );

    return _superLogoShape;
  }
  // -----------------------------------------------------------------------------
  static BorderRadius superBorder({
    @required BuildContext context,
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = superBorderAll(context, corners.toDouble());
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
  // -----------------------------------------------------------------------------
  static double getCornersAsDouble(dynamic corners) {

    BorderRadius _cornerBorders;
    double _topLeftCorner;

    if (corners.runtimeType == BorderRadius) {
      _cornerBorders = corners;
      final Radius _topLeftCornerRadius = _cornerBorders?.topLeft;
      _topLeftCorner = _topLeftCornerRadius?.x;
      // print('_topLeftCorner : $_topLeftCorner');
    }

    else {
      _topLeftCorner = corners.toDouble();
    }

    return _topLeftCorner ?? 0;
  }
  // -----------------------------------------------------------------------------
  static BorderRadius getCornersAsBorderRadius(BuildContext context, dynamic corners) {

    BorderRadius _cornerBorders;

    if (corners == 0) {
      _cornerBorders = BorderRadius.zero;
    }

    else if (corners.runtimeType == BorderRadius) {
      _cornerBorders = corners;
    }

    else {
      _cornerBorders = superBorderAll(context, corners.toDouble());
    }

    return _cornerBorders;
  }
  // -----------------------------------------------------------------------------
  static BorderRadius superOneSideBorders({
    @required BuildContext context,
    @required AxisDirection side,
    @required double corner
  }) {
    switch (side) {
      case AxisDirection.up:
        return superBorderOnly(
          context: context,
          enTopLeft: corner,
          enTopRight: corner,
          enBottomLeft: 0,
          enBottomRight: 0,
        );
        break;

      case AxisDirection.down:
        return superBorderOnly(
          context: context,
          enTopLeft: 0,
          enTopRight: 0,
          enBottomLeft: corner,
          enBottomRight: corner,
        );
        break;

      case AxisDirection.right:
        return superBorderOnly(
          context: context,
          enTopLeft: 0,
          enTopRight: corner,
          enBottomLeft: 0,
          enBottomRight: corner,
        );
        break;

      case AxisDirection.left:
        return superBorderOnly(
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
}
