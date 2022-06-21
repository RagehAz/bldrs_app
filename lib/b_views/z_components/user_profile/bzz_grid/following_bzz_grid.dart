import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/x_screens/x_flyer/d_bz_card_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/user_profile/bzz_grid/bz_static_grid.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FollowingBzzGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowingBzzGrid({
    @required this.bzzModels,
    this.title,
    this.icon,
    this.onBzTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<BzModel> bzzModels;
  final ValueChanged<BzModel> onBzTap;
  final String title;
  final String icon;
  /// --------------------------------------------------------------------------
  Future<void> _onBzTap({
    @required BuildContext context,
    @required BzModel bzModel
  }) async {

    bzModel.blogBz(methodName: 'Followed Bz tapped');

    if (onBzTap == null) {

      await Nav.goToNewScreen(
          context: context,
          screen: BzCardScreen(
            bzID: bzModel.id,
            flyerBoxWidth: Scale.superScreenWidth(context) -
                Ratioz.appBarMargin * 4,
          )
      );

    }

    else {
      onBzTap(bzModel);
    }
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Bubble(
      title: title,
      margins: Scale.superInsets(context: context, bottom: 10, enLeft: 10, enRight: 10),
      columnChildren: <Widget>[

        /// GRID
        BzStaticGrid(
          gridBoxWidth: Scale.superScreenWidth(context),
          bzzModels: bzzModels ?? [],
          numberOfColumns: 4,
          itemOnTap: (BzModel bzModel) => _onBzTap(
              context: context,
              bzModel: bzModel
          ),
        ),

      ],
    );
  }
}
