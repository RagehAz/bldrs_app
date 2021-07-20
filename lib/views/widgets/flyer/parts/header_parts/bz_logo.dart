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
  final bool miniMode;
  final BorderRadius corners;
  final bool bzPageIsOn;
  final bool zeroCornerIsOn;
  final EdgeInsets margins;
  final Function onTap;
  final bool blackAndWhite;
  final bool shadowIsOn;

  BzLogo({
    @required this.width,
    this.image,
    this.miniMode = true,
    this.corners,
    this.bzPageIsOn = false,
    this.zeroCornerIsOn,
    this.margins,
    this.onTap,
    this.blackAndWhite = false,
    this.shadowIsOn = false,
  });


  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double logoRoundCorners = width * Ratioz.bzLogoCorner;
// -----------------------------------------------------------------------------
    double logoZeroCorner = miniMode == true || zeroCornerIsOn == false ? logoRoundCorners : 0;
// -----------------------------------------------------------------------------
    BorderRadius bzLogoCorners = corners == null ?
    Borderers.superBorders(
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
      onTap: onTap == null ? (){} : onTap,
      child: Container(
        height: width,
        width: width,
        margin: margins,
        decoration: BoxDecoration(
            color: ObjectChecker.objectIsColor(image) ? null : Colorz.White10,
            image:
            ObjectChecker.objectIsJPGorPNG(image) ?
            DecorationImage(image: AssetImage(image), fit: BoxFit.cover) : null,
            borderRadius: bzLogoCorners,
            boxShadow:
            shadowIsOn == false ? null :
            <CustomBoxShadow>[
                CustomBoxShadow(
                    color: Colorz.Black200,
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
    );
  }
}
