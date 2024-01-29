import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/components/animators/widget_waiter.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter/material.dart';

class SomethingWrongRestartButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SomethingWrongRestartButton({
    required this.waitSeconds,
    super.key
  });
  /// --------------------------------------------------------------------------
  final int? waitSeconds;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperPositioned(
      appIsLTR: true,
      enAlignment: Alignment.bottomRight,
      verticalOffset: Ratioz.pyramidsHeight * 0.75,
      horizontalOffset: Ratioz.pyramidsWidth * 0.8,
      child: WidgetWaiter(
        waitDuration: Duration(seconds: waitSeconds ?? 0),
        isOn: waitSeconds != null,
        child: WidgetFader(
          fadeType: FadeType.fadeIn,
          child: BldrsBox(
            height: Scale.screenShortestSide(context) * 0.12,
            corners: 35,
            verse: getVerse('phid_somethingWentWrong'),
            icon: Iconz.yellowAlert,
            iconSizeFactor: 0.6,
            verseScaleFactor: 0.5 / 0.6,
            secondLineScaleFactor: 0.7,
            verseCentered: false,
            verseWeight: VerseWeight.thin,
            verseMaxLines: 3,
            // secondLine: const Verse(
            //   id: 'phid_clean_and_restart',
            //   translate: true,
            // ),
            onTap: () => BldrsNav.pushLogoRouteAndRemoveAllBelow(animatedLogoScreen: false),
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
