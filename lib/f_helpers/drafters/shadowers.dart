import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
class CustomBoxShadow extends BoxShadow {
  /// --------------------------------------------------------------------------
  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.style = BlurStyle.normal,
  }) : super(color: color, offset: offset, blurRadius: blurRadius);

  /// --------------------------------------------------------------------------
  final BlurStyle style;

  /// --------------------------------------------------------------------------
  @override
  Paint toPaint() {
    final Paint _result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(style, blurSigma);

    assert(() {
      if (debugDisableShadows) {
        _result.maskFilter = null;
      }
      return true;
    }(), 'debugDisableShadows must be false to show shadow');

    return _result;
  }
}
// -----------------------------------------------------------------------------
List<BoxShadow> superFollowBtShadow(double btHeight) {
  // List<BoxShadow> _btShadow = <BoxShadow>[
  //   CustomBoxShadow(
  //       color: Colorz.Black125,
  //       offset: new Offset(0, 0),
  //       blurRadius: btHeight * 0.1,
  //       blurStyle: BlurStyle.outer),
  //   CustomBoxShadow(
  //       color: Colorz.White80,
  //       offset: new Offset(0, 0),
  //       blurRadius: btHeight * 0.1,
  //       blurStyle: BlurStyle.outer),
  // ];
  // return _btShadow;
  /// TASK : optimize shadows
  return null;
}
// -----------------------------------------------------------------------------
const BoxShadow basicOuterShadow = CustomBoxShadow(
    color: Colorz.black200,
    blurRadius: 10,
    style: BlurStyle.outer
);
// -----------------------------------------------------------------------------
const List<BoxShadow> appBarShadow = <BoxShadow>[
  basicOuterShadow,
];
// -----------------------------------------------------------------------------
List<BoxShadow> flyerZoneShadow(double flyerBoxWidth) {
  final List<BoxShadow> _flyerZoneShadow = <BoxShadow>[
    CustomBoxShadow(
        color: Colorz.black230,
        blurRadius: flyerBoxWidth * 0.055,
        style: BlurStyle.outer),
  ];

  return _flyerZoneShadow;
}
// -----------------------------------------------------------------------------
List<BoxShadow> flyerHeaderShadow(double flyerBoxWidth) {
  final List<BoxShadow> _shadows = <BoxShadow>[
    CustomBoxShadow(
        color: Colorz.black200,
        blurRadius: flyerBoxWidth * 0.1,
        style: BlurStyle.outer),
  ];
  return _shadows;
}
// -----------------------------------------------------------------------------
