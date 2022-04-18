import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_counter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_fields.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
      key: const ValueKey<String>('Max_Header'),
      width: flyerBoxWidth,
      child: Column(
        children: <Widget>[

          /// BUSINESS FIELD
          BzPgFields(
            key: const ValueKey<String>('max_header_bzPageFields'),
            flyerBoxWidth: flyerBoxWidth,
            bzScope: _bzScope,
          ),

          /// BUSINESS BIRTH YEAR
          BzPgVerse(
            key: const ValueKey<String>('max_header_BzPgVerse'),
            flyerBoxWidth: flyerBoxWidth,
            verse: Timers.getString_in_bldrs_since_month_yyyy(context, bzModel.createdAt),
            size: 2,
          ),

          /// BUSINESS DESCRIPTION
          BzAboutVerse(
            key: const ValueKey<String>('max_header_BzAboutVerse'),
            flyerBoxWidth: flyerBoxWidth,
            verse: bzModel != null ? bzModel.about : '',
            bzName: bzModel != null ? bzModel.name : '',
          ),

          /// FOLLOWERS
          BzPgCounter(
            key: const ValueKey<String>('max_header_BzPgCounter_follows'),
            flyerBoxWidth: flyerBoxWidth,
            count: _followersCount,
            verse: superPhrase(context, 'phid_followers'),
            icon: Iconz.follow,
            iconSizeFactor: 0.8,
          ),

          /// CALLS
          BzPgCounter(
            key: const ValueKey<String>('max_header_BzPgCounter_calls'),
            flyerBoxWidth: flyerBoxWidth,
            count: _callsCount,
            verse: superPhrase(context, 'phid_callsReceived'),
            icon: Iconz.comPhone,
            iconSizeFactor: 0.8,
          ),

          /// PUBLISHED SLIDE & FLYERS
          BzPgCounter(
            key: const ValueKey<String>('max_header_BzPgCounter_slides'),
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalSlides,
            verse: superPhrase(context, 'phid_slidesPublished'),
            icon: Iconz.gallery,
            iconSizeFactor: 0.85,
          ),

          /// TOTAL VIEWS
          BzPgCounter(
            key: const ValueKey<String>('max_header_BzPgCounter_views'),
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalViews,
            verse: superPhrase(context, 'phid_totalViews'),
            icon: Iconz.viewsIcon,
            iconSizeFactor: 0.85,
          ),

          /// TOTAL SHARES
          BzPgCounter(
            key: const ValueKey<String>('max_header_BzPgCounter_shares'),
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalShares,
            verse: superPhrase(context, 'phid_totalShares'),
            icon: Iconz.share,
            iconSizeFactor: 0.85,
          ),

          /// TOTAL SAVES
          BzPgCounter(
            key: const ValueKey<String>('max_header_BzPgCounter_saves'),
            flyerBoxWidth: flyerBoxWidth,
            count: _bzTotalSaves,
            verse: superPhrase(context, 'phid_totalSaves'),
            icon: Iconz.saveOn,
            iconSizeFactor: 0.95,
          ),

          /// BZ GALLERY
          // if (Mapper.canLoopList(bzModel.flyersIDs))
          //   Gallery(
          //     key: const ValueKey<String>('max_header_gallery'),
          //     bzModel: bzModel,
          //     showFlyers: true,
          //     galleryBoxWidth: flyerBoxWidth,
          //     addAuthorButtonIsOn: false,
          //     // tinyFlyers: _bzTinyFlyers,
          //   ),

          /// BOTTOM PADDING
          MaxHeaderBottomPadding(
            key: const ValueKey<String>('max_header_bottom_padding'),
            flyerBoxWidth: flyerBoxWidth,
          ),

        ],
      ),
    );
  }
}


class MaxHeaderBottomPadding extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MaxHeaderBottomPadding({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey<String>('max_header_bottom_padding'),
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
    );
  }
}
