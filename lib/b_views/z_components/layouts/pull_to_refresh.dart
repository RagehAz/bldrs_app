import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PullToRefresh extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PullToRefresh({
    @required this.child,
    @required this.onRefresh,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onRefresh;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        onRefresh: onRefresh,
        color: Colorz.black230,
        backgroundColor: Colorz.yellow255,
        displacement: 50,//Ratioz.appBarMargin,
        strokeWidth: 4,
        edgeOffset: 50,
        child: child,
    );

  }
/// --------------------------------------------------------------------------
}
