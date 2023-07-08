import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:flutter/material.dart';

class CensusLineUnit extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CensusLineUnit({
    required this.width,
    required this.number,
    required this.icon,
    required this.isActive,
    required this.title,
    this.stripHeight = 30,
    super.key
  });
  // -----------------------------------------------------------------------------
  final double stripHeight;
  final double width;
  final int? number;
  final String icon;
  final bool isActive;
  final Verse? title;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _titleHeight = title == null ? 0 : stripHeight/2;
    final double _totalHeight = stripHeight + _titleHeight;
    final double _iconZoneWidth = stripHeight * 1.25;
    final double _numberZoneWidth = width - _iconZoneWidth;

    return Container(
      width: width,
      height: _totalHeight,
      decoration: const BoxDecoration(
        color: Colorz.white10,
        borderRadius: Borderers.constantCornersAll12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// ICON
          BldrsImage(
            pic: icon,
            width: _iconZoneWidth,
            height: stripHeight,
            scale: 0.6,
          ),

          /// NUMBER AND TITLE
          SizedBox(
            width: _numberZoneWidth,
            height: _totalHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// NUMBER
                BldrsText(
                  width: _numberZoneWidth,
                  verse: Verse.plain(counterCaliber(number)),
                  size: 1,
                  centered: false,
                  textDirection: UiProvider.getAppTextDir(),
                ),

                /// TITLE
                BldrsText(
                  width: _numberZoneWidth,
                  height: _titleHeight,
                  verse: title,
                  size: 1,
                  centered: false,
                  textDirection: UiProvider.getAppTextDir(),
                ),

              ],
            ),
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
