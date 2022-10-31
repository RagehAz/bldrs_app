import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class StopWatchButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StopWatchButton({
    @required this.icon,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxWidth = BldrsAppBar.width(context);
    final double _buttonSize = (_boxWidth * 0.5) / 4;

    return DreamBox(
      height: _buttonSize,
      width: _buttonSize,
      icon: icon,
      iconSizeFactor: 0.5,
      verseShadow: false,
      onTap: onTap,
    );

  }
  /// --------------------------------------------------------------------------
}
