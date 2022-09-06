import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzLogo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLogo({
    @required this.width,
    this.image,
    this.tinyMode = true,
    this.corners,
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
  final bool zeroCornerIsOn;
  final EdgeInsets margins;
  final Function onTap;
  final bool blackAndWhite;
  final bool shadowIsOn;
  /// --------------------------------------------------------------------------
  static double cornersValue(double logoWidth) {
    return logoWidth * Ratioz.bzLogoCorner;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double logoRoundCorners = cornersValue(width);
    // --------------------
    final double logoZeroCorner =
    tinyMode == true || zeroCornerIsOn == false ? logoRoundCorners : 0;
    // --------------------
    final BorderRadius bzLogoCorners = corners ??
        Borderers.superBorderOnly(
            context: context,
            enTopLeft: logoRoundCorners,
            enBottomLeft: logoRoundCorners,
            enBottomRight: logoZeroCorner,
            enTopRight: logoRoundCorners
        );
    // --------------------
    return GestureDetector(
      key: const ValueKey<String>('bz_logo'),
      onTap: onTap,
      child: Center(
        child: Container(
          height: width,
          width: width,
          margin: margins,
          decoration: BoxDecoration(
              color: image is Color ? image : Colorz.white10,
              image: ObjectCheck.objectIsJPGorPNG(image) ?
              DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover
              )
                  :
              null,
              borderRadius: bzLogoCorners,
              boxShadow: shadowIsOn == false ? null
                  :
              <BoxShadow>[
                CustomBoxShadow(
                    color: Colorz.black200,
                    blurRadius: width * 0.15,
                    style: BlurStyle.outer
                ),
              ]
          ),

          child: ClipRRect(
            key: const ValueKey<String>('bz_logo_image'),
            borderRadius: bzLogoCorners,
            child: SuperImage(
              width: width,
              height: width,
              pic: image,
            ),
          ),

        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
