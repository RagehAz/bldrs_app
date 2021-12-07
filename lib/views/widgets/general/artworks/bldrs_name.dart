import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
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
}

class BldrsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsButton({
    this.onTap,
    // this.size = 40,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  // final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
        child: BldrsName(size: 40,),
      ),
    );
  }
}
