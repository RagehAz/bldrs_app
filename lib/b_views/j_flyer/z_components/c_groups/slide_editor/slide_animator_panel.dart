import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:basics/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
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
                    FromToButton(
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

                    /// PLAY
                    PlayButton(
                      isPlaying: _isPlayingAnimation,
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
                    FromToButton(
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

class PlayButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PlayButton({
    required this.size,
    required this.onTap,
    required this.isPlaying,
    required this.isSelected,
    super.key
  });
  /// ------------------------
  final double size;
  final Function onTap;
  final bool isPlaying;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        BldrsBox(
          width: size * 0.7,
          height: size * 0.7,
          corners: size * 0.5,
          color: isSelected == true ? Colorz.black150 : Colorz.black80,
          iconColor: isSelected == true ? Colorz.yellow255 : Colorz.white255,
          borderColor: isSelected == true ? Colorz.yellow255 : null,
          icon: isPlaying == true ? Iconz.pause : Iconz.play,
          iconSizeFactor: 0.5,
          splashColor: Colorz.yellow255,
          onTap: onTap,
        ),

        /// VERSE
        BldrsText(
          verse: Verse(
            id: isPlaying == true ? 'phid_pause' : 'phid_play',
            translate: true,
          ),
          scaleFactor: size * 0.01,
          weight: VerseWeight.thin,
        ),

        /// SPACING
        Spacing(
          size: size * 0.05,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class FromToButton extends StatelessWidget {

  const FromToButton({
    required this.onTap,
    required this.isSelected,
    required this.flyerBoxWidth,
    required this.matrixNotifier,
    required this.draftSlideNotifier,
    required this.verse,
    super.key,
  });

  final Function onTap;
  final bool isSelected;
  final double flyerBoxWidth;
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final Verse verse;

  @override
  Widget build(BuildContext context) {

    final double _buttonHeight = FlyerDim.footerButtonSize(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _microFlyerHeight = _buttonHeight * 0.65;

    final double _microFlyerWidth = FlyerDim.flyerWidthByFlyerHeight(
        flyerBoxHeight: _microFlyerHeight,
    );

    return TapLayer(
      width: _buttonHeight,
      height: _buttonHeight,
      corners: FlyerDim.headerSlateCorners(flyerBoxWidth: flyerBoxWidth),
      boxColor: isSelected == true ? Colorz.black150 : Colorz.black80,
      borderColor: isSelected == true ? Colorz.yellow255 : null,
      splashColor: Colorz.yellow255,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// MICRO SLIDE
          SizedBox(
            width: _microFlyerWidth,
            height: _microFlyerHeight,
            child: ClipRRect(
              borderRadius: FlyerDim.flyerCorners(_microFlyerWidth),
              child: ValueListenableBuilder(
                  valueListenable: draftSlideNotifier,
                   builder: (_, DraftSlide? draftSlide, Widget? child){

                    return Stack(
                      children: <Widget>[

                        /// BACKGROUND
                        Image.memory(
                          draftSlide!.backPic!.bytes!,
                          key: const ValueKey<String>('SuperImage_slide_back'),
                          width: _microFlyerWidth,
                          height: _microFlyerHeight,
                        ),

                        /// FRONT PIC
                        ValueListenableBuilder(
                            valueListenable: draftSlideNotifier,
                            builder: (_, DraftSlide? draftSlide, Widget? child){

                              return ValueListenableBuilder(
                                valueListenable: matrixNotifier,
                                builder: (_, Matrix4? matrix, Widget? child){

                                  final Matrix4 _mat = Trinity.renderSlideMatrix(
                                      matrix: matrix,
                                      flyerBoxWidth: _microFlyerWidth,
                                      flyerBoxHeight: _microFlyerHeight
                                  )!;

                                  return Transform(
                                    transform: _mat,
                                    child: child,
                                  );

                                  },
                                child: Image.memory(
                                  draftSlide!.medPic!.bytes!,
                                  key: const ValueKey<String>('SuperImage_slide_draft'),
                                  width: _microFlyerWidth,
                                  height: _microFlyerHeight,
                                ),
                              );
                            }
                            ),

                      ],
                    );
                  }
                  ),
            ),
          ),

          /// VERSE
          BldrsText(
            verse: verse,
            scaleFactor: _buttonHeight * 0.01,
            weight: VerseWeight.thin,
          ),

        ],
      ),
    );

  }
}
