import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';

class HeaderShadow extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;

  HeaderShadow({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
});
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        // --- MINI HEADER'S BG COLOR IN MAX STATE
        bzPageIsOn == false ? Container() :
        Container(color:Colorz.bzPageBGColor),//bzPageBGColor,),

        // --- HEADER SHADOW
        Container(
          width: flyerZoneWidth,
          height: flyerZoneWidth,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: superHeaderCorners(context, bzPageIsOn, flyerZoneWidth),
              boxShadow: superHeaderShadower(flyerZoneWidth),
          ),
        ),

      ],
    );

  }
}
