import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'clip_shadow_path.dart';

class UserBalloon extends StatelessWidget {
  final UserStatus balloonType;
  final double balloonWidth;
  final bool blackAndWhite;
  final Function onTap;
  final bool loading;
  final Color balloonColor;
  final Widget child;
  final dynamic pic;

  UserBalloon({
    this.balloonType,
    @required this.balloonWidth,
    this.blackAndWhite = false,
    this.onTap,
    @required this.loading,
    this.balloonColor,
    this.child,
    this.pic
  });

  // Color _bubbleDarkness(){
  //   return
  //     blackAndWhite == false ? Colorz.BlackSmoke :  Colorz.BlackNothing;
  // }

  Widget _balloon([UserModel userModel]){

    CustomClipper _nullClipper;

    return
      Container(
        width: balloonWidth,
        height: balloonWidth,
        // color: Colorz.BloodTest,
        child: GestureDetector(
          onTap: onTap,
          child: ClipShadowPath(
            clipper: balloonType == null ? Iconizer.userBalloon(userModel?.userStatus) : Iconizer.userBalloon(balloonType),
            shadow: Shadowz.basicOuterShadow,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                // --- USER IMAGE LAYER
                Container(
                  // color: Colorz.Yellow,
                    width: balloonWidth,
                    height: balloonWidth,
                    color: balloonColor,
                    child: ColorFiltered(
                        colorFilter: Colorizer.superDesaturation(blackAndWhite),
                        child:
                        loading ?
                        Loading(loading: loading,)
                            :
                        balloonColor == null?
                        superImageWidget(pic == null ? userModel?.pic : pic)
                            :
                        Container()
                    )
                ),

                // --- BUTTON OVAL HIGHLIGHT
                Container(
                  width: 2 * balloonWidth * 0.5 * 0.7,
                  height: 1.4 * balloonWidth * 0.5 * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.elliptical(
                          balloonWidth * 0.8 * 0.5, balloonWidth * 0.7 * 0.8 * 0.5)),
                      color: Colorz.Nothing,
                      boxShadow: <CustomBoxShadow>[
                        CustomBoxShadow(
                            color: Colorz.WhiteSmoke,
                            offset: new Offset(0, balloonWidth * 0.5 * -0.5),
                            blurRadius: balloonWidth * 0.2,
                            blurStyle: BlurStyle.normal),
                      ]
                  ),
                ),

                // --- BUTTON GRADIENT
                // Container(
                //   height: balloonWidth,
                //   width: balloonWidth,
                //   decoration: BoxDecoration(
                //     gradient:
                //     RadialGradient(
                //       colors: <Color>[_bubbleDarkness(), Colorz.BlackNothing],
                //       stops: <double>[0.0, 0.3],
                //       radius: 1,
                //       center: const Alignment(0, 0),
                //       focal: const Alignment(0, 0),
                //       focalRadius: 0.5,
                //       tileMode: TileMode.mirror,
                //
                //     ),
                //
                //   ),
                //
                // ),

                // --- Child
                if(child != null)
                  child,

              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    final String _userID = superUserID();

    return
    balloonColor == null ?

      StreamBuilder<UserModel>(
        stream: UserProvider(userID: _userID)?.userData,
        builder: (context, snapshot){
          if(snapshot.hasData == false){
            return Loading(
              size: balloonWidth,
              loading: true,
              onTap: () => Nav.goToRoute(context, Routez.Starting),
            );
          } else {
            UserModel userModel = snapshot.data;
            return
              _balloon(userModel);
          }
        },
      )

        :

    _balloon();

  }
}
