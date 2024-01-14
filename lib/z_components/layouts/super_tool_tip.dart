import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class SuperToolTip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperToolTip({
    required this.verse,
    required this.triggerMode,
    required this.child,
    this.balloonColor,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? verse;
  final Widget child;
  final TooltipTriggerMode triggerMode;
  final Color? balloonColor;
  // --------------------------------------------------------------------------
  static const int millisecondsPerWord = 500;
  // --------------------
  Duration _calculateShowDuration({
    required String? message,
  }){
    final int _length = message?.split(' ').length ?? 0;
    return Duration(milliseconds: _length * millisecondsPerWord);
  }
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    if (verse == null || TextCheck.isEmpty(verse?.id) == true){
      return child;
    }

    else {

      final String? _message = Verse.bakeVerseToString(verse: verse);

      return Tooltip(
        /// TEXT
        message: _message,
        // richMessage: ,

        /// SCALE
        height: 70,
        margin: Scale.superInsets(
          context: context,
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          enLeft: Ratioz.appBarMargin,
          enRight: Ratioz.appBarMargin * 5,
          top: 20,
          bottom: 20,
        ),
        verticalOffset: 5,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),

        /// BEHAVIOUR
        triggerMode: triggerMode,
        enableFeedback: true,
        preferBelow: true,

        /// STYLE
        textStyle: BldrsText.superVerseDefaultStyle(context),
        decoration: BoxDecoration(
          color: balloonColor ?? Colorz.black255,
          borderRadius: BldrsAppBar.corners,
        ),

        /// DURATION
        showDuration: _calculateShowDuration(
          message: _message,
        ),

        /// HOVER WAIT UNTIL TOOLTIP SHOWS
        // waitDuration: const Duration(milliseconds: 100), // ZERO BY DEFAULT

        child: child,
      );
    }


  }
  /// --------------------------------------------------------------------------
}
