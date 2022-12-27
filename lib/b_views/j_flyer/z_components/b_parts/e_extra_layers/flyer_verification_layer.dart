import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class FlyerVerificationLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerVerificationLayer({
    @required this.flyerBoxWidth,
    @required this.auditState,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final AuditState auditState;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// IF VERIFIED 0R NULL
    if (auditState == null || auditState == AuditState.verified) {
      return const SizedBox();
    }

    /// IF SUSPENDED OR PENDING
    else {

      final String _phid =
      auditState == AuditState.pending ? 'phid_waiting_verification'
          :
      auditState == AuditState.suspended ? 'phid_suspended'
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
                  angle: Numeric.degreeToRadian(-45),
                  child: Center(
                    child: WidgetFader(
                      fadeType: FadeType.repeatAndReverse,
                      duration: const Duration(seconds: 2),
                      child: SuperVerse(
                        verse: Verse(
                          text: _phid,
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

  }
  /// --------------------------------------------------------------------------
}
