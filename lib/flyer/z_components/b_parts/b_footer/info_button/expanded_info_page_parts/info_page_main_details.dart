import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class InfoPageMainDetails extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageMainDetails({
    required this.pageWidth,
    required this.flyerModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final FlyerModel? flyerModel;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String? _getZoneLine({
    required BuildContext context,
    required ZoneModel? zone,
  }){
    String? _output;

    if (zone != null){

      String _city = '${zone.cityName},';
      if (zone.cityName == null){
        _city = '';
      }

      String? _country = zone.countryName;
      _country ??= CountryModel.translateCountry(
          langCode: Localizer.getCurrentLangCode(),
          countryID: zone.countryID,
      );

      _output = '${getWord('phid_targeting')} : $_city $_country';

    }

    return _output;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
      flyerType: flyerModel?.flyerType,
      pluralTranslation: false,
    );
    // --------------------
    final DateTime? _from = PublishTime.getPublishTimeFromTimes(
        times: flyerModel?.times,
        state: PublishState.published
    )?.time;
    // --------------------
    final String _timeDifferance = BldrsTimers.calculateSuperTimeDifferenceString(
      from: _from,
      to: DateTime.now(),
    );
    // --------------------

    final double _lineWidth = pageWidth - 20;

    return Column(
      key: const ValueKey<String>('InfoPageMainDetails'),
      children: <Widget>[

        /// Flyer Type
        StatsLine(
          width: _lineWidth,
          verse: Verse(
            id: '${getWord('phid_flyer_type')} : ${getWord(_flyerTypePhid)}',
            translate: false,
          ),
          icon: FlyerTyper.flyerTypeIcon(flyerType: flyerModel?.flyerType, isOn: false),
          bigIcon: true,
        ),

        /// PUBLISH TIME
        StatsLine(
          width: _lineWidth,
          verse: Verse(
            id: '${getWord('phid_since')} $_timeDifferance',
            translate: false,
          ),
          icon: Iconz.calendar,
        ),

        /// ZONE
        if (flyerModel?.zone != null)
        FutureBuilder(
          future: ZoneProtocols.completeZoneModel(
            invoker: 'InfoPageMainDetails.build',
            incompleteZoneModel: flyerModel!.zone,
          ),
          initialData: flyerModel!.zone,
          builder: (_, AsyncSnapshot snap){

            final ZoneModel? _zone = snap.data;

            return StatsLine(
              width: _lineWidth,
              verse: Verse.plain(_getZoneLine(
                context: context,
                zone: _zone,
              )),
              icon: _zone?.icon ?? Iconz.target,
            );

          },
        ),

      ],
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
