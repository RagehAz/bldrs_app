import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/texting/stats_line.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
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

    final String _flyerTypeString = translateFlyerType(
      context: context,
      flyerType: flyerModel.flyerType,
      pluralTranslation: false,
    );

    final DateTime _from = PublishTime.getPublishTimeFromTimes(
        times: flyerModel.times,
        state: PublishState.published
    )?.time;

    final String _timeDifferance = Timers.getSuperTimeDifferenceString(
        from: _from,
        to: DateTime.now(),
    );

    return Column(
      key: const ValueKey<String>('InfoPageMainDetails'),
      children: <Widget>[

        /// Flyer Type
        StatsLine(
          bubbleWidth: pageWidth,
          verse: 'Flyer Type : $_flyerTypeString',
          icon: Iconizer.flyerTypeIconOff(flyerModel.flyerType),
          iconSizeFactor: 1,
          verseScaleFactor: 0.85 * 0.7,
        ),

        /// PUBLISH TIME
        StatsLine(
          bubbleWidth: pageWidth,
          verse: 'Published $_timeDifferance',
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
