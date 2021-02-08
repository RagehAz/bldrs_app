import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingBzzBubble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final user = Provider.of<UserModel>(context);
    // List<dynamic> followedBzzIDs = [ 'pp3', ...(user?.followedBzzIDs)];
    final List<BzModel> followedBzz = pro.getFollowedBzz;

    return InPyramidsBubble(
      centered: false,
      columnChildren: <Widget>[

        // --- BUBBLE TITLE
        SuperVerse(
          verse: 'Following ${10} Businesses',
          size: 2,
          centered: false,
          margin: Ratioz.ddAppBarMargin,
          color: Colorz.Grey,
        ),

        // --- FOLLOWING BZZ GRID
        BzGrid(
          gridZoneWidth: superScreenWidth(context) - Ratioz.ddAppBarMargin * 4,
          bzz: followedBzz,
          numberOfColumns: 7,
        ),

      ],
    );
  }
}
