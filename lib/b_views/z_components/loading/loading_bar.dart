import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingBar({
    @required this.progress,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double progress;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);

    return Container(
      width: _screenWidth,
      height: 3,
      color: Colorz.white80,
      alignment: Aligners.superCenterAlignment(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 4000),
        width: _screenWidth * progress / 100,
        color: Colorz.yellow255,
      ),
    );
  }
/// --------------------------------------------------------------------------
}
