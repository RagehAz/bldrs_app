import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FlagBox extends StatelessWidget {

  final String flag;
  final Function onTap;
  final double size;

  const FlagBox({
    @required this.flag,
    this.onTap,
    this.size = 35,
  });

  static const double corner = Ratioz.boxCorner12;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            // color: boxColor,
              borderRadius: BorderRadius.circular(corner),
              boxShadow: <BoxShadow>[
                CustomBoxShadow(
                    color: Colorz.black230,
                    offset: const Offset(0, 0),
                    blurRadius: size * 0.12,
                    blurStyle: BlurStyle.outer
                ),
              ]),
        child: ClipRRect(
          borderRadius:
          const BorderRadius.all(const Radius.circular(corner)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// FLAG
              flag == '' || flag == 'Black'?
                  Container() :
              WebsafeSvg.asset(flag, width: size),

              ///  BUTTON GRADIENT
                Container(
                  height: size,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(corner),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colorz.black0, Colorz.black200],
                          stops: <double>[0.65,1]
                      ),
                  ),
                ),

              ///  BUTTON HIGHLIGHT
                Container(
                  height: size,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(corner),
                      gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: <Color>[Colorz.nothing, Colorz.white80],
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
