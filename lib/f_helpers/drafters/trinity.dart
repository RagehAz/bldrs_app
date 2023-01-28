import 'dart:typed_data';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class Trinity {
  // -----------------------------------------------------------------------------

  const Trinity();

  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<double> cipherMatrix(Matrix4 matrix){
    return matrix?.storage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Matrix4 decipherMatrix(List<dynamic> doubles){
    Matrix4 _matrix;

    final List<double> _doubles = Floaters.getDoublesFromDynamics(doubles);

    if (_doubles != null && _doubles.length == 16){
      _matrix = Matrix4.fromList(_doubles);
    }

    return _matrix;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogMatrix(Matrix4 matrix){
    blog('BLOGGING MATRIX\n$matrix');
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT : adjust Matrix Translation To Be In Ratio to flyer box sizes
  static Matrix4 generateSlideMatrix({
    @required Matrix4 matrix,
    @required double flyerBoxWidth,
    @required double flyerBoxHeight,
  }){

    /// matrix is received with translation values in pixels
    final List<double> _m = matrix.storage;

    /// translation values in pixels
    final double _xTranslation = _m[12]; // this is in pixels
    final double _yTranslation = _m[13]; // this is in pixels

    /// translation value in Ratios to flyer sizes
    final double _x = _xTranslation / flyerBoxWidth;
    final double _y = _yTranslation / flyerBoxHeight;

    final Float64List _list = Float64List.fromList(<double>[
      _m[0],  _m[1],  _m[2],  _m[3],
      _m[4],  _m[5],  _m[6],  _m[7],
      _m[8],  _m[9],  _m[10], _m[11],
      _x,     _y,     _m[14], _m[15]
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // --------------------
  /// TESTED : WORKS PERFECT : adjust Matrix Translation To Be In pixels
  static Matrix4 renderSlideMatrix({
    @required Matrix4 matrix,
    @required double flyerBoxWidth,
    @required double flyerBoxHeight,
  }){

    /// matrix is received with translation values are ratios to flyer sizes
    final List<double> _m = matrix.storage;

    /// translation values in ratios
    final double _xTranslation = _m[12]; // this is in ratios
    final double _yTranslation = _m[13]; // this is in ratios

    /// translation value in Ratios to flyer sizes
    final double _x = _xTranslation * flyerBoxWidth;
    final double _y = _yTranslation * flyerBoxHeight;

    final Float64List _list = Float64List.fromList(<double>[
      _m[0],  _m[1],  _m[2],  _m[3],
      _m[4],  _m[5],  _m[6],  _m[7],
      _m[8],  _m[9],  _m[10], _m[11],
      _x,     _y,     _m[14], _m[15]
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkMatrixesAreIdentical({
    @required Matrix4 matrix1,
    @required Matrix4 matrixReloaded,
  }){

    final List<double> _a = matrix1.storage;
    final List<double> _b = matrixReloaded.storage;

    return Mapper.checkListsAreIdentical(
        list1: _a,
        list2: _b
    );

  }
  // --------------------
  /*

                    // blog('matrix sent flyerWidth : $_flyerBoxWidth : flyerHeight : $_flyerBoxHeight -');
                    // blog(m.row0);
                    // blog(m.row1);
                    // blog(m.row2);
                    // blog(m.row3);
                    //
                    // blog(m.storage);

                    // final List<double> _m = m.storage;
                    //
                    // final double _xTranslation = _m[12]; // this is in pixels
                    // final double _yTranslation = _m[13]; // this is in pixels
                    //
                    // /// in Ratios to flyerWidth
                    // final double _x = _xTranslation / _flyerBoxWidth;
                    // final double _y = _yTranslation / _flyerBoxHeight;
                    //
                    // final Float64List _list = Float64List.fromList([
                    //   _m[0],  _m[1],  _m[2],  _m[3],
                    //   _m[4],  _m[5],  _m[6],  _m[7],
                    //   _m[8],  _m[9],  _m[10], _m[11],
                    //   _x,     _y,     _m[14], _m[15]
                    // ]);

                    // blog(m.)

                    NOTE : remember that (0.0) origin is in top left corner
                            +x goes right
                            +y goes down

                    t : translation - r : rotation - s : scale
                    x: x axis
                    y: y axis
                    z: z axis
                    a: all axes

                    [0]   [xs]  [__]  [__]  [xt]
                    [1]   [__]  [ys]  [__]  [yt]
                    [2]   [__]  [__]  [zs]  [__]
                    [3]   [__]  [__]  [__]  [1/as]



                    [0] 1.138749326453811,0.02232896657085917,0.0,-30.159553871702524
                    [1] -0.02232896657085917,1.138749326453811,0.0,-37.20054909383884
                    [2] 0.0,0.0,1.0,0.0
                    [3] 0.0,0.0,0.0,1.0
                     */
  // -----------------------------------------------------------------------------

  /// CURVES CYPHERS

  // --------------------
  ///
  static String cipherAnimationCurve(Curve curve){

    switch (curve){
      case Curves.fastLinearToSlowEaseIn : return 'fastLinearToSlowEaseIn'; break;
      case Curves.ease : return 'ease'; break;
      case Curves.easeIn : return 'easeIn'; break;
      case Curves.easeInToLinear : return 'easeInToLinear'; break;
      case Curves.easeInSine : return 'easeInSine'; break;
      case Curves.easeInQuad : return 'easeInQuad'; break;
      case Curves.easeInCubic : return 'easeInCubic'; break;
      case Curves.easeInQuart : return 'easeInQuart'; break;
      case Curves.easeInQuint : return 'easeInQuint'; break;
      case Curves.easeInExpo : return 'easeInExpo'; break;
      case Curves.easeInCirc : return 'easeInCirc'; break;
      case Curves.easeInBack : return 'easeInBack'; break;
      case Curves.easeOut : return 'easeOut'; break;
      case Curves.linearToEaseOut : return 'linearToEaseOut'; break;
      case Curves.easeOutSine : return 'easeOutSine'; break;
      case Curves.easeOutQuad : return 'easeOutQuad'; break;
      case Curves.easeOutCubic : return 'easeOutCubic'; break;
      case Curves.easeOutQuart : return 'easeOutQuart'; break;
      case Curves.easeOutQuint : return 'easeOutQuint'; break;
      case Curves.easeOutExpo : return 'easeOutExpo'; break;
      case Curves.easeOutCirc : return 'easeOutCirc'; break;
      case Curves.easeOutBack : return 'easeOutBack'; break;
      case Curves.easeInOut : return 'easeInOut'; break;
      case Curves.easeInOutSine : return 'easeInOutSine'; break;
      case Curves.easeInOutQuad : return 'easeInOutQuad'; break;
      case Curves.easeInOutCubic : return 'easeInOutCubic'; break;
      case Curves.easeInOutQuart : return 'easeInOutQuart'; break;
      case Curves.easeInOutQuint : return 'easeInOutQuint'; break;
      case Curves.easeInOutExpo : return 'easeInOutExpo'; break;
      case Curves.easeInOutCirc : return 'easeInOutCirc'; break;
      case Curves.easeInOutBack : return 'easeInOutBack'; break;
      case Curves.fastOutSlowIn : return 'fastOutSlowIn'; break;
      case Curves.slowMiddle : return 'slowMiddle'; break;
      default: return null;
    }

  }
  // --------------------
  ///
  static Curve decipherAnimationCurve(String curve){

    switch(curve){
      case 'fastLinearToSlowEaseIn': return Curves.fastLinearToSlowEaseIn; break;
      case 'ease': return Curves.ease; break;
      case 'easeIn': return Curves.easeIn; break;
      case 'easeInToLinear': return Curves.easeInToLinear; break;
      case 'easeInSine': return Curves.easeInSine; break;
      case 'easeInQuad': return Curves.easeInQuad; break;
      case 'easeInCubic': return Curves.easeInCubic; break;
      case 'easeInQuart': return Curves.easeInQuart; break;
      case 'easeInQuint': return Curves.easeInQuint; break;
      case 'easeInExpo': return Curves.easeInExpo; break;
      case 'easeInCirc': return Curves.easeInCirc; break;
      case 'easeInBack': return Curves.easeInBack; break;
      case 'easeOut': return Curves.easeOut; break;
      case 'linearToEaseOut': return Curves.linearToEaseOut; break;
      case 'easeOutSine': return Curves.easeOutSine; break;
      case 'easeOutQuad': return Curves.easeOutQuad; break;
      case 'easeOutCubic': return Curves.easeOutCubic; break;
      case 'easeOutQuart': return Curves.easeOutQuart; break;
      case 'easeOutQuint': return Curves.easeOutQuint; break;
      case 'easeOutExpo': return Curves.easeOutExpo; break;
      case 'easeOutCirc': return Curves.easeOutCirc; break;
      case 'easeOutBack': return Curves.easeOutBack; break;
      case 'easeInOut': return Curves.easeInOut; break;
      case 'easeInOutSine': return Curves.easeInOutSine; break;
      case 'easeInOutQuad': return Curves.easeInOutQuad; break;
      case 'easeInOutCubic': return Curves.easeInOutCubic; break;
      case 'easeInOutQuart': return Curves.easeInOutQuart; break;
      case 'easeInOutQuint': return Curves.easeInOutQuint; break;
      case 'easeInOutExpo': return Curves.easeInOutExpo; break;
      case 'easeInOutCircle': return Curves.easeInOutCirc; break;
      case 'easeInOutBack': return Curves.easeInOutBack; break;
      case 'fastOutSlowIn': return Curves.fastOutSlowIn; break;
      case 'slowMiddle': return Curves.slowMiddle; break;
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------
}
