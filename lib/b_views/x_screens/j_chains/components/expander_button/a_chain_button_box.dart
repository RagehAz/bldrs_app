import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainButtonBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainButtonBox({
    @required this.boxWidth,
    @required this.child,
    this.isDisabled = false,
    this.alignment,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isDisabled;
  final double boxWidth;
  final Widget child;
  final Alignment alignment;
  /// --------------------------------------------------------------------------
  static double getSonWidth({
    @required double parentWidth,
    @required int parentLevel,
  }){
    const double _padding = 2 * Ratioz.appBarPadding;
    final double _levelOffset = parentLevel * parentWidth * 0.01;
    final double _sonWidth = parentWidth - _padding - _levelOffset;

    return _sonWidth;
  }
// -----------------------------------------------------------------------------
  static double sonHeight(){
    return 50;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: isDisabled == true ? 0.3 : 1,
      child: Container(
        width: boxWidth,
        alignment: alignment ?? Aligners.superInverseCenterAlignment(context),
        // margin: const EdgeInsets.all(Ratioz.appBarPadding),
        child: child,
      ),
    );

  }
}