import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/specific/bz/bz_grid.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_1_bz_card_screen.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingBzzBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowingBzzBubble({
    @required this.bzzModels,
    this.onBzTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<BzModel> bzzModels;
  final Function onBzTap;
  /// --------------------------------------------------------------------------
  Future<void> _onBzTap({
    @required BuildContext context,
    @required String bzID
  }) async {

    blog('bzID = $bzID');

    if (onBzTap == null) {
      await Nav.goToNewScreen(
          context,
          BzCardScreen(
            bzID: bzID,
            flyerBoxWidth: Scale.superScreenWidth(context) -
                Ratioz.appBarMargin * 4,
          ));
    }

    else {
      onBzTap(bzID);
    }
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Scale.superScreenWidth(context),
      // height: Scale.superScreenHeight(context),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[

          /// FOLLOWING BZZ GRID
          BzGrid(
            gridZoneWidth: Scale.appBarWidth(context),
            bzzModels: bzzModels ?? [],
            numberOfColumns: 4,
            scrollDirection: Axis.horizontal,

            // numberOfRows: 1000,
            itemOnTap: (String bzID) => _onBzTap(context: context, bzID: bzID),
          ),

        ],
      ),
    );
  }
}
