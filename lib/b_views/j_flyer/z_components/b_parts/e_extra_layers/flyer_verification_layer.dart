import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerVerificationLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerVerificationLayer({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      key: const ValueKey<String>('FlyerVerificationLayer'),
      fadeType: FadeType.fadeIn,
      child: IgnorePointer(
        child: FlyerBox(
          flyerBoxWidth: flyerBoxWidth,
          boxColor: Colorz.black80,
          stackWidgets: <Widget>[

            Transform.scale(
              scale: 2,
              child: Transform.rotate(
                angle: Numeric.degreeToRadian(-45),
                child: Center(
                  child: WidgetFader(
                    fadeType: FadeType.repeatAndReverse,
                    duration: const Duration(seconds: 2),
                    child: SuperVerse(
                      verse: const Verse(
                        text: 'phid_waiting_verification',
                        translate: true,
                      ),
                      weight: VerseWeight.black,
                      italic: true,
                      scaleFactor: flyerBoxWidth * 0.008,
                      maxLines: 2,
                      color: Colorz.white125,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
