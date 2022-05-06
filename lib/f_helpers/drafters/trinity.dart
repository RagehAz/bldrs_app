import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------

/// BLOGGING

// -------------------------------------
/*
blogMatrix(Matrix4 matrix){

  blog('kos om ommak');

}
 */
// -----------------------------------------------------------------------------

/// BLOGGING

// -------------------------------------
/// adjust Matrix Translation To Be In Ratio to flyer box sizes
Matrix4 generateSlideMatrix({
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

  final Matrix4 _output = Matrix4.fromFloat64List(_list);

  return _output;
}
// ----------------------------------------------
/// adjust Matrix Translation To Be In pixels
Matrix4 renderSlideMatrix({
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

  final Matrix4 _output = Matrix4.fromFloat64List(_list);

  return _output;
}
// -----------------------------------------------------------------------------

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