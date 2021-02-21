import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
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
// === === === === === === === === === === === === === === === === === === ===
List<BoxShadow> superHeaderShadower(double flyerZoneWidth){
  List<BoxShadow> _shadows = <CustomBoxShadow>[CustomBoxShadow(
      color: Colorz.BlackLingerie,
      offset: Offset(0, 0),
      blurRadius: flyerZoneWidth * 0.1,
      blurStyle: BlurStyle.outer
  ),
  ];
  return _shadows;
}
// === === === === === === === === === === === === === === === === === === ===
List<BoxShadow> superFollowBtShadow(double btHeight){
  List<BoxShadow> _btShadow = <CustomBoxShadow>[
    CustomBoxShadow(
        color: Colorz.BlackPlastic,
        offset: new Offset(0, 0),
        blurRadius: btHeight * 0.1,
        blurStyle: BlurStyle.outer),
    CustomBoxShadow(
        color: Colorz.WhiteSmoke,
        offset: new Offset(0, 0),
        blurRadius: btHeight * 0.1,
        blurStyle: BlurStyle.outer),
  ];
  return _btShadow;
}
// === === === === === === === === === === === === === === === === === === ===
class Shadowz {

  static const CustomBoxShadow basicOuterShadow = CustomBoxShadow(
      color: Colorz.BlackLingerie,
      offset: Offset(0, 0),
      blurRadius: 10,
      blurStyle: BlurStyle.outer
  );

  static const List<BoxShadow> appBarShadow = <CustomBoxShadow>[
     basicOuterShadow,
  ];

}

