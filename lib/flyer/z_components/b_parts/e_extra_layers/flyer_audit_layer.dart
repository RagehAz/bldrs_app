import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/components/animators/widget_fader.dart';

class FlyerAuditLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerAuditLayer({
    required this.flyerBoxWidth,
    required this.publishState,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final PublishState? publishState;
  /// --------------------------------------------------------------------------
  static bool showAuditLayer(PublishState? state){
    final bool _shouldHide =
            state == null
            ||
            state == PublishState.published;

    return !_shouldHide;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// IF VERIFIED 0R NULL
    if (showAuditLayer(publishState) == false) {
      return const SizedBox();
    }

    /// IF SUSPENDED OR PENDING
    else {

      final String? _phid =
      publishState == PublishState.pending ? 'phid_waiting_verification'
          :
      publishState == PublishState.suspended ? 'phid_suspended'
          :
          null;

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
                  angle: Numeric.degreeToRadian(-45)!,
                  child: Center(
                    child: WidgetFader(
                      fadeType: FadeType.repeatAndReverse,
                      duration: const Duration(seconds: 3),
                      child: BldrsText(
                        width: flyerBoxWidth * 0.8,
                        verse: Verse(
                          id: _phid,
                          translate: true,
                        ),
                        centered: !UiProvider.checkAppIsLeftToRight(),
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

  }
  /// --------------------------------------------------------------------------
}
