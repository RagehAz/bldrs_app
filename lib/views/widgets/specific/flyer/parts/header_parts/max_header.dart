import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/providers/flyers_and_bzz/bz_streamer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_pg_counter.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_pg_fields.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_pg_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/gallery.dart';
import 'package:flutter/material.dart';

class MaxHeader extends StatelessWidget {
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final TinyBz tinyBz;
  final SuperFlyer superFlyer;


  const MaxHeader({
    @required this.flyerBoxWidth,
    @required this.bzPageIsOn,
    @required this.tinyBz,
    @required this.superFlyer,
  });
// -----------------------------------------------------------------------------
//   Future<void> _openGalleryFlyer (BuildContext context, String flyerID) async {
//
//     await Nav.openFlyer(
//         context: context,
//         flyerID: flyerID,
//     );
//
//   }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // final _prof = Provider.of<FlyersProvider>(context);

    return bzModelBuilder(
      context: context,
      bzID: tinyBz.bzID,
      builder: (ctx, bz){
// -----------------------------------------------------------------------------
        final String _bzScope = bz != null ? bz.bzScope : '';
// -----------------------------------------------------------------------------
//         final List<NanoFlyer> _galleryFlyers = bz.nanoFlyers;
// -----------------------------------------------------------------------------
        final List<AuthorModel> _bzAuthors = bz != null ? bz?.bzAuthors : <AuthorModel>[];
// -----------------------------------------------------------------------------
        final List<String> _bzTeamIDs = <String>[];
        if(_bzAuthors != null) {
          _bzAuthors.forEach((au) {
            _bzTeamIDs.add(au.userID);
          });
        }
// -----------------------------------------------------------------------------
        final int _followersCount  = bz != null ? bz.bzTotalFollowers  : 0;
        final int _bzTotalSaves    = bz != null ? bz.bzTotalSaves      : 0;
        final int _bzTotalShares   = bz != null ? bz.bzTotalShares     : 0;
        final int _bzTotalSlides   = bz != null ? bz.bzTotalSlides     : 0;
        final int _bzTotalViews    = bz != null ? bz.bzTotalViews      : 0;
        final int _callsCount      = bz != null ? bz.bzTotalCalls      : 0;
// -----------------------------------------------------------------------------

        superFlyer.bz = bz;

        return
          Column(
            children: <Widget>[

              /// BUSINESS FIELD
              BzPgFields(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: bzPageIsOn,
                bzScope: _bzScope,
              ),

              /// BUSINESS BIRTH YEAR
              BzPgVerse(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: bzPageIsOn,
                verse: Timers.monthYearStringer(context,bz.createdAt),
                size: 2,
              ),

              /// BUSINESS DESCRIPTION
              BzAboutVerse(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: bzPageIsOn,
                verse: bz != null ? bz.bzAbout : '',
                bzName:  bz != null ? bz.bzName : '',
              ),

              /// FOLLOWERS
              BzPgCounter(
                bzPageIsOn: bzPageIsOn,
                flyerBoxWidth: flyerBoxWidth,
                count: _followersCount,
                verse: Wordz.followers(context),
                icon: Iconz.Follow,
                iconSizeFactor: 0.8,
              ),

              /// CALLS
              BzPgCounter(
                bzPageIsOn: bzPageIsOn,
                flyerBoxWidth: flyerBoxWidth,
                count: _callsCount,
                verse: Wordz.callsReceived(context),
                icon: Iconz.ComPhone,
                iconSizeFactor: 0.8,
              ),

              /// PUBLISHED SLIDE & FLYERS
              BzPgCounter(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: bzPageIsOn,
                count: _bzTotalSlides,
                verse: Wordz.slidesPublished(context),
                icon: Iconz.Gallery,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL VIEWS
              BzPgCounter(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: bzPageIsOn,
                count: _bzTotalViews,
                verse: Wordz.totalViews(context),
                icon: Iconz.Views,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL SHARES
              BzPgCounter(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: bzPageIsOn,
                count: _bzTotalShares,
                verse: Wordz.totalShares(context),
                icon: Iconz.Share,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL ANKHS
              BzPgCounter(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: bzPageIsOn,
                count: _bzTotalSaves,
                verse: Wordz.totalSaves(context),
                icon: Iconz.SaveOn,
                iconSizeFactor: 0.95,
              ),

              /// BZ GALLERY
              // if (superFlyer.mSlides.length != 0)
              if (superFlyer.bz.flyersIDs != null)
              Gallery(
                superFlyer: superFlyer,
                showFlyers: true,
                galleryBoxWidth: flyerBoxWidth,
                addAuthorButtonIsOn: false,
                tinyFlyers: [],
              ),

              Container(
                width: flyerBoxWidth,
                height: flyerBoxWidth * Ratioz.xxflyerBottomCorners + Ratioz.appBarMargin,
                margin: EdgeInsets.only(top: flyerBoxWidth * Ratioz.xxbzPageSpacing),
                decoration: BoxDecoration(
                  color: Colorz.Black80,
                  borderRadius: Borderers.superBorderOnly(
                    context: context,
                    enTopLeft: 0,
                    enTopRight: 0,
                    enBottomLeft: flyerBoxWidth * Ratioz.xxflyerBottomCorners,
                    enBottomRight: flyerBoxWidth * Ratioz.xxflyerBottomCorners,
                  ),
                ),
              ),

            ],
          );

      }
    );
  }
}

