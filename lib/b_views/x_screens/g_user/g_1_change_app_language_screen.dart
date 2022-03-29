import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/b_views/z_components/layouts/list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectAppLanguageScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectAppLanguageScreen({
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

    const List<Lang> _languagesModels = Lang.allLanguages;
    final List<MapModel> _languageMaps = Lang.getLingoNamesMapModels(_languagesModels);

    return ListLayout(
      pyramids: Iconz.pyramidzYellow,
      pageTitle: Wordz.languageName(context),
      mapModels: _languageMaps,
      sky: SkyType.black,
      onItemTap: (String value) => _tapLanguage(context, value),
    );

  }
}
