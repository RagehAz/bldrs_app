import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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

    final double _welcomeBannerHeight = ImageSize.concludeHeightByGraphicSizes(
      width: width,
      graphicWidth: 22,
      graphicHeight: 18,
    );

    return SizedBox(
      width: width,
      height: _welcomeBannerHeight,
      child: ClipRRect(
        borderRadius: Borderers.superBorderAll(context, corners),
        child: SuperImage(
          pic: Iconz.welcomeToBldrsBanner_22x18,
          fit: BoxFit.fitWidth,
          width: width,
          height: _welcomeBannerHeight,
        ),
      ),
    );

  }
}
