import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FlagBox extends StatelessWidget {

  final String flag;
  final Function onTap;

  const FlagBox({
    @required this.flag,
    this.onTap,
  });

  static const double flagWidth = 35;
  static const double corner = Ratioz.boxCorner12;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: flagWidth,
        height: flagWidth,
        decoration: BoxDecoration(
            // color: boxColor,
              borderRadius: BorderRadius.circular(corner),
              boxShadow: <BoxShadow>[
                CustomBoxShadow(
                    color: Colorz.Black230,
                    offset: new Offset(0, 0),
                    blurRadius: flagWidth * 0.12,
                    blurStyle: BlurStyle.outer
                ),
              ]),
        child: ClipRRect(
          borderRadius:
          BorderRadius.all(Radius.circular(corner)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// FLAG
              flag == '' || flag == 'Black'?
                  Container() :
              WebsafeSvg.asset(flag, width: flagWidth),

              ///  BUTTON GRADIENT
                Container(
                  height: flagWidth,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(corner),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colorz.Black0, Colorz.Black200],
                          stops: <double>[0.65,1]
                      ),
                  ),
                ),

              ///  BUTTON HIGHLIGHT
                Container(
                  height: flagWidth,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(corner),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[Colorz.Nothing, Colorz.White80],
                          stops: <double>[0.75,1]
                      ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}