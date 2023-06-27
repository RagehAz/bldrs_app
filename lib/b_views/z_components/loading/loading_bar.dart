import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingBar({
    required this.progress,
    super.key
  });
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
      alignment: BldrsAligners.superCenterAlignment(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 4000),
        width: _screenWidth * progress / 100,
        color: Colorz.yellow255,
      ),
    );
  }
/// --------------------------------------------------------------------------
}
