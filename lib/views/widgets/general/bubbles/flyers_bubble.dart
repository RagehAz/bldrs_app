import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyer_stack.dart';
import 'package:flutter/material.dart';

class FlyersBubble extends StatelessWidget {
  final List<TinyFlyer> tinyFlyers;
  final double flyerSizeFactor;
  final String title;
  final int numberOfColumns;
  final int numberOfRows;
  final Axis scrollDirection;
  final Function onTap;
  final double bubbleWidth;

  const FlyersBubble({
    @required this.tinyFlyers,
    this.title  = 'Flyers',
    this.numberOfColumns = 5,
    this.numberOfRows = 2,
    this.scrollDirection = Axis.horizontal,
    this.onTap,
    this.flyerSizeFactor = 0.3,
    this.bubbleWidth,
  });

  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleColor: Colorz.White10,
      title: title,
      titleColor: Colorz.White255,
      width: bubbleWidth,
      columnChildren: <Widget>[

        FlyerStack(
          flyersType: null,
          flyerSizeFactor: flyerSizeFactor,
          title: null,
          tinyFlyers: tinyFlyers,
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