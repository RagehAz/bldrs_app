import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/b_views/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class InfoPageMainDetails extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageMainDetails({
    @required this.pageWidth,
    @required this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
      flyerType: flyerModel.flyerType,
      pluralTranslation: false,
    );
    // --------------------
    final DateTime _from = PublishTime.getPublishTimeFromTimes(
        times: flyerModel.times,
        state: PublishState.published
    )?.time;
    // --------------------
    final String _timeDifferance = Timers.calculateSuperTimeDifferenceString(
        from: _from,
        to: DateTime.now(),
    );
    // --------------------
    return Column(
      key: const ValueKey<String>('InfoPageMainDetails'),
      children: <Widget>[

        /// Flyer Type
        StatsLine(
          bubbleWidth: pageWidth,
          verse: Verse(
            text: '##Flyer Type : $_flyerTypePhid',
            translate: true,
            variables: _flyerTypePhid,
          ),
          icon: FlyerTyper.flyerTypeIconOff(flyerModel.flyerType),
          iconSizeFactor: 1,
          verseScaleFactor: 0.85 * 0.7,
        ),

        /// PUBLISH TIME
        StatsLine(
          bubbleWidth: pageWidth,
          verse: Verse(
            text: '##Published $_timeDifferance',
            translate: true,
            variables: _timeDifferance,
          ),
          icon: Iconz.calendar,
        ),

        /// ZONE
        StatsLine(
          verse: Verse(
            text: '##Targeting : ${flyerModel.zone?.cityName} , ${flyerModel.zone?.countryName}',
            translate: true,
            variables: [flyerModel.zone?.cityName, flyerModel.zone?.countryName]
          ),
          icon: flyerModel.zone?.flag,
          bubbleWidth: pageWidth,
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
