import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/bt_white.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static String id= 'SignUpScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorz.DarkBlue,
      body: Stack(
        children: <Widget>[
          ListView(

            children: <Widget>[

              Column(

                children: <Widget>[

                  SizedBox(
                      height: MediaQuery.of(context).size.height * .15,
                  ),

                  Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.height * .55,
                      height: MediaQuery.of(context).size.height * .40,
                      color: Colorz.BloodTest,
//                      child: WebsafeSvg.asset('assets/art_works/bldrs_splash_en.svg')
                  ), // ---------------------------- Splash graphic

                  Container(
                    height: MediaQuery.of(context).size.height * .04,
                    alignment: Alignment.center,
                    child: Text(
                      'Choose Account\'s type',
                    style: TextStyle(
                      color: Colorz.Yellow,
                      fontFamily: 'Verdana',
                      fontStyle: FontStyle.italic,
                      fontSize: MediaQuery.of(context).size.height * Ratioz.fontSize2 ,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          blurRadius: 1,
                          color: Colorz.WhiteAir,
                          offset: Offset(2.0,1.0)
                        )
                      ],
                    ),
                    ),
                  ),

                  ButtonWhiteEn(
                    buttonText: 'Normal Account',
                    routeName: Routez.OwnerSignUp,
                    textFont: getTranslated(context, 'Headline_Font'),

                  ), // ---------------------------- Signup

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),

                  ButtonWhiteEn(
                    buttonText: 'Business aount',
                    routeName: Routez.BusinessSignUp,
                    textFont: getTranslated(context, 'Headline_Font'),

                  ), // ---------------------------- Signin

                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),

                ],
              )

            ],

          ),

          Pyramids(
            whichPyramid: Iconz.PyramidsYellow,
          ),

        ],

      )
    );
  }
}