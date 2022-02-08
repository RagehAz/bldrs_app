import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:flutter/material.dart';

class CollapsedInfoButtonBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedInfoButtonBox({
    @required this.flyerBoxWidth,
    @required this.horizontalListViewChildren,
    @required this.infoButtonType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final List<Widget> horizontalListViewChildren;
  final InfoButtonType infoButtonType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ------------------------------------------------------------------
    final double _width = InfoButtonStarter.collapsedWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );
    final double _height = InfoButtonStarter.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
// ------------------------------------------------------------------
    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);
    final double _paddingsValue = _height * 0.25;
    final EdgeInsets _paddings = EdgeInsets.symmetric(horizontal: _paddingsValue);
// ------------------------------------------------------------------
    return Container(
      key: const ValueKey<String>('normal_price_tag'),
      width: _width,
      height: _height,
      // alignment: infoButtonType == InfoButtonType.info ? Alignment.center : Aligners.superCenterAlignment(context),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: horizontalListViewChildren,
      ),
    );
  }
}
