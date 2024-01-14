import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:flutter/material.dart';

class LineBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LineBubble({
    required this.child,
    this.width,
    this.alignment,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final double? width;
  final Alignment? alignment;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(),
      child: Container(
        width: width ?? BldrsAppBar.width(),
        alignment: alignment ?? Alignment.center,
        decoration: const BoxDecoration(
          color: Colorz.white20,
          borderRadius: Borderers.constantCornersAll10,
        ),
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        margin: const EdgeInsets.only(bottom: 5),
        child: child,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
