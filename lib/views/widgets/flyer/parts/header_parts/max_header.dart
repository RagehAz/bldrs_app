import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
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
    final _prof = Provider.of<FlyersProvider>(context);
    final List<FlyerModel> _galleryFlyers = _prof.getFlyersByBzModel(bz);
    // === === === === === === === === === === === === === === === === === === ===
    List<AuthorModel> _bzAuthors = bz != null ? bz?.bzAuthors : [];
    // === === === === === === === === === === === === === === === === === === ===
    List<String> _bzTeamIDs = [];
    if(_bzAuthors != null) {
      _bzAuthors.forEach((au) {
        _bzTeamIDs.add(au.userID);
      });
    }
    // === === === === === === === === === === === === === === === === === === ===
    int _bzConnects      = bz != null ? bz.bzTotalConnects   : 0;
    int _followersCount  = bz != null ? bz.bzTotalFollowers  : 0;
    int _bzTotalSaves    = bz != null ? bz.bzTotalSaves      : 0;
    int _bzTotalShares   = bz != null ? bz.bzTotalShares     : 0;
    int _bzTotalSlides   = bz != null ? bz.bzTotalSlides     : 0;
    int _bzTotalViews    = bz != null ? bz.bzTotalViews      : 0;
    int _callsCount      = bz != null ? bz.bzTotalCalls      : 0;
    // === === === === === === === === === === === === === === === === === === ===
    String _bzScope = bz != null ? bz.bzScope : '';
    return Column(
      children: <Widget>[
        // --- BUSINESS FIELD
        BzPgFields(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          bzScope: _bzScope,
        ),

        // --- BUSINESS BIRTH YEAR
        BzPgVerse(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          verse: monthYearStringer(context,bz.bldrBirth),
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
          count: _bzConnects,
          verse: Wordz.bldrsConnected(context),
          icon: Iconz.HandShake,
          iconSizeFactor: 0.98,
        ),

        // --- FOLLOWERS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: _followersCount,
          verse: Wordz.followers(context),
          icon: Iconz.Follow,
          iconSizeFactor: 0.8,
        ),

        // --- CALLS
        BzPgCounter(
          bzPageIsOn: bzPageIsOn,
          flyerZoneWidth: flyerZoneWidth,
          count: _callsCount,
          verse: Wordz.callsReceived(context),
          icon: Iconz.ComPhone,
          iconSizeFactor: 0.8,
        ),

        // --- PUBLISHED SLIDE & FLYERS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: _bzTotalSlides,
          verse: Wordz.slidesPublished(context),
          icon: Iconz.Gallery,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL VIEWS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: _bzTotalViews,
          verse: Wordz.totalViews(context),
          icon: Iconz.Views,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL SHARES
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: _bzTotalShares,
          verse: Wordz.totalShares(context),
          icon: Iconz.Share,
          iconSizeFactor: 0.85,
        ),

        // --- TOTAL ANKHS
        BzPgCounter(
          flyerZoneWidth: flyerZoneWidth,
          bzPageIsOn: bzPageIsOn,
          count: _bzTotalSaves,
          verse: Wordz.totalSaves(context),
          icon: Iconz.SaveOn,
          iconSizeFactor: 0.95,
        ),

        // --- BZ GALLERY
        Gallery(
          flyerZoneWidth: flyerZoneWidth,
          bzShowsTeam: bzShowsTeam,
          followersCount: _followersCount,
          bzTeamIDs: _bzTeamIDs,
          bzPageIsOn: bzPageIsOn,
          bzConnects: _bzConnects,
          authors: _bzAuthors,
          galleryFlyers: _galleryFlyers,
          bzName:  bz != null ? bz.bzName : '',
          // tappingMiniFlyer: openFlyer,
        ),

      ],
    );
  }
}

