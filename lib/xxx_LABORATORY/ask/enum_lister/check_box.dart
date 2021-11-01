import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CheckBox extends StatelessWidget {
  final Function onTap;
  final bool checkBoxIsOn;

  const CheckBox({
    this.onTap,
    @required this.checkBoxIsOn,

});


  @override
  Widget build(BuildContext context) {

    const double checkBoxRadius = 12.5;
    final Color checkBoxColor = checkBoxIsOn == true ? Colorz.yellow255 : Colorz.white20;
    const double btOvalSizeFactor = 0.8; // as a ratio of button sizes

    const Color iconColor = Colorz.black230;


    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(checkBoxRadius * 0.75),
      decoration: const BoxDecoration(
        color: Colorz.white20,
        shape: BoxShape.circle,
          boxShadow: <BoxShadow>[
            const CustomBoxShadow(
                color: Colorz.black230,
                blurRadius: 10,
                blurStyle: BlurStyle.outer
            ),
            const CustomBoxShadow(
                color: Colorz.white20,
                blurRadius: 10,
                blurStyle: BlurStyle.outer
            ),
          ]
      ),

      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(checkBoxRadius)),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: checkBoxRadius,
              backgroundColor: checkBoxColor,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  // --- CHECKBOX OVAL HIGHLIGHT
                  Container(
                    width: 2 * checkBoxRadius * btOvalSizeFactor,
                    height: 1.4 * checkBoxRadius* btOvalSizeFactor,
                    decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.elliptical(checkBoxRadius * btOvalSizeFactor, checkBoxRadius * 0.7 * btOvalSizeFactor)),
                      color: Colorz.nothing,
                      boxShadow: <BoxShadow>[CustomBoxShadow(
                        color: Colorz.white80,
                        offset: Offset(0, checkBoxRadius * -0.5),
                        blurRadius: checkBoxRadius * 0.3 ,
                        blurStyle: BlurStyle.normal
                      ),]
                    ),
                  ),

                  // --- CHECKBOX GRADIENT
                  Container(
                    width: checkBoxRadius * 2,
                    height: checkBoxRadius * 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colorz.nothing, Colorz.black50],
                          stops: <double>[0.3,1]
                      ),

                    ),
                  ),

                  checkBoxIsOn == false ? Container() :
                  Container(
                        width: checkBoxRadius * 1.25,
                        height: checkBoxRadius * 1.25,
                        child: WebsafeSvg.asset(
                          Iconz.Check,
                            color: iconColor,
                        ),
                      )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}