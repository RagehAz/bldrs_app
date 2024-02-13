// ignore_for_file: avoid_positional_boolean_parameters
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_screens/g_search_screen/super_search_screen.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class CountriesFilterTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CountriesFilterTile({
    required this.countries,
    required this.onTileTap,
    required this.onSwitchTap,
    required this.onSelectedCountryTap,
    super.key
  });
  // --------------------
  final List<String> countries;
  final Function onTileTap;
  final Function(bool) onSwitchTap;
  final Function(String countryID) onSelectedCountryTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    return TileBubble(
      bubbleWidth: _tileWidth,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          leadingIcon: Iconz.planet,
          headerWidth: _tileWidth,
          headlineVerse: const Verse(id: 'phid_inn', translate: true),
          hasSwitch: true, //UsersProvider.userIsAdmin(context),
          switchValue: countries.isNotEmpty,
          onSwitchTap: onSwitchTap
      ),
      onTileTap: onTileTap,
      textDirection: UiProvider.getAppTextDir(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      child: SizedBox(
        width: TileBubble.childWidth(context: context),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: <Widget>[

            if (Lister.checkCanLoop(countries) == true)
            ...List.generate(countries.length, (index){

              final String _countryID = countries[index];
              final String? _countryName = CountryModel.translateCountry(
                langCode: Localizer.getCurrentLangCode(),
                countryID: _countryID,
              );

              return BldrsBox(
                height: 30,
                maxWidth: TileBubble.childWidth(context: context),
                color: Colorz.black125,
                icon: Flag.getCountryIcon(_countryID),
                verse: Verse.plain(_countryName),
                verseScaleFactor: 0.7,
                onTap: () => onSelectedCountryTap(_countryID),
              );

            }),

          ],
        ),

      ),
    );

  }
// -----------------------------------------------------------------------------
}
