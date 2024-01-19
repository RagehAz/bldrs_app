import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:basics/components/layers/blur_layer.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';

class ColorPanelButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ColorPanelButton({
    required this.size,
    required this.isSelected,
    required this.onTap,
    this.color,
    this.icon,
    super.key
  });
  // --------------------
  final double size;
  final bool isSelected;
  final Color? color;
  final dynamic icon;
  final Function onTap;
  // --------------------------------------------------------------------------
  static double getSize({
    required bool isSelected,
    required double size,
  }){
    return isSelected == true ? size * 0.8 : size;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _size = isSelected == true ? size * 0.8 : size;
    // --------------------
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: BldrsBox(
        height: _size,
        width: _size,
        corners: _size / 2,
        color: color,
        borderColor: isSelected == true ? Colorz.yellow255 : Colorz.white125,
        onTap: onTap,
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class BlurPanelButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BlurPanelButton({
    required this.size,
    required this.isSelected,
    required this.draftSlide,
    required this.onTap,
    super.key
  });
  // --------------------
  final double size;
  final bool isSelected;
  final DraftSlide? draftSlide;
  final Function onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _size = ColorPanelButton.getSize(isSelected: isSelected, size: size);
    // --------------------
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: BlurLayer(
        width: _size,
        height: _size,
        borders: BorderRadius.circular(_size / 2),
        blurIsOn: true,
        blur: 3,
        borderColor: isSelected == true ? Colorz.yellow255 : Colorz.black255,
        child: BldrsBox(
          height: _size,
          width: _size,
          corners: _size / 2,
          icon: draftSlide?.smallPic?.bytes ??
                draftSlide?.medPic?.bytes ??
                draftSlide?.bigPic?.bytes,
          onTap: onTap,
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class ColorPickerPanelButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ColorPickerPanelButton({
    required this.slideBackColor,
    required this.size,
    required this.isPickingColor,
    required this.onTap,
    required this.loadingColorPicker,
    super.key
  });
  // --------------------
  final ValueNotifier<Color?> slideBackColor;
  final double size;
  final bool isPickingColor;
  final Function onTap;
  final ValueNotifier<bool> loadingColorPicker;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _size = ColorPanelButton.getSize(isSelected: isPickingColor, size: size);
    // --------------------
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: slideBackColor,
        builder: (_, Color? color, Widget? child) {

          return Stack(
            children: <Widget>[

              /// LIVE COLOR
              if (isPickingColor == true)
                Container(
                  width: _size,
                  height: _size,
                  decoration: BoxDecoration(
                    borderRadius: Borderers.cornerAll(_size / 2),
                    color: color,
                  ),
                ),

              /// COLOR ROSE
              if (isPickingColor == false)
                BldrsBox(
                  height: _size,
                  width: _size,
                  corners: _size / 2,
                  icon: Iconz.colorCircle,
                ),

              /// ICON
              child!,

            ],
          );
          },

        child: ValueListenableBuilder(
          valueListenable: loadingColorPicker,
          builder: (_, bool loading, Widget? child) {

            return BldrsBox(
              height: _size,
              width: _size,
              corners: _size / 2,
              icon: Icons.colorize,
              loading: loading,
              iconColor: Colorz.black255,
              iconSizeFactor: 0.65,
              borderColor: isPickingColor == true ? Colorz.yellow255 : Colorz.white125,
              onTap: onTap,
            );
          }
        ),
      ),
    );
  // --------------------
  }
  // --------------------------------------------------------------------------
}
