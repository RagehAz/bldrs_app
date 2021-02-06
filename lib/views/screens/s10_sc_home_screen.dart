import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 's51_sc_bz_card_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;

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
    if(_isInit){
      Provider.of<FlyersProvider>(context,listen: true)?.fetchAndSetBzz();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    FlyersProvider prof = Provider.of<FlyersProvider>(context, listen: true);
    List<BzModel> bzz = prof.getAllBzz;

    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      appBarType: AppBarType.Main,
      sky: Sky.Night,
      layoutWidget: Stack(
        children: <Widget>[

          CustomScrollView(
            slivers: <Widget>[

              SliverList(
                // key: ,
                delegate: SliverChildListDelegate(
                    <Widget>[

                      Stratosphere(),

                      Ask(
                        tappingAskInfo: (){print('Ask info is tapped aho');},
                      ),

                      InPyramidsBubble(

                        columnChildren: <Widget>[

                          // --- Title
                          SuperVerse(
                            verse: 'Businesses',
                          ),

                          BzGrid(
                            gridZoneWidth: superBubbleClearWidth(context),
                            bzz: bzz,
                            numberOfColumns: 5,
                            itemOnTap: (bzID)=> goToNewScreen(context, BzCardScreen(bzID: bzID,))
                          ),

                        ],
                      ),

                      ...List<Widget>.generate(flyerTypesList.length,
                              (index){
                            return
                              FlyerStack(flyersType: flyerTypesList[index]);
                          }
                      ),

                      PyramidsHorizon(heightFactor: 10),

                    ]
                ),
              ),
            ],
          ),

          // --- ADD NEW BZ ACCOUNT
          Positioned(
            bottom: 0,
            left: 0,
            child: DreamBox(
              height: 40,
              verse: Wordz.createBzAccount(context),
              verseColor: Colorz.White,
              boxMargins: EdgeInsets.all(10),
              color: Colorz.WhiteAir,
              icon: Iconz.Bz,
              iconSizeFactor: 0.55,
              boxFunction: (){
                goToRoute(context, Routez.CreateBz);
              },
            ),
          )

        ],
      ),
    );


  }
}

