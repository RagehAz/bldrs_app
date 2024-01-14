import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class CensusLineUnit extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CensusLineUnit({
    required this.width,
    required this.icon,
    required this.isActive,
    this.title,
    this.text,
    this.number,
    this.stripHeight = 30,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    super.key
  });
  // -----------------------------------------------------------------------------
  final double stripHeight;
  final double width;
  final int? number;
  final String? icon;
  final bool isActive;
  final Verse? text;
  final Verse? title;
  final CrossAxisAlignment crossAxisAlignment;
  // -----------------------------------------------------------------------------
  static double getTotalHeight({
    required bool hasTitle,
    double? stripHeight,
  }){
    final double _stripHeight = stripHeight ?? 30;
    final double _titleHeight = hasTitle == false ? 0 : _stripHeight/2;
    return _stripHeight + _titleHeight;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _titleHeight = title == null ? 0 : stripHeight/2;
    final double _totalHeight = getTotalHeight(
      hasTitle: title != null,
      stripHeight: stripHeight,
    );
    final double _iconZoneWidth = stripHeight * 1.25;
    final double _numberZoneWidth = width - _iconZoneWidth;

    return Container(
      width: width,
      height: _totalHeight,
      decoration: const BoxDecoration(
        // color: isActive == true ? Colorz.white10 : Colorz.nothing,
        borderRadius: Borderers.constantCornersAll12,
      ),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[

          /// ICON
          BldrsImage(
            pic: icon,
            width: _iconZoneWidth,
            height: stripHeight,
            scale: 0.6,
            greyscale: !isActive,
            solidGreyScale: true,

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
                  verse: text ?? Verse.plain(BldrsText.getCounterCaliber(number)),
                  size: 1,
                  centered: false,
                  textDirection: UiProvider.getAppTextDir(),
                  color: isActive == true ? Colorz.white255 : Colorz.white80,
                ),

                /// TITLE
                if (title != null)
                BldrsText(
                  width: _numberZoneWidth,
                  height: _titleHeight,
                  verse: title,
                  size: 1,
                  centered: false,
                  textDirection: UiProvider.getAppTextDir(),
                  color: isActive == true ? Colorz.white255 : Colorz.white80,
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

class CensusLineUnitSeparator extends StatelessWidget {

  const CensusLineUnitSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: 1,
        height: 25,
        color: Colorz.white20,
      ),
    );

  }

}
