import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/user_counter_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class UserCounterBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const UserCounterBubble({
    required this.userModel,
    super.key
  });
  // --------------------
  final UserModel? userModel;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (userModel == null || userModel?.id == null){
      return const SizedBox();
    }
    else{

      return FutureBuilder(
        future: RecorderProtocols.fetchUserCounter(
            userID: userModel!.id,
            forceRefetch: false,
        ),
        initialData: UserCounterModel.createInitialModel(userModel!.id!),
        builder: (context, AsyncSnapshot<UserCounterModel?> snap) {

          final UserCounterModel _counter = snap.data ?? UserCounterModel.createInitialModel(userModel!.id!);

          return Bubble(
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                context: context,
                headlineVerse: const Verse(
                  id: 'phid_stats',
                  translate: true,
                ),
              ),
              columnChildren: <Widget>[

                /// SESSIONS
                StatsLine(
                  verse: Verse(
                    id: '${_counter.sessions} ${getWord('phid_total_times_used_bldrs')}',
                    translate: false,
                  ),
                  icon: Iconz.bldrsAppIcon,
                ),

                /// VIEWS
                StatsLine(
                  verse: Verse(
                    id: '${_counter.views} ${getWord('phid_total_flyer_views')}',
                    translate: false,
                  ),
                  icon: Iconz.viewsIcon,
                ),

                /// SAVES
                StatsLine(
                  verse: Verse(
                      id: '${_counter.saves} ${getWord('phid_totalSaves')}',
                      translate: false,
                  ),
                  icon: Iconz.save,
                ),

                /// REVIEWS
                StatsLine(
                  verse: Verse(
                    id: '${_counter.reviews} ${getWord('phid_total_reviews')}',
                    translate: false,
                  ),
                  icon: Iconz.balloonSpeaking,
                ),

                /// SHARES
                StatsLine(
                  verse: Verse(
                    id: '${_counter.shares} ${getWord('phid_totalShares')}',
                    translate: false,
                  ),
                  icon: Iconz.share,
                ),

                /// FOLLOWING
                StatsLine(
                  verse: Verse(
                    id: '${_counter.follows} ${getWord('phid_totalFollows')}',
                    translate: false,
                  ),
                  icon: Iconz.follow,
                ),

                /// CALLS
                StatsLine(
                  verse: Verse(
                    id: '${_counter.calls} ${getWord('phid_totalCalls')}',
                    translate: false,
                  ),
                  icon: Iconz.comPhone,
                ),

              ]
          );
        }
      );

    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
