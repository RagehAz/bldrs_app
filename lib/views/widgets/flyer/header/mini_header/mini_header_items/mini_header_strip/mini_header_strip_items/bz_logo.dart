import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class BzLogo extends StatelessWidget {
  final double width;
  final String image;
  final bool miniMode;
  final double corner;
  final bool bzPageIsOn;
  final bool flyerShowsAuthor;

  BzLogo({
    @required this.width,
    @required this.image,
    this.miniMode = true,
    this.corner,
    this.bzPageIsOn = false,
    this.flyerShowsAuthor,
  });


  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    double logoRoundCorners = corner == null ? width * Ratioz.bzLogoCorner : corner;
    // === === === === === === === === === === === === === === === === === === ===
    double logoZeroCorner = miniMode == true || flyerShowsAuthor == false ? logoRoundCorners : 0;
    // === === === === === === === === === === === === === === === === === === ===
    BorderRadius bzLogoCorners = superBorderRadius(context, logoRoundCorners, logoRoundCorners, logoZeroCorner, logoRoundCorners);
    // === === === === === === === === === === === === === === === === === === ===
    return Container(
      decoration: BoxDecoration(
        color: Colorz.WhiteAir,
        borderRadius: bzLogoCorners,
      ),
      child: Container(
        height: width,
        width: width,
        decoration: BoxDecoration(
            image:
                fileExtensionOf(image) == 'jpeg' || fileExtensionOf(image) == 'jpg' || fileExtensionOf(image) == 'png' ?
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover) : null,

            borderRadius: bzLogoCorners,
        ),
        child:
        fileExtensionOf(image) == 'svg' ?
        ClipRRect(
            borderRadius: bzLogoCorners,
            child: WebsafeSvg.asset(image, fit: BoxFit.cover, height:width, width: width)) : Container(),
      ),
    );
  }
}
