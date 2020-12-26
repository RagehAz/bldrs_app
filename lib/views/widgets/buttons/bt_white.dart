import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ButtonWhiteEn extends StatelessWidget {

final String buttonText;
//double buttonWidthRatio;
final routeName;
final String textFont;

ButtonWhiteEn({@required this.buttonText,@required this.routeName,@required this.textFont
//  @required this.buttonWidthRatio
});

  @override
  Widget build(BuildContext context) {

    double buttonCorner = MediaQuery.of(context).size.height * Ratioz.rrButtonCorner;
    double buttonTextSize = MediaQuery.of(context).size.height * Ratioz.fontSize3;

    return Container(
      width: MediaQuery.of(context).size.height * 0.4, //buttonWidthRatio,
      height: MediaQuery.of(context).size.height * 0.0615764,
      margin: const EdgeInsets.all(3),

      child:RaisedButton(
        onPressed: (){
          Navigator.pushNamed(context, routeName);
        },
        color: Colorz.WhiteGlass,
        elevation: 2,
        splashColor: Colorz.Yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonCorner)
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colorz.White,
            fontFamily: textFont,
            fontSize: buttonTextSize,
            letterSpacing: 0.75,
            shadows: [Shadow(
              blurRadius: 2,
              color: Colorz.BlackBlack,
              offset: Offset(3.0,1.0),

            )]
          ),

        ),
      )


    );
  }

}
