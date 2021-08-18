import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {


  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth  = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    /// --- FUTURE LOADING BLOCK
    bool _loading = false;
    Future <void> _triggerLoading({Function function}) async {

      if(mounted){

        if (function == null){
          setState(() {
            _loading = !_loading;
          });
        }

        else {
          setState(() {
            _loading = !_loading;
            function();
          });
        }

      }

      _loading == true?
      print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
    }
// -----------------------------------------------------------------------------

    return MainLayout(
      appBarType: AppBarType.Basic,
      sky: Sky.Night,
      canRefreshFlyers: false,
      tappingRageh: null,
      pageTitle: 'Questions',
      loading: _loading,
      pyramids: Iconz.DvBlankSVG,
      appBarRowWidgets: [],
      layoutWidget: Column(
        children: <Widget>[

          Stratosphere(),

          Container(
            width: _screenWidth,
            height: 100,
            color: Colorz.BloodTest,
          ),



        ],
      ),
    );
  }
}
