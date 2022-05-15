import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_1_bz_card_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/bzz_grid/bz_static_grid.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzzBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzzBubble({
    @required this.bzzModels,
    this.title = 'Businesses',
    this.numberOfColumns = 5,
    this.numberOfRows = 2,
    this.scrollDirection = Axis.horizontal,
    this.onTap,
    this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<BzModel> bzzModels;
  final String title;
  final int numberOfColumns;
  final int numberOfRows;
  final Axis scrollDirection;
  final ValueChanged<BzModel> onTap;
  final double corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Bubble(
      corners: corners,
      columnChildren: <Widget>[

        /// --- Title
        Padding(
          padding: const EdgeInsets.only(
              bottom: Ratioz.appBarPadding,
              left: Ratioz.appBarMargin * 2,
              right: Ratioz.appBarMargin * 2),
          child: SuperVerse(
            verse: title,
            centered: false,
            maxLines: 2,
          ),
        ),

        BzStaticGrid(
          gridBoxWidth: Bubble.clearWidth(context),
          bzzModels: bzzModels ?? <BzModel>[],
          numberOfColumns: numberOfColumns,
          itemOnTap: (BzModel bzModel) {

            if (onTap == null) {
              Nav.goToNewScreen(
                  context: context,
                  screen: BzCardScreen(
                    bzID: bzModel.id,
                    flyerBoxWidth: Bubble.clearWidth(context),
                  )
              );
            }

            else {
              onTap(bzModel);
            }

            },
        ),

      ],
    );
  }
}
