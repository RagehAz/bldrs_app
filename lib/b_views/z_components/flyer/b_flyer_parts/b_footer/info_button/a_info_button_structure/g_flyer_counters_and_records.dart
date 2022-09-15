import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/gg_flyer_record_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
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

            final int _saves = counter.saves ?? 0;
            final int _shares = counter.shares ?? 0;
            final int _views = counter.views ?? 0;

            return Column(
              children: <Widget>[

                /// SAVES
                if (counter != null && _saves > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse(
                      text: '##$_saves Total flyer saves',
                      translate: true,
                      variables: _saves,
                    ),
                    icon: Iconz.saveOn,
                    realNodePath: 'saves/${flyerModel.id}/',
                  ),

                /// SHARES
                if (counter != null && _shares > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse(
                      text: '##$_shares Total shares',
                      translate: true,
                      variables: _shares,
                    ),
                    icon: Iconz.share,
                    realNodePath: 'shares/${flyerModel.id}/',
                  ),

                /// VIEWS
                if (counter != null && _views > 0)
                  FlyerRecordsBox(
                    pageWidth: pageWidth,
                    headlineVerse: Verse(
                      text: '$_views Total views',
                      translate: true,
                      variables: _views,
                    ),
                    icon: Iconz.viewsIcon,
                    realNodePath: 'views/${flyerModel.id}/',
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
