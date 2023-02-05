import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:widget_fader/widget_fader.dart';

class FlyerAuditLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerAuditLayer({
    @required this.flyerBoxWidth,
    @required this.auditState,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final AuditState auditState;
  /// --------------------------------------------------------------------------
  static bool showAuditLayer(AuditState auditState){
    final bool _shouldHide =
            auditState == null
            ||
            auditState == AuditState.verified;

    return !_shouldHide;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// IF VERIFIED 0R NULL
    if (showAuditLayer(auditState) == false) {
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
                      duration: const Duration(seconds: 3),
                      child: SuperVerse(
                        width: flyerBoxWidth * 0.8,
                        verse: Verse(
                          text: _phid,
                          translate: true,
                        ),
                        centered: !UiProvider.checkAppIsLeftToRight(context),
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
