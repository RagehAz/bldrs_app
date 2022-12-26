import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/lines/zone_name_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/super_headline.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:flutter/material.dart';

class DistrictPreviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DistrictPreviewBubble({
    @required this.districtModel,
    @required this.cityModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DistrictModel districtModel;
  final CityModel cityModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Phrase _nameEn = Phrase.searchFirstPhraseByLang(
      phrases: districtModel?.phrases,
      langCode: 'en',
    );

    final Phrase _cityNameEN = Phrase.searchFirstPhraseByLang(
      phrases: cityModel?.phrases,
      langCode: 'en',
    );

    final Phrase _countryNameEn = Flag.getCountryPhrase(
      countryID: cityModel?.getCountryID(),
      langCode: 'en',
    );


    return Bubble(
      bubbleHeaderVM: const BubbleHeaderVM(),
      bubbleColor: Colorz.white20,
      childrenCentered: true,
      columnChildren: <Widget>[

        /// PADDING
        const SizedBox(width: 20, height: 20,),

        /// DISTRICT NAME
        SuperHeadline(
          verse: Verse.plain(_nameEn?.value),
        ),

        /// COUNTRY NAME EN
        ZoneNameLine(
          name: 'in ${_cityNameEN?.value} . ${_countryNameEn.value}',
        ),

        /// PADDING
        const SizedBox(width: 20, height: 20,),

      ],

    );

  }
  /// --------------------------------------------------------------------------
}
