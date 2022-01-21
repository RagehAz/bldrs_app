import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_counter.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_fields.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/gallery.dart';
import 'package:bldrs/d_providers/streamers/bz_streamer.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class MaxHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MaxHeader({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
    final String _bzScope = bzModel != null ? bzModel.scope : '';
// -----------------------------------------------------------------------------
    final List<AuthorModel> _bzAuthors =
    bzModel != null ? bzModel?.authors : <AuthorModel>[];
// -----------------------------------------------------------------------------
    final List<String> _bzTeamIDs = <String>[];

    if (Mapper.canLoopList(_bzAuthors)) {
      for (final AuthorModel author in _bzAuthors) {
        _bzTeamIDs.add(author.userID);
      }

    }
// -----------------------------------------------------------------------------
    final int _followersCount = bzModel != null ? bzModel.totalFollowers : 0;
    final int _bzTotalSaves = bzModel != null ? bzModel.totalSaves : 0;
    final int _bzTotalShares = bzModel != null ? bzModel.totalShares : 0;
    final int _bzTotalSlides = bzModel != null ? bzModel.totalSlides : 0;
    final int _bzTotalViews = bzModel != null ? bzModel.totalViews : 0;
    final int _callsCount = bzModel != null ? bzModel.totalCalls : 0;
// -----------------------------------------------------------------------------
    return SizedBox(
      width: flyerBoxWidth,
      child: Column(
        children: <Widget>[

          /// BUSINESS FIELD
          BzPgFields(
            flyerBoxWidth: flyerBoxWidth,
            bzScope: _bzScope,
          ),

          /// BUSINESS BIRTH YEAR
          BzPgVerse(
            flyerBoxWidth: flyerBoxWidth,
            verse: Timers.monthYearStringer(context, bzModel.createdAt),
            size: 2,
          ),

          /// BUSINESS DESCRIPTION
          BzAboutVerse(
            flyerBoxWidth: flyerBoxWidth,
            verse: bzModel != null ? bzModel.about : '',
            bzName: bzModel != null ? bzModel.name : '',
          ),

          /// FOLLOWERS
          BzPgCounter(
            flyerBoxWidth: flyerBoxWidth,
            count: _followersCount,
            verse: Wordz.followers(context),
            icon: Iconz.follow,
            iconSizeFactor: 0.8,
          ),

          /// CALLS
          BzPgCounter(
            flyerBoxWidth: flyerBoxWidth,
            count: _callsCount,
            verse: Wordz.callsReceived(context),
            icon: Iconz.comPhone,
            iconSizeFactor: 0.8,
          ),

          /// PUBLISHED SLIDE & FLYERS
          BzPgCounter(
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalSlides,
            verse: Wordz.slidesPublished(context),
            icon: Iconz.gallery,
            iconSizeFactor: 0.85,
          ),

          /// TOTAL VIEWS
          BzPgCounter(
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalViews,
            verse: Wordz.totalViews(context),
            icon: Iconz.viewsIcon,
            iconSizeFactor: 0.85,
          ),

          /// TOTAL SHARES
          BzPgCounter(
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalShares,
            verse: Wordz.totalShares(context),
            icon: Iconz.share,
            iconSizeFactor: 0.85,
          ),

          /// TOTAL ANKHS
          BzPgCounter(
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalSaves,
            verse: Wordz.totalSaves(context),
            icon: Iconz.saveOn,
            iconSizeFactor: 0.95,
          ),

          /// BZ GALLERY
          if (Mapper.canLoopList(bzModel.flyersIDs))
            Gallery(
              bzModel: bzModel,
              showFlyers: true,
              galleryBoxWidth: flyerBoxWidth,
              addAuthorButtonIsOn: false,
              // tinyFlyers: _bzTinyFlyers,
            ),

          /// BOTTOM PADDING
          Container(
            width: flyerBoxWidth,
            height: flyerBoxWidth * Ratioz.xxflyerBottomCorners + Ratioz.appBarMargin,
            margin: EdgeInsets.only(top: flyerBoxWidth * Ratioz.xxbzPageSpacing),
            decoration: BoxDecoration(
              color: Colorz.black80,
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
      ),
    );
  }
}
