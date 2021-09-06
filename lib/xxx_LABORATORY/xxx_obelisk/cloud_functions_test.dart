import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/cloud_functions.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class CloudFunctionsTest extends StatefulWidget {

  @override
  _CloudFunctionsTestState createState() => _CloudFunctionsTestState();
}

class _CloudFunctionsTestState extends State<CloudFunctionsTest> {
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;

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
  @override
  void initState() {

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here

        _triggerLoading(
            function: (){
              /// set new values here
            }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: <Widget>[

        DreamBox(
            height: 40,
            width: 150,
            color: Colorz.Yellow255,
            verse: 'call a cloud function',
            verseMaxLines: 2,
            verseScaleFactor: 0.6,
            onTap: () async {

              dynamic map = await CloudFunctionz.callFunction(
                  context: context,
                  cloudFunctionName: CloudFunctionz.callable_sayHello,
                  toDBMap: {'name' : 'FUCKING fucking FUCK',}
              );

                print('done : map is : $map');

            }
        ),

      ],

      layoutWidget: Center(
        child: GoHomeOnMaxBounce(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: Ratioz.stratosphere),
            children: <Widget>[

              DreamBox(
                height: 60,
                width: 250,
                verse: 'do thing',
                verseScaleFactor: 0.7,
                onTap: () async {





                },
              ),

            ],
          ),
        ),
      ),
    );
  }

}
