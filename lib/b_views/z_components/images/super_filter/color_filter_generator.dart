import 'package:flutter/material.dart';
import 'package:matrix2d/matrix2d.dart';

/// The [ColorFilterModel] class to define a Filter which will applied to each color, consists of multiple [SubFilter]s
class ColorFilterModel {
  /// --------------------------------------------------------------------------
  const ColorFilterModel({
    @required this.name,
    @required this.matrixes,
  });
  /// --------------------------------------------------------------------------
  final String name;
  final List<List<double>> matrixes;
// -----------------------------------------------------------------------------

  /// MATRIX BUILDER

// -------------------------------------
  /// Build matrix of current filter
  static List<double> combineMatrixes({
  @required List<List<double>> matrixes,
}) {

    List<double> _colorMatrix;

    if (matrixes.isEmpty) {
      return _colorMatrix;
    }

    const Matrix2d m2d = Matrix2d();

    List<double> result = m2d.reshape([matrixes[0]], 4, 5);
    // List listA = m2d.reshape([filters[0]], 4, 5);

    for (int i = 1; i < matrixes.length; i++) {

      final List<double> listB = <double>[
        ...matrixes[i] is ColorFilterModel ?
        _getStandardMatrix()
            :
        matrixes[i]
        ,
        0,
        0,
        0,
        0,
        1,
      ];

      result = m2d.dot(
        result,
        m2d.reshape([listB], 5, 5),
      );
    }

    return List<double>.from(result.flatten.sublist(0, 20));
  }
// -----------------------------------------------------------------------------
  static List<double> _getStandardMatrix(){
    return <double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }
// -----------------------------------------------------------------------------
  /// Create new filter from this filter with given opacity
  ColorFilterModel addOpacity(double value) {
    return ColorFilterModel(
        name: name,
        matrixes: <List<double>>[
      ...matrixes,
      [
        value, 0, 0, 0, 0,
        0, value, 0, 0, 0,
        0, 0, value, 0, 0,
        0, 0, 0, 1, 0,
      ],
    ]
    );
  }
// -----------------------------------------------------------------------------
}


