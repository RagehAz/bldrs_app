import 'package:bldrs/models/enums/enum_user_type.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'balloons/clip_shadow_path.dart';

class UserBalloon extends StatelessWidget {
  final UserType userType;
  final String userPic;
  final double balloonWidth;
  final bool blackAndWhite;
  final Function onTap;

  UserBalloon({
    @required this.userType,
    @required this.userPic,
    @required this.balloonWidth,
    this.blackAndWhite = false,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color bubbleDarkness = blackAndWhite == false ? Colorz.BlackNothing :  Colorz.BlackSmoke;
    Color imageSaturationColor = blackAndWhite == true ? Colorz.Grey : Colorz.Nothing;


    return GestureDetector(
      onTap: onTap,
      child: ClipShadowPath(
        clipper: userBalloon(userType),
        shadow: BoxShadow(
          color: Colorz.BlackLingerie,
          offset: Offset(0, balloonWidth * -0.019),
          spreadRadius: balloonWidth * 0.15,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            // --- USER IMAGE
            Container(
              // color: Colorz.Yellow,
              width: balloonWidth,
              height: balloonWidth,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    imageSaturationColor,
                    BlendMode.saturation
                ),
                child:
                fileExtensionOf(userPic) == 'jpg' || fileExtensionOf(userPic) == 'jpeg' || fileExtensionOf(userPic) == 'png' ?
                Image.asset(userPic, fit: BoxFit.cover,):

                 fileExtensionOf(userPic) == 'svg' ?
                     WebsafeSvg.asset(userPic, fit: BoxFit.cover) : Container()
              ),
            ),

            // --- BUTTON OVAL HIGHLIGHT
            Container(
              width: 2 * balloonWidth * 0.5 * 0.5,
              height: 1.4 * balloonWidth * 0.5 * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(
                      balloonWidth * 0.8 * 0.5, balloonWidth * 0.7 * 0.8 * 0.5)),
                  color: Colorz.Nothing,
                  boxShadow: [
                    CustomBoxShadow(
                        color: Colorz.WhiteZircon,
                        offset: new Offset(0, balloonWidth * 0.5 * -0.33),
                        blurRadius: balloonWidth * 0.2,
                        blurStyle: BlurStyle.normal),
                  ]),
            ),

            // --- BUTTON GRADIENT
            Container(
              height: balloonWidth,
              width: balloonWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [bubbleDarkness, Colorz.BlackLingerie],
                    stops: [0.65, 0.85]),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
