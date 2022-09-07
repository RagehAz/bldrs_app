import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ValueBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ValueBox({
    @required this.dataKey,
    @required this.value,
    this.color = Colorz.bloodTest,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String dataKey;
  final dynamic value;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Keyboard.copyToClipboard(
        context: context,
        copy: value,
      ),
      child: Container(
        height: 40,
        width: 80,
        color: color,
        margin: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SuperVerse(
              verse: dataKey,
              weight: VerseWeight.thin,
              italic: true,
              size: 1,
            ),
            SuperVerse(
              verse: value.toString(),
              size: 1,
            ),
          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
