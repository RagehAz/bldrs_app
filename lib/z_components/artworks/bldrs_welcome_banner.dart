import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:flutter/material.dart';
import 'package:basics/mediator/models/dimension_model.dart';

class BldrsWelcomeBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsWelcomeBanner({
    required this.width,
    this.corners = 0,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _welcomeBannerHeight = Dimensions.concludeHeightByDimensions(
      width: width,
      graphicWidth: 22,
      graphicHeight: 18,
    );

    return SizedBox(
      width: width,
      height: _welcomeBannerHeight,
      child: ClipRRect(
        borderRadius: Borderers.cornerAll(corners),
        child: BldrsImage(
          pic: Iconz.welcomeToBldrsBanner_22x18,
          fit: BoxFit.fitWidth,
          width: width,
          height: _welcomeBannerHeight,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
