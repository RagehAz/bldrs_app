import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
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

                    /// ---> SPACING
                    FooterButtonSpacer(flyerBoxWidth: flyerBoxWidth),

                    /// FROM
                    AnimatorButton(
                      icon: 'From',
                      size: _size,
                      isSelected: _isPlayingAnimation == false && _isDoingMatrixFrom == true,
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

                    const Expander(),

                    /// PLAY
                    AnimatorButton(
                      icon: _isPlayingAnimation == true ? Iconz.pause : Iconz.play,
                      size: _size * 0.7,
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

                    const Expander(),

                    /// TO
                    AnimatorButton(
                      icon: 'To',
                      size: _size,
                      isSelected: _isPlayingAnimation == false && _isDoingMatrixFrom == false,
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

                    /// ---> SPACING
                    FooterButtonSpacer(flyerBoxWidth: flyerBoxWidth),

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

class AnimatorButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimatorButton({
    required this.size,
    required this.icon,
    required this.onTap,
    required this.isSelected,
    super.key
  });
  /// ------------------------
  final double size;
  final dynamic icon;
  final Function onTap;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
      width: size,
      height: size,
      corners: size * 0.5,
      color: isSelected == true ? Colorz.black150 : Colorz.black80,
      iconColor: isSelected == true ? Colorz.yellow255 : Colorz.white255,
      borderColor: isSelected == true ? Colorz.yellow255 : null,
      icon: icon,
      iconSizeFactor: 0.5,
      splashColor: Colorz.yellow255,
      onTap: onTap,
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
