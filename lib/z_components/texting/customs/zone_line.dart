import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/flagbox_button.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class ZoneLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneLine({
    required this.zoneModel,
    this.showCity = true,
    this.centered = true,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ZoneModel? zoneModel;
  final bool showCity;
  final bool centered;
  final double? width;
  // --------------------------------------------------------------------------
  static const double flagSize = 20;
  static const Color textColor = Colorz.grey255;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Verse _zoneVerse = ZoneModel.generateInZoneVerse(
      zoneModel: zoneModel,
      showCity: showCity,
    );
    // --------------------
    final double _width = width ?? 200;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        width: _width - flagSize,
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: centered == true ? Alignment.center : BldrsAligners.superCenterAlignment(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.5),
              child: FlagBox(
                size: flagSize,
                countryID: zoneModel?.countryID,
              ),
            ),

            const SizedBox(
              width: 5,
              height: 5,
            ),

            BldrsText(
              maxWidth: _width - 5 - flagSize - 30,
              width: centered == true ?
              null
                  :
              (_zoneVerse.id?.length ?? 0) > 20 ? _width - flagSize - 20 - 5 - 10
                  :
              null,
              verse: _zoneVerse,
              weight: VerseWeight.thin,
              italic: true,
              color: textColor,
              margin: 5,
              // maxLines: 1,
              centered: false,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
