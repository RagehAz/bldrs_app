import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/ask/question/ask_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  // void _triggerLoading(){
  //   setState(() {_loading = !_loading;});
  //   _loading == true?
  //   print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  // }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      pageTitle: 'Ask a Question',
      // onBack: true,
      loading: _loading,
      layoutWidget: ListView(

        children: <Widget>[

          Stratosphere(),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              /// INSTRUCTIONS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
                child: SuperVerse(
                  verse: 'Ask the Builders in your city.',
                  size: 2,
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
                tappingAskInfo: () {print('Ask info is tapped aho');},
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

