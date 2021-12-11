import 'package:bldrs/helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/helpers/theme/colorz.dart';
import 'package:bldrs/helpers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/images/super_image.dart';
import 'package:flutter/material.dart';

class BzLogo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLogo({
    @required this.width,
    this.image,
    this.tinyMode = true,
    this.corners,
    this.bzPageIsOn = false,
    this.zeroCornerIsOn,
    this.margins,
    this.onTap,
    this.blackAndWhite = false,
    this.shadowIsOn = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final dynamic image;
  final bool tinyMode;
  final BorderRadius corners;
  final bool bzPageIsOn;
  final bool zeroCornerIsOn;
  final EdgeInsets margins;
  final Function onTap;
  final bool blackAndWhite;
  final bool shadowIsOn;
  /// --------------------------------------------------------------------------
  static double cornersValue(double logoWidth){
    return  logoWidth * Ratioz.bzLogoCorner;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double logoRoundCorners = cornersValue(width);
// -----------------------------------------------------------------------------
    final double logoZeroCorner = tinyMode == true || zeroCornerIsOn == false ? logoRoundCorners : 0;
// -----------------------------------------------------------------------------
    final BorderRadius bzLogoCorners =
        corners ??
            Borderers.superBorderOnly(
                context: context,
                enTopLeft: logoRoundCorners,
                enBottomLeft: logoRoundCorners,
                enBottomRight: logoZeroCorner,
                enTopRight: logoRoundCorners);
// -----------------------------------------------------------------------------


    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: width,
          width: width,
          margin: margins,
          decoration: BoxDecoration(
              color: image is Color ? null : Colorz.white10,
              image:
              ObjectChecker.objectIsJPGorPNG(image) ?
              DecorationImage(image: AssetImage(image), fit: BoxFit.cover) : null,
              borderRadius: bzLogoCorners,
              boxShadow:
              shadowIsOn == false ? null :
              <BoxShadow>[
                Shadowz.CustomBoxShadow(
                      color: Colorz.black200,
                      blurRadius: width * 0.15,
                      blurStyle: BlurStyle.outer
                  ),
              ]
          ),

          child:
          ClipRRect(
              borderRadius: bzLogoCorners,
              child: SuperImage(image)
          ),

        ),
      ),
    );
  }
}
