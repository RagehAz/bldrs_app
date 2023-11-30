import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/animation_frame_button.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/panel_circle_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SlideAnimatorPanel extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SlideAnimatorPanel({
    required this.flyerBoxWidth,
    required this.isDoingMatrixFrom,
    required this.isPlayingAnimation,
    required this.draftSlideNotifier,
    required this.matrixNotifier,
    required this.matrixFromNotifier,
    required this.onResetMatrix,
    required this.canResetMatrix,
    required this.onTriggerSlideIsAnimated,
    required this.onFromTap,
    required this.onToTap,
    required this.onPlayTap,
    required this.showAnimationPanel,
    super.key
  });
  // --------------------
  final double flyerBoxWidth;
  final ValueNotifier<bool> isDoingMatrixFrom;
  final ValueNotifier<bool> isPlayingAnimation;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<Matrix4?> matrixFromNotifier;
  final Function onResetMatrix;
  final ValueNotifier<bool> canResetMatrix;
  final Function onTriggerSlideIsAnimated;
  final Function onFromTap;
  final Function onToTap;
  final Function onPlayTap;
  final ValueNotifier<bool> showAnimationPanel;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _size = FlyerDim.footerButtonSize(
      flyerBoxWidth: flyerBoxWidth,
    );

    final Widget _spacing = Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,);

    return ValueListenableBuilder(
      valueListenable: showAnimationPanel,
      builder: (_, bool showPanel, Widget? child) {

          /// SHOW PANEL
          if (showPanel == true){
            return child!;
          }

          /// HIDE PANEL
          else {
            return const SizedBox();
          }
        },

      child: Positioned(
        bottom: 2,
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

                      return ValueListenableBuilder(
                          valueListenable: draftSlideNotifier,
                          builder: (_, DraftSlide? _draftSlide, Widget? child) {

                            final bool _hasAnimation = _draftSlide?.animationCurve != null;

                            return Row(
                              children: <Widget>[

                                const Expander(),

                                /// FROM
                                if (_hasAnimation == true)
                                  AnimationFrameButton(
                                    flyerBoxWidth: flyerBoxWidth,
                                    verse: const Verse(
                                      id: 'phid_from',
                                      translate: true,
                                    ),
                                    isSelected: _isPlayingAnimation == false && _isDoingMatrixFrom == true,
                                    draftSlideNotifier: draftSlideNotifier,
                                    matrixNotifier: matrixFromNotifier,
                                    onTap: onFromTap ,
                                  ),

                                /// SPACING
                                _spacing,

                                // /// RESET MATRIX
                                // ValueListenableBuilder(
                                //     valueListenable: canResetMatrix,
                                //     builder: (_, bool _canResetMatrix, Widget? child){
                                //       return PanelCircleButton(
                                //         verse: const Verse(
                                //           id: 'phid_reset',
                                //           translate: true,
                                //         ),
                                //         icon: Iconz.reload,
                                //         size: _size,
                                //         isSelected: false,
                                //         isDisabled: !_canResetMatrix,
                                //         onTap: onResetMatrix,
                                //       );
                                //     }),

                                /// NEW RESET MATRIX
                                ValueListenableBuilder(
                                  valueListenable: matrixFromNotifier,
                                  builder: (_, Matrix4? matrixF, Widget? child){

                                    return ValueListenableBuilder(
                                        valueListenable: matrixNotifier,
                                        builder: (_, Matrix4? matrix, Widget? child){

                                          final bool _m = Trinity.checkMatrixesAreIdentical(
                                              matrix1: matrix,
                                              matrixReloaded: Matrix4.identity(),
                                          );


                                          final bool _mf = Trinity.checkMatrixesAreIdentical(
                                              matrix1: matrixF,
                                              matrixReloaded: Trinity.slightlyZoomed(
                                                  flyerBoxWidth: flyerBoxWidth,
                                                  flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
                                                    flyerBoxWidth: flyerBoxWidth,
                                                  ),
                                              )
                                          );

                                          final bool _isWrong = !_m || !_mf;

                                          return PanelCircleButton(
                                            verse: const Verse(
                                              id: 'phid_reset',
                                              translate: true,
                                            ),
                                            icon: Iconz.reload,
                                            size: _size,
                                            isSelected: false,
                                            isDisabled: !_isWrong,
                                            onTap: onResetMatrix,
                                          );
                                        });
                                  }
                                ),

                                /// SPACING
                                _spacing,

                                /// SLIDE IS ANIMATED
                                PanelCircleButton(
                                  verse: Verse(
                                    id: _hasAnimation ? 'phid_animated' : 'phid_still',
                                    translate: true,
                                  ),
                                  icon: _hasAnimation ? Iconz.flyerScale : Iconz.flyer,
                                  size: _size,
                                  isSelected: false,
                                  onTap: onTriggerSlideIsAnimated,
                                ),

                                /// SPACING
                                _spacing,

                                /// PLAY
                                PanelCircleButton(
                                  verse: Verse(
                                    id: _isPlayingAnimation == true ? 'phid_pause' : 'phid_play',
                                    translate: true,
                                  ),
                                  icon: _isPlayingAnimation == true ? Iconz.pause : Iconz.play,
                                  size: _size,
                                  isSelected: _isPlayingAnimation,
                                  isDisabled: _hasAnimation == false,
                                  onTap: onPlayTap,
                                ),

                                /// SPACING
                                _spacing,

                                /// TO
                                if (_hasAnimation == true)
                                  AnimationFrameButton(
                                    flyerBoxWidth: flyerBoxWidth,
                                    verse: const Verse(
                                      id: 'phid_to',
                                      translate: true,
                                    ),
                                    isSelected: _isPlayingAnimation == false && _isDoingMatrixFrom == false,
                                    draftSlideNotifier: draftSlideNotifier,
                                    matrixNotifier: matrixNotifier,
                                    onTap: onToTap,
                                  ),

                                const Expander(),

                              ],
                            );
                          }
                          );
                    }
                    );
              }
              ),
        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
