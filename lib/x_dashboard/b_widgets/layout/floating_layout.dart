import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';

class FloatingLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FloatingLayout({
    @required this.child,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Scale.superScreenWidth(context),
      height: DashBoardLayout.clearScreenHeight(context),
      child: child,
    );
  }
}
