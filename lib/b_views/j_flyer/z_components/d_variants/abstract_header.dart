import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/d_bz_logo.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class AbstractMiniHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AbstractMiniHeader({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _stripHeight = FlyerDim.headerBoxHeight(flyerBoxWidth);
    // --------------------
    final BorderRadius _stripBorders = FlyerDim.headerBoxCorners(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final double _logoSize = FlyerDim.logoWidth(flyerBoxWidth);
    // --------------------
    return Container(
      height: _stripHeight,
      width: flyerBoxWidth,
      padding: EdgeInsets.all(flyerBoxWidth * FlyerDim.xFlyerHeaderMainPadding),
      decoration: BoxDecoration(
        borderRadius: _stripBorders,
        gradient: Colorizer.superHeaderStripGradient(Colorz.white50),
      ),

      alignment: Aligners.superCenterAlignment(context),
      child: SizedBox( /// NEED THIS BECAUSE BZLOGO HAS CENTER WIDGET
        width: _logoSize,
        height: _logoSize,
        child: BzLogo(
          width: _logoSize,
          image: bzModel.logo,
          tinyMode: FlyerDim.isTinyMode(context, flyerBoxWidth),
          corners: FlyerDim.logoCorners(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
          ),
          zeroCornerIsOn: false,
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
