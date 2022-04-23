import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class StaticHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticHeader({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Opacity(
      key: const ValueKey<String>('StaticHeader'),
      opacity: 0.5,
      child: HeaderBox(
        tinyMode: false,
        onHeaderTap: null,
        headerBorders: FlyerBox.superHeaderCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          bzPageIsOn: false,
        ),
        flyerBoxWidth: flyerBoxWidth,
        headerColor: Colorz.black255,
        headerHeightTween: FlyerBox.headerBoxHeight(flyerBoxWidth: flyerBoxWidth),
        children: const <Widget>[],
      ),
    );
  }

}
