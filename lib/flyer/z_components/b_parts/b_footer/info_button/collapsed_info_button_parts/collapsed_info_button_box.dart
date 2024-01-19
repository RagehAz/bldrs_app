import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:flutter/material.dart';

class CollapsedInfoButtonBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedInfoButtonBox({
    required this.flyerBoxWidth,
    required this.horizontalListViewChildren,
    required this.infoButtonType,
    required this.tinyMode,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final List<Widget> horizontalListViewChildren;
  final InfoButtonType infoButtonType;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      key: const ValueKey<String>('normal_price_tag'),
      width: FlyerDim.infoButtonWidth(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode,
        isExpanded: false,
        infoButtonType: infoButtonType,
      ),
      height: FlyerDim.infoButtonHeight(
        flyerBoxWidth: flyerBoxWidth,
        isExpanded: false,
        tinyMode: tinyMode,
      ),
      // alignment: infoButtonType == InfoButtonType.info ? Alignment.center : Aligners.superCenterAlignment(context),
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: horizontalListViewChildren,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
