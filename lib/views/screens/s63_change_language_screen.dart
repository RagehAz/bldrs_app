import 'package:bldrs/controllers/localization/change_language.dart';
import 'package:bldrs/controllers/localization/language_class.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/layouts/listLayout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SelectLanguageScreen extends StatelessWidget {
// ---------------------------------------------------------------------------
  Future<void> _tapLanguage(BuildContext context,String languageCode) async {
    await changeAppLanguage(context, languageCode);

    // Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    List<LanguageClass> _languagesModels = LanguageClass.languageList();
    List<Map<String ,String>> _languageMaps = LanguageClass.getLanguagesMapsFromLanguages(_languagesModels);

    return ListLayout(
      pyramids: Iconz.PyramidzYellow,
      pageTitle: Wordz.languageName(context),
      icons: null,
      idValueMaps: _languageMaps,
      pageIcon: null,
      pageIconVerse: null,
      sky: Sky.Black,
      onItemTap: (value) => _tapLanguage(context, value),
    );

  }

}
