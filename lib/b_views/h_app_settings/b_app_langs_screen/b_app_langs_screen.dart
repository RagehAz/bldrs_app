import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:provider/provider.dart';

class AppLangsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppLangsScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  Future<void> _tapLanguage(String langCode) async {

    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(getMainContext(), listen: false);
    await _phraseProvider.changeAppLang(
      langCode: langCode,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const List<Lang> _languagesModels = Lang.allLanguages;
    final List<MapModel> _languageMaps = Lang.getLingoNamesMapModels(_languagesModels);
    final String _currentLang = PhraseProvider.proGetCurrentLangCode(
      context: context,
      listen: true,
    );
    // --------------------
    return FloatingLayout(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        ...List.generate(_languageMaps.length, (index){

          final MapModel _langs = _languageMaps[index];

          return SettingsWideButton(
            verse: Verse.plain(_langs.value),
            isOn: _currentLang != _langs.key,
            onTap: () => _tapLanguage(_langs.key),
          );

        }),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
