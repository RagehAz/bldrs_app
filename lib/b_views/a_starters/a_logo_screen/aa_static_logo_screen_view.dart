import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class LogoScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LogoScreenView({
    this.scaleController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Animation<double>? scaleController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          const SizedBox(
            width: 300,
            height: 100,
          ),

          if (scaleController != null)
          ScaleTransition(
            scale: scaleController!,
            child: const LogoSlogan(
              showTagLine: true,
              showSlogan: true,
            ),
          ),

          if (scaleController == null)
            const LogoSlogan(
              showTagLine: true,
              showSlogan: true,
            ),

          SizedBox(
            width: 300,
            height: 100,
            child: WidgetFader(
              fadeType: FadeType.repeatAndReverse,
              duration: Ratioz.durationSliding400,
              min: 0.2,
              max: 0.8,
              child: BldrsText(
                verse: Verse(
                  id: Words.loading(),
                  casing: Casing.upperCase,
                  translate: false,
                ),
                size: 5,
                margin: 20,
                italic: true,
                shadow: true,
              ),
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
