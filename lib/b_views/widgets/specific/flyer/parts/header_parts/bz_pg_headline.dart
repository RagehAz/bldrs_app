import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzPageHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPageHeadline({
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
    return bzPageIsOn == false
        ? Container()
        : Container(
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
                  verse: TextGen.countryStringer(
                    context: context,
                    zone: bzModel?.zone,
                    country: country,
                    city: city,
                  ),
                  italic: true,
                  weight: VerseWeight.regular,
                  color: Colorz.white200,
                ),
              ],
            ),
          );
  }
}
