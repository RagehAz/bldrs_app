import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'max_header_parts/bz_pg_counter.dart';
import 'max_header_parts/bz_pg_fields.dart';
import 'max_header_parts/bz_pg_verse.dart';
import 'max_header_parts/gallery.dart';

class MaxHeader extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final BzModel bz;
  final bool bzShowsTeam;
  // final String authorID;


  MaxHeader({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    this.bz,
    this.bzShowsTeam,
    // @required this.authorID,
  });

  @override
  Widget build(BuildContext context) {
    final prof = Provider.of<FlyersProvider>(context);
    final List<FlyerModel> galleryFlyers = prof.getFlyersByBzModel(bz);
    // === === === === === === === === === === === === === === === === === === ===
    List<AuthorModel> bzAuthors = bz != null ? bz?.authors : [];
    // === === === === === === === === === === === === === === === === === === ===
    List<String> bzTeamIDs = [];
    if(bzAuthors != null) {
      bzAuthors.forEach((au) {
        bzTeamIDs.add(au.userID);
      });
    }
    // === === === === === === === === === === === === === === === === === === ===
    int bzConnects      = bz != null ? bz.bzTotalConnects   : 0;
    int followersCount  = bz != null ? bz.bzTotalFollowers  : 0;
    int bzTotalSaves    = bz != null ? bz.bzTotalSaves      : 0;
    int bzTotalShares   = bz != null ? bz.bzTotalShares     : 0;
    int bzTotalSlides   = bz != null ? bz.bzTotalSlides     : 0;
    int bzTotalViews    = bz != null ? bz.bzTotalViews      : 0;
    int callsCount      = bz != null ? bz.bzTotalCalls      : 0;
    // === === === === === === === === === === === === === === === === === === ===
    String bzScope = bz != null ? bz.bzScope : '';
    return Column(
      children: <Widget>[
        // --- BUSINESS FIELD
        BzPgFields(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          bzScope: bzScope,
        ),

        // --- BUSINESS BIRTH YEAR
        BzPgVerse(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          verse: 'In Bldrs.net since ${bz.bldrBirth}',
          size: 2,
        ),

        // --- BUSINESS DESCRIPTION
        BzAboutVerse(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          verse: bz != null ? bz.bzAbout : '',
          bzName:  bz != null ? bz.bzName : '',
        ),

        // --- BUILDERS CONNECTS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: bzConnects,
          verse: Wordz.bldrsConnected(context),
          icon: Iconz.HandShake,
          iconSizeFactor: 0.98,
        ),

        // --- FOLLOWERS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: followersCount,
          verse: Wordz.followers(context),
          icon: Iconz.Follow,
          iconSizeFactor: 0.8,
        ),

        // --- CALLS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: callsCount,
          verse: Wordz.callsReceived(context),
          icon: Iconz.ComPhone,
          iconSizeFactor: 0.8,
        ),

        // --- PUBLISHED SLIDE & FLYERS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalSlides,
          verse: Wordz.slidesPublished(context),
          icon: Iconz.Gallery,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL VIEWS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalViews,
          verse: Wordz.totalViews(context),
          icon: Iconz.Views,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL SHARES
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalShares,
          verse: Wordz.totalShares(context),
          icon: Iconz.Share,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL ANKHS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: bzTotalSaves,
          verse: Wordz.totalSaves(context),
          icon: Iconz.SaveOn,
          iconSizeFactor: 0.95,
        ),

        // --- BZ GALLERY
        Gallery(
          flyerZoneWidth: flyerZoneWidth,
          bzShowsTeam: bzShowsTeam,
          followersCount: followersCount,
          bzTeamIDs: bzTeamIDs,
          bzPageIsOn: bzPageIsOn,
          bzConnects: bzConnects,
          authors: bzAuthors,
          galleryFlyers: galleryFlyers,
          bzName:  bz != null ? bz.bzName : '',
          // tappingMiniFlyer: openFlyer,
        ),

      ],
    );
  }
}

