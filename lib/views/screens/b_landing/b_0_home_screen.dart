import 'package:bldrs/db/fire/methods/dynamic_links.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/walls/home_wall.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool notiIsOn;

  HomeScreen({
    @required this.notiIsOn,
});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _isInit = true;
  bool _isLoading = false;
  // List<TinyBz> _tinyBzz;
  // List<TinyBz> _myTinyBzz;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // works
    // Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();

    // hack around
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FlyersProvider>(context,listen: true).fetchAndSetBzz();
    // });

    DynamicLinksApi().initializeDynamicLinks(context);
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

    // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    // List<TinyBz> _tinyBzz = _prof.getAllTinyBzz;
    // List<TinyBz> _userTinyBzz = _prof.getUserTinyBzz;

    Tracer.traceScreenBuild(screenName: 'HomeScreen');
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MainLayout(
        appBarType: AppBarType.Main,
        sky: Sky.Night,
        canRefreshFlyers: false,
        // tappingRageh: () async {
        //   await Nav.goToNewScreen(context, QuestionScreen());
        // },
        layoutWidget: _isLoading == true ?
        Center(child: Loading(loading: _isLoading,))
            :
        HomeWall(),
      ),
    );
  }
}
