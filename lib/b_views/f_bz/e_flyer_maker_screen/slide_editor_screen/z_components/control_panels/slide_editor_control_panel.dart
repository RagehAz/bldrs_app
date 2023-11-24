import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/slide_editor_button.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_part/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:flutter/material.dart';

class SlideEditorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorControlPanel({
    required this.height,
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
  final double height;
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
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getControlPanelHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, screenHeight);
    final double _controlPanelHeight = screenHeight - _slideZoneHeight;
    return _controlPanelHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getButtonSize(double controlPanelHeight){
    final double _buttonSize = controlPanelHeight * 0.6;
    return _buttonSize;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _controlPanelHeight = height;
    final double _buttonSize = getButtonSize(_controlPanelHeight);
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

                return SlideEditorButton(
                  size: _buttonSize,
                  icon: _isFirst == true ? Iconz.exit : Iconizer.superYellowArrowENLeft(context),
                  verse: Verse(
                    id: _isFirst == true ? 'phid_exit' : 'phid_previous',
                    translate: true,
                  ),
                  onTap: _isFirst == true ?
                  onFirstSlideBack
                      :
                  () async {

                    final DraftSlide? previousSlide = draftFlyer?.draftSlides?[_slideIndex - 1];
                    if (previousSlide != null){
                      onPreviousSlide(previousSlide);
                    }

                  },
                );

              }
            );
          }
        ),

        /// TRIGGER COLOR PANEL
        ValueListenableBuilder(
            valueListenable: showColorPanel,
            builder: (_, bool showPanel, Widget? child){

              return SlideEditorButton(
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

              return SlideEditorButton(
                size: _buttonSize,
                icon: Iconz.flyerScale,
                verse: const Verse(
                  id: 'phid_animation',
                  translate: true,
                ),
                isSelected: showPanel,
                onTap: onTriggerAnimationPanel,
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

                    return SlideEditorButton(
                      size: _buttonSize,
                      icon: _isLast == true ? Iconz.check : Iconizer.superYellowArrowENRight(context),
                      verse: Verse(
                        id: _isLast == true ? 'phid_confirm' : 'phid_next',
                        translate: true,
                      ),
                      onTap: _isLast == true ?
                      onLastSlideNext
                          :
                          () async {

                        final DraftSlide? nextSlide = draftFlyer?.draftSlides?[_slideIndex + 1];
                        if (nextSlide != null){
                          await onNextSlide(nextSlide);
                        }

                        },
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
