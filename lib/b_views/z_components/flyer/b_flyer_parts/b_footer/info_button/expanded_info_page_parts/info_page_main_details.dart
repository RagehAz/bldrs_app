import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/texting/stats_line.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class InfoPageMainDetails extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageMainDetails({
    @required this.pageWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey<String>('InfoPageMainDetails'),
      children: <Widget>[

        /// Flyer Type
        StatsLine(
          bubbleWidth: pageWidth,
          verse: 'Flyer Type : ${TextGen.flyerTypeSingleStringer(context, flyerModel.flyerType)}',
          icon: Iconizer.flyerTypeIconOff(flyerModel.flyerType),
          iconSizeFactor: 1,
          verseScaleFactor: 0.85 * 0.7,
        ),

        /// PUBLISH TIME
        StatsLine(
          bubbleWidth: pageWidth,
          verse: 'Published ${Timers.getSuperTimeDifferenceString(from: PublishTime.getPublishTimeFromTimes(times: flyerModel.times, state: FlyerState.published), to: DateTime.now())}',
          icon: Iconz.calendar,
        ),

        /// ZONE
        StatsLine(
          verse: 'Targeting : ${flyerZone?.cityName} , ${flyerZone?.countryName}',
          icon: Flag.getFlagIconByCountryID(flyerZone?.countryID),
          bubbleWidth: pageWidth,
        ),

      ],
    );
  }
}
