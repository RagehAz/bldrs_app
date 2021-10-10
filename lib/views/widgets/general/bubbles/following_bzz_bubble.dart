import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/views/screens/i_flyer/h_1_bz_card_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/specific/in_pyramids/profile/bz_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingBzzBubble extends StatelessWidget {
  final List<TinyBz> tinyBzz;
  final Function onBzTap;

  const FollowingBzzBubble({
    @required this.tinyBzz,
    this.onBzTap,
});

  @override
  Widget build(BuildContext context) {

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final List<dynamic> followedBzzIDs = _usersProvider.myUserModel.followedBzzIDs;

    return Bubble(
      centered: false,
      title: 'Following ${followedBzzIDs.length} Businesses',
      columnChildren: <Widget>[

        /// FOLLOWING BZZ GRID
        BzGrid(
          gridZoneWidth: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4,
          tinyBzz: tinyBzz,
          numberOfColumns: 7,
          scrollDirection: Axis.horizontal,
          itemOnTap: (bzID) async {

            print('bzID = $bzID');

            if (onBzTap == null){
              await Nav.goToNewScreen(context, BzCardScreen(bzID: bzID, flyerBoxWidth: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4,));
            }

            else {
              onBzTap(bzID);
            }

          },
        ),

      ],
    );
  }
}
