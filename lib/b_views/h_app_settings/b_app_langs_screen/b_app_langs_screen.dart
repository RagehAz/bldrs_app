import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/settings_wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLangsScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppLangsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  Future<void> _tapLanguage(BuildContext context, String langCode) async {

    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    await _phraseProvider.changeAppLang(
      context: context,
      langCode: langCode,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const List<Lang> _languagesModels = Lang.allLanguages;
    final List<MapModel> _languageMaps = Lang.getLingoNamesMapModels(_languagesModels);
    // --------------------
    return CenteredListLayout(
      columnChildren: <Widget>[

        const DotSeparator(color: Colorz.yellow80,),

        ...List.generate(_languageMaps.length, (index){

          final MapModel _langs = _languageMaps[index];

          return SettingsWideButton(
            verse: Verse.plain(_langs.value),
            onTap: () => _tapLanguage(context, _langs.key),
          );

        }),

        const DotSeparator(color: Colorz.yellow80,),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
