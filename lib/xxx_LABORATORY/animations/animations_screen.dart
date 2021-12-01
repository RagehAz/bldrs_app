import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/animations/animated_dream_box.dart';
import 'package:flutter/material.dart';

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({Key key}) : super(key: key);

  @override
  _AnimationsScreenState createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> with TickerProviderStateMixin {
  double width;
  double height;
  AnimationController _controller;
  AnimationController _btController;
  double btWidth;
  int btDuration = 200;

  @override
  void initState() {
    super.initState();
    width = 100;
    height = 100;
    btWidth = 100;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this
    );
    _btController = AnimationController(
      duration: Duration(milliseconds: btDuration),
      vsync: this,

      lowerBound: -0.5,
      upperBound: 0.5,

    )..addListener(() {
      setState(() {

      });
    });
  }

  void resizeBox(){
    print('tapped aho');
    setState(() {
      width = width == 100 ? Scale.superScreenWidth(context) : 100;
      height = height == 100 ? Scale.superScreenHeight(context) : 100;
    });
  }

  bool condition(){
    bool condition = width > 100 ? true : false;
    return condition;
  }

  // void animateBT(){
  //   setState(() {
  //     btWidth == 100 ? btWidth = 80 : btWidth = 100;
  //     Future.delayed(Duration(milliseconds: btDuration), (){
  //       setState(() {
  //         btWidth == 100 ? btWidth = 80 : btWidth = 100;
  //       });
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    double screenWidth = Scale.superScreenWidth(context);
    double btCorner = btWidth * 0.2;

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      appBarRowWidgets: <Widget>[

        DreamBox(
          height: 40,
          icon: Iconz.Play,
          margins: const EdgeInsets.all(5),
          onTap: resizeBox,
        ),

        DreamBox(
          height: 40,
          icon: Iconz.Pause,
          margins: const EdgeInsets.all(5),
          onTap: (){
            _controller.stop(canceled: false);
          },
        ),

        DreamBox(
          height: 40,
          icon: Iconz.Stop,
          margins: const EdgeInsets.all(5),
          onTap: (){
            _controller.reset();
          },
        ),

        DreamBox(
          height: 40,
          icon: Iconz.Clock,
          margins: const EdgeInsets.all(5),
          onTap: (){
            _controller.forward();
          },
        ),


      ],
      layoutWidget: ListView(
        children: <Widget>[

          // width > 200 ? Container() :
          // ScaleTransition(
          //   scale: Tween(begin: 1.0, end: 0.0).animate(_controller),
          //     child: const Stratosphere()
          // ),
          
          InkWell(
            onTap: resizeBox,
            highlightColor: Colorz.yellow255,
            splashColor: Colorz.blue225,

            child: Center(
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),

                child: AnimatedOpacity(
                  opacity: condition() == true ? 1 : 0.2,
                  duration: const Duration(seconds: 1),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOutCirc,
                    width: width,
                    height: height,
                    margin: EdgeInsets.only(top: condition() == true ? 0 : Ratioz.stratosphere),
                    color: condition() == true ? Colorz.red255 : Colorz.yellow255,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        AnimatedPositioned(
                          left: condition() == true ? (Scale.superScreenWidth(context) * 0.5) : 0,
                          duration: const Duration(seconds: 1),
                          child: DreamBox(
                            height: 50,
                            icon: Iconz.ComYoutube,
                            onTap: (){
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

          const Stratosphere(),
          
          Container(
            width: screenWidth,
            height: screenWidth,
            color: Colorz.black230,
            alignment: Alignment.center,
            child: DreamBox(
              width: 200,
              height: 200,
              icon: Iconz.Clock,
              color: Colorz.yellow255,
              splashColor: Colorz.darkRed125,
              underLine: 'Ripple Effect\n Works Now',
              underLineColor: Colorz.black230,
              onTap: (){
                print('ripple effect works now');
                Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) => const HeroMax())
                );
                },
            ),
          ),

          const TweenTest(),

          Container(
            width: 300,
            height: 300,
            child: Hero(
              tag: 'unique tag aho',

              child: DreamBox(
                height: 100,
                icon: Iconz.DvDonaldDuck,
                verse: 'ana ho',
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HeroMax())
                  );
                },
              ),
            ),
          ),

          Container(
            width: screenWidth,
            height: screenWidth,
            color: Colorz.blue80,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  btWidth = 80;
                  Future.delayed(Duration(milliseconds: btDuration), (){setState(() {
                    btWidth = 100;
                  });});

                });
                print('onTap');
                },
              // onTapCancel: (){print('onTapCancel');},
              // onDoubleTap: (){print('onDoubleTap');},
              // onDoubleTapCancel: (){print('onDoubleTapCancel');},
              // onHorizontalDragCancel: (){print('onHorizontalDragCancel');},
              onTapDown: (TapDownDetails details){
                // _btController.forward();
                setState(() {
                  btWidth = 85;
                  Future.delayed(Duration(milliseconds: btDuration), (){setState(() {
                    btWidth = 90;
                  });});
                });
              },
              onTapUp: (TapUpDetails details){
                // _btController.reverse();
                setState(() {
                  btWidth = 105;
                  Future.delayed(Duration(milliseconds: btDuration), (){setState(() {
                    btWidth = 100;
                  });});

                });
              },
              // onLongPress: (){
              //   print('onLongPress');
              //   setState(() {
              //     btWidth = 80;
              //   });
              //   },
              // onLongPressUp: (){
              //   print('onLongPressUp');
              //   setState(() {
              //     btWidth = 105;
              //     Future.delayed(Duration(milliseconds: btDuration), (){
              //       setState(() {
              //         btWidth = 100;
              //       });
              //     });
              //   });
              //   },
              // onPanCancel: (){print('onPanCancel');},
              // onSecondaryLongPress: (){print('onSecondaryLongPress');},
              // onSecondaryLongPressUp: (){print('onSecondaryLongPressUp');},
              // onSecondaryTap: (){print('onSecondaryTap');},
              // onSecondaryTapCancel: (){print('onSecondaryTapCancel');},
              // onTertiaryTapCancel: (){print('onTertiaryTapCancel');},
              // onVerticalDragCancel: (){print('onVerticalDragCancel');},
              // onForcePressStart: (){},
              // onForcePressUpdate: (){},
              // onHorizontalDragEnd: (){},
              // onHorizontalDragStart: (){},
              // onHorizontalDragUpdate: (){},
              // onLongPressEnd: (){},
              // onLongPressMoveUpdate: (){},
              // onLongPressStart: (){},
              // onPanDown: (){},
              // onPanEnd: (){},
              // onPanStart: (){},
              // onPanUpdate: (){},
              // onScaleEnd: (){},
              // onScaleStart: (){},
              // onScaleUpdate: (){},
              // onSecondaryLongPressEnd: (){},
              // onSecondaryLongPressMoveUpdate: (){},
              // onSecondaryLongPressStart: (){},
              // onSecondaryTapDown: (){},
              // onTapDown: (){},
              // onSecondaryTapUp: (){},
              // onTapUp: (){},
              // onTertiaryTapDown: (){},
              // onTertiaryTapUp: (){},
              // onVerticalDragDown: (){},
              // onForcePressPeak: (){},
              // onHorizontalDragDown: (){},
              // onForcePressEnd: (){},
              // onDoubleTapDown: (){},
              // onVerticalDragEnd: (){},
              // onVerticalDragStart: (){},
              // onVerticalDragUpdate: (){},

              child: Transform.scale(
                scale: 1 - _btController.value,

                child: AnimatedContainer(
                  duration: Duration(milliseconds: btDuration),
                  curve: Curves.easeInOutQuint, // easeInOutBack was good
                  width: btWidth,
                  height: btWidth,
                  decoration: BoxDecoration(
                    color: Colorz.yellow80,
                    image: const DecorationImage(image: const AssetImage(Iconz.DumAuthorPic), fit: BoxFit.fitHeight),
                    borderRadius: Borderers.superBorderOnly(context: context, enTopLeft: btCorner, enBottomLeft: btCorner, enBottomRight: btCorner, enTopRight: btCorner),
                  ),
                ),
              ),
            ),
          ),

          AnimatedDreamBox(
            height: 100,
            width: 100,
            icon: Iconz.DvGouran,
            iconSizeFactor: 0.5,
            corners: 35,
            boxMargins: const EdgeInsets.all(20),
            boxFunction: (){},
            ),

          const PyramidsHorizon(),

        ],
      ),
    );
  }
}

/// tween animation like this requires being in separate stateless widget but
/// restarts each time widget rebuilds
class TweenTest extends StatelessWidget {
  const TweenTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = Scale.superScreenWidth(context);

    return Container(
      width: screenWidth,
      height: screenWidth * 0.5,
      color: Colorz.bloodTest,
      alignment: Alignment.topCenter,
      child: TweenAnimationBuilder(
        child: SuperVerse(
          verse: 'WTF is this',
          size: 4,
        ),
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 5),
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
  const HeroMax({Key key}) : super(key: key);

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
              onTap: (){
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
