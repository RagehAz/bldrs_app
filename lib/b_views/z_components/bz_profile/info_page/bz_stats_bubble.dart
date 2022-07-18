import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/stats_line.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;

class BzStatsBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzStatsBubble({
    this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _myActiveBzModel = bzModel ?? BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

    return Bubble(
        title: 'Stats',
        columnChildren: <Widget>[

          /// FOLLOWERS
          StatsLine(
            verse: '${_myActiveBzModel.totalFollowers} ${superPhrase(context, 'phid_followers')}',
            icon: Iconz.follow,
          ),

          /// CALLS
          StatsLine(
            verse: '${_myActiveBzModel.totalCalls} ${superPhrase(context, 'phid_callsReceived')}',
            icon: Iconz.comPhone,
          ),

          /// SLIDES & FLYERS
          StatsLine(
        verse: '${_myActiveBzModel.totalSlides} '
            '${superPhrase(context, 'phid_slidesPublished')} '
            '${superPhrase(context, 'phid_inn')} '
            '${_myActiveBzModel.flyersIDs.length} '
            '${superPhrase(context, 'phid_flyers')}',
        icon: Iconz.gallery,
      ),

          /// SAVES
          StatsLine(
            verse: '${_myActiveBzModel.totalSaves} ${superPhrase(context, 'phid_totalSaves')}',
            icon: Iconz.saveOn,
          ),

          /// VIEWS
          StatsLine(
            verse: '${_myActiveBzModel.totalViews} ${superPhrase(context, 'phid_total_flyer_views')}',
            icon: Iconz.viewsIcon,
          ),

          /// SHARES
          StatsLine(
            verse: '${_myActiveBzModel.totalShares} ${superPhrase(context, 'phid_totalShares')}',
            icon: Iconz.share,
          ),

          /// BIRTH
          StatsLine(
            verse: Timers.generateString_in_bldrs_since_month_yyyy(context, _myActiveBzModel.createdAt),
            icon: Iconz.calendar,
          ),

        ]
    );

  }
}
