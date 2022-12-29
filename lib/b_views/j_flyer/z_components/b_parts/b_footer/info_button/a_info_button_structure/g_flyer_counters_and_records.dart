import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/gg_flyer_record_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class FlyerCountersAndRecords extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerCountersAndRecords({
    @required this.pageWidth,
    @required this.flyerModel,
    @required this.flyerCounter,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel flyerModel;
  final ValueNotifier<FlyerCounterModel> flyerCounter;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: pageWidth,
      child: ValueListenableBuilder(
        valueListenable: flyerCounter,
        builder: (_, FlyerCounterModel counter, Widget child){


          if (counter == null){
            return const SizedBox();
          }

          else {

            // counter?.blogCounter();

            final int _saves = counter.saves ?? 0;
            final int _shares = counter.shares ?? 0;
            final int _views = counter.views ?? 0;

            return Column(
              children: <Widget>[

                /// SAVES
                if (counter != null && _saves > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse.plain('$_saves ${xPhrase(context, 'phid_totalSaves')}'),
                    icon: Iconz.saveOn,
                    realNodePath: '${RealColl.recordingSaves}/${flyerModel.id}/',
                  ),

                /// SHARES
                if (counter != null && _shares > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse.plain('$_shares ${xPhrase(context, 'phid_totalShares')}'),
                    icon: Iconz.share,
                    realNodePath: '${RealColl.recordingShares}/${flyerModel.id}/',
                  ),

                /// VIEWS
                if (counter != null && _views > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse.plain('$_views ${xPhrase(context, 'phid_totalViews')}'),
                    icon: Iconz.viewsIcon,
                    realNodePath: '${RealColl.recordingViews}/${flyerModel.id}/',
                  ),

              ],
            );
          }

        },
      ),
    );

  }
/// --------------------------------------------------------------------------
}
