import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/texting/stats_line.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
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
    // --------------------
    final String _flyerTypeString = FlyerTyper.translateFlyerType(
      context: context,
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
          verse: '##Flyer Type : $_flyerTypeString',
          icon: FlyerTyper.flyerTypeIconOff(flyerModel.flyerType),
          iconSizeFactor: 1,
          verseScaleFactor: 0.85 * 0.7,
        ),

        /// PUBLISH TIME
        StatsLine(
          bubbleWidth: pageWidth,
          verse: '##Published $_timeDifferance',
          icon: Iconz.calendar,
        ),

        /// ZONE
        StatsLine(
          verse: '##Targeting : ${flyerZone?.cityName} , ${flyerZone?.countryName}',
          icon: flyerZone?.flag,
          bubbleWidth: pageWidth,
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
