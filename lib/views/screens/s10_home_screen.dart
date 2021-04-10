import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  List<TinyBz> _tinyBzz;
  List<TinyBz> _myTinyBzz;

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

      _prof.fetchAndSetTinyBzzAndTinyFlyers(context)
          .then((_) async {

            List<TinyBz> _myTinyBzzList = await _prof.getUserTinyBzz(context);

            setState(() {
              _tinyBzz = _prof.getAllTinyBzz;
              _myTinyBzz = _myTinyBzzList;
            });

        _triggerLoading();
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
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
  Widget build(BuildContext context) {
    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    // List<TinyBz> _tinyBzz = _prof.getAllTinyBzz;

    return MainLayout(
      appBarType: AppBarType.Main,
      sky: Sky.Night,
      canRefreshFlyers: true,
      myTinyBzz: _myTinyBzz,
      layoutWidget: Stack(
        children: <Widget>[
          _isLoading == true ?
          Center(child: Loading(loading: _isLoading,))
              :
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                // key: ,
                delegate: SliverChildListDelegate(<Widget>[

                  Stratosphere(),

                  // Ask(
                  //   tappingAskInfo: () {print('Ask info is tapped aho');},
                  // ),

                  BzzBubble(tinyBzz: _tinyBzz),

                  ...List<Widget>.generate(FlyerModel.flyerTypesList.length,
                          (index) {
                    return
                      FlyerStack(flyersType: FlyerModel.flyerTypesList[index]);

                  }),

                  PyramidsHorizon(heightFactor: 10),

                ]),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
