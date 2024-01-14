import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';

class TheStripOfDataStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TheStripOfDataStrip({
    required this.text,
    required this.width,
    this.height = 50,
    this.color = Colorz.bloodTest,
    this.highlightText,
    this.onTap,
    this.textColor = Colorz.white255,
    this.hasBottomMargin = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double height;
  final double? width;
  final Color color;
  final String? text;
  final Color textColor;
  final ValueNotifier<dynamic>? highlightText;
  final Function? onTap;
  final bool hasBottomMargin;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TapLayer(
      height: height,
      width: width,
      boxColor: color,
      splashColor: Colorz.yellow200,
      corners: Borderers.constantCornersAll10,
      margin: hasBottomMargin == true ? const EdgeInsets.only(bottom: 5) : null,
      onTap: onTap,
      onLongTap: () => Keyboard.copyToClipboardAndNotify(
        copy: text,
      ),
      child: ClipRRect(
        borderRadius: Borderers.constantCornersAll10,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child:  BldrsBox(
            height: height,
            verse: Verse.plain(text),
            corners: Borderers.constantCornersAll10,
            // verseShadow: false,
            verseScaleFactor: 0.8,
            verseColor: textColor,
            bubble: false,
            color: color,
            verseWeight: VerseWeight.thin,
            verseCentered: false,
            verseHighlight: highlightText,
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
