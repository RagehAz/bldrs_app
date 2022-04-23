import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:matrix2d/matrix2d.dart';

/// The [ImageFilterModel] class to define a Filter which will applied to each color, consists of multiple [SubFilter]s
class ImageFilterModel {
  /// --------------------------------------------------------------------------
  const ImageFilterModel({
    @required this.id,
    @required this.matrixes,
    this.opacity = 1,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final List<List<double>> matrixes;
  final double opacity;
// -----------------------------------------------------------------------------

  /// MATRIX BUILDER

// -------------------------------------
  /// Build matrix of current filter
  static List<double> combineMatrixes({
  @required List<List<double>> matrixes,
}) {

    List<double> _colorMatrix;

    blog('combineMatrixes : input are : ${matrixes.length} matrixes ');

    if (canLoopList(matrixes) == true){

      const Matrix2d m2d = Matrix2d();

      List<dynamic> result = m2d.reshape([matrixes[0]], 4, 5);
      // List listA = m2d.reshape([filters[0]], 4, 5);

      for (int i = 1; i < matrixes.length; i++) {

        final List<double> listB = <double>[
          ...matrixes[i] is ImageFilterModel ?
          getStandardMatrix()
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

      _colorMatrix = List<double>.from(result.flatten.sublist(0, 20));

      blog('combineMatrixes : output is : $_colorMatrix');

      return _colorMatrix;
    }

    else {
      return _colorMatrix;
    }

  }
// -----------------------------------------------------------------------------
  static List<double> getStandardMatrix(){
    return <double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ];
  }
// -----------------------------------------------------------------------------
  /// Create new filter from this filter with given opacity
  ImageFilterModel addOpacity(double value) {
    return ImageFilterModel(
        id: id,
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
  static ImageFilterModel noFilter = const ImageFilterModel(
    id: 'No Filter',
    matrixes: <List<double>>[],
  );
// -----------------------------------------------------------------------------
}
