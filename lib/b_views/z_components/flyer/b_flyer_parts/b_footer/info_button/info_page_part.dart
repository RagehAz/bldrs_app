import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/stats_line.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class InfoPagePart extends StatelessWidget {

  const InfoPagePart({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;

  @override
  Widget build(BuildContext context) {

    final double _pageWidth = InfoButton.expandedWidth(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return Container(
      width: _pageWidth,
      height: 700,
      color: Colorz.bloodTest,
      child: Column(
        children: <Widget>[

          /// Flyer Type
          StatsLine(
            bubbleWidth: _pageWidth,
            verse: 'Flyer Type : ${TextGen.flyerTypeSingleStringer(context, flyerModel.flyerType)}',
            icon: Iconizer.flyerTypeIconOff(flyerModel.flyerType),
            iconSizeFactor: 1,
            verseScaleFactor: 0.85 * 0.7,
          ),

          /// PUBLISH TIME
          StatsLine(
            bubbleWidth: _pageWidth,
            verse: 'Published ${Timers.getSuperTimeDifferenceString(from: PublishTime.getPublishTimeFromTimes(times: flyerModel.times, state: FlyerState.published), to: DateTime.now())}',
            icon: Iconz.calendar,
          ),

          /// ZONE
          StatsLine(
            verse: 'Targeting : ${flyerZone?.cityName} , ${flyerZone?.countryName}',
            icon: Flag.getFlagIconByCountryID(flyerZone.countryID),
            bubbleWidth: _pageWidth,
          ),

        ],
      ),
    );
  }
}
