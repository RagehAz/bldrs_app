import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Pyramids extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const Pyramids({
    @required this.pyramidsIcon,
    @required this.loading,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String pyramidsIcon;
  final bool loading;

  /// --------------------------------------------------------------------------
  @override
  _PyramidsState createState() => _PyramidsState();

  /// --------------------------------------------------------------------------
}

class _PyramidsState extends State<Pyramids> with TickerProviderStateMixin {
  AnimationController _controller;
// Animation _pyramidsAnimation;
  static const int _fadeCycleDuration = 750;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _fadeCycleDuration),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.loading == true) {
      _controller.repeat(reverse: true);
    } else {
      _controller.forward();
    }

    // final _user = Provider.of<UserModel>(context);

    return Positioned(
      key: widget.key,
      bottom: 0,
      right: 0,
      child: SizedBox(
        width: Ratioz.pyramidsWidth,
        height: Ratioz.pyramidsHeight,
        // padding: const EdgeInsets.all(0),
        // color: Ratioz.ccBloodTest,
        // alignment: Alignment.bottomRight,

        child: GestureDetector(
          /// TASK : REMOVE THIS ON RELEASE
          onLongPress: () {
            Navigator.pushNamed(context, Routez.obelisk);
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
