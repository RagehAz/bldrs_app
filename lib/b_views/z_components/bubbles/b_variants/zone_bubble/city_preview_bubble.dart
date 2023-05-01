import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/lines/zone_bubble_line.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/lines/zone_name_line.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';

class CityPreviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CityPreviewBubble({
    @required this.cityModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CityModel cityModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _countryID = cityModel?.getCountryID();

    final Phrase _countryNameEn = Flag.getCountryPhrase(
      countryID: _countryID,
      langCode: 'en',
    );

    final Phrase _nameEn = Phrase.searchFirstPhraseByLang(
        phrases: cityModel?.phrases,
        langCode: 'en',
    );

    /// TASK : DO ME WHEN YOU HAVE TIME
    const bool _isCapital = false;

    final Flag _flag = Flag.getFlagFromFlagsByCountryID(
      flags: allFlags,
      countryID: _countryID,
    );
    final String _countryPop = counterCaliber(context, _flag?.population);
    final String _cityPop = counterCaliber(context, cityModel?.population);
    final String _percentage = Numeric.formatNumToSeparatedKilos(
      number: (cityModel?.population?? 0 / _flag?.population ?? 0) * 100,
      fractions: 1,
    );
    final String _populationLine = '$_cityPop / $_countryPop = $_percentage% of ${_countryNameEn.value} live here';

    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
      bubbleColor: Colorz.white20,
      childrenCentered: true,
      columnChildren: <Widget>[

        /// PADDING
        const SizedBox(width: 20, height: 20,),

        /// FLAG
        Center(
          child: FlagBox(
            size: 80,
            countryID: _countryID,
            // onTap: _onTap,
          ),
        ),

        /// COUNTRY NAME EN
        ZoneNameLine(
          name: '${_nameEn?.value} . ${_countryNameEn.value}',
        ),

        /// IS CAPITAL
        if (_isCapital == true)
        BldrsBox(
          height: 20,
          icon: Iconz.star,
          verse: Verse.plain('The Capital'),
          iconSizeFactor: 0.5,
          bubble: false,
        ),

        /// AREA - POPULATION
        ZoneBubbleLine(
          icon: Iconz.users,
          line: _populationLine,
        ),

        /// PADDING
        const SizedBox(width: 20, height: 20,),

      ],

    );

  }
  /// --------------------------------------------------------------------------
}
