import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_shelf.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyersBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersBubble({
    @required this.flyers,
    this.title = 'Flyers',
    this.numberOfColumns = 5,
    this.numberOfRows = 2,
    this.scrollDirection = Axis.horizontal,
    this.onTap,
    this.flyerSizeFactor = 0.3,
    this.bubbleWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final double flyerSizeFactor;
  final String title;
  final int numberOfColumns;
  final int numberOfRows;
  final Axis scrollDirection;
  final ValueChanged<String> onTap;
  final double bubbleWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Bubble(
      bubbleColor: Colorz.white10,
      title: title,
      width: bubbleWidth,
      columnChildren: <Widget>[

        FlyersShelf(
          flyerSizeFactor: flyerSizeFactor,
          flyers: flyers,
        ),

        // FlyersGrid(
        //   gridZoneWidth: superBubbleClearWidth(context),
        //   tinyFlyers: tinyFlyers ?? [],
        //   numberOfColumns: numberOfColumns,
        //   stratosphere: false,
        //   scrollable: true,
        //   scrollDirection: Axis.vertical,
        // )

        // BzGrid(
        //   gridZoneWidth: superBubbleClearWidth(context),
        //   tinyBzz: tinyBzz ?? [],
        //   numberOfColumns: numberOfColumns,
        //   numberOfRows: numberOfRows,
        //   scrollDirection: scrollDirection,
        //   itemOnTap: (bzID) {
        //
        //     if (onTap == null) {
        //       Nav.goToNewScreen(context, BzCardScreen(bzID: bzID,));
        //     } else {
        //       onTap(bzID);
        //     }
        //   },
        // ),

      ],
    );
  }
}
