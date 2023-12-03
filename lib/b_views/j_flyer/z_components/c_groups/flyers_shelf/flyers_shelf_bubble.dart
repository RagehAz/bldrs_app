import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyers_shelf/flyers_shelf_list_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class FlyersShelfBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const FlyersShelfBubble({
    required this.flyersIDs,
    required this.flyerBoxWidth,
    this.gridWidth,
    this.titleVerse,
    this.titleIcon,
    this.lastSlideWidget,
    this.flyerOnTap,
    super.key
  });
  // -------------------------
  final Verse? titleVerse;
  final String? titleIcon;
  final double flyerBoxWidth;
  final List<String> flyersIDs;
  final double? gridWidth;
  final Widget? lastSlideWidget;
  final Function(FlyerModel? flyerModel)? flyerOnTap;
  // -------------------------
  static const double spacing = Ratioz.appBarMargin;
  static const double titleIconWidth = Ratioz.appBarButtonSize;
  static const double titleIconCorner = Ratioz.appBarButtonCorner;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _gridWidth = Bubble.bubbleWidth(context: context);
    final double _flyerHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return Bubble(
      width: _gridWidth,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: titleVerse,
        leadingIcon: titleIcon,
        leadingIconSizeFactor: 0.7,
      ),
      columnChildren: <Widget>[

        const SizedBox(height: spacing),

        ClipRRect(
          borderRadius: FlyerDim.flyerCorners(flyerBoxWidth),
          child: FlyersShelfListBuilder(
            shelfTitleVerse: titleVerse,
            flyersIDs: flyersIDs,
            flyerBoxWidth: flyerBoxWidth,
            gridHeight: _flyerHeight,
            gridWidth: _gridWidth,
            flyerOnTap: flyerOnTap,
            lastSlideWidget: lastSlideWidget,
          ),
        ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
