import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

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
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight(context);
    // --------------------
    return Center(
      child: SizedBox(
        height: width,
        width: width,
        child: Stack(
          children: <Widget>[
            /// LOGO
            DreamBox(
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
            if (isVerified == true)
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

            if (isVerified == true)
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
