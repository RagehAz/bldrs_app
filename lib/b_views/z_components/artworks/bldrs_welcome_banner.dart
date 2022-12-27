import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:super_image/super_image.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class BldrsWelcomeBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsWelcomeBanner({
    @required this.width,
    this.corners = 0,
    Key key,
  }) : super(key: key);
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
        borderRadius: Borderers.cornerAll(context, corners),
        child: SuperImage(
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
