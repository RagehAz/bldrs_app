import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class OldBzPageHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldBzPageHeadline({
    @required this.flyerBoxWidth,
    @required this.bzPageIsOn,
    @required this.bzModel,
    @required this.country,
    @required this.city,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final BzModel bzModel;
  final CountryModel country;
  final CityModel city;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return bzPageIsOn == false ?
    Container()
        :
    Container(
      height: flyerBoxWidth * 0.3,
      width: flyerBoxWidth,
      color: Colorz.nothing,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// BUSINESS NAME
          SuperVerse(
            verse: bzModel?.name,
            size: 5,
            shadow: true,
            maxLines: 2,
            // softWrap: true,
          ),

          /// BUSINESS LOCALE
          SuperVerse(
            verse: ZoneModel.translateZoneString(
              context: context,
              zoneModel: bzModel?.zone,
            ),
            italic: true,
            weight: VerseWeight.regular,
            color: Colorz.white200,
          ),

        ],
      ),
    );
  }
/// --------------------------------------------------------------------------
}
