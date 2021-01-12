import 'package:bldrs/view_brains/drafters/animators.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class AnimationsScreen extends StatefulWidget {
  @override
  _AnimationsScreenState createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> with TickerProviderStateMixin{
  double width;
  double height;
  AnimationController _controller;

  @override
  void initState() {
    width = 100;
    height = 100;
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this
    );
    super.initState();
  }

  void resizeBox(){
    print('tapped aho');
    setState(() {
      width = width == 100 ? superScreenWidth(context) : 100;
      height = height == 100 ? superScreenHeight(context) : 100;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        DreamBox(
          height: 40,
          icon: Iconz.Play,
          boxMargins: EdgeInsets.all(5),
          boxFunction: resizeBox,
        ),

        DreamBox(
          height: 40,
          icon: Iconz.Pause,
          boxMargins: EdgeInsets.all(5),
          boxFunction: (){
            _controller.stop(canceled: false);
          },
        ),

        DreamBox(
          height: 40,
          icon: Iconz.Stop,
          boxMargins: EdgeInsets.all(5),
          boxFunction: (){
            _controller.reset();
          },
        ),

        DreamBox(
          height: 40,
          icon: Iconz.Clock,
          boxMargins: EdgeInsets.all(5),
          boxFunction: (){
            _controller.forward();
          },
        ),


      ],
      layoutWidget: ListView(
        children: <Widget>[

          // width > 200 ? Container() :
          ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.0).animate(_controller),
              child: Stratosphere()
          ),
          
          InkWell(
            onTap: resizeBox,
            highlightColor: Colorz.Yellow,
            splashColor: Colorz.BabyBlue,

            child: Center(
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),

                child: AnimatedContainer(
                  duration: Duration(seconds: 10),
                  curve: Curves.easeInOutCirc,
                  width: width,
                  height: height,
                  color: Colorz.BloodRed,
                  child: DreamBox(
                    height: 50,
                    icon: Iconz.ComYoutube,
                    boxFunction: (){
                      resizeBox();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
