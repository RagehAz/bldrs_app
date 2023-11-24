import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:flutter/material.dart';

class SlideEditorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorControlPanel({
    required this.onResetMatrix,
    required this.height,
    required this.canResetMatrix,
    required this.draftSlideNotifier,
    required this.onTriggerAnimation,
    required this.draftFlyerNotifier,

    required this.onNextSlide,
    required this.onPreviousSlide,
    required this.onFirstSlideBack,
    required this.onLastSlideNext,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function onResetMatrix;
  final double height;
  final ValueNotifier<bool> canResetMatrix;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final ValueNotifier<DraftFlyer?> draftFlyerNotifier;
  final Function onTriggerAnimation;

  final Function(DraftSlide draftSlide) onNextSlide;
  final Function(DraftSlide draftSlide) onPreviousSlide;
  final Function onFirstSlideBack;
  final Function onLastSlideNext;
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
    // final double _screenWidth = Scale.screenWidth(getMainContext());
    final double _buttonSize = controlPanelHeight * 0.5;
    // final double _buttonSize = Scale.getUniformRowItemWidth(
    //   context: getMainContext(),
    //   numberOfItems: 5,
    //   boxWidth: _screenWidth,
    //   spacing: 20,
    //   // considerMargins: true,
    // );
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

        /// RESET MATRIX
        ValueListenableBuilder(
            valueListenable: canResetMatrix,
            builder: (_, bool _canResetMatrix, Widget? child){
              return SlideEditorButton(
                size: _buttonSize,
                icon: Iconz.reload,
                verse: const Verse(
                  id: 'phid_reset',
                  translate: true,
                ),
                isDisabled: !_canResetMatrix,
                onTap: onResetMatrix,
              );
            }
            ),

        /// BACKGROUND
        ValueListenableBuilder(
            valueListenable: draftSlideNotifier,
            builder: (_, DraftSlide? draftSlide, Widget? child){

              return SlideEditorButton(
                size: _buttonSize,
                icon: Iconz.colors,
                verse: const Verse(
                  id: 'phid_background',
                  translate: true,
                ),
                onTap: () async {

                  final bool _hasBackColor = draftSlide?.backColor != null;

                  /// SHOULD SET BLURRED PIC
                  if (_hasBackColor == true){

                    /// DELETE BACK COLOR
                    DraftSlide _draftSlide = draftSlide!.nullifyField(
                      backColor: true,
                    );

                    /// SET BLURRED IMAGE
                    final PicModel? _backPic = await SlidePicMaker.createSlideBackground(
                      bigPic: draftSlide.bigPic,
                      flyerID: draftSlide.flyerID,
                      slideIndex: draftSlide.slideIndex,
                      overrideSolidColor: null,
                    );
                    _draftSlide = _draftSlide.copyWith(
                      backPic: _backPic,
                    );

                    setNotifier(
                        notifier: draftSlideNotifier,
                        mounted: true,
                        value: _draftSlide,
                    );

                  }

                  /// SHOULD SET COLOR
                  else {

                    /// DELETE BACK PIC
                    DraftSlide _draftSlide = draftSlide!.nullifyField(
                      backPic: true,
                    );

                    /// SET BACK COLOR
                    _draftSlide = _draftSlide.copyWith(
                      backColor: Colorz.white255,
                    );

                    setNotifier(
                      notifier: draftSlideNotifier,
                      mounted: true,
                      value: _draftSlide,
                    );


                  }

                },
              );
            }
            ),

        /// ANIMATE
        ValueListenableBuilder(
            valueListenable: draftSlideNotifier,
            builder: (_, DraftSlide? draftSlide, Widget? child){
              final bool animate = draftSlide?.animationCurve != null;
              return ValueListenableBuilder(
                  valueListenable: canResetMatrix,
                  builder: (_, bool canReset, Widget? child) {
                    return SlideEditorButton(
                      size: _buttonSize,
                      icon: animate == true ? Iconz.flyerScale : Iconz.flyer,
                      verse: Verse(
                        id: animate == true ? 'phid_animated' : 'phid_static',
                        translate: true,
                      ),
                      // isDisabled: !canReset,
                      onTap: onTriggerAnimation,
                    );
                  });
            }),

        // /// CROP
        // SlideEditorButton(
        //   size: _buttonSize,
        //   icon: Iconz.crop,
        //   verse: const Verse(
        //     text: 'phid_crop',
        //     translate: true,
        //   ),
        //   onTap: onCrop,
        // ),

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
