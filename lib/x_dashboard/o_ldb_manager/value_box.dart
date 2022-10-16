import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
      onTap: () async {

        blog('copyToClipboard : value.runTimeType : ${value.runtimeType}');

        await Keyboard.copyToClipboard(
          context: context,
          copy: value,
        );

      },
      child: Container(
        height: 40,
        width: 80,
        color: color,
        margin: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: Verse(
                text: dataKey,
                translate: false,
              ),
              weight: VerseWeight.thin,
              italic: true,
              size: 1,
            ),

            SuperVerse(
              verse: Verse(
                text: value.toString(),
                translate: false,
              ),
              size: 1,
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
