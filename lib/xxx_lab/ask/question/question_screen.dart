import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/ask/question/ask_bubble.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      appBarType: AppBarType.basic,
      pageTitle: 'Ask a Question',
      // onBack: true,
      layoutWidget: ListView(
        children: <Widget>[

          const Stratosphere(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /// INSTRUCTIONS
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
                child: SuperVerse(
                  verse: 'Ask the Builders in your city.',
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
              //   child: SuperVerse(
              //     verse: 'searching for a property ?'
              //         '\nbuilding or finishing a project ?'
              //         '\nseeking professional help ?'
              //         '\nAsk ..'
              //         '\n& receive private replies from the Builders',
              //     color: Colorz.White50,
              //     italic: true,
              //     weight: VerseWeight.thin,
              //     size: 2,
              //     scaleFactor: 0.9,
              //     maxLines: 10,
              //     centered: false,
              //     margin: Ratioz.appBarPadding,
              //   ),
              // ),

              /// ASK BUBBLE
              QuestionBubble(
                tappingAskInfo: () {
                  blog('Ask info is tapped aho');
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
}



/// ask button in nav bar
// _spacer,
//
// /// --- ASK
// BarButton(
//   width: _buttonWidth,
//   text: Wordz.ask(context),
//   icon: Iconz.SaveOn,
//   iconSizeFactor: 0.7,
//   barType: barType,
//   onTap: () => goToNewScreen(context, AskScreen()),
//   clipperWidget : UserBalloon(
//     balloonWidth: _circleWidth,
//     balloonType: UserStatus.PlanningTalking,
//     // userPic: null,
//     balloonColor: Colorz.Nothing,
//     loading: false,
//     child: SuperVerse(
//       verse: Wordz.ask(context),
//       size: 1,
//       shadow: true,
//     ),
//   ),
// ),
