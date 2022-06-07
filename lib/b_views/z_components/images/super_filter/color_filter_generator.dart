import 'package:bldrs/b_views/z_components/images/super_filter/color_layers.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';
import 'package:matrix2d/matrix2d.dart';

/// The [ImageFilterModel] class to define a Filter which will applied to each color, consists of multiple [-SubFilter-]s
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
  /// TESTED : WORKS PERFECT : Build matrix of current filter
  static List<double> combineMatrixes({
  @required List<List<double>> matrixes,
}) {

    List<double> _colorMatrix;

    blog('combineMatrixes : input are : ${matrixes.length} matrixes ');

    if (Mapper.checkCanLoopList(matrixes) == true){

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
  /// TESTED : WORKS PERFECT :
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

  /// BLDRS IMAGE FILTERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static ImageFilterModel noFilter(){
    return bldrsImageFilters[0];
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<ImageFilterModel> bldrsImageFilters = <ImageFilterModel>[
    /// NORMAL
    const ImageFilterModel(
      id: 'phid_filter_normal',
      matrixes: <List<double>>[],
    ),
    /// SHARP
    ImageFilterModel(
      id: 'phid_filter_sharp',
      matrixes: <List<double>>[
        ColorFilterLayer.contrast(0.1),
        ColorFilterLayer.saturation(0.15),
      ],
    ),
    /// LIGHT
    ImageFilterModel(
      id: 'phid_filter_light',
      matrixes: <List<double>>[
        ColorFilterLayer.brightness(30),
        ColorFilterLayer.contrast(0.01),
        ColorFilterLayer.saturation(0.02),
      ],
    ),
    /// DARK
    ImageFilterModel(
      id: 'phid_filter_dark',
      matrixes: <List<double>>[
        ColorFilterLayer.brightness(-28),
        ColorFilterLayer.contrast(0.015),
        ColorFilterLayer.saturation(10),
      ],
    ),
    /// COOL
    ImageFilterModel(
      id: 'phid_filter_cool',
      matrixes: <List<double>>[
        ColorFilterLayer.sepia(0.1),
        ColorFilterLayer.colorOverlay(255, 145, 0, 0.1),
        ColorFilterLayer.brightness(10),
        ColorFilterLayer.saturation(15),
      ],
    ),
    /// WARM
    ImageFilterModel(
      id: 'phid_filter_warm',
      matrixes: <List<double>>[
        ColorFilterLayer.colorOverlay(15, 145, 152, 0.07),
        ColorFilterLayer.sepia(0.05),
      ],
    ),
    /// BLACK & WHITE
    ImageFilterModel(
      id: 'phid_filter_blackandwhite',
      matrixes: <List<double>>[
        ColorFilterLayer.grayscale(),
        ColorFilterLayer.brightness(30),
        ColorFilterLayer.colorOverlay(210, 137, 28, 0.12),
        ColorFilterLayer.contrast(0.12),
      ],
    ),
  ];
// -------------------------------------
}
