import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BzLogo extends StatelessWidget {
  final double width;
  final dynamic image;
  final bool miniMode;
  final BorderRadius corners;
  final bool bzPageIsOn;
  final bool flyerShowsAuthor;
  final EdgeInsets margins;
  // final File file;

  BzLogo({
    @required this.width,
    this.image,
    this.miniMode = true,
    this.corners,
    this.bzPageIsOn = false,
    this.flyerShowsAuthor,
    this.margins,
    // this.file,
  });


  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    double logoRoundCorners = width * Ratioz.bzLogoCorner;
    // === === === === === === === === === === === === === === === === === === ===
    double logoZeroCorner = miniMode == true || flyerShowsAuthor == false ? logoRoundCorners : 0;
    // === === === === === === === === === === === === === === === === === === ===
    BorderRadius bzLogoCorners = corners == null ?
    superBorderRadius(context, logoRoundCorners, logoRoundCorners, logoZeroCorner, logoRoundCorners)
    :
    corners
    ;
    // === === === === === === === === === === === === === === === === === === ===
    return Container(
      decoration: BoxDecoration(
        color: Colorz.WhiteAir,
        borderRadius: bzLogoCorners,
      ),
      margin: margins,
      child: Container(
        height: width,
        width: width,
        decoration: BoxDecoration(
            image:
            objectIsJPGorPNG(image)?
            DecorationImage(image: AssetImage(image), fit: BoxFit.cover) : null,

            borderRadius: bzLogoCorners,
        ),
        child:
        objectIsSVG(image) ?
        ClipRRect(
            borderRadius: bzLogoCorners,
            child: WebsafeSvg.asset(image, fit: BoxFit.cover, height:width, width: width)) :

        image != null && objectIsFile(image) == true ?
            ClipRRect(
              borderRadius: bzLogoCorners,
              child: Image.file(
                image,
                fit: BoxFit.cover,
                width: width,
                height: width,
                // colorBlendMode: BlendMode.overlay,
                // color: Colorz.WhiteAir,
              ),
            )

            :

        Container(),


      ),
    );
  }
}
