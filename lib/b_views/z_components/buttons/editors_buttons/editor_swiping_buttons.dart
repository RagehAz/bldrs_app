import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:flutter/material.dart';

class EditorSwipingButtons extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const EditorSwipingButtons({
    this.onNext,
    this.canGoNext = false,
    this.onDisabledNextTap,
    this.onPrevious,
    // this.onDisabledPreviousTap,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Function? onNext;
  final bool canGoNext;
  final Function? onDisabledNextTap;
  final Function? onPrevious;
  // final Function? onDisabledPreviousTap;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onNextTap({
    required BuildContext context,
    required ValueNotifier<ProgressBarModel?> progressBarModel,
    required PageController pageController,
    required bool mounted,
  }) async {

    final int _numberOfPages = progressBarModel.value?.numberOfStrips ?? 1;
    final int _currentIndex = pageController.page?.toInt() ?? 0;
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onPreviousTap({
    required BuildContext context,
    required ValueNotifier<ProgressBarModel?> progressBarModel,
    required PageController pageController,
    required bool mounted,
  }) async {

    final int _numberOfPages = progressBarModel.value?.numberOfStrips ?? 1;
    final int _currentIndex = pageController.page?.toInt() ?? 0;
    final bool _isFirstPage = _currentIndex == 0;
    final int _previousIndex = _isFirstPage == true ? 0 : _currentIndex - 1;

    ProgressBarModel.onSwipe(
      context: context,
      newIndex: _previousIndex,
      progressBarModel: progressBarModel,
      mounted: mounted,
      numberOfPages: _numberOfPages,
    );

    await Sliders.slideToIndex(
      pageController: pageController,
      toIndex: _previousIndex,
      curve: Curves.easeInOut,
      // duration: const Duration(milliseconds: 500),
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: Bubble.bubbleWidth(context: context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            /// PREVIOUS
            if (onPrevious != null)
            BldrsBox(
              // isDisabled: !canGoPrevious,
              // onDisabledTap: onDisabledPreviousTap,
              verse: const Verse(id: 'phid_previous', translate: true),
              verseScaleFactor: 0.7,
              height: 50,
              margins: 10,
              width: 100,
              color: Colorz.white10,
              onTap: () async {
                Keyboard.closeKeyboard();
                onPrevious?.call();
              },
            ),

            if (onPrevious != null)
            const Expander(),

            /// NEXT
            if (onNext != null)
            BldrsBox(
              isDisabled: !canGoNext,
              verse: const Verse(id: 'phid_next', translate: true),
              verseScaleFactor: 0.7,
              height: 50,
              margins: 10,
              width: 100,
              color: canGoNext == true ? Colorz.green255 : null,
              onDisabledTap: onDisabledNextTap,
              onTap: () async {
                Keyboard.closeKeyboard();
                onNext?.call();
              },
            ),

          ],
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}