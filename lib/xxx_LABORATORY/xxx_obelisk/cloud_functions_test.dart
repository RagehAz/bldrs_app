import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart';
import 'package:bldrs/db/fire/methods/cloud_functions.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';

class CloudFunctionsTest extends StatefulWidget {
  const CloudFunctionsTest({Key key}) : super(key: key);

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
      appBarRowWidgets: <Widget>[

        DreamBox(
            height: 40,
            width: 150,
            color: Colorz.yellow255,
            verse: 'call a cloud function callable_sayHello',
            verseMaxLines: 2,
            verseScaleFactor: 0.6,
            onTap: () async {

              dynamic map = await CloudFunctionz.callFunction(
                  context: context,
                  cloudFunctionName: 'n001_notifyUser',
                  toDBMap: <String, dynamic>{
                    'from': superUserID(),
                    'to': '60a1SPzftGdH6rt15NF96m0j9Et2', // rageh by facebook
                    'title': 'Targetted notification',
                    'body': 'this is by far the first true targeted notification in this app',
                  }
              );

                print('done : map is : $map');

            }
        ),

      ],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: Ratioz.stratosphere),
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
