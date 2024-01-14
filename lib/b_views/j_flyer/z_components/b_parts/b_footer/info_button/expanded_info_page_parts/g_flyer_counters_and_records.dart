import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/gg_flyer_record_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class FlyerCountersAndRecords extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerCountersAndRecords({
    required this.pageWidth,
    required this.flyerModel,
    required this.flyerCounter,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel? flyerModel;
  final ValueNotifier<FlyerCounterModel?> flyerCounter;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: pageWidth,
      child: ValueListenableBuilder(
        valueListenable: flyerCounter,
        builder: (_, FlyerCounterModel? counter, Widget? child){


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
                if (_saves > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse.plain('$_saves ${getWord('phid_totalSaves')}'),
                    icon: Iconz.love,
                    recordType: RecordType.save,
                    bzID: flyerModel!.bzID!,
                    flyerID: flyerModel!.id!,
                  ),

                /// SHARES
                if (_shares > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse.plain('$_shares ${getWord('phid_totalShares')}'),
                    icon: Iconz.share,
                    recordType: RecordType.share,
                    bzID: flyerModel!.bzID!,
                    flyerID: flyerModel!.id!,
                  ),

                /// VIEWS
                if (_views > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse.plain('$_views ${getWord('phid_totalViews')}'),
                    icon: Iconz.viewsIcon,
                    recordType: RecordType.view,
                    bzID: flyerModel!.bzID!,
                    flyerID: flyerModel!.id!,
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
