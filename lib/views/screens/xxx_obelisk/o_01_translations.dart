import 'package:bldrs/main.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class Translations extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final List<String> wordsList = [
    Wordz.Views(context),
    Wordz.Owner(context),
  ];

    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      tappingRageh:
      translate(context, 'Active_Language') == 'Arabic' ?
          () async {
        Locale temp = await setLocale('en');
        BldrsApp.setLocale(context, temp);
      } :
          () async {
        Locale temp = await setLocale('ar');
        BldrsApp.setLocale(context, temp);
      },
      layoutWidget: Column(
        children: wordsList.map(
            (word) =>
                SuperVerse(
                  verse: word,
                ),
        ).toList(),
      ),
    );
  }
}
