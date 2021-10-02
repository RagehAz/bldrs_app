import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String verse;
  final Color verseColor;
  final double width;
  final Color color;
  final Function onTap;

  const DialogButton({
    @required this.verse,
    this.verseColor = Colorz.White255,
    this.width = 100,
    this.color,
    this.onTap,
  });

  static const double height = 50;

  @override
  Widget build(BuildContext context) {
    return DreamBox(
        height: height,
        width: width,
        margins: const EdgeInsets.all(Ratioz.appBarPadding),
        verse: verse.toUpperCase(),
        verseWeight: VerseWeight.black,
        verseItalic: true,
        verseMaxLines: 2,
        verseColor: verseColor,
        color: color,
        verseScaleFactor: 0.6,
        onTap: onTap,
    );
  }
}