import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class MiniHeaderStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniHeaderStrip({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _stripHeight = FlyerBox.headerStripHeight(
        bzPageIsOn: superFlyer.nav.bzPageIsOn, flyerBoxWidth: flyerBoxWidth);
    final BorderRadius _stripBorders = FlyerBox.superHeaderStripCorners(
      context: context,
      bzPageIsOn: superFlyer.nav.bzPageIsOn,
      flyerBoxWidth: flyerBoxWidth,
    );
// -----------------------------------------------------------------------------
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        // there was Align(Alignment: Alignment.topCenter above this container ,, delete this comment if you see me again
        height: _stripHeight,
        width: flyerBoxWidth,
        padding:
            EdgeInsets.all(flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding),
        decoration: BoxDecoration(
          borderRadius: _stripBorders,
          gradient: Colorizer.superHeaderStripGradient(Colorz.white50),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// --- BzLogo
            BzLogo(
              width: FlyerBox.logoWidth(
                  bzPageIsOn: superFlyer.nav.bzPageIsOn,
                  flyerBoxWidth: flyerBoxWidth),
              image: superFlyer.bz.logo,
              tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
              corners: FlyerBox.superLogoCorner(
                  context: context,
                  flyerBoxWidth: flyerBoxWidth,
                  zeroCornerIsOn: superFlyer.flyerShowsAuthor),
              bzPageIsOn: superFlyer.nav.bzPageIsOn,
              zeroCornerIsOn: superFlyer.flyerShowsAuthor,
              // onTap: superFlyer.onHeaderTap,
            ),

            /// --- B.NAME, B.LOCALE, AUTHOR PICTURE, AUTHOR NAME, AUTHOR TITLE, FOLLOWERS COUNT
            HeaderLabels(
              flyerBoxWidth: flyerBoxWidth,
              authorID: superFlyer.authorID,
              bzCity: superFlyer.bzCity,
              bzCountry: superFlyer.bzCountry,
              bzModel: superFlyer.bz,
              headerIsExpanded: superFlyer.nav.bzPageIsOn,
              flyerShowsAuthor: superFlyer.flyerShowsAuthor,
            ),

            /// --- FOLLOW & Call
            FollowAndCallBTs(
              flyerBoxWidth: flyerBoxWidth,
              onFollowTap: superFlyer.rec.onFollowTap,
              onCallTap: superFlyer.rec.onCallTap,
              followIsOn: superFlyer.rec.followIsOn,
              headerIsExpanded: superFlyer.nav.bzPageIsOn,
            ),
          ],
        ),
      ),
    );
  }
}
