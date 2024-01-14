import 'package:basics/bldrs_theme/assets/planet/all_flags_list.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/models/flag_model.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/zone_bubble/lines/zone_bubble_line.dart';
import 'package:bldrs/z_components/bubbles/b_variants/zone_bubble/lines/zone_name_line.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/flagbox_button.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class CityPreviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CityPreviewBubble({
    required this.cityModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final CityModel? cityModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String? _countryID = cityModel?.getCountryID();

    final Phrase? _countryNameEn = CountryModel.getCountryPhrase(
      countryID: _countryID,
      langCode: 'en',
    );

    final Phrase? _nameEn = Phrase.searchFirstPhraseByLang(
        phrases: cityModel?.phrases,
        langCode: 'en',
    );

    /// TASK : DO ME WHEN YOU HAVE TIME
    const bool _isCapital = false;

    final Flag? _flag = Flag.getFlagFromFlagsByCountryID(
      flags: allFlags,
      countryID: _countryID,
    );
    final String? _countryPop = getCounterCaliber(_flag?.population);
    final String? _cityPop = getCounterCaliber(cityModel?.population);
    final String? _percentage = Numeric.formatNumToSeparatedKilos(
      number: (cityModel?.population?? 0 / (_flag?.population ?? 0)) * 100,
      fractions: 1,
    );
    final String _populationLine = '$_cityPop / $_countryPop = $_percentage% of ${_countryNameEn?.value} live here';

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
          name: '${_nameEn?.value} . ${_countryNameEn?.value}',
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
