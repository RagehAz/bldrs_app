import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';

class SuperToolTip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperToolTip({
    @required this.verse,
    @required this.child,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final Widget child;
  // --------------------------------------------------------------------------
  static const int millisecondsPerWord = 400;
  // --------------------
  ///
  Duration _calculateShowDuration(){
    final int _length = verse.id.split(' ').length;
    return Duration(milliseconds: _length * millisecondsPerWord);
  }
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    if (verse == null || TextCheck.isEmpty(verse.id) == true){
      return child;
    }

    else {
      return Tooltip(
        /// TEXT
        message: Verse.bakeVerseToString(context: context, verse: verse),
        // richMessage: ,

        /// SCALE
        height: 70,
        margin: Scale.superInsets(
          context: context,
          appIsLTR: UiProvider.checkAppIsLeftToRight(context),
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
        triggerMode: TooltipTriggerMode.longPress,
        enableFeedback: true,
        preferBelow: true,

        /// STYLE
        textStyle: BldrsText.superVerseDefaultStyle(context),
        decoration: const BoxDecoration(
          color: Colorz.black255,
          borderRadius: BldrsAppBar.corners,
        ),

        /// DURATION
        showDuration: _calculateShowDuration(),

        /// HOVER WAIT UNTIL TOOLTIP SHOWS
        // waitDuration: const Duration(milliseconds: 100), // ZERO BY DEFAULT

        child: child,
      );
    }


  }
  /// --------------------------------------------------------------------------
}
