import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  }) : super(color: color, offset: offset, blurRadius: blurRadius);

  @override
  Paint toPaint() {
    final Paint _result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows)
        _result.maskFilter = null;
      return true;
    }());
    return _result;
  }
}
// -----------------------------------------------------------------------------
List<BoxShadow> superFollowBtShadow(double btHeight){
  List<BoxShadow> _btShadow = <BoxShadow>[
    CustomBoxShadow(
        color: Colorz.Black125,
        offset: new Offset(0, 0),
        blurRadius: btHeight * 0.1,
        blurStyle: BlurStyle.outer),
    CustomBoxShadow(
        color: Colorz.White80,
        offset: new Offset(0, 0),
        blurRadius: btHeight * 0.1,
        blurStyle: BlurStyle.outer),
  ];
  // return _btShadow;
  /// TASK : optimize shadows
  return null;
}
// -----------------------------------------------------------------------------
class Shadowz {
// -----------------------------------------------------------------------------
  static const BoxShadow basicOuterShadow = CustomBoxShadow(
      color: Colorz.Black200,
      offset: Offset(0, 0),
      blurRadius: 10,
      blurStyle: BlurStyle.outer
  );

  static const List<BoxShadow> appBarShadow = <BoxShadow>[
     basicOuterShadow,
  ];
// -----------------------------------------------------------------------------
  static List<BoxShadow> flyerZoneShadow(double flyerZoneWidth){
    List<BoxShadow> _flyerZoneShadow = <BoxShadow>[
      CustomBoxShadow(
          color: Colorz.Black230,
          blurRadius: flyerZoneWidth * 0.055,
          blurStyle: BlurStyle.outer
      ),
    ];

    return _flyerZoneShadow;
  }
// -----------------------------------------------------------------------------
  static List<BoxShadow> flyerHeaderShadow(double flyerZoneWidth){
    List<BoxShadow> _shadows = <BoxShadow>[
      CustomBoxShadow(
        color: Colorz.Black200,
        offset: Offset(0, 0),
        blurRadius: flyerZoneWidth * 0.1,
        blurStyle: BlurStyle.outer
      ),
    ];
    return _shadows;
  }
// -----------------------------------------------------------------------------


}
// -----------------------------------------------------------------------------
