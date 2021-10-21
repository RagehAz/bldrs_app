import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
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

class BldrsButton extends StatelessWidget {
  final Function onTap;
  // final double size;

  const BldrsButton({
    this.onTap,
    // this.size = 40,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
        child: const BldrsName(size: 40,),
      ),
    );
  }
}
