import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ZoneLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneLine({
    @required this.zoneModel,
    this.showCity = true,
    this.showDistrict = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel zoneModel;
  final bool showCity;
  final bool showDistrict;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _zoneString = ZoneModel.generateZoneString(
      context: context,
      zoneModel: zoneModel,
      showCity: showCity,
      showDistrict: showDistrict,
    );

    return Container(
      height: 35,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          FlagBox(
            size: 20,
            countryID: zoneModel?.countryID,
          ),

          const SizedBox(
            width: 5,
            height: 5,
          ),

          SuperVerse(
            verse: _zoneString,
            weight: VerseWeight.thin,
            italic: true,
            color: Colorz.grey255,
            margin: 5,
            maxLines: 2,
          ),

        ],
      ),
    );
  }
}
