import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ZoneSelectionButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionButton({
    required this.title,
    required this.verse,
    required this.onTap,
    this.icon = Iconz.circleDot,
    this.loading = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse title;
  final Verse verse;
  final String icon;
  final Function onTap;
  final bool loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _bubbleClearWidth = Bubble.clearWidth(context);
    // const double _buttonsSpacing = Ratioz.appBarPadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// TITLE
        BldrsText(
          verse: title,
          centered: false,
          italic: true,
          weight: VerseWeight.thin,
          color: Colorz.white80,
          margin: 5,
        ),

        /// BUTTON CONTENTS
        BldrsBox(
          height: 50,
          verseScaleFactor: 0.8,
          icon: icon,
          bubble: false,
          verse: loading == true ?
          const Verse(
            id: 'phid_loading'  ,
            translate: true,
          )
              :
          verse,
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
