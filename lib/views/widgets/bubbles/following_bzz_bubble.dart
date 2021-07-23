import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/h_1_bz_card_screen.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingBzzBubble extends StatelessWidget {
  final List<TinyBz> tinyBzz;

  FollowingBzzBubble({
    @required this.tinyBzz,
});

  @override
  Widget build(BuildContext context) {

    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final user = Provider.of<UserModel>(context);
    List<dynamic> followedBzzIDs = pro.getFollows;

    return InPyramidsBubble(
      centered: false,
      title: 'Following ${followedBzzIDs.length} Businesses',
      columnChildren: <Widget>[

        // --- FOLLOWING BZZ GRID
        BzGrid(
          gridZoneWidth: Scale.superScreenWidth(context) - Ratioz.appBarMargin * 4,
          tinyBzz: tinyBzz,
          numberOfColumns: 7,
          itemOnTap: (bzID){
            print('bzID = $bzID');
            Nav.goToNewScreen(context, BzCardScreen(bzID: bzID,));
          },
        ),

      ],
    );
  }
}
