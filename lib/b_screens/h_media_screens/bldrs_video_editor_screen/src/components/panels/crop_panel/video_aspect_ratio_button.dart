import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class VideoAspectRatioButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoAspectRatioButton({
    required this.verse,
    required this.aspectRatio,
    required this.onTap,
    super.key
  });
  // --------------------
  final Verse verse;
  final double? aspectRatio;
  final Function onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _size = 60;
    const double _ratioIconWidth = _size * 0.3;
    // --------------------
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// FOOT PRINT
          BldrsBox(
            height: _size,
            width: _size,
            color: Colorz.white20,
            borderColor: Colorz.white50,
            bubble: false,
            onTap: onTap,
          ),

          SizedBox(
            height: _size,
            width: _size,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                /// RATIO ICON
                FlyerBox(
                  flyerBoxWidth: _ratioIconWidth,
                  boxColor: Colorz.black255,
                  stackWidgets: [

                    if (aspectRatio != null)
                    Align(
                      child: BldrsBox(
                        height: _ratioIconWidth / aspectRatio!,
                        width: _ratioIconWidth,
                        color: Colorz.white255,
                        borderColor: Colorz.black150,
                        corners: _ratioIconWidth * 0.05,
                        bubble: false,
                      ),
                    ),

                  ],
                ),

                /// TEXT
                BldrsText(
                  height: _size * 0.3,
                  width: _size,
                  weight: VerseWeight.thin,
                  italic: true,
                  verse: verse,
                  size: 1,
                ),

              ],
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
