import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

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
  // --------------------
  static double getSize({
    @required bool isNano
  }){
    final double _factor = isNano == true ? 0.7 : 1.0;
    final double _height = defaultSize * _factor;
    return _height;
  }
  // --------------------
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
    // --------------------
    final String _count = _concludeCount(count);
    final double factor = isNano == true ? 0.7 : 1.0;
    final double _size = getSize(isNano: isNano);
    // --------------------
    return Container(
      // width: _buttonWidth * 0.3,
      height: _size,
      // margin: const EdgeInsets.all(buttonWidth * 0.1),
      constraints: BoxConstraints(
        minWidth: _size,
        maxWidth: _count == null ? _size : maxWidth,
      ),
      decoration: BoxDecoration(
        borderRadius: Borderers.cornerAll(context, _size * 0.5),
        color: Colorz.red255,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 2 * factor),
      // alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[

          SuperVerse(
            verse: Verse(
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
  static double getShrinkageScale({
    @required double childWidth,
    @required bool isNano,
  }){
    final double _viewWidth = childWidth - (NoteRedDot.getSize(isNano: isNano) * 0.2);
    return _viewWidth / childWidth;
  }
  // --------------------
  static double getShrinkageDX({
    @required double childWidth,
    @required bool isNano,
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

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        if (shrinkChild == true)
          Transform.scale(
            scale: getShrinkageScale(
              isNano: isNano,
              childWidth: childWidth,
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
            appIsLTR: UiProvider.checkAppIsLeftToRight(context),
            child: NoteRedDot(
              count: count,
              isNano: isNano,
            ),
          ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
