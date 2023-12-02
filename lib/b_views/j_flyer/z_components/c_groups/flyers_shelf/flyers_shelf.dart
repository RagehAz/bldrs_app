import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyers_shelf/flyers_shelf_list_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class FlyersShelf extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersShelf({
    required this.flyersIDs,
    required this.flyerBoxWidth,
    this.gridWidth,
    this.titleVerse,
    this.titleIcon,
    this.flyerOnTap,
    this.onScrollEnd,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? titleVerse;
  final String? titleIcon;
  final Function(String? flyerID)? flyerOnTap;
  final Function? onScrollEnd;
  final double flyerBoxWidth;
  final List<String> flyersIDs;
  final double? gridWidth;
  /// --------------------------------------------------------------------------
  static const double spacing = Ratioz.appBarMargin;
  static const double titleIconWidth = Ratioz.appBarButtonSize;
  static const double titleIconCorner = Ratioz.appBarButtonCorner;
  // -----------------------------------------------------------------------------
  static double shelfHeight({
    required double flyerBoxWidth,
  }) {

    final double _flyerZoneHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );

    return spacing + _flyerZoneHeight + spacing;
    // return spacing + titleIconWidth + spacing + _flyerZoneHeight + spacing;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _gridWidth = gridWidth ?? Scale.screenWidth(context);
    final double _gridHeight = shelfHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return Container(
      width: _gridWidth,
      margin: const EdgeInsets.only(
        bottom: 5,
        left: spacing,
        right: spacing,
      ),
      decoration: BoxDecoration(
        borderRadius: Bubble.borders(),
        color: Colorz.white10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// ---  ABOVE TITLE SPACING
          if (titleVerse != null)
            SizedBox(
              width: _gridWidth,
              height: spacing,
            ),

          /// --- COLLECTION TITLE
          if (titleVerse != null)
            GestureDetector(
              onTap: onScrollEnd == null ? null : () => onScrollEnd!(),
              child: Container(
                width: _gridWidth - 20,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // color: Colorz.BloodTest,
                child: Row(
                  children: <Widget>[

                    if (titleIcon != null)
                      BldrsBox(
                        height: titleIconWidth,
                        icon: titleIcon,
                        margins: EdgeInsets.zero,
                        corners: titleIconCorner,
                      ),

                    if (titleIcon != null)
                      const SizedBox(
                        width: Ratioz.appBarMargin,
                      ),

                    BldrsText(
                      width: _gridWidth - (Ratioz.appBarMargin * 5) - titleIconWidth - 20,
                      verse: titleVerse,
                      centered: false,
                      shadow: true,
                      italic: true,
                      maxLines: 2,
                    ),

                  ],
                ),
              ),
            ),

          // /// --- BENEATH TITLE SPACING
          // if (titleVerse != null)
          //   SizedBox(
          //     width: _gridWidth,
          //     height: spacing,
          //   ),

          /// --- COLLECTION FLYER'S ZONE
          FlyersShelfListBuilder(
            shelfTitleVerse: titleVerse,
            flyersIDs: flyersIDs,
            flyerBoxWidth: flyerBoxWidth,
            flyerOnTap: flyerOnTap,
            onScrollEnd: onScrollEnd,
            gridHeight: _gridHeight,
            gridWidth: _gridWidth,
          ),

          // /// --- BENEATH FLYERS SPACING
          // SizedBox(
          //   width: _gridWidth,
          //   height: spacing,
          // ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
