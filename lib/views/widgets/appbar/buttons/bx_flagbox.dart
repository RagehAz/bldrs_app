import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FlagBox extends StatelessWidget {

  final String flag;

  FlagBox({@required this.flag});

  @override
  Widget build(BuildContext context) {

    double flagWidth = 40;
    // dynamic boxColor = flag == 'Black' ? Colorz.BlackPlastic : Colorz.Nothing;

    return Container(
      width: flagWidth,
      height: flagWidth,
      decoration: BoxDecoration(
          // color: boxColor,
            borderRadius: BorderRadius.circular(Ratioz.ddBoxCorner),
            boxShadow: [
              CustomBoxShadow(
                  color: Colorz.BlackBlack,
                  offset: new Offset(0, 0),
                  blurRadius: flagWidth * 0.12,
                  blurStyle: BlurStyle.outer
              ),
            ]),
      child: ClipRRect(
        borderRadius:
        BorderRadius.all(Radius.circular(Ratioz.ddBoxCorner)),
        child: Stack(
          alignment: Alignment.center,
          children: [

            // --- FLAG
            flag == '' || flag == 'Black'?
                Container() :
            WebsafeSvg.asset(flag, width: flagWidth),

            // --- BUTTON GRADIENT
              Container(
                height: flagWidth,
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: Colorz.Grey,
                    borderRadius: BorderRadius.circular(Ratioz.ddBoxCorner),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colorz.BlackNothing, Colorz.BlackLingerie],
                        stops: [0.65,1]
                    ),
                ),
              ),

            // --- BUTTON HIGHLIGHT
              Container(
                height: flagWidth,
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: Colorz.Grey,
                    borderRadius: BorderRadius.circular(Ratioz.ddBoxCorner),
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colorz.Nothing, Colorz.WhiteSmoke],
                        stops: [0.75,1]
                    ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
