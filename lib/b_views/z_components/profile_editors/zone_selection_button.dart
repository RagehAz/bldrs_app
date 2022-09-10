import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ZoneSelectionButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionButton({
    @required this.title,
    @required this.verse,
    @required this.onTap,
    this.icon = Iconz.circleDot,
    this.loading = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final String verse;
  final String icon;
  final Function onTap;
  final bool loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _bubbleClearWidth = Bubble.clearWidth(context);
    // const double _buttonsSpacing = Ratioz.appBarPadding;

    final String _buttonVerse = loading ? 'Loading ...'
        :
    verse == null ? ''
        :
    ' $verse    ';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// TITLE
        SuperVerse(
          verse: title,
          centered: false,
          italic: true,
          weight: VerseWeight.thin,
          color: Colorz.white80,
          margin: 5,
        ),

        /// BUTTON CONTENTS
        DreamBox(
          height: 50,
          verseScaleFactor: 0.8,
          icon: icon,
          bubble: false,
          verse: _buttonVerse,
          verseMaxLines: 2,
          color: Colorz.white10,
          onTap: onTap,
          loading: loading,
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
