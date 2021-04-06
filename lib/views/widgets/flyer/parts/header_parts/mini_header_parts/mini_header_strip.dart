import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:flutter/material.dart';
import 'follow_and_call_bts.dart';
import 'header_labels.dart';

class MiniHeaderStrip extends StatelessWidget {
  final TinyBz tinyBz;
  final TinyUser tinyAuthor;
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final bool followIsOn;
  final Function tappingHeader;
  final Function tappingFollow;
  final bool flyerShowsAuthor;
  final bool stripBlurIsOn;

  MiniHeaderStrip({
    @required this.tinyBz,
    @required this.tinyAuthor,
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.followIsOn,
    @required this.tappingHeader,
    @required this.tappingFollow,
    @required this.flyerShowsAuthor,
    this.stripBlurIsOn = false,
  });

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------------------
    double _stripHeight = superHeaderStripHeight(bzPageIsOn, flyerZoneWidth);
    BorderRadius _stripBorders = Borderers.superHeaderStripCorners(context, bzPageIsOn, flyerZoneWidth);

    return
      Align(
        alignment: Alignment.topCenter,
        child: Container( // there was Align(Alignment: Alignment.topCenter above this container ,, delete this comment if you see me again
          height: _stripHeight,
          width: flyerZoneWidth,
          padding: EdgeInsets.all(flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding),
          decoration: BoxDecoration(
            borderRadius: _stripBorders,
            gradient: superHeaderStripGradient(Colorz.WhiteZircon),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            <Widget>[

              // --- BzLogo
              Expanded(
                flex: bzPageIsOn ? 1 : 26,
                child: BzLogo(
                  width: superLogoWidth(bzPageIsOn, flyerZoneWidth),
                  image: tinyBz.bzLogo,
                  miniMode: superFlyerMiniMode(context, flyerZoneWidth),
                  corners: Borderers.superLogoCorner(context, flyerZoneWidth),
                  bzPageIsOn: bzPageIsOn,
                  zeroCornerIsOn: flyerShowsAuthor,
                  onTap: tappingHeader,
                ),
              ),

              // --- B.NAME, B.LOCALE, AUTHOR PICTURE, AUTHOR NAME, AUTHOR TITLE, FOLLOWERS COUNT
              Expanded(
                flex: bzPageIsOn ? 0 : 62,
                child: HeaderLabels(
                  flyerZoneWidth: flyerZoneWidth,
                  bzPageIsOn: bzPageIsOn,
                  flyerShowsAuthor: flyerShowsAuthor ?? false,
                  tinyBz: tinyBz,
                  tinyAuthor: tinyAuthor,
                ),
              ),

              // --- FOLLOW & Call
              Expanded(
                flex: bzPageIsOn ? 0 : 11,
                child: FollowAndCallBTs(
                  flyerZoneWidth: flyerZoneWidth,
                  bzPageIsOn: bzPageIsOn,
                  followIsOn: followIsOn,
                  tappingFollow: tappingFollow,
                  phoneNumber: tinyAuthor.contact,
                ),
              ),

            ],
          ),
        ),
      )
    ;
  }
}
