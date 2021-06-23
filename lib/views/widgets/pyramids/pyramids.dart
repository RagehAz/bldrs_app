import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
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

    // final _user = Provider.of<UserModel>(context);

    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: Ratioz.pyramidsWidth,
        height: Ratioz.pyramidsHeight,
        padding: EdgeInsets.all(0),
//          color: Ratioz.ccBloodTest,
//           alignment: Alignment.bottomRight,

        child: GestureDetector(
          onDoubleTap: widget.onDoubleTap,
          onLongPress: () {
            Navigator.pushNamed(context, Routez.Obelisk);
          },

          // onTap: widget.pyramidsIcon == Iconz.PyramidsYellow ? () {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) {
          //           return
          //
          //             StreamBuilder<UserModel>(
          //               stream: UserProvider(userID: _user.userID).userData,
          //               builder: (context, snapshot){
          //                 if(snapshot.hasData == false){
          //                   return LoadingFullScreenLayer();
          //                 } else {
          //                   UserModel userModel = snapshot.data;
          //                   return
          //                       Container();
          //                     // InPyramidsScreen(userModel: userModel);
          //                 }
          //               },
          //             );
          //
          //         }));
          //       }
          //     : widget.pyramidsIcon == Iconz.PyramidsWhite ?
          //     () { Navigator.pop(context); }
          //         : () {},

          child: FadeTransition(
            opacity: _controller,
            child: WebsafeSvg.asset(widget.pyramidsIcon),
          ),
        ),
      ),
    );
  }
}
