import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BzLogo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLogo({
    required this.width,
    required this.isVerified,
    this.image,
    this.corners,
    this.zeroCornerIsOn = false,
    this.margins,
    this.onTap,
    this.shadowIsOn = false,
    super.key
  });

  /// --------------------------------------------------------------------------
  final double width;
  final dynamic image;
  final BorderRadius? corners;
  final bool? zeroCornerIsOn;
  final EdgeInsets? margins;
  final Function? onTap;
  final bool shadowIsOn;
  final bool? isVerified;

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
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight();
    // --------------------
    return Center(
      child: SizedBox(
        height: width,
        width: width,
        child: Stack(
          children: <Widget>[

            /// LOGO
            BldrsBox(
              height: width,
              width: width,
              margins: margins,
              corners: bzLogoCorners,
              icon: image,

              /// TAKE CARE
              bubble: shadowIsOn,
              onTap: onTap,
            ),

            /// VERIFIED ICON
            if (Mapper.boolIsTrue(isVerified) == true)
              SuperPositioned(
                enAlignment: Alignment.topLeft,
                horizontalOffset: width * 0.00,
                verticalOffset: width * 0.00,
                appIsLTR: _appIsLTR,
                child: BldrsImage(
                  width: width * 0.2,
                  height: width * 0.2,
                  pic: Iconz.bzBadgeWhite,
                  iconColor: Colorz.yellow255,
                ),
              ),

            if (Mapper.boolIsTrue(isVerified) == true)
              SuperPositioned(
                enAlignment: Alignment.topLeft,
                horizontalOffset: width * 0.00,
                verticalOffset: width * 0.00,
                appIsLTR: _appIsLTR,
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
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
