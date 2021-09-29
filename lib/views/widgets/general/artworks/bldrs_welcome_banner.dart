import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:flutter/material.dart';

class BldrsWelcomeBanner extends StatelessWidget {
  final double width;
  final double corners;

  const BldrsWelcomeBanner({
    @required this.width,
    this.corners = 0,
});

  @override
  Widget build(BuildContext context) {

    double _welcomeBannerHeight = Imagers.concludeHeightByGraphicSizes(
      width: width,
      graphicWidth: 22,
      graphicHeight: 18,
    );

    return Container(
      width: width,
      height: _welcomeBannerHeight,
      child: ClipRRect(
        borderRadius: Borderers.superBorderAll(context, corners),
        child: Imagers.superImageWidget(
          Iconz.WelcomeToBldrsBanner_22x18,
          fit: BoxFit.fitWidth,
          width: width,
          height: _welcomeBannerHeight,
        ),
      ),
    );
  }
}
