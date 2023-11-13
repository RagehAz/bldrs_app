import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class EditorSwipingButtons extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const EditorSwipingButtons({
    this.onNext,
    this.canGoNext = false,
    this.onDisabledNextTap,
    this.onPrevious,
    this.onSkipTap,
    // this.onDisabledPreviousTap,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Function? onNext;
  final bool canGoNext;
  final Function? onDisabledNextTap;
  final Function? onPrevious;
  final Function? onSkipTap;
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

    await onGoToIndexPage(
        context: context,
        progressBarModel: progressBarModel,
        pageController: pageController,
        mounted: mounted,
        toIndex: _nextIndex,
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

    final int _currentIndex = pageController.page?.toInt() ?? 0;
    final bool _isFirstPage = _currentIndex == 0;
    final int _previousIndex = _isFirstPage == true ? 0 : _currentIndex - 1;

    await onGoToIndexPage(
      context: context,
      progressBarModel: progressBarModel,
      pageController: pageController,
      mounted: mounted,
      toIndex: _previousIndex,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onGoToIndexPage({
    required BuildContext context,
    required ValueNotifier<ProgressBarModel?> progressBarModel,
    required PageController pageController,
    required bool mounted,
    required int toIndex,
  }) async {

    final int _numberOfPages = progressBarModel.value?.numberOfStrips ?? 1;

    if (toIndex >= 0 && toIndex < _numberOfPages){

      await Keyboard.closeKeyboard();

      ProgressBarModel.onSwipe(
        context: context,
        newIndex: toIndex,
        progressBarModel: progressBarModel,
        mounted: mounted,
        numberOfPages: _numberOfPages,
      );

      await Sliders.slideToIndex(
        pageController: pageController,
        toIndex: toIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
      );

    }


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
                await Keyboard.closeKeyboard();
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
                await Keyboard.closeKeyboard();
                onNext?.call();
              },
            ),

            if (onSkipTap != null && onNext == null)
            BldrsBox(
              verse: const Verse(id: 'phid_skip', translate: true),
              verseScaleFactor: 0.7,
              height: 50,
              margins: 10,
              width: 100,
              color: Colorz.white10,
              onTap: () async {
                await Keyboard.closeKeyboard();
                onSkipTap?.call();
              },
            ),

          ],
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
