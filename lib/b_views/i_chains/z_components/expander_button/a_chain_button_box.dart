import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';

import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class ChainButtonBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainButtonBox({
    required this.boxWidth,
    required this.child,
    this.isDisabled = false,
    this.inverseAlignment = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool isDisabled;
  final double boxWidth;
  final Widget child;
  final bool inverseAlignment;
  /// --------------------------------------------------------------------------
  static double getSonWidth({
    required double parentWidth,
    required int level,
  }){
    final int _level = level ?? 0;
    const double _padding = 2 * Ratioz.appBarMargin;
    final double _levelOffset = _level * _level * 0.01;
    final double _sonWidth = parentWidth - _padding - _levelOffset;

    return _sonWidth;
  }
  // -----------------------------------------------------------------------------
  static double sonHeight(){
    return 45;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: isDisabled == true ? 0.3 : 1,
      child: Container(
        width: boxWidth,
        alignment: inverseAlignment == true ? BldrsAligners.superInverseCenterAlignment(context) : null,
        // margin: const EdgeInsets.all(Ratioz.appBarPadding),
        child: child,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
