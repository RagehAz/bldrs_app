import 'package:bldrs/b_views/widgets/general/images/super_image.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class InfoGraphic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoGraphic({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ------------------------------------------------------------------
    final double _size = InfoButton.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
// ------------------------------------------------------------------
    return Container(
      key: const ValueKey<String>('InfoGraphic'),
      // width: _size,
      // height: _size,
      alignment: Alignment.topLeft,
      child: SuperImage(
        pic: Iconz.info,
        width: _size,
        height: _size,
        scale: 0.4,
      ),
    );

  }
}
