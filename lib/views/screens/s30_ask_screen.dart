import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/ask/ask_screen.dart';
import 'package:flutter/material.dart';

import 's30_chat_screen.dart';

class AskScreen extends StatefulWidget {
  @override
  _AskScreenState createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {

  // ----------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
  // ----------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      pageTitle: 'Ask a Question',
      appBarBackButton: true,
      loading: _loading,
      layoutWidget: ListView(

        children: <Widget>[

          Stratosphere(),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // --- INSTRUCTIONS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin * 2),
                child: SuperVerse(
                  verse: 'Ask the Builders in your city.',
                  size: 2,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin * 2),
                child: SuperVerse(
                  verse: 'searching for a property ?'
                      '\nbuilding or finishing a project ?'
                      '\nseeking professional help ?'
                      '\nAsk ..'
                      '\n& receive private replies from the Builders',
                  color: Colorz.WhiteLingerie,
                  italic: true,
                  weight: VerseWeight.thin,
                  size: 2,
                  scaleFactor: 0.9,
                  maxLines: 10,
                  centered: false,
                  margin: Ratioz.ddAppBarPadding,
                ),
              ),

              // --- ASK BUBBLE
              Ask(
                tappingAskInfo: () {print('Ask info is tapped aho');},
              ),

            ],
          ),




          /// my asks bubbles
          ///
          ///
          /// temp

        ],
      ),
    );
  }
}
