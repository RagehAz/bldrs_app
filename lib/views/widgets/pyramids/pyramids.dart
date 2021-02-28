import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Pyramids extends StatefulWidget {
  final String pyramidsIcon;
  final Function onDoubleTap;
  final bool loading;

  Pyramids({
    @required this.pyramidsIcon,
    this.onDoubleTap,
    @required this.loading,
  });

  @override
  _PyramidsState createState() => _PyramidsState();
}

class _PyramidsState extends State<Pyramids> with TickerProviderStateMixin {
AnimationController _controller;
Animation _pyramidsAnimation;
int _fadeCycleDuration = 750;

  @override
  void initState() {

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _fadeCycleDuration),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.loading == true){
      _controller.repeat(reverse: true);
    } else {
      _controller.forward();
    }

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
          onDoubleTap: widget.onDoubleTap,
          onLongPress: () {
            Navigator.pushNamed(context, Routez.Obelisk);
          },
          onTap: widget.pyramidsIcon == Iconz.PyramidsYellow ? () {
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
                                Container();
                              // InPyramidsScreen(userModel: userModel);
                          } // bent el kalb dih when u comment off the Loading indicator widget part with its condition
                        },
                      );

                  }));
                }
              : widget.pyramidsIcon == Iconz.PyramidsWhite ?
              () { Navigator.pop(context); }
                  : () {},
          child: FadeTransition(
            opacity: _controller,
            child: WebsafeSvg.asset(widget.pyramidsIcon),
          ),
        ),
      ),
    );
  }
}
