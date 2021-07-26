import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_counter.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_fields.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_verse.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/gallery.dart';
import 'package:flutter/material.dart';

class MaxHeader extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final TinyBz tinyBz;
  final SuperFlyer superFlyer;


  MaxHeader({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.tinyBz,
    @required this.superFlyer,
  });

  @override
  Widget build(BuildContext context) {
    // final _prof = Provider.of<FlyersProvider>(context);

    return bzModelBuilder(
      context: context,
      bzID: tinyBz.bzID,
      builder: (ctx, bz){
// -----------------------------------------------------------------------------
        String _bzScope = bz != null ? bz.bzScope : '';
// -----------------------------------------------------------------------------
        final List<NanoFlyer> _galleryFlyers = bz.nanoFlyers;
// -----------------------------------------------------------------------------
        List<AuthorModel> _bzAuthors = bz != null ? bz?.bzAuthors : [];
// -----------------------------------------------------------------------------
        List<String> _bzTeamIDs = <String>[];
        if(_bzAuthors != null) {
          _bzAuthors.forEach((au) {
            _bzTeamIDs.add(au.userID);
          });
        }
// -----------------------------------------------------------------------------
        int _followersCount  = bz != null ? bz.bzTotalFollowers  : 0;
        int _bzTotalSaves    = bz != null ? bz.bzTotalSaves      : 0;
        int _bzTotalShares   = bz != null ? bz.bzTotalShares     : 0;
        int _bzTotalSlides   = bz != null ? bz.bzTotalSlides     : 0;
        int _bzTotalViews    = bz != null ? bz.bzTotalViews      : 0;
        int _callsCount      = bz != null ? bz.bzTotalCalls      : 0;
// -----------------------------------------------------------------------------
        return
          Column(
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
                verse: TextGenerator.monthYearStringer(context,bz.bldrBirth),
                size: 2,
              ),

              // --- BUSINESS DESCRIPTION
              BzAboutVerse(
                flyerZoneWidth: flyerZoneWidth,
                bzPageIsOn: bzPageIsOn,
                verse: bz != null ? bz.bzAbout : '',
                bzName:  bz != null ? bz.bzName : '',
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
                superFlyer: superFlyer,
                flyerZoneWidth: flyerZoneWidth,
                showFlyers: bzPageIsOn ? true : false,
                bz: bz,
                flyerOnTap: (flyerID) => Nav().openFlyer(context, flyerID),
              ),

            ],
          );

      }
    );
  }
}

