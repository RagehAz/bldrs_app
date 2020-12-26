import 'package:bldrs/providers/combined_models/co_author.dart';
import 'package:bldrs/providers/combined_models/co_bz.dart';
import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'max_header_items/authors_flyers/gallery.dart';
import 'max_header_items/bz_pg_counter.dart';
import 'max_header_items/bz_pg_fields.dart';
import 'max_header_items/bz_pg_verse.dart';

class MaxHeader extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final CoBz coBz;
  final bool bzShowsTeam;
  final String bzID;
  // final String authorID;


  MaxHeader({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.coBz,
    @required this.bzShowsTeam,
    @required this.bzID,
    // @required this.authorID,
  });

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<CoFlyersProvider>(context);
    // final CoBz coBz = pro.hatCoBzByBzID(), mesh wa2to
    final List<CoFlyer> galleryCoFlyers = pro.hatCoFlyersByBzID(bzID);
    // === === === === === === === === === === === === === === === === === === ===
    List<CoAuthor> bzCoAuthors = coBz.coAuthors;
    // === === === === === === === === === === === === === === === === === === ===
    List<String> bzTeamIDs = [];
    bzCoAuthors.forEach((au) {bzTeamIDs.add(au.author.authorID);});
    // === === === === === === === === === === === === === === === === === === ===
    int bzConnects = coBz.bzConnects;
    int followersCount = coBz.followsCount;
    int bzTotalSaves = coBz.bzTotalSaves;
    int bzTotalShares = coBz.bzTotalShares;
    int bzTotalSlides = coBz.bzTotalSlides;
    int bzTotalViews = coBz.bzTotalViews;
    int callsCount = coBz.callsCount;
    // === === === === === === === === === === === === === === === === === === ===
    return Column(
      children: <Widget>[
        // --- BUSINESS FIELD
        BzPgFields(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          fieldo: coBz.bz.bzFieldsList,
        ),

        // // --- BUSINESS BIRTH YEAR
        // BzPgVerse(
        //   flyerZoneWidth: flyerZoneWidth,
        //   bzPageIsOn: bzPageIsOn,
        //   verse: 'Established in $bzBirth',
        //   size: 2,
        // ),
        //
        // // --- BUSINESS BIRTH YEAR
        // BzPgVerse(
        //   flyerZoneWidth: flyerZoneWidth,
        //   bzPageIsOn: bzPageIsOn,
        //   verse: 'In Bldrs.net since $bldrBirth',
        //   size: 2,
        // ),

        // --- BUSINESS DESCRIPTION
        BzAboutVerse(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          verse: coBz.bz.bzAbout,
          bzName: coBz.bz.bzName,
        ),

        // --- BUILDERS CONNECTS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: bzConnects,
          verse: 'Builders connected',
          icon: Iconz.HandShake,
          iconSizeFactor: 0.98,
        ),

        // --- FOLLOWERS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: followersCount,
          verse: 'followers',
          icon: Iconz.Follow,
          iconSizeFactor: 0.8,
        ),

        // --- CALLS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: callsCount,
          verse: 'calls received',
          icon: Iconz.ComPhone,
          iconSizeFactor: 0.8,
        ),

        // --- PUBLISHED SLIDE & FLYERS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalSlides,
          verse: 'slides published',
          icon: Iconz.Gallery,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL VIEWS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalViews,
          verse: 'total flyers\' views',
          icon: Iconz.Views,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL SHARES
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalShares,
          verse: 'total shared flyers',
          icon: Iconz.Share,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL ANKHS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalSaves,
          verse: 'total saved flyers',
          icon: Iconz.SaveOn,
          iconSizeFactor: 0.95,
        ),

        // --- PUBLISHED FLYERS AND BZ TEAM
        Gallery(
          flyerZoneWidth: flyerZoneWidth,
          bzShowsTeam: bzShowsTeam,
          followersCount: followersCount,
          bzTeamIDs: bzTeamIDs,
          bzPageIsOn: bzPageIsOn,
          bzConnects: bzConnects,
          coAuthors: bzCoAuthors,
          galleryCoFlyers: galleryCoFlyers,
          bzName: coBz.bz.bzName,
          // tappingMiniFlyer: openFlyer,
        ),

      ],
    );
  }
}

