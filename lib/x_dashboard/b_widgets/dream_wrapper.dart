import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DreamWrapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamWrapper({
    this.verses,
    this.icons,
    this.spacing = Ratioz.appBarPadding,
    this.buttonHeight = 35,
    this.onTap,
    this.margins,
    this.boxWidth,
    this.boxHeight,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> verses;
  final List<String> icons;
  final double spacing;
  final double buttonHeight;
  final Function onTap;
  final EdgeInsets margins;
  final double boxWidth;
  final double boxHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    blog(verses);
    blog(icons);

    final int _listLength = verses == null && icons == null
        ? 0
        : verses == null
            ? icons.length
            : icons == null
                ? verses.length
                : verses.length;

    return Container(
      width: boxWidth,
      // height: boxHeight,
      decoration: BoxDecoration(
        color: Colorz.bloodTest,
        borderRadius: Borderers.superBorderAll(context, 10),
      ),
      child: Wrap(
        spacing: spacing,
        children: <Widget>[
          ...List<Widget>.generate(_listLength, (int index) {
            final String _verse = verses[index];

            return DreamBox(
                height: buttonHeight,
                icon: icons[index],
                margins: margins,
                verse: _verse,
                verseWeight: VerseWeight.thin,
                iconSizeFactor: 0.6,
                onTap: () => onTap(_verse));
          }),
        ],
      ),
    );
  }
  /// --------------------------------------------------------------------------
}
