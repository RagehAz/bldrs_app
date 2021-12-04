import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/views/screens/i_flyer/h_1_bz_card_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/bz/bz_grid.dart';
import 'package:flutter/material.dart';

class BzzBubble extends StatelessWidget {
  final List<BzModel> bzzModels;
  final String title;
  final int numberOfColumns;
  final int numberOfRows;
  final Axis scrollDirection;
  final ValueChanged<String> onTap;
  final double corners;

  const BzzBubble({
    @required this.bzzModels,
    this.title  = 'Businesses',
    this.numberOfColumns = 5,
    this.numberOfRows = 2,
    this.scrollDirection = Axis.horizontal,
    this.onTap,
    this.corners,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      bubbleColor: Colorz.white10,
      corners: corners,
      columnChildren: <Widget>[

        /// --- Title
        Padding(
          padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding, left: Ratioz.appBarMargin*2, right: Ratioz.appBarMargin*2),
          child: SuperVerse(
            verse: title,
            centered: false,
            maxLines: 2,
          ),
        ),

        BzGrid(
            gridZoneWidth: Bubble.clearWidth(context),
            bzzModels: bzzModels == null ? <BzModel>[] : bzzModels,
            numberOfColumns: numberOfColumns,
            numberOfRows: numberOfRows,
            scrollDirection: scrollDirection,
            corners: corners == null ? null : corners - Ratioz.appBarMargin,
            itemOnTap: (String bzID) {

              if (onTap == null) {
                Nav.goToNewScreen(context, BzCardScreen(bzID: bzID, flyerBoxWidth: Bubble.clearWidth(context),));
              } else {
                onTap(bzID);
              }

            },
        ),

      ],
    );
  }
}
