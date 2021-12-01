import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/views/widgets/general/images/super_image.dart';
import 'package:flutter/material.dart';

class BldrsWelcomeBanner extends StatelessWidget {
  final double width;
  final double corners;

  const BldrsWelcomeBanner({
    @required this.width,
    this.corners = 0,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _welcomeBannerHeight = ImageSize.concludeHeightByGraphicSizes(
      width: width,
      graphicWidth: 22,
      graphicHeight: 18,
    );

    return Container(
      width: width,
      height: _welcomeBannerHeight,
      child: ClipRRect(
        borderRadius: Borderers.superBorderAll(context, corners),
        child: SuperImage(
          Iconz.WelcomeToBldrsBanner_22x18,
          fit: BoxFit.fitWidth,
          width: width,
          height: _welcomeBannerHeight,
        ),
      ),
    );
  }
}
