import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/b_views/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
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
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String _getZoneLine({
    @required BuildContext context,
    @required ZoneModel zone,
  }){
    String _output;

    if (zone != null){

      String _city = '${zone.cityName},';
      if (zone.cityName == null){
        _city = '';
      }

      String _country = zone.countryName;
      _country ??= CountryModel.translateCountryName(
          context: context,
          countryID: zone.countryID,
      );

      _output = '${xPhrase(context, 'phid_targeting')} : $_city $_country';

    }

    return _output;
  }
  // --------------------------------------------------------------------------
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
      context: context,
      from: _from,
        to: DateTime.now(),
    );
    // --------------------

    return Column(
      key: const ValueKey<String>('InfoPageMainDetails'),
      children: <Widget>[

        /// Flyer Type
        StatsLine(
          bubbleWidth: pageWidth - 20,
          verse: Verse(
            text: '${xPhrase(context, 'phid_flyer_type')} : ${xPhrase(context, _flyerTypePhid)}',
            translate: false,
          ),
          icon: FlyerTyper.flyerTypeIconOff(flyerModel.flyerType),
          iconSizeFactor: 1,
          verseScaleFactor: 0.85 * 0.7,
        ),

        /// PUBLISH TIME
        StatsLine(
          bubbleWidth: pageWidth - 20,
          verse: Verse(
            text: '${xPhrase(context, 'phid_since')} $_timeDifferance',
            translate: false,
          ),
          icon: Iconz.calendar,
        ),

        /// ZONE
        if (flyerModel?.zone != null)
        FutureBuilder(
          future: ZoneProtocols.completeZoneModel(
              context: context,
              incompleteZoneModel: flyerModel.zone,
          ),
          initialData: flyerModel.zone,
          builder: (_, AsyncSnapshot snap){

            final ZoneModel _zone = snap.data;

            return StatsLine(
              bubbleWidth: pageWidth - 20,
              verse: Verse.plain(_getZoneLine(
                context: context,
                zone: _zone,
              )),
              icon: _zone?.flag ?? Iconz.target,
            );

          },
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
