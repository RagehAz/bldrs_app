import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/collapsed_info_button_parts/discount_price_tag.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/collapsed_info_button_parts/info_graphic.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/collapsed_info_button_parts/installment_price_tag.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/collapsed_info_button_parts/normal_price_tag.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:flutter/material.dart';

class CollapsedInfoButtonContent extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedInfoButtonContent({
    @required this.infoButtonType,
    @required this.flyerBoxWidth,
    @required this.buttonIsExpanded,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final InfoButtonType infoButtonType;
  final double flyerBoxWidth;
  final ValueNotifier<bool> buttonIsExpanded;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (infoButtonType == InfoButtonType.info){
      return InfoGraphic(
        flyerBoxWidth: flyerBoxWidth,
        buttonIsExpanded: buttonIsExpanded,
      );
    }

    else if (infoButtonType == InfoButtonType.price){
      return NormalPriceTag(
          flyerBoxWidth: flyerBoxWidth
      );
    }

    else if (infoButtonType == InfoButtonType.discount){
      return DiscountPriceTag(
          flyerBoxWidth: flyerBoxWidth
      );
    }

    else if (infoButtonType == InfoButtonType.installments){
      return InstallmentsPriceTag(
        flyerBoxWidth: flyerBoxWidth,
      );
    }

    else {
      return const SizedBox();
    }

  }
}
