import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/collection/flyers_compact_collection.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/pyramids_horizon.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    // final pro = Provider.of<CoFlyersProvider>(context, listen: true); // this is the FlyersProvider data wormHole
    // final flyers = flyersData.hatAllFlyers;
// ----------------------------------------------------------------------------
    // List<CoFlyer> propertyFlyers  =   pro.hatCoFlyersByFlyerType(FlyerType.Property);
    // List<CoFlyer> designFlyers    =   pro.hatCoFlyersByFlyerType(FlyerType.Design);
    // List<CoFlyer> productFlyers   =   pro.hatCoFlyersByFlyerType(FlyerType.Product);
    // List<CoFlyer> projectFlyers   =   pro.hatCoFlyersByFlyerType(FlyerType.Project);
    // List<CoFlyer> craftFlyers     =   pro.hatCoFlyersByFlyerType(FlyerType.Craft);
    // List<CoFlyer> equipmentFlyers =   pro.hatCoFlyersByFlyerType(FlyerType.Equipment);
// ----------------------------------------------------------------------------
    List<FlyerType> collectionTypes = [
    FlyerType.Property,
    FlyerType.Design,
    FlyerType.Product,
    FlyerType.Project,
    FlyerType.Craft,
    FlyerType.Equipment,
    ];
// ----------------------------------------------------------------------------
    return GestureDetector(
      onTap: (){
        minimizeKeyboardOnTapOutSide(context);
        // // ANOTHER SOLUTION
        // FocusScopeNode currentFocus = FocusScope.of(context);
        // if(!currentFocus.hasPrimaryFocus){
        //   currentFocus.unfocus();
        // }
        // // ---
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          // resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[

              NightSky(),

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

                        ...List<Widget>.generate(
                            collectionTypes.length,
                            (index){
                              return
                                FlyersCompactCollection(flyersType: collectionTypes[index]);
                            }
                        ),

                        PyramidsHorizon(heightFactor: 10),
                      ]
                    ),
                  ),
                ],
              ),

              ABMain(),

              Pyramids(
                whichPyramid: Iconz.PyramidsYellow,
              ),

              // --- ADD NEW BZ ACCOUNT
              Positioned(
                bottom: 0,
                left: 0,
                child: DreamBox(
                  height: 40,
                  verse: 'Open a business account',
                  verseColor: Colorz.White,
                  boxMargins: EdgeInsets.all(10),
                  color: Colorz.WhiteAir,
                  icon: Iconz.Bz,
                  iconSizeFactor: 0.55,
                  boxFunction: (){
                    Navigator.pushNamed(context, Routez.AddBz);
                    },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

