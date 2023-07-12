import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class BldrsUnderConstructionScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsUnderConstructionScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      appBarType: AppBarType.non,
      pyramidsAreOn: true,
      title: const Verse(
        id: '',
        translate: false,
      ),
      skyType: SkyType.blackStars,
      pyramidType: PyramidType.glass,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          BldrsText(
            verse: Verse.plain(Words.bldrsUnderConstruction()),
            width: Bubble.bubbleWidth(context: context) * 0.7,
            maxLines: 4,
            size: 5,
            italic: true,
            scaleFactor: Bubble.bubbleWidth(context: context) * 0.003,
          ),

          const BldrsBox(
            height: 100,
            icon: Iconz.dvGouran,
            bubble: false,
            iconColor: Colorz.yellow50,
          ),

          BldrsText(
            verse: Verse.plain('We will be back soon isa'),
            width: Bubble.bubbleWidth(context: context) * 0.7,
            maxLines: 4,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.yellow50,
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
