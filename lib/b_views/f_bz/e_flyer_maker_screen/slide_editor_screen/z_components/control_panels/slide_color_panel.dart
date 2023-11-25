import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/color_panel_buttons.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class SlideColorPanel extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SlideColorPanel({
    required this.flyerBoxWidth,
    required this.draftSlideNotifier,
    required this.onWhiteBackTap,
    required this.onBlackBackTap,
    required this.onColorPickerTap,
    required this.onBlurBackTap,
    required this.isPickingBackColor,
    required this.showColorPanel,
    required this.slideBackColor,
    required this.loadingColorPicker,
    super.key
  });
  // --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final Function onWhiteBackTap;
  final Function onBlackBackTap;
  final Function onColorPickerTap;
  final Function onBlurBackTap;
  final ValueNotifier<bool> isPickingBackColor;
  final ValueNotifier<bool> showColorPanel;
  final ValueNotifier<Color?> slideBackColor;
  final ValueNotifier<bool> loadingColorPicker;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _size = FlyerDim.infoButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
      isExpanded: false,
      tinyMode: false,
    );

    final Widget _spacing = Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,);

    return ValueListenableBuilder(
      valueListenable: showColorPanel,
      builder: (_, bool showPanel, Widget? child) {

        /// NO ANIMATION
        if (showPanel == true){
          return child!;
        }

        /// HAS ANIMATION
        else {
          return const SizedBox();
        }

        },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: flyerBoxWidth,
          height: FlyerDim.footerBoxHeight(
            flyerBoxWidth: flyerBoxWidth,
            infoButtonExpanded: false,
            showTopButton: false,
          ),
          child: ValueListenableBuilder(
              valueListenable: draftSlideNotifier,
              builder: (_, DraftSlide? _draftSlide, Widget? child){
                return ValueListenableBuilder(
                    valueListenable: isPickingBackColor,
                    builder: (_, bool isPicking, Widget? child) {

                      final bool _isColor = isPicking;
                      final Color? _slideBackColor = _draftSlide?.backColor;
                      final bool _isBlur = _isColor == false && _draftSlide?.backPic != null;
                      final bool _isBlack = _isColor == false && _slideBackColor == Colorz.black255;
                      final bool _isWhite = _isColor == false && _slideBackColor == Colorz.white255;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          /// BLUR
                          BlurPanelButton(
                            isSelected: _isBlur,
                            size: _size,
                            draftSlide: _draftSlide,
                            onTap: onBlurBackTap,
                          ),

                          /// SPACING
                          _spacing,

                          /// WHITE
                          ColorPanelButton(
                            size: _size,
                            isSelected: _isWhite,
                            color: Colorz.white255,
                            onTap: onWhiteBackTap,
                          ),

                          /// SPACING
                        _spacing,

                        /// BLACK
                        ColorPanelButton(
                          size: _size,
                          isSelected: _isBlack,
                          color: Colorz.black255,
                          onTap: onBlackBackTap,
                        ),

                        /// SPACING
                        _spacing,

                        /// COLOR
                        ColorPickerPanelButton(
                          size: _size,
                          isPickingColor: isPicking,
                          slideBackColor: slideBackColor,
                          onTap: onColorPickerTap,
                          loadingColorPicker: loadingColorPicker,
                        ),

                      ],
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
