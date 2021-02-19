import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'clip_shadow_path.dart';

class UserBalloon extends StatelessWidget {
  final UserStatus userStatus;
  final double balloonWidth;
  final bool blackAndWhite;
  final Function onTap;
  final bool loading;
  final Color balloonColor;

  UserBalloon({
    @required this.userStatus,
    @required this.balloonWidth,
    this.blackAndWhite = false,
    @required this.onTap,
    @required this.loading,
    this.balloonColor,
  });

  Color _bubbleDarkness(){
    return
      blackAndWhite == false ? Colorz.BlackLingerie :  Colorz.BlackNothing;
  }

  Widget _balloon([UserModel userModel]){
    return
      GestureDetector(
        onTap: onTap,
        child: ClipShadowPath(
          clipper: userBalloon(userStatus),
          shadow: BoxShadow(
            color: Colorz.BlackLingerie,
            offset: Offset(0, balloonWidth * -0.019),
            spreadRadius: balloonWidth * 0.15,
          ),
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
                      colorFilter: superDesaturation(blackAndWhite),
                      child:
                      loading ?
                      Loading()
                          :
                      balloonColor == null?
                      superImageWidget(userModel?.pic)
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
              Container(
                height: balloonWidth,
                width: balloonWidth,
                decoration: BoxDecoration(
                  gradient:
                  RadialGradient(
                    colors: <Color>[_bubbleDarkness(), Colorz.BlackNothing],
                    stops: <double>[0.0, 0.3],
                    radius: 1,
                    center: const Alignment(0, 0),
                    focal: const Alignment(0, 0),
                    focalRadius: 0.5,
                    tileMode: TileMode.mirror,

                  ),

                ),

              ),

            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserModel>(context);

    return
    balloonColor == null ?

      StreamBuilder<UserModel>(
        stream: UserProvider(userID: _user.userID).userData,
        builder: (context, snapshot){
          if(snapshot.hasData == false){
            return Loading(size: balloonWidth,);
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
