import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/a_models/x_secondary/record_model.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/bb_bz_slide_fields.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/c_bz_slide_horizon.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_black_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_bz_about_verse.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_bz_pg_counter.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_bz_slide_verse.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/report_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/bz_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class BzSlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSlide({
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
    // --------------------
    final List<String> _bzScope = bzModel != null ? bzModel.scope : <String>[];
    // --------------------
    final List<AuthorModel> _bzAuthors =
    bzModel != null ? bzModel?.authors : <AuthorModel>[];
    // --------------------
    final List<String> _bzTeamIDs = <String>[];
    // --------------------
    if (Mapper.checkCanLoopList(_bzAuthors)) {
      for (final AuthorModel author in _bzAuthors) {
        _bzTeamIDs.add(author.userID);
      }

    }
    // --------------------
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
              BzSlideVerse(
                key: const ValueKey<String>('max_header_BzPgVerse'),
                flyerBoxWidth: flyerBoxWidth,
                verse: Verse.plain(Timers.generateString_in_bldrs_since_month_yyyy(context, bzModel.createdAt)),
                size: 2,
              ),

              /// BUSINESS DESCRIPTION
              BzAboutVerse(
                key: const ValueKey<String>('max_header_BzAboutVerse'),
                flyerBoxWidth: flyerBoxWidth,
                verse: Verse.plain(bzModel != null ? bzModel.about : ''),
                bzName: bzModel != null ? bzModel.name : '',
              ),

              /// FOLLOWERS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_follows'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter?.follows,
                verse: const Verse(
                  text: 'phid_followers',
                  translate: true,
                ),
                icon: Iconz.follow,
                iconSizeFactor: 0.8,
              ),

              /// CALLS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_calls'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter?.calls,
                verse: const Verse(
                  text: 'phid_callsReceived',
                  translate: true,
                ),
                icon: Iconz.comPhone,
                iconSizeFactor: 0.8,
              ),

              /// PUBLISHED SLIDE & FLYERS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_flyers'),
                flyerBoxWidth: flyerBoxWidth,
                count: bzModel.flyersIDs.length,
                verse: const Verse(
                  text: 'phid_published_flyers',
                  translate: true,
                ),
                icon: Iconz.gallery,
                iconSizeFactor: 0.85,
              ),

              /// PUBLISHED SLIDE & FLYERS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_slides'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter?.allSlides,
                verse: const Verse(
                  text: 'phid_slidesPublished',
                  translate: true,
                ),
                icon: Iconz.flyerScale,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL VIEWS
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_views'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter?.allViews,
                verse: const Verse(
                  text: 'phid_totalViews',
                  translate: true,
                ),
                icon: Iconz.viewsIcon,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL SHARES
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_shares'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter?.allShares,
                verse: const Verse(
                  text: 'phid_totalShares',
                  translate: true,
                ),
                icon: Iconz.share,
                iconSizeFactor: 0.85,
              ),

              /// TOTAL SAVES
              BzPgCounter(
                key: const ValueKey<String>('max_header_BzPgCounter_saves'),
                flyerBoxWidth: flyerBoxWidth,
                count: _counter?.allSaves,
                verse: const Verse(
                  text: 'phid_totalSaves',
                  translate: true,
                ),
                icon: Iconz.saveOn,
                iconSizeFactor: 0.95,
              ),

              /// REPORT
              if (AuthModel.userIsSignedIn() == true)
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
              BzSlideHorizon(
                key: const ValueKey<String>('max_header_bottom_padding'),
                flyerBoxWidth: flyerBoxWidth,
              ),

            ],
          );

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
