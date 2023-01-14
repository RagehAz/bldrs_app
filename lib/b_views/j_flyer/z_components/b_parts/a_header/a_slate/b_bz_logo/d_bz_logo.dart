import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class BzLogo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLogo({
    @required this.width,
    @required this.isVerified,
    this.image,
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
  final BorderRadius corners;
  final bool zeroCornerIsOn;
  final EdgeInsets margins;
  final Function onTap;
  final bool blackAndWhite;
  final bool shadowIsOn;
  final bool isVerified;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius bzLogoCorners = FlyerDim.logoCornersByLogoWidth(
      context: context,
      cornersOverride: corners,
      logoWidth: width,
      zeroCornerIsOn: zeroCornerIsOn,
    );
    // --------------------
    return GestureDetector(
      // key: const ValueKey<String>('bz_logo'),
      onTap: onTap,
      child: Center(
        child: Container(
          height: width,
          width: width,
          margin: margins,
          decoration: BoxDecoration(
              color: image is Color ? image : Colorz.white10,
              image: ObjectCheck.objectIsJPGorPNG(image) == false ? null :
              DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover
              ),
              borderRadius: bzLogoCorners,
              boxShadow: shadowIsOn == false ? null : FlyerColors.logoShadows(width),

          ),

          child: Stack(
            children: <Widget>[

              ClipRRect(
                key: const ValueKey<String>('bz_logo_image'),
                borderRadius: bzLogoCorners,
                child: BldrsImage(
                  width: width,
                  height: width,
                  pic: image,
                ),
              ),

              if (isVerified == true)
              SuperPositioned(
                  enAlignment: Alignment.topLeft,
                  horizontalOffset: width * 0.00,
                  verticalOffset: width * 0.00,
                  child: BldrsImage(
                    width: width * 0.2,
                    height: width * 0.2,
                    pic: Iconz.bzBagdeWhite,
                    iconColor: Colorz.yellow255,
                  ),
              ),

              if (isVerified == true)
                SuperPositioned(
                  enAlignment: Alignment.topLeft,
                  horizontalOffset: width * 0.00,
                  verticalOffset: width * 0.00,
                  child: BldrsImage(
                    width: width * 0.2,
                    height: width * 0.2,
                    pic: Iconz.check,
                    iconColor: Colorz.black255,
                    scale: 0.5,
                  ),
                ),

            ],
          ),

        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
