import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BldrsName extends StatelessWidget {
  final double size;

  const BldrsName({
    @required this.size,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: WebsafeSvg.asset(Iconz.BldrsNameEn),
    );
  }
}
