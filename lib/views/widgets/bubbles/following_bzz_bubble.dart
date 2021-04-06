import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingBzzBubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final user = Provider.of<UserModel>(context);
    // List<dynamic> followedBzzIDs = [ 'pp3', ...(user?.followedBzzIDs)];
    final List<TinyBz> _followedBzz = pro.getFollowedBzz;

    return InPyramidsBubble(
      centered: false,
      title: 'Following ${10} Businesses',
      columnChildren: <Widget>[

        // --- FOLLOWING BZZ GRID
        BzGrid(
          gridZoneWidth: superScreenWidth(context) - Ratioz.ddAppBarMargin * 4,
          tinyBzz: _followedBzz,
          numberOfColumns: 7,
        ),

      ],
    );
  }
}
