import 'package:animators/animators.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class AnimationsLab extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AnimationsLab({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AnimationsLabState createState() => _AnimationsLabState();
/// --------------------------------------------------------------------------
}

class _AnimationsLabState extends State<AnimationsLab> with TickerProviderStateMixin {
  double width;
  double height;
  AnimationController _animationController;
  AnimationController _btController;
  double btWidth;
  int btDuration = 200;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    width = 100;
    height = 100;
    btWidth = 100;

    _animationController = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
    );

    _btController = AnimationController(
      duration: Duration(milliseconds: btDuration),
      vsync: this,
      lowerBound: -0.5,
      upperBound: 0.5,
    )..addListener(() {
        setState(() {});
      });
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _animationController.dispose();
    _btController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void resizeBox() {
    blog('tapped aho');
    setState(() {
      width = width == 100 ? Scale.screenWidth(context) : 100;
      height = height == 100 ? Scale.screenHeight(context) : 100;
    });
  }
// -----------------------------------------------------------------------------
  bool condition() {
    bool _condition;

    if (width > 100) {
      _condition = true;
    } else {
      _condition = false;
    }

    return _condition;
  }
// -----------------------------------------------------------------------------
  /*
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
   */
// -----------------------------------------------------------------------------
  Matrix4 getMatrix({@required bool normal}){
    if (normal == true){
      return Matrix4.identity();
    }
    else {

      final List<double> _list = <double>[
        1.2, -0.1, 0, 0,
        0.1, 1.2, 0, 0,
        0, 0, 1, 0,
        -52.5, -42, 0, 1
      ];

      return Matrix4.fromList(_list);
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    // final double _screenHeight = Scale.superScreenHeight(context);
    final double _btCorner = btWidth * 0.2;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      appBarRowWidgets: <Widget>[

        BldrsBox(
          height: 40,
          icon: Iconz.play,
          margins: const EdgeInsets.all(5),
          onTap: resizeBox,
        ),

        BldrsBox(
          height: 40,
          icon: Iconz.pause,
          margins: const EdgeInsets.all(5),
          onTap: () {
            _animationController.stop(canceled: false);
          },
        ),

        BldrsBox(
          height: 40,
          icon: Iconz.stop,
          margins: const EdgeInsets.all(5),
          onTap: () {
            _animationController.reset();
          },
        ),

        BldrsBox(
          height: 40,
          icon: Iconz.clock,
          margins: const EdgeInsets.all(5),
          onTap: () {
            _animationController.forward();
          },
        ),
        const Expander(),
        BldrsBox(
          height: 40,
          icon: Iconz.bldrsNameEn,
          iconSizeFactor: 0.7,
          margins: const EdgeInsets.all(5),
          onTap: () async {


            // final Matrix4 _identity = Matrix4.identity();

            // blog(_identity.row0);

            // final List<double> _list = _identity.storage;

            // blog(_list);

            // final Matrix4 _again = Matrix4.fromList(_list);

            // blog(_again);

            final Matrix4 _endMatrix = getMatrix(normal: false);
            blog(_endMatrix);

            blog(_endMatrix.storage);

            /*
                  [0] 1.4939111513823777,0.38717771757102626,0.0,0.0
                  [1] -0.38717771757102626,1.4939111513823777,0.0,0.0
                  [2] 0.0,0.0,1.0,0.0
                  [3] -0.5227380792108395,-132.9740691922929,0.0,1.0

                  1.4939111513823777,-0.38717771757102626,0.0,-0.5227380792108395,
                  0.38717771757102626,1.4939111513823777,0.0,-132.9740691922929,
                  0.0,0.0,1.0,0.0,
                  0.0,0.0,0.0,1.0,

             */


            setState(() {

            });

          },
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.only(top: Ratioz.stratosphere),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          Container(
            width: _screenWidth,
            height: _screenWidth,
            color: Colorz.black255,
            alignment: Alignment.center,
            child: AnimateWidgetToMatrix(
              matrix: getMatrix(normal: false),
              child: Container(
                width: 100,
                height: FlyerDim.flyerHeightByFlyerWidth(
                  flyerBoxWidth: 100,
                  forceMaxHeight: false,
                ),
                color: Colorz.bloodTest,
                alignment: Alignment.center,
                child: BldrsImage(
                  width: 100,
                  height: FlyerDim.flyerHeightByFlyerWidth(
                    flyerBoxWidth: 100,
                    forceMaxHeight: false,
                  ),
                  fit: BoxFit.fitWidth,
                  pic: Iconz.dvRageh,
                ),
              ),
            ),
          ),

          InkWell(
            onTap: resizeBox,
            highlightColor: Colorz.yellow255,
            splashColor: Colorz.blue255,
            child: Center(
              child: RotationTransition(
                turns: Tween<double>(begin: 0, end: 1).animate(_animationController),
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
                          left: condition() == true ? (Scale.screenWidth(context) * 0.5)
                              : 0,
                          duration: const Duration(seconds: 1),
                          child: BldrsBox(
                            height: 50,
                            icon: Iconz.comYoutube,
                            onTap: () {
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
            width: _screenWidth,
            height: _screenWidth,
            color: Colorz.black230,
            alignment: Alignment.center,
            child: BldrsBox(
              width: 200,
              height: 200,
              icon: Iconz.clock,
              color: Colorz.yellow255,
              splashColor: Colorz.darkRed125,
              onTap: () {
                blog('ripple effect works now');
                Navigator.push(
                    context,
                    MaterialPageRoute<HeroMax>(
                        builder: (BuildContext context) => const HeroMax()));
              },
            ),
          ),

          const TweenTest(),

          SizedBox(
            width: 300,
            height: 300,
            child: Hero(
              tag: 'unique tag aho',
              child: BldrsBox(
                height: 100,
                icon: Iconz.dvDonaldDuck,
                verse: const Verse(
                  id: 'ana ho',
                  translate: false,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<HeroMax>(
                          builder: (BuildContext context) => const HeroMax()));
                },
              ),
            ),
          ),

          Container(
            width: _screenWidth,
            height: _screenWidth,
            color: Colorz.blue80,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  btWidth = 80;
                  Future<void>.delayed(Duration(milliseconds: btDuration), () {
                    setState(() {
                      btWidth = 100;
                    });
                  });
                });
                blog('onTap');
              },
              // onTapCancel: (){blog('onTapCancel');},
              // onDoubleTap: (){blog('onDoubleTap');},
              // onDoubleTapCancel: (){blog('onDoubleTapCancel');},
              // onHorizontalDragCancel: (){blog('onHorizontalDragCancel');},
              onTapDown: (TapDownDetails details) {
                // _btController.forward();
                setState(() {
                  btWidth = 85;
                  Future<void>.delayed(Duration(milliseconds: btDuration), () {
                    setState(() {
                      btWidth = 90;
                    });
                  });
                });
              },
              onTapUp: (TapUpDetails details) {
                // _btController.reverse();
                setState(() {
                  btWidth = 105;
                  Future<void>.delayed(Duration(milliseconds: btDuration), () {
                    setState(() {
                      btWidth = 100;
                    });
                  });
                });
              },
              // onLongPress: (){
              //   blog('onLongPress');
              //   setState(() {
              //     btWidth = 80;
              //   });
              //   },
              // onLongPressUp: (){
              //   blog('onLongPressUp');
              //   setState(() {
              //     btWidth = 105;
              //     Future.delayed(Duration(milliseconds: btDuration), (){
              //       setState(() {
              //         btWidth = 100;
              //       });
              //     });
              //   });
              //   },
              // onPanCancel: (){blog('onPanCancel');},
              // onSecondaryLongPress: (){blog('onSecondaryLongPress');},
              // onSecondaryLongPressUp: (){blog('onSecondaryLongPressUp');},
              // onSecondaryTap: (){blog('onSecondaryTap');},
              // onSecondaryTapCancel: (){blog('onSecondaryTapCancel');},
              // onTertiaryTapCancel: (){blog('onTertiaryTapCancel');},
              // onVerticalDragCancel: (){blog('onVerticalDragCancel');},
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
                    image: const DecorationImage(
                        image: AssetImage(
                            Iconz.dvDonaldDuck,
                            // package: Iconz.bldrsTheme,
                        ),
                        fit: BoxFit.fitHeight,
                    ),
                    borderRadius: Borderers.cornerOnly(
                        appIsLTR: UiProvider.checkAppIsLeftToRight(context),
                        enTopLeft: _btCorner,
                        enBottomLeft: _btCorner,
                        enBottomRight: _btCorner,
                        enTopRight: _btCorner),
                  ),
                ),
              ),
            ),
          ),

          const Horizon(),
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
    final double screenWidth = Scale.screenWidth(context);

    return Container(
      width: screenWidth,
      height: screenWidth * 0.5,
      color: Colorz.bloodTest,
      alignment: Alignment.topCenter,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 5),
        builder: (BuildContext context, double _val, Widget child) {
          return Opacity(
            opacity: _val,
            child: Padding(
              padding: EdgeInsets.only(top: _val * 100),
              child: child,
            ),
          );
        },
        child: const BldrsText(
          verse: Verse(
            id: 'WTF is this',
            translate: false,
          ),
          size: 4,
        ),
      ),
    );
  }
}

class HeroMax extends StatelessWidget {
  const HeroMax({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramidsAreOn: true,
      child: Center(
        child: SizedBox(
          width: 400,
          height: 300,
          child: Hero(
            tag: 'unique tag aho',
            child: BldrsBox(
              height: 150,
              icon: Iconz.dvDonaldDuck,
              verse: const Verse(
                id: 'ana ho',
                translate: false,
              ),
              verseMaxLines: 2,
              onTap: () {
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
