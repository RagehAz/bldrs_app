import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
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
      Provider.of<FlyersProvider>(context, listen: true)
          .fetchAndSetBzz(context)
          .then((_) {
        _triggerLoading();
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _triggerLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    FlyersProvider prof = Provider.of<FlyersProvider>(context, listen: true);
    List<BzModel> bzz = prof.getAllBzz;

    return MainLayout(
      appBarType: AppBarType.Main,
      sky: Sky.Night,
      canRefreshFlyers: true,
      // tappingRageh: () => goToRoute(context, Routez.Obelisk),
      layoutWidget: Stack(
        children: <Widget>[
          _isLoading == true ?
          Center(child: Loading())
              :
          CustomScrollView(
            slivers: <Widget>[
              SliverList(
                // key: ,
                delegate: SliverChildListDelegate(<Widget>[

                  Stratosphere(),

                  Ask(
                    tappingAskInfo: () {print('Ask info is tapped aho');},
                  ),

                  BzzBubble(bzz: bzz),

                  ...List<Widget>.generate(flyerTypesList.length,
                          (index) {
                    return FlyerStack(flyersType: flyerTypesList[index]);
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
