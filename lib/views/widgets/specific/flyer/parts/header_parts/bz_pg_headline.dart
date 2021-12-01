import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPageHeadline extends StatelessWidget {
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final BzModel bzModel;
  final CountryModel country;
  final CityModel city;

  const BzPageHeadline({
    @required this.flyerBoxWidth,
    @required this.bzPageIsOn,
    @required this.bzModel,
    @required this.country,
    @required this.city,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      bzPageIsOn == false ? Container() :
      Container(
        height: (flyerBoxWidth * 0.3),
        width: flyerBoxWidth,
        color: Colorz.nothing,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// BUSINESS NAME
            SuperVerse(
              verse: bzModel.name,
              size: 5,
              shadow: true,
              centered: true,
              maxLines: 2,
              // softWrap: true,
            ),
            /// BUSINESS LOCALE
            SuperVerse(
              verse: TextGen.countryStringer(
                context: context,
                zone: bzModel.zone,
                country: country,
                city: city,
              ),
              size: 2,
              centered: true,
              italic: true,
              maxLines: 1,
              // softWrap: true,
              shadow: false,
              weight: VerseWeight.regular,
              color: Colorz.white200,
            ),
          ],
        ),
      )
    ;
  }
}
