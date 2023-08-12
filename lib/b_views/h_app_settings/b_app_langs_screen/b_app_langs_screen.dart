import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class AppLangsScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AppLangsScreen({
    super.key
  });
  // --------------------------------------------------------------------------
  Future<void> _tapLanguage({
    required BuildContext context,
    required String? langCode,
  }) async {

    if (langCode != null){
      await PhraseProtocols.changeAppLang(
        context: context,
        langCode: langCode,
      );
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _currentLang = Localizer.getCurrentLangCode();
    // --------------------
    return FloatingLayout(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        ...List.generate(Localizer.supportedLangCodes.length, (index){

          final String _langCode = Localizer.supportedLangCodes[index];
          final String _langName = Localizer.getLangNameByCode(_langCode);

          return SettingsWideButton(
            verse: Verse.plain(_langName),
            isOn: _currentLang != _langCode,
            onTap: () => _tapLanguage(
              context: context,
              langCode: _langCode,
            ),
          );

        }),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
