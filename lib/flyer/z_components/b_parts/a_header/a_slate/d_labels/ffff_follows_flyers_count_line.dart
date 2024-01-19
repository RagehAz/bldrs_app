import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/bz_counter_model.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:flutter/material.dart';

class FollowsFlyersCountLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const FollowsFlyersCountLine({
    required this.width,
    required this.bzModel,
    required this.versesScaleFactor,
    required this.margin,
    super.key
  });
  // -------------------
  final double width;
  final BzModel? bzModel;
  final double versesScaleFactor;
  final dynamic margin;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (bzModel == null){
      return const SizedBox();
    }
    // --------------------
    else {
      return SizedBox(
        width: width,
        child: FutureBuilder(
            future: RecorderProtocols.fetchBzCounters(
              bzID: bzModel!.id,
              forceRefetch: false,
            ),
            builder: (_, AsyncSnapshot<BzCounterModel?> counter) {

              return BldrsText(
                verse: FlyerVerses.followersCounters(
                  followersCount: counter.data?.follows ?? 0,
                  flyersCount: bzModel?.publication.published.length ?? 0,
                ),
                italic: true,
                centered: false,
                weight: VerseWeight.thin,
                margin: margin,
                size: 1,
                scaleFactor: versesScaleFactor,
                textDirection: UiProvider.getAppTextDir(),
              );

            }
            ),
      );
    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
