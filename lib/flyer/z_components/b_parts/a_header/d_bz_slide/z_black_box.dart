import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:flutter/material.dart';

class BlackBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BlackBox({
    required this.width,
    required this.child,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final Widget child;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const Color bzPageBGColor = Colorz.black80;
    final double _bzPageDividers = width * 0.005;
    final double _margins = width * 0.05;
    // --------------------
    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(),
      child: Padding(
        padding: EdgeInsets.only(top: _bzPageDividers),
        child: Container(
          width: width,
          color: bzPageBGColor,
          padding: EdgeInsets.only(left: _margins, right: _margins, top: _margins * 0.5, bottom: _margins * 0.5),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
