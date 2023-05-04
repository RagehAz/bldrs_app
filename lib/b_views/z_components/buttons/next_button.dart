import 'package:animators/animators.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NextButton({
    @required this.onTap,
    @required this.canGoNext,
    this.onDisabledTap,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Function onTap;
  final bool canGoNext;
  final Function onDisabledTap;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onNextTap({
    @required BuildContext context,
    @required ValueNotifier<ProgressBarModel> progressBarModel,
    @required PageController pageController,
    @required bool mounted,
  }) async {

    final int _numberOfPages = progressBarModel.value.numberOfStrips;
    final int _currentIndex = pageController?.page?.toInt() ?? 0;
    final bool _isLastPage = _currentIndex == _numberOfPages - 1;
    final int _nextIndex = _isLastPage == true ? 0 : _currentIndex + 1;

    ProgressBarModel.onSwipe(
      context: context,
      newIndex: _nextIndex,
      progressBarModel: progressBarModel,
      mounted: mounted,
      numberOfPages: _numberOfPages,
    );

    await Sliders.slideToIndex(
      pageController: pageController,
      toIndex: _nextIndex,
      curve: Curves.easeInOut,
      // duration: const Duration(milliseconds: 500),
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        BldrsBox(
          isDisabled: !canGoNext,
          verse: const Verse(id: 'phid_next', translate: true),
          verseScaleFactor: 0.7,
          height: 50,
          margins: 10,
          width: 100,
          onTap: onTap,
          color: canGoNext == true ? Colorz.green255 : null,
          onDisabledTap: onDisabledTap,
        ),
      ],
    );

  }
  // -----------------------------------------------------------------------------
}
