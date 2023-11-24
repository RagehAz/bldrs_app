import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';

class SlideColorPanel extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SlideColorPanel({
    required this.flyerBoxWidth,
    required this.draftSlideNotifier,
    // required this.pickedColor,
    required this.onSetWhiteBack,
    required this.onSetBlackBack,
    required this.onColorPickerTap,
    required this.onSetBlurBack,
    required this.isPickingBackColor,
    required this.showColorPanel,
    required this.slideBackColor,
    super.key
  });
  // --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  // final ValueNotifier<Color?> pickedColor;
  final Function onSetWhiteBack;
  final Function onSetBlackBack;
  final Function onColorPickerTap;
  final Function onSetBlurBack;
  final ValueNotifier<bool> isPickingBackColor;
  final ValueNotifier<bool> showColorPanel;
  final ValueNotifier<Color?> slideBackColor;
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
                      children: <Widget>[
                        const Expander(),

                        /// BLUR
                        BlurLayer(
                          width: _size,
                          height: _size,
                          borders: BorderRadius.circular(_size / 2),
                          blurIsOn: true,
                          blur: 3,
                          borderColor: _isBlur == true ? Colorz.yellow255 : Colorz.black255,
                          child: BldrsBox(
                            height: _size,
                            width: _size,
                            corners: _size / 2,
                            icon: _draftSlide?.smallPic?.bytes ??
                                  _draftSlide?.medPic?.bytes ??
                                  _draftSlide?.bigPic?.bytes,
                            // color: Colorz.white255,
                            // borderColor: _isWhite == true ? Colorz.yellow255 : Colorz.black255,
                            onTap: onSetBlurBack,
                          ),
                        ),

                        /// SPACING
                        _spacing,

                        /// WHITE
                        BldrsBox(
                          height: _size,
                          width: _size,
                          corners: _size / 2,
                          color: Colorz.white255,
                          borderColor: _isWhite == true ? Colorz.yellow255 : Colorz.black255,
                          onTap: onSetWhiteBack,
                        ),

                        /// SPACING
                        _spacing,

                        /// BLACK
                        BldrsBox(
                          height: _size,
                          width: _size,
                          corners: _size / 2,
                          color: Colorz.black255,
                          borderColor: _isBlack == true ? Colorz.yellow255 : Colorz.white125,
                          onTap: onSetBlackBack,
                        ),

                        /// SPACING
                        _spacing,

                        /// COLOR
                        ValueListenableBuilder(
                          valueListenable: slideBackColor,
                          builder: (_, Color? color, Widget? child) {

                            final bool _isBlackx = color == Colorz.black255;
                            final bool _isWhitex = color == Colorz.white255;

                            final bool showColorRose = _isBlackx || _isWhitex || _isBlur;

                            return Stack(
                              children: [

                                /// LIVE COLOR
                                if (showColorRose == false)
                                Container(
                                  width: _size,
                                  height: _size,
                                  decoration: BoxDecoration(
                                    borderRadius: Borderers.cornerAll(_size / 2),
                                    color: color,
                                  ),
                                ),

                                /// COLOR ROSE
                                if (showColorRose == true)
                                BldrsBox(
                                  height: _size,
                                  width: _size,
                                  corners: _size / 2,
                                  icon: Iconz.colorCircle,
                                  borderColor: _isColor == true ? Colorz.yellow255 : Colorz.white125,
                                  onTap: onColorPickerTap,
                                ),

                                /// ICON
                                // if (showColorRose == false)
                                BldrsBox(
                                  height: _size,
                                  width: _size,
                                  corners: _size / 2,
                                  icon: Icons.colorize,
                                  iconColor: Colorz.black255,
                                  iconSizeFactor: 0.65,
                                  borderColor: _isColor == true ? Colorz.yellow255 : Colorz.white125,
                                  onTap: onColorPickerTap,
                                ),

                              ],
                            );
                          }
                        ),

                        /// SPACING
                        _spacing,

                        const Expander(),

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
