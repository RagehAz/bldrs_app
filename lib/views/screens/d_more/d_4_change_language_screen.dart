import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/secondary_models/map_model.dart';
import 'package:bldrs/views/widgets/general/layouts/list_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatelessWidget {
// -----------------------------------------------------------------------------
  Future<void> _tapLanguage(BuildContext context,String languageCode) async {
    await Localizer.changeAppLanguage(context, languageCode);

    // Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const List<Lingo> _languagesModels = Lingo.allLanguages;
    final List<MapModel> _languageMaps = Lingo.getLingoNamesMapModels(_languagesModels);

    return ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: Wordz.languageName(context),
      icons: null,
      mapModels: _languageMaps,
      pageIcon: null,
      pageIconVerse: null,
      sky: Sky.Black,
      onItemTap: (value) => _tapLanguage(context, value),
    );

  }

}
