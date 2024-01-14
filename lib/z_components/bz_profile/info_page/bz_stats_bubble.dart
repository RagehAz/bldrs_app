import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/bz_counter_model.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class BzStatsBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzStatsBubble({
    this.bzModel,
    super.key
  });
  // --------------------
  final BzModel? bzModel;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel? _bzModel = bzModel ?? BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );
    // --------------------
    return FutureBuilder(
        future: RecorderProtocols.fetchBzCounters(
          bzID: _bzModel?.id,
          forceRefetch: false,
        ),
        builder: (context, AsyncSnapshot<BzCounterModel?> snap) {

          final BzCounterModel _counter = snap.data ?? BzCounterModel.createInitialModel(_bzModel?.id);

          return Bubble(
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                context: context,
                headlineVerse: const Verse(
                  id: 'phid_stats',
                  translate: true,
                ),
              ),
              columnChildren: <Widget>[

                /// FOLLOWERS
                StatsLine(
                  verse: Verse(
                    id: '${_counter.follows} ${getWord('phid_followers')}',
                    translate: false,
                    casing: Casing.lowerCase,
                  ),
                  icon: Iconz.follow,
                ),

                /// CALLS
                StatsLine(
                  verse: Verse(
                    id: '${_counter.calls} ${getWord('phid_calls')}',
                    translate: false,
                    casing: Casing.lowerCase,
                  ),
                  icon: Iconz.comPhone,
                ),

                /// SLIDES
                StatsLine(
                  verse: Verse(
                    id: '${_counter.allSlides} ${getWord('phid_slides')}',
                    translate: false,
                    casing: Casing.lowerCase,
                  ),
                  icon: Iconz.gallery,
                ),

                /// SLIDES
                StatsLine(
                  verse: Verse(
                    id: '${_bzModel?.publication.published.length} ${getWord('phid_flyers')}',
                    translate: false,
                    casing: Casing.lowerCase,
                  ),
                  icon: Iconz.flyer,
                ),

                /// SAVES
                StatsLine(
                  verse: Verse(
                    id:  '${_counter.allSaves} ${getWord('phid_saves')}',
                    translate: false,
                    casing: Casing.lowerCase,
                  ),
                  icon: Iconz.love,
                ),

                /// VIEWS
                StatsLine(
                  verse: Verse(
                    id: '${_counter.allViews} ${getWord('phid_views')}',
                    translate: false,
                    casing: Casing.lowerCase,
                  ),
                  icon: Iconz.viewsIcon,
                ),

                /// SHARES
                StatsLine(
                  verse: Verse(
                    id: '${_counter.allShares} ${getWord('phid_shares')}',
                    translate: false,
                    casing: Casing.lowerCase,
                  ),
                  icon: Iconz.share,
                ),

                /// BIRTH
                StatsLine(
                  verse: Verse(
                    id: BldrsTimers.generateString_in_bldrs_since_month_yyyy(_bzModel?.createdAt),
                    translate: false,
                  ),
                  icon: Iconz.calendar,
                ),
              ]
          );
        });
    // --------------------
  }
  // --------------------------------------------------------------------------
}
