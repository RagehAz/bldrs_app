import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ViewPage({
    required this.title,
    this.child,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Widget? child;
  final String title;
  // --------------------
  static const double navBarHeight = 50;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getViewHeight(){
    final BuildContext context = getMainContext();
    final double _screenHeight = Scale.screenHeight(context);
    return _screenHeight; // - (navBarHeight * 2);
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.screenWidth(context),
      height: getViewHeight(),
      color: Colorz.black255,
      child: child,
    );

  }
// -----------------------------------------------------------------------------
}
