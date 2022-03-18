import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/b_views/z_components/layouts/list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/f_helpers/localization/lingo.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class SelectAppLanguageScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectAppLanguageScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  Future<void> _tapLanguage(BuildContext context, String languageCode) async {
    await Localizer.changeAppLanguage(context, languageCode);

    // Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
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
