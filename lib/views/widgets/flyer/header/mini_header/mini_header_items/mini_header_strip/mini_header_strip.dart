import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'mini_header_strip_items/bz_logo.dart';
import 'mini_header_strip_items/follow_call_bts.dart';
import 'mini_header_strip_items/header_labels.dart';

class MiniHeaderStrip extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final String bzLogo;
  final String bzName;
  final String bzCity;
  final String bzCountry;
  final String aPic;
  final String aName;
  final String aTitle;
  final int followersCount;
  final int bzGalleryCount;
  final bool followIsOn;
  final String phoneNumber;
  final Function tappingHeader;
  final Function tappingFollow;
  final bool flyerShowsAuthor;
  final int bzConnects;
  final String authorID;

  MiniHeaderStrip({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.bzLogo,
    @required this.bzName,
    @required this.bzCity,
    @required this.bzCountry,
    @required this.aPic,
    @required this.aName,
    @required this.aTitle,
    @required this.followersCount,
    @required this.bzGalleryCount,
    @required this.followIsOn,
    @required this.phoneNumber,
    @required this.tappingHeader,
    @required this.tappingFollow,
    @required this.flyerShowsAuthor,
    @required this.bzConnects,
    @required this.authorID,
  });

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------------------
    return
      Align(
        alignment: Alignment.topCenter,
        child: Container( // there was Align(Alignment: Alignment.topCenter above this container ,, delete this comment if you see me again
          height: superHeaderStripHeight(bzPageIsOn, flyerZoneWidth),
          width: flyerZoneWidth,
          padding: EdgeInsets.all(flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding),
          decoration: BoxDecoration(
            borderRadius: superHeaderStripCorners(context, bzPageIsOn, flyerZoneWidth),
            gradient: superHeaderStripGradient(),
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
                    image: bzLogo,
                    miniMode: superFlyerMiniMode(context, flyerZoneWidth),
                    corner: superLogoCorner(flyerZoneWidth),
                    bzPageIsOn: bzPageIsOn,
                    flyerShowsAuthor: flyerShowsAuthor
                ),
              ),

              // --- B.NAME, B.LOCALE, AUTHOR PICTURE, AUTHOR NAME, AUTHOR TITLE, FOLLOWERS COUNT
              Expanded(
                flex: bzPageIsOn ? 0 : 62,
                child: HeaderLabels(
                  flyerZoneWidth: flyerZoneWidth,
                  bzPageIsOn: bzPageIsOn,
                  flyerShowsAuthor: flyerShowsAuthor,
                  bzName: bzName,
                  bzCity: bzCity,
                  bzCountry: bzCountry,
                  aPic: aPic,
                  aName: aName,
                  aTitle: aTitle,
                  followersCount: followersCount,
                  bzGalleryCount: bzGalleryCount,
                  bzConnects: bzConnects,
                  authorID: authorID,
                ),
              ),

              // --- FOLLOW & Call
              Expanded(
                flex: bzPageIsOn ? 0 : 11,
                child: FollowCallBTs(
                  flyerZoneWidth: flyerZoneWidth,
                  bzPageIsOn: bzPageIsOn,
                  followIsOn: followIsOn,
                  tappingFollow: tappingFollow,
                  phoneNumber: phoneNumber,
                ),
              ),

            ],
          ),
        ),
      )
    ;
  }
}
