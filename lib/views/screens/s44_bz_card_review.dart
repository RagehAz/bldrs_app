import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzCardReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;



    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              NightSky(),

              Container(
                width: screenWidth,
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    // --- PAGE HEADLINE
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: screenWidth,
                        alignment: Alignment.center,
                        // color: Colorz.Yellow,
                        child: SuperVerse(
                          verse: 'Edit your Bldrs business card',
                          centered: true,
                          italic: true,
                          size: 3,
                          weight: VerseWeight.black,
                          maxLines: 3,
                          margin: 10,
                        ),
                      ),
                    ),

                    Flexible(
                      flex: 5,
                      child: Container(
                        // color: Colorz.BloodTest,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            // MaxHeader(
                            //   flyerZoneWidth: screenWidth,
                            //   bzPageIsOn: true,
                            //   bzShowsTeam: true,
                            //   authorID: null,
                            //   coBzData: ,
                            // )

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ---  NEXT BUTTON
              Positioned(
                bottom: 70,
                  child: DreamBox(
                    height: 60,
                    width: screenWidth * 0.7,
                    verse: 'Confirm',
                    boxFunction: (){Navigator.pushNamed(context, Routez.AddBzDetails);},
                  ),

              ),

              Pyramids(
                whichPyramid: Iconz.PyramidzYellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
