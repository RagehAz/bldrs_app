import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingVerse({
    this.verseWidth,
    this.builder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? verseWidth;
  final Widget Function(Verse? verse)? builder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return WidgetFader(
      fadeType: FadeType.repeatAndReverse,
      duration: Ratioz.durationSliding400,
      min: 0.2,
      max: 0.8,
      child: Selector<UiProvider, Verse?>(
        selector: (_, UiProvider uiProvider) => uiProvider.loadingVerse,
        builder: (BuildContext context, Verse? verse, Widget? child) {

          if (builder == null){
            final Verse _verse = verse ?? Verse(
              id: Words.loading(),
              casing: Casing.upperCase,
              translate: false,
            );

            return BldrsText(
              width: verseWidth,
              verse: _verse,
              size: 3,
              margin: 10,
              italic: true,
              shadow: true,
              maxLines: 5,
              weight: VerseWeight.thin,
            );
          }

          else {
            return builder!(verse);
          }

          },
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
