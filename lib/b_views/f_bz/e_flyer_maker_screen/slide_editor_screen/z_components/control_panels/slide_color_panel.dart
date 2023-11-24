import 'package:basics/bldrs_theme/classes/colorz.dart';
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
    required this.onSetWhiteBack,
    required this.onSetBlackBack,
    required this.onSetColorBack,
    required this.onSetBlurBack,
    super.key
  });
  // --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final Function onSetWhiteBack;
  final Function onSetBlackBack;
  final Function onSetColorBack;
  final Function onSetBlurBack;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _size = FlyerDim.infoButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
      isExpanded: false,
      tinyMode: false,
    );

    final Widget _spacing = Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,);

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
          valueListenable: draftSlideNotifier,
          builder: (_, DraftSlide? _draftSlide, Widget? child){

            final bool _isBlur = _draftSlide?.backPic != null;
            final Color? _backColor = _draftSlide?.backColor;
            final bool _isBlack = _backColor == Colorz.black255;
            final bool _isWhite = _backColor == Colorz.white255;
            final bool _isColor = _isBlack == false && _isWhite == false && _isBlur == false;

            return Row(
              children: <Widget>[

                const Expander(),

                /// BLUR
                BlurLayer(
                  width: _size,
                  height: _size,
                  borders: BorderRadius.circular(_size / 2),
                  blurIsOn: true,
                  blur: 1,
                  borderColor: _isBlur == true ? Colorz.yellow255 : Colorz.black255,
                  child: BldrsBox(
                    height: _size,
                    width: _size,
                    corners: _size / 2,
                    icon: _draftSlide?.smallPic?.bytes,
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
                BldrsBox(
                  height: _size,
                  width: _size,
                  corners: _size / 2,
                  icon: Icons.colorize,
                  iconSizeFactor: 0.65,
                  color: _backColor,
                  borderColor: _isColor == true ? Colorz.yellow255 : Colorz.white125,
                  onTap: onSetColorBack,
                ),

                /// SPACING
                _spacing,

                const Expander(),

              ],
            );
          }
        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
