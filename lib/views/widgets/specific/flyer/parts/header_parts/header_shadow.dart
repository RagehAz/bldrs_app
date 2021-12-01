import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class HeaderShadow extends StatelessWidget {
  final double flyerBoxWidth;
  final bool bzPageIsOn;

  const HeaderShadow({
    @required this.flyerBoxWidth,
    @required this.bzPageIsOn,
    Key key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        /// --- MINI HEADER'S BG COLOR IN MAX STATE
        if (bzPageIsOn == true)
        Container(color:Colorz.bzPageBGColor),//bzPageBGColor,),

        /// --- HEADER SHADOW
        Container(
          width: flyerBoxWidth,
          height: flyerBoxWidth,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: Borderers.superHeaderCorners(context, bzPageIsOn, flyerBoxWidth),
              boxShadow: Shadowz.flyerHeaderShadow(flyerBoxWidth),
          ),
        ),

      ],
    );

  }
}
