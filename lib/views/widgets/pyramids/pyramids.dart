import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/s11_inpyramids_screen.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Pyramids extends StatelessWidget {
  final String whichPyramid;
  final Function onDoubleTap;

  Pyramids({
    @required this.whichPyramid,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserModel>(context);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: Ratioz.ddPyramidsWidth,
        height: Ratioz.ddPyramidsHeight,
        padding: EdgeInsets.all(0),
//          color: Ratioz.ccBloodTest,
//           alignment: Alignment.bottomRight,

        child: GestureDetector(
          onDoubleTap: onDoubleTap,
          onLongPress: () {
            Navigator.pushNamed(context, Routez.Obelisk);
          },
          onTap: whichPyramid == Iconz.PyramidsYellow ? () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return

                      StreamBuilder<UserModel>(
                        stream: UserProvider(userID: _user.userID).userData,
                        builder: (context, snapshot){
                          if(snapshot.hasData == false){
                            return LoadingFullScreenLayer();
                          } else {
                            UserModel userModel = snapshot.data;
                            return
                              InPyramidsScreen(userModel: userModel);
                          } // bent el kalb dih when u comment off the Loading indicator widget part with its condition
                        },
                      );

                  }));
                }
              : whichPyramid == Iconz.PyramidsWhite ?
              () { Navigator.pop(context); }
                  : () {},
          child: WebsafeSvg.asset(whichPyramid),
        ),
      ),
    );
  }
}
