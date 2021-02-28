import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
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
    this.shadowIsOn,
  });


  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    double logoRoundCorners = width * Ratioz.bzLogoCorner;
    // === === === === === === === === === === === === === === === === === === ===
    double logoZeroCorner = miniMode == true || zeroCornerIsOn == false ? logoRoundCorners : 0;
    // === === === === === === === === === === === === === === === === === === ===
    BorderRadius bzLogoCorners = corners == null ?
    superBorderRadius(context, logoRoundCorners, logoRoundCorners, logoZeroCorner, logoRoundCorners)
    :
    corners
    ;
    // === === === === === === === === === === === === === === === === === === ===

    return GestureDetector(
      onTap: onTap == null ? (){} : onTap,
      child: ClipRRect(
        borderRadius: bzLogoCorners,
        child: ColorFiltered(
          colorFilter: superDesaturation(blackAndWhite),
          child: Container(
            height: width,
            width: width,
            margin: margins,
            decoration: BoxDecoration(
              color: objectIsColor(image) ? image : Colorz.WhiteAir,
                image:
                objectIsJPGorPNG(image)?
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover) : null,

                borderRadius: bzLogoCorners,
            ),
            child:

            ClipRRect(
                  borderRadius: bzLogoCorners,
                  child: superImageWidget(image)
              ),


          ),
        ),
      ),
    );
  }
}
