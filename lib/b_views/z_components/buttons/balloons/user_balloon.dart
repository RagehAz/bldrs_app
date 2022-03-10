import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_shadow_path.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserBalloon({
    @required this.userModel,
    @required this.balloonWidth,
    @required this.loading,
    this.balloonType,
    this.blackAndWhite = false,
    this.onTap,
    this.balloonColor,
    this.child,
    this.shadowIsOn = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserStatus balloonType;
  final UserModel userModel;
  final double balloonWidth;
  final bool blackAndWhite;
  final Function onTap;
  final bool loading;
  final Color balloonColor;
  final Widget child;
  final bool shadowIsOn;

  /// --------------------------------------------------------------------------
  // Color _bubbleDarkness(){
  //   return
  //     blackAndWhite == false ? Colorz.BlackSmoke :  Colorz.BlackNothing;
  // }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: true);

    return Balloona(
        balloonWidth: balloonWidth,
        onTap: onTap,
        userStatus: balloonType ?? UserStatus.normal,
        pic: userModel?.pic,
        shadowIsOn: shadowIsOn,
        loading: loading,
        balloonColor: balloonColor,
        blackAndWhite: blackAndWhite,
        child: child);

    // balloonColor == null ?
    //
    //   StreamBuilder<UserModel>(
    //     stream: _usersProvider.myUserModelStream,
    //     builder: (context, snapshot){
    //       if(snapshot.hasData == false){
    //         return Loading(
    //           size: balloonWidth,
    //           loading: true,
    //           onTap: (){},// => Nav.goToRoute(context, Routez.Starting),
    //         );
    //       } else {
    //         final UserModel userModel = snapshot.data;
    //         return
    //           Balloona(
    //               balloonWidth: balloonWidth,
    //               onTap: onTap,
    //               userStatus: balloonType,
    //               pic: userModel.pic,
    //               shadowIsOn: shadowIsOn,
    //               child: child,
    //               loading: loading,
    //               balloonColor: balloonColor,
    //               blackAndWhite: blackAndWhite
    //           );
    //       }
    //     },
    //   )
    //
    //     :
    //
    // Balloona(
    //     balloonWidth: balloonWidth,
    //     onTap: onTap,
    //     userStatus: balloonType,
    //     shadowIsOn: shadowIsOn,
    //     pic: pic,
    //     child: child,
    //     loading: loading,
    //     balloonColor: balloonColor,
    //     blackAndWhite: blackAndWhite);
  }
}

class Balloona extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Balloona({
    @required this.balloonWidth,
    @required this.pic,
    @required this.loading,
    this.onTap,
    this.shadowIsOn = false,
    this.child,
    this.balloonColor = Colorz.white10,
    this.blackAndWhite = false,
    this.userStatus = UserStatus.normal,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double balloonWidth;
  final Function onTap;
  final dynamic pic;
  final UserStatus userStatus;
  final bool shadowIsOn;
  final Widget child;
  final bool loading;
  final Color balloonColor;
  final bool blackAndWhite;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final CustomClipper _clipper = Iconizer.userBalloon(userStatus);

    return SizedBox(
      width: balloonWidth,
      height: balloonWidth,
      // color: Colorz.BloodTest,
      child: GestureDetector(
        onTap: onTap,
        child: shadowIsOn == true ?
        ClipShadowPath(
          clipper: _clipper,
          shadow: Shadowz.basicOuterShadow,
          child: BalloonComponents(
            pic: pic,
            loading: loading,
            balloonColor: balloonColor,
            balloonWidth: balloonWidth,
            blackAndWhite: blackAndWhite,
            child: child,
          ),
        )
            :
        ClipPath(
          clipper: _clipper,
          child: BalloonComponents(
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
  /// --------------------------------------------------------------------------
  const BalloonComponents({
    @required this.balloonWidth,
    @required this.blackAndWhite,
    @required this.pic,
    @required this.child,
    this.balloonColor,
    this.loading = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double balloonWidth;
  final Color balloonColor;
  final bool blackAndWhite;
  final bool loading;
  final dynamic pic;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Color _balloonColor = pic == null ? balloonColor : null;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        /// --- USER IMAGE LAYER
        Container(
            // color: Colorz.Yellow,
            width: balloonWidth,
            height: balloonWidth,
            color: _balloonColor,
            child: ColorFiltered(
                colorFilter: Colorizer.superDesaturation(
                    isItBlackAndWhite: blackAndWhite
                ),
                child: loading == true ?
                Loading(loading: loading,)
                    :
                _balloonColor == null ?
                SuperImage(
                  pic: pic,
                  width: balloonWidth,
                  height: balloonWidth,
                  fit: BoxFit.cover,
                )
                    :
                Container()
            )
        ),

        /// --- BUTTON OVAL HIGHLIGHT
        Container(
          width: 2 * balloonWidth * 0.5 * 0.7,
          height: 1.4 * balloonWidth * 0.5 * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(balloonWidth * 0.8 * 0.5, balloonWidth * 0.7 * 0.8 * 0.5)),
              color: Colorz.nothing,
              boxShadow: <CustomBoxShadow>[
                CustomBoxShadow(
                    color: Colorz.white80,
                    offset: Offset(0, balloonWidth * 0.5 * -0.5),
                    blurRadius: balloonWidth * 0.2),
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
        if (child != null)
          child,

      ],
    );
  }
}