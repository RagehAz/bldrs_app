import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class HeaderShadow extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;

  const HeaderShadow({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
});
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        /// --- MINI HEADER'S BG COLOR IN MAX STATE
        bzPageIsOn == false ? Container() :
        Container(color:Colorz.bzPageBGColor),//bzPageBGColor,),

        /// --- HEADER SHADOW
        Container(
          width: flyerZoneWidth,
          height: flyerZoneWidth,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: Borderers.superHeaderCorners(context, bzPageIsOn, flyerZoneWidth),
              boxShadow: Shadowz.flyerHeaderShadow(flyerZoneWidth),
          ),
        ),

      ],
    );

  }
}
