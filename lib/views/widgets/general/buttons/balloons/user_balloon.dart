import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/users/user_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/clip_shadow_path.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserBalloon extends StatelessWidget {
  final UserStatus balloonType;
  final double balloonWidth;
  final bool blackAndWhite;
  final Function onTap;
  final bool loading;
  final Color balloonColor;
  final Widget child;
  final dynamic pic;
  final bool shadowIsOn;

  const UserBalloon({
    this.balloonType,
    @required this.balloonWidth,
    this.blackAndWhite = false,
    this.onTap,
    @required this.loading,
    this.balloonColor,
    this.child,
    this.pic,
    this.shadowIsOn = true,
  });

  // Color _bubbleDarkness(){
  //   return
  //     blackAndWhite == false ? Colorz.BlackSmoke :  Colorz.BlackNothing;
  // }


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
            final UserModel userModel = snapshot.data;
            return
              Balloona(
                  balloonWidth: balloonWidth,
                  onTap: onTap,
                  userModel: userModel,
                  balloonType: balloonType,
                  shadowIsOn: shadowIsOn,
                  pic: pic,
                  child: child,
                  loading: loading,
                  balloonColor: balloonColor,
                  blackAndWhite: blackAndWhite
              );
          }
        },
      )

        :

    Balloona(
        balloonWidth: balloonWidth,
        onTap: onTap,
        userModel: null,
        balloonType: balloonType,
        shadowIsOn: shadowIsOn,
        pic: pic,
        child: child,
        loading: loading,
        balloonColor: balloonColor,
        blackAndWhite: blackAndWhite);

  }
}

class Balloona extends StatelessWidget {
  final double balloonWidth;
  final Function onTap;
  final UserModel userModel;
  final UserStatus balloonType;
  final bool shadowIsOn;
  final String pic;
  final Widget child;
  final bool loading;
  final Color balloonColor;
  final bool blackAndWhite;

  const Balloona({
    @required this.balloonWidth,
    @required this.onTap,
    @required this.userModel,
    @required this.balloonType,
    @required this.shadowIsOn,
    @required this.pic,
    @required this.child,
    @required this.loading,
    @required this.balloonColor,
    @required this.blackAndWhite,
  });

  @override
  Widget build(BuildContext context) {

    final CustomClipper _clipper = balloonType == null ? Iconizer.userBalloon(userModel?.userStatus) : Iconizer.userBalloon(balloonType);

    return Container(
      width: balloonWidth,
      height: balloonWidth,
      // color: Colorz.BloodTest,
      child: GestureDetector(
        onTap: onTap,
        child:

          shadowIsOn == true ?
          ClipShadowPath(
            clipper: _clipper,
            shadow: Shadowz.basicOuterShadow,
            child: BalloonComponents(
              userModel: userModel,
              pic: pic,
              child: child,
              loading: loading,
              balloonColor: balloonColor,
              balloonWidth: balloonWidth,
              blackAndWhite: blackAndWhite,
            ),
          )

              :

          ClipPath(
            clipper: _clipper,
            child: BalloonComponents(
              userModel: userModel,
              pic: pic,
              loading: loading,
              balloonColor: balloonColor,
              balloonWidth: balloonWidth,
              blackAndWhite: blackAndWhite,
              child: child,
            ),
          ),

      ),
    );
  }
}

class BalloonComponents extends StatelessWidget {
  final double balloonWidth;
  final Color balloonColor;
  final bool blackAndWhite;
  final bool loading;
  final String pic;
  final UserModel userModel;
  final Widget child;

  const BalloonComponents({
    @required this.balloonWidth,
    @required this.balloonColor,
    @required this.blackAndWhite,
    @required this.loading,
    @required this.pic,
    @required this.userModel,
    @required this.child,
});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        /// --- USER IMAGE LAYER
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
                Imagers.superImageWidget(pic == null ? userModel?.pic : pic)
                    :
                Container()
            )
        ),

        /// --- BUTTON OVAL HIGHLIGHT
        Container(
          width: 2 * balloonWidth * 0.5 * 0.7,
          height: 1.4 * balloonWidth * 0.5 * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(
                  balloonWidth * 0.8 * 0.5, balloonWidth * 0.7 * 0.8 * 0.5)),
              color: Colorz.Nothing,
              boxShadow: <CustomBoxShadow>[
                CustomBoxShadow(
                    color: Colorz.White80,
                    offset: new Offset(0, balloonWidth * 0.5 * -0.5),
                    blurRadius: balloonWidth * 0.2,
                    blurStyle: BlurStyle.normal),
              ]
          ),
        ),

        /// --- BUTTON GRADIENT
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
    );
  }
}
