import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SuperRage7Screen extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SuperRage7Screen({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    return MainLayout(
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      loading: ValueNotifier(true),
      appBarType: AppBarType.basic,
      title: Verse.plain('Rageh Azzazi'),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Center(
            child: WidgetFader(
              fadeType: FadeType.repeatAndReverse,
              duration: const Duration(milliseconds: 100),
              builder: (double value, Widget child){

                // blog('building : value : $value');

                if (value < 0.5){
                  return  const SuperImage(
                    width: 250,
                    height: 250,
                    pic: Iconz.dvRageh2,
                    corners: 50,
                  );
                }
                else {
                  return  const SuperImage(
                    width: 250,
                    height: 250,
                    pic: Iconz.dvRageh,
                    corners: 50,
                  );
                }

              },
            ),
          ),

          Positioned(
            top: _screenHeight * 0.5 - 125,
            left: _screenWidth * 0.5 + 60,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: const <Widget>[

                  Balloona(
                    loading: false,
                    balloonWidth: 150,
                    balloonType: BalloonType.speaking,
                    balloonColor: Colorz.white255,
                    shadowIsOn: true,
                  ),

                  Padding(
                    padding: EdgeInsets.all(25),
                    child: TalkingBalloon(
                      lines: <String>[

                        'We reached testing phase',
                        'and will come out on stores soon',
                        'if you see this message',
                        'that means that',
                        'you are super special to my heart',
                        'and your opinion matters to me',
                        'so',
                        'I will be posting here',
                        'asking specific questions',
                        'and your feedback will change the world',
                        'but for now',
                        'This is a Heads up',
                        'on WHAT IS GOING ON ?',

                      ],
                    ),

                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class TalkingBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TalkingBalloon({
    @required this.lines,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> lines;
  /// --------------------------------------------------------------------------
  static TextStyle getStyle({
    @required BuildContext context,
  }){
    return SuperVerse.createStyle(
      context: context,
      color: Colorz.black255,
      size: 3,
      scaleFactor: 0.9,
      weight: VerseWeight.bold,
    );
  }
// --------------------
  static TypewriterAnimatedText generateLine({
    @required BuildContext context,
    @required String text,
  }){
    return TypewriterAnimatedText(
      text,
      speed: const Duration(milliseconds: 100),
      textAlign: TextAlign.center,
      curve: Curves.easeOut,
      textStyle: getStyle(context: context),
      cursor: '',
    );
  }
// --------------------
  static List<TypewriterAnimatedText> generateLines({
    @required BuildContext context,
    @required List<String> lines,
  }){
    final List<TypewriterAnimatedText> _lines = <TypewriterAnimatedText>[];

    if (Mapper.checkCanLoopList(lines) == true){

      for (final String line in lines){
        final TypewriterAnimatedText _line = generateLine(
          context: context,
          text: line,
        );
        _lines.add(_line);
      }

    }

    return _lines;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return AnimatedTextKit(
      displayFullTextOnTap: true,
      // isRepeatingAnimation: true,
      // onFinished: (){
      //   blog('finished type writer');
      // },
      onNext: (int x, bool what){
        blog('onNext : x : $x : what : $what');
      },
      onNextBeforePause: (int x, bool what){
        blog('onNextBeforePause : x : $x : what : $what');
      },
      // pause: const Duration(seconds: 2),
      repeatForever: true,
      stopPauseOnTap: true,
      totalRepeatCount: 10,
      onTap: (){
        blog('animated text is tapped');
      },
      animatedTexts: <AnimatedText>[

        ...generateLines(
            context: context,
            lines: lines
        ),

      ],
    );
  }
  // -----------------------------------------------------------------------------
}
