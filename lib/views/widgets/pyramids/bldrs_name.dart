import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BldrsName extends StatelessWidget {
  final double width;
  final double height;

  const BldrsName({
    @required this.width,
    @required this.height,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: WebsafeSvg.asset(Iconz.BldrsNameEn),
    );
  }
}
