import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class NoteRedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteRedDot({
    this.isNano = false,
    this.count, Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isNano;
  final int count;
  /// --------------------------------------------------------------------------
  static const double defaultSize = 18;
  static const double maxWidth = 60;
// -----------------------------
  static double getSize({
    @required bool isNano
  }){
    final double _factor = isNano == true ? 0.7 : 1.0;
    final double _height = defaultSize * _factor;
    return _height;
  }
// -----------------------------
  String _concludeCount(int count) {
    String _count;

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

    final String _count = _concludeCount(count);
    final double factor = isNano == true ? 0.7 : 1.0;
    final double _size = getSize(isNano: isNano);

    return Container(
      // width: _buttonWidth * 0.3,
      height: _size,
      // margin: const EdgeInsets.all(buttonWidth * 0.1),
      constraints: BoxConstraints(
        minWidth: _size,
        maxWidth: _count == null ? _size : maxWidth,
      ),
      decoration: BoxDecoration(
        borderRadius: Borderers.superBorderAll(context, _size * 0.5),
        color: Colorz.red255,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 2 * factor),
      // alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[

          SuperVerse(
            verse: _count,
            size: 0,
            scaleFactor: 1.4 * factor,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            // labelColor: Colorz.white50,
          ),

        ],
      ),
    );

  }
}

class NoteRedDotWrapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteRedDotWrapper({
    @required this.child,
    @required this.redDotIsOn,
    @required this.childWidth,
    this.count,
    this.shrinkChild = false,
    this.isNano = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool redDotIsOn;
  final int count;
  final Widget child;
  final bool shrinkChild;
  final bool isNano;
  final double childWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _viewWidth = childWidth - (NoteRedDot.getSize(isNano: isNano) * 0.2);
    final double _scale = _viewWidth / childWidth;

    blog('_viewWidth $_viewWidth : childWidth $childWidth : _scale $_scale');

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        if (shrinkChild == true)
          Transform.scale(
            scale: _scale,
            alignment: superBottomAlignment(context),
            child: child,
          ),

        if (shrinkChild == false)
          child,

        if (redDotIsOn == true)
          SuperPositioned(
            enAlignment: Alignment.topRight,
            // horizontalOffset: -(NoteRedDot.size * 0.5),
            child: NoteRedDot(
              count: count,
              isNano: isNano,
            ),
          ),

      ],
    );

  }
}
