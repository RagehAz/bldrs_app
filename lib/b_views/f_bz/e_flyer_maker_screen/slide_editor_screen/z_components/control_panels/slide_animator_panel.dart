import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/animation_frame_button.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/panel_circle_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SlideAnimatorPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideAnimatorPanel({
    required this.flyerBoxWidth,
    required this.isDoingMatrixFrom,
    required this.isPlayingAnimation,
    required this.draftFlyerNotifier,
    required this.mounted,
    required this.draftSlideNotifier,
    required this.matrixNotifier,
    required this.matrixFromNotifier,
    required this.onResetMatrix,
    required this.canResetMatrix,
    required this.onTriggerSlideIsAnimated,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<bool> isDoingMatrixFrom;
  final ValueNotifier<bool> isPlayingAnimation;
  final ValueNotifier<DraftFlyer?> draftFlyerNotifier;
  final bool mounted;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<Matrix4?> matrixFromNotifier;
  final Function onResetMatrix;
  final ValueNotifier<bool> canResetMatrix;
  final Function onTriggerSlideIsAnimated;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _size = FlyerDim.footerButtonSize(
        flyerBoxWidth: flyerBoxWidth,
      );

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: flyerBoxWidth,
        height: FlyerDim.footerBoxHeight(
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
          showTopButton: false,
        ),
        child: ValueListenableBuilder(
          valueListenable: isPlayingAnimation,
          builder: (_, bool _isPlayingAnimation, __) {

            return ValueListenableBuilder(
              valueListenable: isDoingMatrixFrom,
              builder: (__, bool _isDoingMatrixFrom, ___) {
                return Row(
                  children: <Widget>[

                    const Expander(),

                    /// FROM
                    AnimationFrameButton(
                      flyerBoxWidth: flyerBoxWidth,
                      verse: const Verse(
                        id: 'phid_from',
                        translate: true,
                      ),
                      isSelected: _isPlayingAnimation == false && _isDoingMatrixFrom == true,
                      draftSlideNotifier: draftSlideNotifier,
                      matrixNotifier: matrixFromNotifier,
                      onTap: () => onFromTap(
                        isPlayingAnimation: isPlayingAnimation,
                        isDoingMatrixFrom: isDoingMatrixFrom,
                        mounted: mounted,
                        draftSlideNotifier: draftSlideNotifier,
                        draftFlyerNotifier: draftFlyerNotifier,
                        matrixFromNotifier: matrixFromNotifier,
                        matrixNotifier: matrixNotifier,
                      ),
                    ),

                    /// SPACING
                    Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,),

                    /// RESET MATRIX
                    ValueListenableBuilder(
                        valueListenable: canResetMatrix,
                        builder: (_, bool _canResetMatrix, Widget? child){

                          return PanelCircleButton(
                            verse: const Verse(
                              id: 'phid_reset',
                              translate: true,
                            ),
                            icon: Iconz.reload,
                            size: _size,
                            isSelected: false,
                            isDisabled: !_canResetMatrix,
                            onTap: onResetMatrix,
                          );

                        }),

                    /// SPACING
                    Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,),

                    /// SLIDE IS ANIMATED
                    ValueListenableBuilder(
                        valueListenable: draftSlideNotifier,
                        builder: (_, DraftSlide? draftSlide, Widget? child) {

                          final bool _isAnimated = draftSlide?.animationCurve != null;

                          return PanelCircleButton(
                            verse: Verse(
                              id: _isAnimated ? 'phid_animated' : 'phid_still',
                              translate: true,
                            ),
                            icon: _isAnimated ? Iconz.flyerScale : Iconz.flyer,
                            size: _size,
                            isSelected: false,
                            onTap: onTriggerSlideIsAnimated,
                          );
                        }),

                    /// SPACING
                    Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,),

                    /// PLAY
                    PanelCircleButton(
                      verse: Verse(
                        id: _isPlayingAnimation == true ? 'phid_pause' : 'phid_play',
                        translate: true,
                      ),
                      icon: _isPlayingAnimation == true ? Iconz.pause : Iconz.play,
                      size: _size,
                      isSelected: _isPlayingAnimation,
                      onTap: () => onPlayTap(
                        isPlayingAnimation: isPlayingAnimation,
                        mounted: mounted,
                        draftSlideNotifier: draftSlideNotifier,
                        draftFlyerNotifier: draftFlyerNotifier,
                        matrixFromNotifier: matrixFromNotifier,
                        matrixNotifier: matrixNotifier,
                        isDoingMatrixFrom: isDoingMatrixFrom,
                      ),
                    ),

                    /// SPACING
                    Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,),

                    /// TO
                    AnimationFrameButton(
                      flyerBoxWidth: flyerBoxWidth,
                      verse: const Verse(
                        id: 'phid_to',
                        translate: true,
                      ),
                      isSelected: _isPlayingAnimation == false && _isDoingMatrixFrom == false,
                      draftSlideNotifier: draftSlideNotifier,
                      matrixNotifier: matrixNotifier,
                      onTap: () => onToTap(
                        isPlayingAnimation: isPlayingAnimation,
                        isDoingMatrixFrom: isDoingMatrixFrom,
                        mounted: mounted,
                        draftSlideNotifier: draftSlideNotifier,
                        draftFlyerNotifier: draftFlyerNotifier,
                        matrixFromNotifier: matrixFromNotifier,
                        matrixNotifier: matrixNotifier,
                      ),
                    ),

                    const Expander(),

                  ],
                );
              }
            );

          }
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
