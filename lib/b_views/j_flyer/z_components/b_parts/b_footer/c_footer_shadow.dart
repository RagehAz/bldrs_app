import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FooterShadow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterShadow({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _footerHeight = FooterBox.collapsedHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );
    // --------------------
    return Align(
      key: const ValueKey<String>('FooterShadow'),
      alignment: Alignment.bottomCenter,
      child: WebsafeSvg.asset(
        Iconz.footerShadow,
        fit: BoxFit.fitWidth,
        width: flyerBoxWidth,
        height: _footerHeight,
        alignment: Alignment.bottomCenter,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
