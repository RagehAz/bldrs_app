import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'user_bubble_items/clip_shadow_path.dart';
import 'user_bubble_items/path_building_user.dart';
import 'user_bubble_items/path_constructing_user.dart';
import 'user_bubble_items/path_normal_user.dart';
import 'user_bubble_items/path_planning_user.dart';
import 'user_bubble_items/path_searching_user.dart';
import 'user_bubble_items/path_selling_user.dart';

enum UserType {
  NormalUser,
  SearchingUser,
  ConstructingUser,
  PlanningUser,
  BuildingUser,
  SellingUser,
}

class UserBubble extends StatelessWidget {
  final UserType userType;
  final String userPic;
  final double bubbleWidth;
  final bool blackAndWhite;
  final Function onTap;

  UserBubble({
    @required this.userType,
    @required this.userPic,
    @required this.bubbleWidth,
    this.blackAndWhite = false,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color bubbleDarkness = blackAndWhite == false ? Colorz.BlackNothing :  Colorz.BlackSmoke;
    Color imageSaturationColor = blackAndWhite == true ? Colorz.Grey : Colorz.Nothing;

    CustomClipper<Path> userBubble =
      userType == UserType.NormalUser ? NormalUserBubble() :
      userType == UserType.SearchingUser ? SearchingUserBubble() :
      userType == UserType.ConstructingUser ? ConstructingUserBubble() :
      userType == UserType.PlanningUser ? PlanningUserBubble() :
      userType == UserType.BuildingUser ? BuildingUserBubble() :
      userType == UserType.SellingUser ? SellingUserBubble() :
      NormalUserBubble();

    return GestureDetector(
      onTap: onTap,
      child: ClipShadowPath(
        clipper: userBubble,
        shadow: BoxShadow(
          color: Colorz.BlackLingerie,
          offset: Offset(0, bubbleWidth * -0.019),
          spreadRadius: bubbleWidth * 0.15,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            // --- USER IMAGE
            Container(
              // color: Colorz.Yellow,
              width: bubbleWidth,
              height: bubbleWidth,
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
              width: 2 * bubbleWidth * 0.5 * 0.5,
              height: 1.4 * bubbleWidth * 0.5 * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(
                      bubbleWidth * 0.8 * 0.5, bubbleWidth * 0.7 * 0.8 * 0.5)),
                  color: Colorz.Nothing,
                  boxShadow: [
                    CustomBoxShadow(
                        color: Colorz.WhiteZircon,
                        offset: new Offset(0, bubbleWidth * 0.5 * -0.33),
                        blurRadius: bubbleWidth * 0.2,
                        blurStyle: BlurStyle.normal),
                  ]),
            ),

            // --- BUTTON GRADIENT
            Container(
              height: bubbleWidth,
              width: bubbleWidth,
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
