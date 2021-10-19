import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/expanding_tile.dart';
import 'package:bldrs/views/widgets/specific/keywords/group_expansion_tile.dart';
import 'package:bldrs/views/widgets/specific/keywords/sub_group_expansion_tile.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class CollapsedTile extends StatelessWidget {
  final Function toggleExpansion;
  final double tileWidth;
  final double collapsedHeight;
  final String icon;
  final Widget child;
  final String firstHeadline;
  final String secondHeadline;
  final Animation<double> arrowTurns;
  final Color arrowColor;
  final double expandableHeightFactorAnimationValue;
  final Color tileColor;
  final double corners;
  final double iconCorners;

  const CollapsedTile({
    @required this.toggleExpansion,
    @required this.tileWidth,
    @required this.collapsedHeight,
    @required this.icon,
    @required this.child,
    @required this.firstHeadline,
    @required this.secondHeadline,
    @required this.arrowTurns,
    @required this.arrowColor,
    @required this.expandableHeightFactorAnimationValue,
    @required this.tileColor,
    @required this.corners,
    this.iconCorners,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tileWidth,
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding, horizontal: Ratioz.appBarMargin),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: Borderers.superBorderAll(context, corners),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          /// COLLAPSED ZONE
          GestureDetector(
            onTap: toggleExpansion,
            child: Container(
              width: tileWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  /// Icon
                  if (icon != null)
                    DreamBox(
                      height: GroupTile.collapsedGroupHeight,
                      width: SubGroupTile.calculateTitleIconSize(icon: icon),
                      icon: icon,
                      corners: iconCorners ?? ExpandingTile.cornersValue,
                    ),

                  /// Tile title
                  Container(
                    width: SubGroupTile.calculateTitleBoxWidth(buttonHeight: collapsedHeight, tileWidth: tileWidth, icon: icon),
                    height: GroupTile.collapsedGroupHeight,
                    color: Colorz.nothing,
                    padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// FIRST HEADLINE
                        SuperVerse(
                          verse: firstHeadline,
                          weight: VerseWeight.bold,
                          italic: false,
                          size: 2,
                        ),

                        /// SECOND HEADLINE
                        SuperVerse(
                          verse: secondHeadline,
                          weight: VerseWeight.thin,
                          italic: true,
                          size: 1,
                          color: Colorz.white125,
                        ),

                      ],
                    ),
                  ),

                  /// Arrow
                  new RotationTransition(
                    turns: arrowTurns,
                    child: DreamBox(
                      height: GroupTile.arrowBoxSize,
                      width: GroupTile.arrowBoxSize,
                      bubble: false,
                      icon: Iconz.ArrowDown,
                      iconSizeFactor: 0.2,
                      iconColor: arrowColor,
                    ),
                  ),

                ],
              ),
            ),
          ),

          /// EXPANDABLE ZONE
          ClipRRect(
            child: new Align(
              heightFactor: expandableHeightFactorAnimationValue,
              child: child,
            ),
          ),

        ],
      ),
    );
  }
}
