import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';


class AbstractMiniHeader extends StatelessWidget {

  const AbstractMiniHeader({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final BzModel bzModel;

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _stripHeight = FlyerBox.headerStripHeight(
      headerIsExpanded: false,
      flyerBoxWidth: flyerBoxWidth,
    );
// -----------------------------------------------------------------------------
    final BorderRadius _stripBorders = FlyerBox.superHeaderStripCorners(
      context: context,
      bzPageIsOn: false,
      flyerBoxWidth: flyerBoxWidth,
    );
// -----------------------------------------------------------------------------
    final double _logoSize = FlyerBox.logoWidth(
        bzPageIsOn: false,
        flyerBoxWidth: flyerBoxWidth,
    );
// -----------------------------------------------------------------------------
    return Container(
      height: _stripHeight,
      width: flyerBoxWidth,
      padding: EdgeInsets.all(flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding),
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
          tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
          corners: FlyerBox.superLogoCorner(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
          ),
          zeroCornerIsOn: false,
        ),
      ),
    );
  }
}
