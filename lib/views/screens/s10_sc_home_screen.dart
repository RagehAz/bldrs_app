import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

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

