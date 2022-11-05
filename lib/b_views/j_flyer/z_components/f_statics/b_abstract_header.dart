import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:flutter/material.dart';

class AbstractHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AbstractHeader({
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
    final double _logoSize = FlyerDim.logoWidth(flyerBoxWidth);
    // --------------------
    return Container(
      height: FlyerDim.headerSlateHeight(flyerBoxWidth),
      width: flyerBoxWidth,
      padding: FlyerDim.headerSlatePaddings(flyerBoxWidth),
      decoration: BoxDecoration(
        borderRadius: FlyerDim.headerSlateCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
        ),
        gradient: FlyerColors.headerGradient,
      ),

      alignment: Aligners.superCenterAlignment(context),
      child: SizedBox( /// NEED THIS BECAUSE BZ LOGO HAS CENTER WIDGET
        width: _logoSize,
        height: _logoSize,
        child: BzLogo(
          width: _logoSize,
          image: bzModel.logoPath,
          isVerified: bzModel.isVerified,
          corners: FlyerDim.logoCornersByFlyerBoxWidth(
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
