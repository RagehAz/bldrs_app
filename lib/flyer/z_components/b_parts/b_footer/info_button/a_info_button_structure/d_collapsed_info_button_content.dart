import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/collapsed_info_button_parts/discount_price_tag.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/collapsed_info_button_parts/info_graphic.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/collapsed_info_button_parts/installment_price_tag.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/collapsed_info_button_parts/normal_price_tag.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:flutter/material.dart';

class CollapsedInfoButtonContent extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedInfoButtonContent({
    required this.infoButtonType,
    required this.flyerBoxWidth,
    required this.buttonIsExpanded,
    required this.tinyMode,
    super.key
  });
  /// --------------------------------------------------------------------------
  final InfoButtonType infoButtonType;
  final double flyerBoxWidth;
  final ValueNotifier<bool?> buttonIsExpanded;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = FlyerDim.infoButtonWidth(
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
      infoButtonType: infoButtonType,
      isExpanded: false,
    );
    // --------------------
    final double _height = FlyerDim.infoButtonHeight(
      tinyMode: tinyMode,
      flyerBoxWidth: flyerBoxWidth,
      isExpanded: false,
    );

    // --------------------
    final double _paddingValue = _height * 0.1;
    // --------------------
    if (infoButtonType == InfoButtonType.info){
      return InfoGraphic(
        flyerBoxWidth: flyerBoxWidth,
        buttonIsExpanded: buttonIsExpanded,
        tinyMode: tinyMode,
      );
    }

    else if (infoButtonType == InfoButtonType.price){
      return NormalPriceTag(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
        width: _width,
        height: _height,
        paddingValue: _paddingValue,
      );
    }

    else if (infoButtonType == InfoButtonType.discount){
      return DiscountPriceTag(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
        width: _width,
        height: _height,
        paddingValue: _paddingValue,
        buttonIsExpanded: buttonIsExpanded,
      );
    }

    else if (infoButtonType == InfoButtonType.installments){
      return InstallmentsPriceTag(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
        width: _width,
        height: _height,
        paddingValue: _paddingValue,
        buttonIsExpanded: buttonIsExpanded,
      );
    }

    else {
      return const SizedBox();
    }
    // --------------------
  }
}
