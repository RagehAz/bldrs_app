import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/localizers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'dream_box.dart';

class BldrsBackButton extends StatelessWidget {
  final double size;
  final Function onTap;

  BldrsBackButton({
    this.size = 40,
    this.onTap,
});

  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: size,
      width: size,
      boxMargins: EdgeInsets.symmetric(horizontal: ((Ratioz.ddAppBarHeight - size)/2)),
      icon: superBackIcon(context),
      iconSizeFactor: 1,
      bubble: true,
      color: Colorz.WhiteAir,
      textDirection: superInverseTextDirection(context),
      boxFunction: onTap == null ? () => goBack(context) : onTap,
    );
  }
}
