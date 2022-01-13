import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/specific/bz/bz_static_grid.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_1_bz_card_screen.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
  final Function onBzTap;
  final String title;
  final String icon;
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
      color: Colorz.white10,
      margin: const EdgeInsets.only(bottom: 5),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          /// TITLE
          if (title != null)
          Align(
            alignment: superCenterAlignment(context),
            child: DreamBox(
              height: 40,
              verse: title,
              verseScaleFactor: 0.7,
              verseCentered: false,
              margins: 10,
              verseItalic: true,
              bubble: false,
              icon: icon,
            ),
          ),

          /// GRID
          BzStaticGrid(
            gridBoxWidth: Scale.superScreenWidth(context),
            bzzModels: bzzModels ?? [],
            numberOfColumns: 4,
            itemOnTap: (String bzID) => _onBzTap(context: context, bzID: bzID),
          ),

        ],
      ),
    );
  }
}
