import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ButtonNotiCounter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ButtonNotiCounter({@required this.buttonWidth, this.count, Key key})
      : super(key: key);

  /// --------------------------------------------------------------------------
  final double buttonWidth;
  final int count;

  /// --------------------------------------------------------------------------
  String _concludeCount(int count) {
    String _count;

    if (count == null || count == 0) {
      _count = null;
    } else if (count > 1 && count <= 99) {
      _count = '$count';
    } else {
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
        borderRadius: superBorderAll(context, buttonWidth * 0.3 * 0.5),
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