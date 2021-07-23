import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:flutter/material.dart';

class FlyerHeader extends StatelessWidget {
  final TinyBz tinyBz;
  final TinyUser tinyAuthor;
  final bool flyerShowsAuthor;
  final bool followIsOn;
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final Function tappingHeader;
  final Function onFollowTap;
  final Function onCallTap;
  final bool stripBlurIsOn;

  FlyerHeader({
    this.tinyBz,
    this.tinyAuthor,
    this.flyerShowsAuthor = true,
    this.followIsOn = false,
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.tappingHeader,
    @required this.onFollowTap,
    @required this.onCallTap,
    this.stripBlurIsOn = false,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    return GestureDetector(
        onTap: tappingHeader,
        child: ListView(
          physics: Scrollers.superScroller(bzPageIsOn),
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          children: <Widget>[

            Container(
              height: Scale.superHeaderHeight(bzPageIsOn, flyerZoneWidth),
              width: flyerZoneWidth,
              child: Stack(
                children: <Widget>[

                  if (stripBlurIsOn)
                  BlurLayer(
                    height: Scale.superHeaderHeight(bzPageIsOn, flyerZoneWidth),
                    width: flyerZoneWidth,
                    borders: Borderers.superHeaderStripCorners(context, bzPageIsOn, flyerZoneWidth),
                  ),


                  // --- HEADER SHADOW
                  HeaderShadow(
                    flyerZoneWidth: flyerZoneWidth,
                    bzPageIsOn: bzPageIsOn,
                  ),

                  // --- HEADER COMPONENTS
                  MiniHeaderStrip(
                    flyerZoneWidth: flyerZoneWidth,
                    bzPageIsOn: bzPageIsOn,
                    tinyBz: tinyBz,
                    tinyAuthor: tinyAuthor,
                    flyerShowsAuthor: flyerShowsAuthor,
                    followIsOn: followIsOn,
                    tappingHeader: tappingHeader,
                    onFollowTap: onFollowTap,
                    onCallTap: onCallTap,
                    stripBlurIsOn: stripBlurIsOn,
                  ),

                  // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
                  BzPageHeadline(
                    flyerZoneWidth: flyerZoneWidth,
                    bzPageIsOn: bzPageIsOn,
                    tinyBz: tinyBz,
                  ),

                ],
              ),
            ),

            // TASK : 3ayzeen zorar follow gowwa el bzPage
            if (bzPageIsOn)
            MaxHeader(
              flyerZoneWidth: flyerZoneWidth,
              bzPageIsOn: bzPageIsOn,
              tinyBz: tinyBz,
            ),

          ],
        )
    );

  }
}

