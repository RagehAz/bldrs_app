// ignore_for_file: unused_element
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class _RedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _RedDot({
    this.isNano = false,
    this.count,
    this.verse,
    this.color,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool isNano;
  final int? count;
  final Verse? verse;
  final Color? color;
  /// --------------------------------------------------------------------------
  static const double defaultSize = 18;
  static const double maxWidth = 60;
  // --------------------
  static double getSize({
    required bool isNano
  }){
    final double _factor = isNano == true ? 0.7 : 1.0;
    final double _height = defaultSize * _factor;
    return _height;
  }
  // --------------------
  String? _concludeCount(int? count) {
    String? _count;

    if (count == null || count == 0) {
      _count = null;
    }

    else if (count > 0 && count <= 99) {
      _count = '$count';
    }

    else {
      _count = '99+';
    }

    return _count;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? _count = _concludeCount(count);
    final double factor = isNano == true ? 0.7 : 1.0;
    final double _size = getSize(isNano: isNano);
    // --------------------
    return Container(
      // width: _size * 0.3,
      height: _size,
      // margin: const EdgeInsets.all(buttonWidth * 0.1),
      constraints: BoxConstraints(
        minWidth: _size,
        maxWidth: _count != null || verse != null ? maxWidth : _size,
      ),
      decoration: BoxDecoration(
        borderRadius: Borderers.cornerAll(_size * 0.5),
        color: color ?? Colorz.red255,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 2 * factor),
      // alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[

          BldrsText(
            verse: verse ?? Verse(
              id: _count,
              translate: false,
            ),
            size: 0,
            scaleFactor: 1.4 * factor,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            // labelColor: Colorz.white50,
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class RedDotBadge extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RedDotBadge({
    required this.child,
    required this.redDotIsOn,
    required this.approxChildWidth,
    this.count,
    this.shrinkChild = false,
    this.isNano = false,
    this.verse,
    this.color,
    this.height,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool redDotIsOn;
  final int? count;
  final Widget child;
  final bool shrinkChild;
  final bool isNano;
  final double approxChildWidth;
  final Verse? verse;
  final Color? color;
  final double? height;
  /// --------------------------------------------------------------------------
  static double getShrinkageScale({
    required double childWidth,
    required bool isNano,
  }){
    final double _viewWidth = childWidth - (_RedDot.getSize(isNano: isNano) * 0.2);
    return _viewWidth / childWidth;
  }
  // --------------------
  static double getShrinkageDX({
    required double childWidth,
    required bool isNano,
  }){

    final double ratio = getShrinkageScale(
      childWidth: childWidth,
      isNano: isNano,
    );
    final double _dx = childWidth - (ratio * childWidth);

    return _dx;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          if (shrinkChild == true)
            Transform.scale(
              scale: getShrinkageScale(
                isNano: isNano,
                childWidth: approxChildWidth,
              ),
              alignment: BldrsAligners.superBottomAlignment(context),
              child: child,
            ),

          if (shrinkChild == false)
            child,

          if (redDotIsOn == true)
            SuperPositioned(
              enAlignment: Alignment.topRight,
              // horizontalOffset: -(NoteRedDot.size * 0.5),
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              child: _RedDot(
                count: count,
                isNano: isNano,
                verse: verse,
                color: color,
              ),
            ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
