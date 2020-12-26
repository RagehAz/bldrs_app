import 'package:bldrs/ambassadors/services/launch_url.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'follow_call_bts/call_bt.dart';
import 'follow_call_bts/follow_bt.dart';

class FollowCallBTs extends StatelessWidget {

  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final bool followIsOn;
  final Function tappingFollow;
  final String phoneNumber;

  FollowCallBTs({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.followIsOn,
    @required this.tappingFollow,
    @required this.phoneNumber,
});


  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    double headerMainHeight = superHeaderStripHeight(bzPageIsOn, flyerZoneWidth);
    double headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
    double headerOffsetHeight = headerMainHeight - (2 * headerMainPadding);
    // --- FOLLOWERS & GALLERY --- --- --- --- --- --- --- --- --- --- --- --- ---
    double followGalleryHeight = headerOffsetHeight;
    double followGalleryWidth = flyerZoneWidth * Ratioz.xxflyerFollowBtWidth;
    double fakeSpaceBetweenFollowGallery = headerMainPadding;
    // === === === === === === === === === === === === === === === === === === ===
    return
      bzPageIsOn == true ? Container () :
      Container(
        height: followGalleryHeight,
        width: followGalleryWidth,
        child: Column(
          children: <Widget>[

            // --- FOLLOW BUTTON
            FollowBT(
              flyerZoneWidth: flyerZoneWidth,
              tappingFollow: tappingFollow,
              tappingUnfollow: (){},
              followOn: followIsOn,
            ),

            // --- FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
            SizedBox(
              height: fakeSpaceBetweenFollowGallery,
            ),

            // --- Call BUTTON
            CallBT(
              flyerZoneWidth: flyerZoneWidth,
              tappingCall: (){
                if (phoneNumber == null){print('no phone here');}
                else
                  {launchCall('tel: $phoneNumber');}
              },
            ),

          ],
        ),
      )
    ;
  }
}
