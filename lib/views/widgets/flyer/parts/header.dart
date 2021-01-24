import 'package:bldrs/providers/combined_models/co_author.dart';
import 'package:bldrs/providers/combined_models/co_bz.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/scrollers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:flutter/material.dart';

import 'header_parts/common_parts/header_shadow.dart';
import 'header_parts/max_header.dart';
import 'header_parts/max_header_parts/bz_pg_headline.dart';
import 'header_parts/mini_header.dart';
import 'header_parts/mini_header_parts/mini_header_strip.dart';

class OLDHeader extends StatelessWidget {
  final CoBz coBz;
  final CoAuthor coAuthor;
  final bool flyerShowsAuthor;
  // final List<CoFlyer> bzGalleryCoFlyers;
  final bool followIsOn;
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final Function tappingHeader;
  final Function tappingFollow;
  final Function tappingUnfollow;
  final Function tappingGallery;

  OLDHeader({
    @required this.coBz,
    @required this.coAuthor,
    @required this.flyerShowsAuthor,
    // @required this.bzGalleryCoFlyers,
    @required this.followIsOn,
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.tappingHeader,
    @required this.tappingFollow,
    @required this.tappingUnfollow,
    @required this.tappingGallery,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: tappingHeader,
      child: BackdropFilter(
        filter: superBlur(bzPageIsOn),
        child: ListView(
          physics: superScroller(bzPageIsOn),
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          children: <Widget>[

            MiniHeader(
              coBz: coBz,
              coAuthor: coAuthor,
              flyerShowsAuthor: flyerShowsAuthor,
              bzGalleryCount: 0,//bzGalleryCoFlyers.length,
              flyerZoneWidth: flyerZoneWidth,
              bzPageIsOn: bzPageIsOn,
              tappingHeader: tappingFollow,
              tappingFollow: tappingFollow,
              followIsOn: followIsOn,
            ),

            // 3ayzeen zorar follow gowwa el bzPage

            // bzPageIsOn == false ? Container() :
            MaxHeader(
              // galleryCoFlyers: bzGalleryCoFlyers,
              flyerZoneWidth: flyerZoneWidth,
              bzPageIsOn: bzPageIsOn,
              coBz: coBz,
              bzShowsTeam: coBz?.bz?.bzShowsTeam,
              bzID: coBz.bz.bzId,
            ),

          ],
        ),
      )
    );

  }
}

class Header extends StatelessWidget {
  final CoBz coBz;
  final CoAuthor coAuthor;
  final bool flyerShowsAuthor;
  // final List<CoFlyer> bzGalleryCoFlyers;
  final bool followIsOn;
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final Function tappingHeader;
  final Function tappingFollow;
  final Function tappingUnfollow;

  Header({
    this.coBz,
    this.coAuthor,
    this.flyerShowsAuthor = true,
    this.followIsOn = false,
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.tappingHeader,
    @required this.tappingFollow,
    @required this.tappingUnfollow,
  });

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === ===
    String _phoneNumber = feinPhoneFromContacts(coBz?.bzContacts);
    // --- B.LOCALE --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    String bzCity = coBz != null ? coBz?.bz?.bzCountry : '';
    String bzCountry = coBz != null ? coBz?.bz?.bzCity : '';
    String businessLocale = localeStringer(context, bzCity, bzCountry);
    // === === === === === === === === === === === === === === === === === === ===

    return GestureDetector(
        onTap: tappingHeader,
        child: BackdropFilter(
          filter: superBlur(bzPageIsOn),
          child: ListView(
            physics: superScroller(bzPageIsOn),
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            children: <Widget>[

              Container(
                height: superHeaderHeight(bzPageIsOn, flyerZoneWidth),
                width: flyerZoneWidth,
                child: Stack(
                  children: <Widget>[

                    // --- HEADER SHADOW
                    HeaderShadow(
                      flyerZoneWidth: flyerZoneWidth,
                      bzPageIsOn: bzPageIsOn,
                    ),

                    // --- HEADER COMPONENTS
                    MiniHeaderStrip(
                      flyerZoneWidth: flyerZoneWidth,
                      bzPageIsOn: bzPageIsOn,
                      flyerShowsAuthor: flyerShowsAuthor,
                      authorID: coAuthor?.author?.authorID,
                      bzLogo: coBz?.bz?.bzLogo,
                      bzName: coBz?.bz?.bzName,
                      bzCity: coBz?.bz?.bzCity,
                      bzCountry: coBz?.bz?.bzCountry,
                      phoneNumber: _phoneNumber,
                      aPic: coAuthor?.coUser?.user?.pic,
                      aName: coAuthor?.coUser?.user?.name,
                      aTitle: coAuthor?.coUser?.user?.title,
                      followersCount: coBz?.followsCount,
                      followIsOn: followIsOn,
                      bzGalleryCount: coAuthor?.authorFlyersIDs?.length,
                      bzConnects: coBz?.bzConnects,
                      tappingHeader: tappingHeader,
                      tappingFollow: tappingFollow,
                    ),

                    // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
                    BzPageHeadline(
                      flyerZoneWidth: flyerZoneWidth,
                      bzPageIsOn: bzPageIsOn,
                      bzLocale: businessLocale,
                      bzName: coBz?.bz?.bzName,
                    ),

                  ],
                ),
              ),

              // 3ayzeen zorar follow gowwa el bzPage
              bzPageIsOn == false ? Container() :
              MaxHeader(
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: bzPageIsOn,
                coBz: coBz,
                bzShowsTeam: coBz?.bz?.bzShowsTeam,
                bzID: coBz?.bz?.bzId,
              ),

            ],
          ),
        )
    );

  }
}

