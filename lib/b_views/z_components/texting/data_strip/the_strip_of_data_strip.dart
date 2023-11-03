import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class TheStripOfDataStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TheStripOfDataStrip({
    required this.text,
    required this.width,
    this.height = 50,
    this.color = Colorz.bloodTest,
    this.highlightText,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final Color color;
  final String? text;
  final ValueNotifier<dynamic>? highlightText;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: Borderers.constantCornersAll10,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      child: ClipRRect(
        borderRadius: Borderers.constantCornersAll10,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child:  BldrsBox(
            height: height,
            verse: Verse.plain(text),
            // verseShadow: false,
            verseScaleFactor: 0.8,
            bubble: false,
            color: color,
            verseWeight: VerseWeight.thin,
            verseCentered: false,
            verseHighlight: highlightText,
            onTap: onTap,
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
