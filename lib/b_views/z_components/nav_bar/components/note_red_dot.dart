import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class NoteRedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteRedDot({
    @required this.buttonWidth,
    this.count, Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double buttonWidth;
  final int count;
  /// --------------------------------------------------------------------------
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

    return Container(
      // width: _buttonWidth * 0.3,
      height: buttonWidth * 0.3,
      margin: EdgeInsets.all(buttonWidth * 0.1),
      constraints: BoxConstraints(
        minWidth: buttonWidth * 0.3,
        maxWidth: _count == null ? buttonWidth * 0.3 : buttonWidth,
      ),
      decoration: BoxDecoration(
        borderRadius: Borderers.superBorderAll(context, buttonWidth * 0.3 * 0.5),
        color: Colorz.red255,
      ),
      padding: EdgeInsets.symmetric(horizontal: buttonWidth * 0.08),
      child: SuperVerse(
        verse: _count,
        size: 0,
        scaleFactor: buttonWidth * 0.025,
      ),
    );

  }
}
