import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/xx_questions_screen.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/walls/home_wall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final bool notiIsOn;

  HomeScreen({
    @required this.notiIsOn,
});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  List<TinyBz> _tinyBzz;
  List<TinyBz> _myTinyBzz;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
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

  // /// this method of fetching provided data allows listening true or false,
  // /// both working one  & the one with delay above in initState does not allow listening,
  // /// i will go with didChangeDependencies as init supposedly works only at start
  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     _triggerLoading();
  //
  //     FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
  //
  //     _prof.fetchAndSetTinyBzzAndTinyFlyers(context)
  //         .then((_) async {
  //
  //           List<TinyBz> _myTinyBzzList = await _prof.getUserTinyBzz(context);
  //
  //           setState(() {
  //             _tinyBzz = _prof.getAllTinyBzz;
  //             _myTinyBzz = _myTinyBzzList;
  //           });
  //
  //       _triggerLoading();
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    // List<TinyBz> _tinyBzz = _prof.getAllTinyBzz;
    // List<TinyBz> _userTinyBzz = _prof.getUserTinyBzz;

    Tracer.traceScreenBuild(screenName: 'HomeScreen');
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MainLayout(
        appBarType: AppBarType.Main,
        sky: Sky.Night,
        canRefreshFlyers: false,
        tappingRageh: () async {
          await Nav.goToNewScreen(context, QuestionsScreen());
        },
        layoutWidget: _isLoading == true ?
        Center(child: Loading(loading: _isLoading,))
            :
        HomeWall(),
      ),
    );
  }
}
