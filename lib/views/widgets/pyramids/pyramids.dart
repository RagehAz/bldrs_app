import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/s13_in_pyramids_screen.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Pyramids extends StatelessWidget {
  final String whichPyramid;
  final Function onDoubleTap;

  Pyramids({
    @required this.whichPyramid,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: Ratioz.ddPyramidsWidth,
        height: Ratioz.ddPyramidsHeight,
        padding: EdgeInsets.all(0),
//          color: Ratioz.ccBloodTest,
//           alignment: Alignment.bottomRight,

        child: GestureDetector(
          onDoubleTap: onDoubleTap,
          onLongPress: () {
            Navigator.pushNamed(context, Routez.Obelisk);
          },
          onTap: whichPyramid == Iconz.PyramidsYellow ? () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InPyramidsScreen();
                  }));
                }
              : whichPyramid == Iconz.PyramidsWhite ?
              () { Navigator.pop(context); }
                  : () {},
          child: WebsafeSvg.asset(whichPyramid),
        ),
      ),
    );
  }
}
