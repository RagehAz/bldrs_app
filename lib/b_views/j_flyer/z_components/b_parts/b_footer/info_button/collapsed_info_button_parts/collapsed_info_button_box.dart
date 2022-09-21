import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:flutter/material.dart';

class CollapsedInfoButtonBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedInfoButtonBox({
    @required this.flyerBoxWidth,
    @required this.horizontalListViewChildren,
    @required this.infoButtonType,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final List<Widget> horizontalListViewChildren;
  final InfoButtonType infoButtonType;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = tinyMode ?
    InfoButtonStarter.tinyWidth(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    )
        :
    InfoButtonStarter.collapsedWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );
    // --------------------
    final double _height = tinyMode ?
    InfoButtonStarter.tinyHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    )
        :
    InfoButtonStarter.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    /*
    // final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
    // final double _paddingsValue = _height * 0.25;
    // final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: _paddingsValue);
     */
    // --------------------
    return Container(
      key: const ValueKey<String>('normal_price_tag'),
      width: _width,
      height: _height,
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
