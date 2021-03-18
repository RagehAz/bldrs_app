import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CheckBox extends StatelessWidget {
  final Function onTap;
  final bool checkBoxIsOn;

  CheckBox({
    this.onTap,
    @required this.checkBoxIsOn,

});


  @override
  Widget build(BuildContext context) {

    double checkBoxRadius = 12.5;
    Color checkBoxColor = checkBoxIsOn == true ? Colorz.Yellow : Colorz.WhiteGlass;
    double btOvalSizeFactor = 0.8; // as a ratio of button sizes

    Color iconColor = Colorz.BlackBlack;


    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(checkBoxRadius * 0.75),
      decoration: BoxDecoration(
        color: Colorz.WhiteGlass,
        shape: BoxShape.circle,
        boxShadow: [
            CustomBoxShadow(
                color: Colorz.BlackBlack,
                blurRadius: 10,
                blurStyle: BlurStyle.outer
            ),
            CustomBoxShadow(
                color: Colorz.WhiteGlass,
                blurRadius: 10,
                blurStyle: BlurStyle.outer
            ),
          ]
      ),

      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(checkBoxRadius)),
          child: Padding(
            padding: EdgeInsets.all(2),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.elliptical(checkBoxRadius * btOvalSizeFactor, checkBoxRadius * 0.7 * btOvalSizeFactor)),
                      color: Colorz.Nothing,
                      boxShadow: <BoxShadow>[CustomBoxShadow(
                        color: Colorz.WhiteSmoke,
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colorz.Nothing, Colorz.BlackZircon],
                          stops: [0.3,1]
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
