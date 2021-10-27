import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';

class TestLab extends StatefulWidget {

  @override
  _TestLabState createState() => _TestLabState();
}

class _TestLabState extends State<TestLab> {

  ScrollController _ScrollController;

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
    _ScrollController = new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here
        ///
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

      ],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _ScrollController,
            children: <Widget>[

              const Stratosphere(),

              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'move continents',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    final Map<String, dynamic> _map = await Fire.readDoc(context: context, collName: 'admin', docName: 'continents');

                    await Fire.createNamedDoc(context: context, collName: FireColl.zones, docName: FireDoc.zones_continents, input: _map);

                    _triggerLoading();

                  }
              ),



            ],
          ),
        ),
      ),
    );
  }


}
