import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BldrsName extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsName({
    @required this.size,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: size,
      height: size,
      child: WebsafeSvg.asset(Iconz.bldrsNameEn),
    );
  }
/// --------------------------------------------------------------------------
}
