import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_shelf_list_builder.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyersShelf extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersShelf({
    this.title,
    this.flyers,
    this.titleIcon,
    this.flyerOnTap,
    this.onScrollEnd,
    this.flyerSizeFactor = 0.3,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final List<FlyerModel> flyers;
  final String titleIcon;
  final Function flyerOnTap;
  final Function onScrollEnd;
  final double flyerSizeFactor;
  /// --------------------------------------------------------------------------
  static const double spacing = Ratioz.appBarMargin;
  static const double titleIconWidth = Ratioz.appBarButtonSize;
  static const double titleIconCorner = Ratioz.appBarButtonCorner;
// -----------------------------------------------------------------------------
  static double shelfHeight({BuildContext context, double flyerSizeFactor}) {

    final double _flyerZoneHeight = FlyerBox.heightBySizeFactor(
        context: context,
        flyerSizeFactor: flyerSizeFactor
    );

    final double _height = spacing + titleIconWidth + spacing + _flyerZoneHeight + spacing;
    return _height;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final double _flyerZoneHeight = FlyerBox.heightBySizeFactor(
        context: context,
        flyerSizeFactor: flyerSizeFactor,
    );
// -----------------------------------------------------------------------------
//     bool _slidingIsOn = false;
    const double _titleIconMargin = 0;
    const double _titleIconWidthWithMargin = titleIconWidth + _titleIconMargin;
// -----------------------------------------------------------------------------
    return Container(
      width: _screenWidth,
      // height: _collectionHeight + 2*_titleSpacing + (_screenHeight * Ratioz.fontSize3) + 12,
      margin: const EdgeInsets.only(bottom: 5),
      color: Colorz.white10,
      // decoration: BoxDecoration(
      //   // color: Colorz.BlackLingerie,
      //   //   border: Border.symmetric(
      //   //       vertical: BorderSide(width: 0.5, color: Colorz.BabyBlueAir, ),
      //   //   )
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          /// ---  ABOVE TITLE SPACING
          if (title != null)
            SizedBox(
              width: _screenWidth,
              height: spacing,
            ),

          /// --- COLLECTION TITLE
          if (title != null)
            GestureDetector(
              onTap: onScrollEnd,
              child: Container(
                width: _screenWidth,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                // color: Colorz.BloodTest,
                child: Row(
                  children: <Widget>[

                    if (titleIcon != null)
                      DreamBox(
                        height: titleIconWidth,
                        icon: titleIcon,
                        margins: EdgeInsets.zero,
                        corners: titleIconCorner,
                      ),

                    if (titleIcon != null)
                      const SizedBox(
                        width: Ratioz.appBarMargin,
                      ),

                    SizedBox(
                      width: _screenWidth - (Ratioz.appBarMargin * 5) - _titleIconWidthWithMargin,
                      child: SuperVerse(
                        verse: title,
                        centered: false,
                        shadow: true,
                        italic: true,
                        maxLines: 3,
                      ),
                    ),

                  ],
                ),
              ),
            ),

          /// --- BENEATH TITLE SPACING
          if (title != null)
            SizedBox(
              width: _screenWidth,
              height: spacing,
            ),

          /// --- COLLECTION FLYER'S ZONE
          SizedBox(
            width: _screenWidth,
            height: _flyerZoneHeight,
            // color: Colorz.WhiteAir,
            child: FlyersShelfListBuilder(
              shelfTitle: title,
              flyers: flyers,
              flyerSizeFactor: flyerSizeFactor,
              flyerOnTap: flyerOnTap,
              onScrollEnd: onScrollEnd,
            ),
          ),

          /// --- BENEATH FLYERS SPACING
          SizedBox(
            width: _screenWidth,
            height: spacing,
          ),
        ],
      ),
    );
  }
}
