import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ShelfSlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfSlide({
    @required this.mutableSlide,
    @required this.number,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final MutableSlide mutableSlide;
  final int number;
  final Function onTap;
  /// --------------------------------------------------------------------------
  static const double flyerBoxWidth = 150;
  static const double slideNumberBoxHeight = 20;
// ----------------------------------------------
  static double shelfSlideZoneHeight(BuildContext context){
    final double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);
    return _flyerZoneHeight + slideNumberBoxHeight + (Ratioz.appBarPadding * 3);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);

    return Container(
      width: flyerBoxWidth,
      height: shelfSlideZoneHeight(context),
      margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding,),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

          /// FLYER NUMBER
          Container(
            width: flyerBoxWidth,
            height: slideNumberBoxHeight,
            alignment: Aligners.superCenterAlignment(context),
            child: SuperVerse(
              verse: '$number',
              size: 1,
              // color: Colorz.white255,
              labelColor: mutableSlide?.midColor?.withAlpha(80) ?? Colorz.white10,
            ),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

          /// IMAGE
          GestureDetector(
            onTap: onTap,
            child: FlyerBox(
              flyerBoxWidth: flyerBoxWidth,
              boxColor: mutableSlide?.midColor ?? Colorz.white10,
              stackWidgets: <Widget>[

                if (mutableSlide != null)
                Align(
                  child: SuperImage(
                    width: flyerBoxWidth,
                    height: _flyerZoneHeight,
                    pic: mutableSlide.picAsset ?? mutableSlide.picFile,
                    fit: mutableSlide.picFit,
                  ),
                ),

                if (mutableSlide == null)
                  SizedBox(
                    width: flyerBoxWidth,
                    height: _flyerZoneHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        /// PLUS ICON
                        const DreamBox(
                          height: flyerBoxWidth * 0.5,
                          width: flyerBoxWidth * 0.5,
                          icon: Iconz.plus,
                          iconColor: Colorz.white20,
                          bubble: false,
                        ),

                        const SizedBox(
                          height: flyerBoxWidth * 0.05,
                        ),

                        SizedBox(
                          width: flyerBoxWidth * 0.95,
                          child: SuperVerse(
                            verse: superPhrase(context, 'phid_add_images'),
                            color: Colorz.white20,
                            maxLines: 2,
                          ),
                        ),

                      ],
                    ),
                  ),

              ],
            ),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

        ],
      ),
    );
  }
}
