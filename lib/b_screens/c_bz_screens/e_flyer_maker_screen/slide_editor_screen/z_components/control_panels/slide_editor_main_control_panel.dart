import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_nab_button/editor_nav_button.dart';
import 'package:bldrs/b_screens/h_media_screens/editor_scale.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:flutter/material.dart';

class SlideEditorMainControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorMainControlPanel({
    required this.draftSlideNotifier,
    required this.onTriggerAnimationPanel,
    required this.onTriggerColorPanel,
    required this.draftFlyerNotifier,
    required this.onNextSlide,
    required this.onPreviousSlide,
    required this.onFirstSlideBack,
    required this.onLastSlideNext,
    required this.showColorPanel,
    required this.showAnimationPanel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final ValueNotifier<DraftFlyer?> draftFlyerNotifier;
  final Function onTriggerAnimationPanel;
  final Function(DraftSlide draftSlide) onNextSlide;
  final Function(DraftSlide draftSlide) onPreviousSlide;
  final Function onFirstSlideBack;
  final Function onLastSlideNext;
  final ValueNotifier<bool> showColorPanel;
  final Function onTriggerColorPanel;
  final ValueNotifier<bool> showAnimationPanel;
  // -----------------------------------------------------------------------------

  /// FUNCTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Function onGoPreviousFunction({
    required bool isFirst,
    required int slideIndex,
    required DraftFlyer? draftFlyer,
  }){

    if (isFirst == true){
      return onFirstSlideBack;
    }
    else {

      return () async {
        final DraftSlide? previousSlide = draftFlyer?.draftSlides?[slideIndex - 1];
        if (previousSlide != null){
          onPreviousSlide(previousSlide);
        }
      };

    }

  }
  // --------------------
  Function onGoNextFunction({
    required bool isLast,
    required int slideIndex,
    required DraftFlyer? draftFlyer,
  }){

    if (isLast == true){
      return onLastSlideNext;
    }

    else {
      return () async {
        final DraftSlide? nextSlide = draftFlyer?.draftSlides?[slideIndex + 1];
        if (nextSlide != null){
          await onNextSlide(nextSlide);
        }
      };
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _controlPanelHeight = EditorScale.navZoneHeight();
    final double _buttonSize = EditorScale.navButtonSize();
    // --------------------
    return FloatingList(
      width: _screenWidth,
      height: _controlPanelHeight,
      scrollDirection: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      columnChildren: <Widget>[

        /// GO PREVIOUS - EXIT
        ValueListenableBuilder(
            valueListenable: draftFlyerNotifier,
            builder: (_, DraftFlyer? draftFlyer, Widget? child){

            return ValueListenableBuilder(
                valueListenable: draftSlideNotifier,
                builder: (_, DraftSlide? draftSlide, Widget? child){

                  final int _slideIndex = draftSlide?.slideIndex ?? 0;
                  final bool _isFirst = _slideIndex == 0;

                return EditorNavButton(
                  size: _buttonSize,
                  icon: _isFirst == true ? Iconz.exit : Iconizer.superYellowArrowENLeft(context),
                  verse: Verse(
                    id: _isFirst == true ? 'phid_exit' : 'phid_previous',
                    translate: true,
                  ),
                  onTap: onGoPreviousFunction(
                    isFirst: _isFirst,
                    slideIndex: _slideIndex,
                    draftFlyer: draftFlyer,
                  ),
                );

              }
            );
          }
        ),

        /// TRIGGER COLOR PANEL
        ValueListenableBuilder(
            valueListenable: showColorPanel,
            builder: (_, bool showPanel, Widget? child){

              return EditorNavButton(
                size: _buttonSize,
                icon: Iconz.colors,
                verse: const Verse(
                  id: 'phid_background',
                  translate: true,
                ),
                isSelected: showPanel,
                onTap: onTriggerColorPanel,
              );
            }
            ),

        /// ANIMATION TRIGGER
        ValueListenableBuilder(
            valueListenable: showAnimationPanel,
            builder: (_, bool showPanel, Widget? child){

              return ValueListenableBuilder(
                valueListenable: draftSlideNotifier,
                builder: (_, DraftSlide? draftSlide, Widget? child){

                  final bool _hasAnimation = draftSlide?.animationCurve != null;

                  return EditorNavButton(
                    size: _buttonSize,
                    icon: _hasAnimation ? Iconz.flyerScale : Iconz.flyer,
                    verse: const Verse(
                      id: 'phid_animation',
                      translate: true,
                    ),
                    isSelected: showPanel,
                    onTap: onTriggerAnimationPanel,
                  );
                }
              );

            }),

        /// GO NEXT - CONFIRM
        ValueListenableBuilder(
            valueListenable: draftFlyerNotifier,
            builder: (_, DraftFlyer? draftFlyer, Widget? child){

              return ValueListenableBuilder(
                  valueListenable: draftSlideNotifier,
                  builder: (_, DraftSlide? draftSlide, Widget? child){

                    final int _slideIndex = draftSlide?.slideIndex ?? 0;
                    final int _numberOfSlides = draftFlyer?.draftSlides?.length ?? 0;
                    final bool _isLast = _slideIndex + 1 == _numberOfSlides;

                    return EditorNavButton(
                      size: _buttonSize,
                      icon: _isLast == true ? Iconz.check : Iconizer.superYellowArrowENRight(context),
                      verse: Verse(
                        id: _isLast == true ? 'phid_confirm' : 'phid_next',
                        translate: true,
                      ),
                      onTap: onGoNextFunction(
                        isLast: _isLast,
                        slideIndex: _slideIndex,
                        draftFlyer: draftFlyer,
                      ),
                    );

                  });

            }
            ),

        ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
