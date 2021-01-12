import 'package:bldrs/view_brains/drafters/animators.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AnimationsScreen extends StatefulWidget {
  @override
  _AnimationsScreenState createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> with TickerProviderStateMixin {
  double width;
  double height;
  AnimationController _controller;
  AnimationController _controllerB;

  @override
  void initState() {
    width = 100;
    height = 100;
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );
    // _controllerB = AnimationController(
    //   duration: Duration(seconds: 1),
    //   vsync:
    // );
    super.initState();
  }

  void resizeBox(){
    print('tapped aho');
    setState(() {
      width = width == 100 ? superScreenWidth(context) : 100;
      height = height == 100 ? superScreenHeight(context) : 100;
    });
  }

  bool condition(){
    bool condition = width > 100 ? true : false;
    return condition;
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
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
          // ScaleTransition(
          //   scale: Tween(begin: 1.0, end: 0.0).animate(_controller),
          //     child: Stratosphere()
          // ),
          
          InkWell(
            onTap: resizeBox,
            highlightColor: Colorz.Yellow,
            splashColor: Colorz.BabyBlue,

            child: Center(
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),

                child: AnimatedOpacity(
                  opacity: condition() == true ? 1 : 0.2,
                  duration: Duration(seconds: 1),
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutCirc,
                    width: width,
                    height: height,
                    margin: EdgeInsets.only(top: condition() == true ? 0 : Ratioz.stratosphere),
                    color: condition() == true ? Colorz.BloodRed : Colorz.Yellow,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        AnimatedPositioned(
                          left: condition() == true ? (superScreenWidth(context) * 0.5) : 0,
                          duration: Duration(seconds: 1),
                          child: DreamBox(
                            height: 50,
                            icon: Iconz.ComYoutube,
                            boxFunction: (){
                              resizeBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Stratosphere(),
          
          Container(
            width: screenWidth,
            height: screenWidth,
            color: Colorz.BlackBlack,
            alignment: Alignment.center,
            child: DreamBox(
              width: 200,
              height: 200,
              icon: Iconz.Clock,
              color: Colorz.Yellow,
              splashColor: Colorz.DarkRedPlastic,
              underLine: 'Ripple Effect\n Works Now',
              underLineColor: Colorz.BlackBlack,
              underLineLabelColor: Colorz.YellowLingerie,
              boxFunction: (){
                print('ripple effect works now');
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => HeroMax())
                );
                },
            ),
          ),

          TweenTest(),

          Container(
            width: 300,
            height: 300,
            child: Hero(
              tag: 'unique tag aho',

              child: DreamBox(
                height: 100,
                icon: Iconz.DvDonaldDuck,
                verse: 'ana ho',
                boxFunction: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HeroMax())
                  );
                },
              ),
            ),
          ),

          PyramidsHorizon(heightFactor: 5,),


        ],
      ),
    );
  }
}

/// tween animation like this requires being in separate stateless widget but
/// restarts each time widget rebuilds
class TweenTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);

    return Container(
      width: screenWidth,
      height: screenWidth * 0.5,
      color: Colorz.BloodTest,
      alignment: Alignment.topCenter,
      child: TweenAnimationBuilder(
        child: SuperVerse(
          verse: 'WTF is this',
          size: 4,
        ),
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(seconds: 5),
        builder: (BuildContext context, double _val, Widget child){
          return Opacity(
            opacity: _val,
            child: Padding(
              padding: EdgeInsets.only(top: (_val * 100)),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class HeroMax extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: Center(
        child: Container(
          width: 400,
          height: 300,
          child: Hero(
            tag: 'unique tag aho',
            child: DreamBox(
              height: 150,
              icon: Iconz.DvDonaldDuck,
              verse: 'ana ho',
              verseMaxLines: 2,
              boxFunction: (){
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AnimationsScreen());
                // );
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
  }
