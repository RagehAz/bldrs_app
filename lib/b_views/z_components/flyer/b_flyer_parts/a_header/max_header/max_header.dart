import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/black_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_counter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_fields.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/bz_pg_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/e_flyer_special_widgets/report_button.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/e_db/fire/ops/bz_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class MaxHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MaxHeader({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.bzCounters,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final ValueNotifier<BzCounterModel> bzCounters;
  /// --------------------------------------------------------------------------
  /*
  Future<void> _openGalleryFlyer (BuildContext context, String flyerID) async {

    await Nav.openFlyer(
        context: context,
        flyerID: flyerID,
    );

  }
   */
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final List<String> _bzScope = bzModel != null ? bzModel.scope : <String>[];
// -----------------------------------------------------------------------------
    final List<AuthorModel> _bzAuthors =
    bzModel != null ? bzModel?.authors : <AuthorModel>[];
// -----------------------------------------------------------------------------
    final List<String> _bzTeamIDs = <String>[];
// -----------------------------------------------------------------------------
    if (Mapper.checkCanLoopList(_bzAuthors)) {
      for (final AuthorModel author in _bzAuthors) {
        _bzTeamIDs.add(author.userID);
      }

    }
// -----------------------------------------------------------------------------
    return SizedBox(
      key: const ValueKey<String>('Max_Header'),
      width: flyerBoxWidth,
      child: ValueListenableBuilder(
        valueListenable: bzCounters,
        builder: (_, BzCounterModel _counter, Widget child){

          return Column(
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
                verse: Timers.generateString_in_bldrs_since_month_yyyy(context, bzModel.createdAt),
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
                count: _counter.follows,
                verse: xPhrase(context, 'phid_followers'),
                icon: Iconz.follow,
                iconSizeFactor: 0.8,
              ),

              /// CALLS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_calls'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter.calls,
                verse: xPhrase(context, 'phid_callsReceived'),
                icon: Iconz.comPhone,
                iconSizeFactor: 0.8,
              ),

              /// PUBLISHED SLIDE & FLYERS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_flyers'),
                flyerBoxWidth: flyerBoxWidth,
                count: bzModel.flyersIDs.length,
                verse: 'Published flyers',
                icon: Iconz.gallery,
                iconSizeFactor: 0.85,
              ),

              /// PUBLISHED SLIDE & FLYERS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_slides'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter.allSlides,
                verse: xPhrase(context, 'phid_slidesPublished'),
                icon: Iconz.flyerScale,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL VIEWS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_views'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter.allViews,
                verse: xPhrase(context, 'phid_totalViews'),
                icon: Iconz.viewsIcon,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL SHARES
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_shares'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter.allShares,
                verse: xPhrase(context, 'phid_totalShares'),
                icon: Iconz.share,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL SAVES
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_saves'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter.allSaves,
                verse: xPhrase(context, 'phid_totalSaves'),
                icon: Iconz.saveOn,
                iconSizeFactor: 0.95,
              ),

              /// REPORT
              BlackBox(
                width: flyerBoxWidth,
                child: ReportButton(
                  modelType: ModelType.bz,
                  color: Colorz.black255,
                  onTap: () => BzFireOps.reportBz(
                    context: context,
                    bzModel: bzModel,
                  ),
                ),
              ),

              /// BOTTOM PADDING
              MaxHeaderBottomPadding(
                key: const ValueKey<String>('max_header_bottom_padding'),
                flyerBoxWidth: flyerBoxWidth,
              ),

            ],
          );

        },
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
