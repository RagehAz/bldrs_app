import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FlagBox extends StatelessWidget {

  final String flag;
  final Function onTap;

  FlagBox({
    @required this.flag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    double _flagWidth = 35;
    double _corner = Ratioz.boxCorner12;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _flagWidth,
        height: _flagWidth,
        decoration: BoxDecoration(
            // color: boxColor,
              borderRadius: BorderRadius.circular(_corner),
              boxShadow: <BoxShadow>[
                CustomBoxShadow(
                    color: Colorz.Black230,
                    offset: new Offset(0, 0),
                    blurRadius: _flagWidth * 0.12,
                    blurStyle: BlurStyle.outer
                ),
              ]),
        child: ClipRRect(
          borderRadius:
          BorderRadius.all(Radius.circular(_corner)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              // --- FLAG
              flag == '' || flag == 'Black'?
                  Container() :
              WebsafeSvg.asset(flag, width: _flagWidth),

              // --- BUTTON GRADIENT
                Container(
                  height: _flagWidth,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(_corner),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colorz.Black0, Colorz.Black200],
                          stops: [0.65,1]
                      ),
                  ),
                ),

              // --- BUTTON HIGHLIGHT
                Container(
                  height: _flagWidth,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(_corner),
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
