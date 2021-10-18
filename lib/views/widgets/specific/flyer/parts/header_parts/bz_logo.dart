import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzLogo extends StatelessWidget {
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
  });

  static double cornersValue(double logoWidth){
    return  logoWidth * Ratioz.bzLogoCorner;
  }


  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double logoRoundCorners = cornersValue(width);
// -----------------------------------------------------------------------------
    final double logoZeroCorner = tinyMode == true || zeroCornerIsOn == false ? logoRoundCorners : 0;
// -----------------------------------------------------------------------------
    final BorderRadius bzLogoCorners = corners == null ?
    Borderers.superBorderOnly(
        context: context,
        enTopLeft: logoRoundCorners,
        enBottomLeft: logoRoundCorners,
        enBottomRight: logoZeroCorner,
        enTopRight: logoRoundCorners)
    :
    corners
    ;
// -----------------------------------------------------------------------------


    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: width,
          width: width,
          margin: margins,
          decoration: BoxDecoration(
              color: ObjectChecker.objectIsColor(image) ? null : Colorz.white10,
              image:
              ObjectChecker.objectIsJPGorPNG(image) ?
              DecorationImage(image: AssetImage(image), fit: BoxFit.cover) : null,
              borderRadius: bzLogoCorners,
              boxShadow:
              shadowIsOn == false ? null :
              <CustomBoxShadow>[
                  CustomBoxShadow(
                      color: Colorz.black200,
                      offset: new Offset(0, 0),
                      blurRadius: width * 0.15,
                      blurStyle: BlurStyle.outer
                  ),
              ]
          ),

          child:
          ClipRRect(
              borderRadius: bzLogoCorners,
              child: Imagers.superImageWidget(image)
          ),

        ),
      ),
    );
  }
}
