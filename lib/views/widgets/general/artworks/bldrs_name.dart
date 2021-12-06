import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BldrsName extends StatelessWidget {
  final double size;

  const BldrsName({
    @required this.size,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: WebsafeSvg.asset(Iconz.bldrsNameEn),
    );
  }
}

class BldrsButton extends StatelessWidget {
  final Function onTap;
  // final double size;

  const BldrsButton({
    this.onTap,
    // this.size = 40,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
        child: const BldrsName(size: 40,),
      ),
    );
  }
}
