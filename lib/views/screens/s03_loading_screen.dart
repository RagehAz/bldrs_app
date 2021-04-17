import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/s10_home_screen.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isInit = true;
  List<TinyBz> _sponsors;
  bool _canContinue = false;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    // works
    // Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();

    // hack around
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FlyersProvider>(context,listen: true).fetchAndSetBzz();
    // });

    super.initState();
  }

  /// this method of fetching provided data allows listening true or false,
  /// both working one  & the one with delay above in initState does not allow listening,
  /// i will go with didChangeDependencies as init supposedly works only at start
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading();

      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);

      // _prof.fetchAndSetTinyBzzAndTinyFlyers(context)
      _prof.fetchAndSetSponsors(context)
          .then((_) async {

            setState(() {
              _sponsors = _prof.getSponsors;
            });

            await _prof.fetchAndSetUserTinyBzz(context);

            await _prof.fetchAndSetTinyBzzAndTinyFlyers(context);

            setState(() {
              _canContinue = true;
            });


            // List<TinyBz> _myTinyBzzList = await _prof.getUserTinyBzz(context);

        // setState(() {
        //   _tinyBzz = _prof.getAllTinyBzz;
        //   _myTinyBzz = _myTinyBzzList;
        // });

        _triggerLoading();
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      // appBarType: AppBarType.,
      loading: _loading,
      layoutWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          Stratosphere(heightFactor: 0.5),

          LogoSlogan(onlyLogo: true,),

          Expanded(child: Container()),

          BzzBubble(
            tinyBzz: _sponsors,
            numberOfRows: 2,
            numberOfColumns: 3,
            title: 'Sponsored by',
            scrollDirection: Axis.vertical,
          ),


          Expanded(child: Container()),


          if (_loading == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Loading(
                size: superVerseRealHeight(context, 2, 1, null),
                loading: _loading,),

              SuperVerse(
                verse: 'Loading',
                margin: 10,
                size: 2,
              ),

            ],
          ),

          if(_canContinue == true)
            DreamBox(
              height: 40,
              verse: 'Continue',
              verseScaleFactor: 0.8,
              boxFunction: () => Nav.goToNewScreen(context, HomeScreen()),
            ),

          PyramidsHorizon(),
        ],
      ),
    );
  }
}
