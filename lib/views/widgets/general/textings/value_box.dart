import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ValueBox extends StatelessWidget {
  final String dataKey;
  final dynamic value;
  final Color color;

  const ValueBox({
    @required this.dataKey,
    @required this.value,
    this.color = Colorz.bloodTest,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Keyboarders.copyToClipboard(
        context: context,
        copy: value,
      ),
      child: Container(
        height: 40,
        width: 80,
        color: color,
        margin: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: dataKey,
              weight: VerseWeight.thin,
              italic: true,
              size: 1,
            ),

            SuperVerse(
              verse: '${value.toString()}',
              weight: VerseWeight.bold,
              italic: false,
              size: 1,
            ),

          ],
        ),
      ),
    );
  }
}
