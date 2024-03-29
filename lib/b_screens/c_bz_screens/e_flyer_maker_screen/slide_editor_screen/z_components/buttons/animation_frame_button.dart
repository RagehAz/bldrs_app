import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/helpers/space/trinity.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/panel_circle_button.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AnimationFrameButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AnimationFrameButton({
    required this.onTap,
    required this.isSelected,
    required this.flyerBoxWidth,
    required this.matrixNotifier,
    required this.draftSlideNotifier,
    required this.verse,
    super.key,
  });
  // --------------------------------------------------------------------------
  final Function onTap;
  final bool isSelected;
  final double flyerBoxWidth;
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final Verse verse;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonHeight = FlyerDim.footerButtonSize(
      flyerBoxWidth: flyerBoxWidth,
    )-2;

    final double _microFlyerHeight = _buttonHeight * 0.65;

    final double _microFlyerWidth = FlyerDim.flyerWidthByFlyerHeight(
        flyerBoxHeight: _microFlyerHeight,
    );

    final BorderRadius _corners = FlyerDim.headerSlateCorners(
      flyerBoxWidth: flyerBoxWidth,
    );

    return Stack(
      children: <Widget>[

        /// WHITE BACKGROUND FOR BLACK SLIDE
        Container(
          width: _buttonHeight,
          height: _buttonHeight,
          decoration: BoxDecoration(
            color: PanelCircleButton.getBackColor(isDisabled: false),
            borderRadius: _corners,
          ),
        ),

        /// BUTTON
        TapLayer(
          width: _buttonHeight,
          height: _buttonHeight,
          corners: _corners,
          boxColor: PanelCircleButton.getFrontColor(isSelected: isSelected),
          borderColor: PanelCircleButton.getBorderColor(isSelected: isSelected),
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

                            /// BACKGROUND PIC
                            if (draftSlide?.backPic != null)
                              SuperImage(
                                loading: false,
                                pic: draftSlide!.backPic!,
                                key: const ValueKey<String>('SuperImage_slide_back'),
                                width: _microFlyerWidth,
                                height: _microFlyerHeight,
                              ),

                            /// BACKGROUND COLOR
                            if (draftSlide?.backColor != null)
                            Container(
                              width: _microFlyerWidth,
                              height: _microFlyerHeight,
                              color: draftSlide!.backColor,
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


                                    child: SuperImage(
                                      loading: false,
                                      pic: draftSlide!.medPic!,
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
        ),

      ],
    );

  }
  // --------------------------------------------------------------------------
}
