import 'package:bldrs/b_views/z_components/chains_drawer/parts/c_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainBox({
    @required this.boxWidth,
    @required this.child,
    this.isDisabled = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isDisabled;
  final double boxWidth;
  final Widget child;
  /// --------------------------------------------------------------------------
  static double getSonWidth({
    @required double parentWidth,
    @required int parentLevel,
  }){
    const double _padding = 2 * Ratioz.appBarMargin;
    final int _levelOffset = parentLevel * 30;
    final double _sonWidth = parentWidth - _padding - _levelOffset;

    return _sonWidth;
  }
// -----------------------------------------------------------------------------
  static double sonHeight(){
    return 60;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Opacity(
      opacity: isDisabled == true ? 0.3 : 1,
      child: Container(
        width: boxWidth,
        alignment: superInverseCenterAlignment(context),
        // margin: const EdgeInsets.all(Ratioz.appBarPadding),
        child: child,
      ),
    );

  }
}
