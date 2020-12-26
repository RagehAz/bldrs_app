import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 's42_add_bz_logo.dart';

class AddBzScreen extends StatelessWidget {

    void goToAddBzLogo(BuildContext ctx, BzType selectedBzType){
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_){
      return AddBzLogoScreen(bzType: selectedBzType);
      },
      ),
    );
    }


  @override
  Widget build(BuildContext context) {
    final _bzTypes = const [
      {
        'BzType': BzType.Developer,
        'color': Colorz.GreenZircon,
      },
      {
        'BzType': BzType.Broker,
        'color': Colorz.GreenZircon,
      },
      {
        'BzType': BzType.Designer,
        'color': Colorz.BloodRedZircon,
      },
      {
        'BzType': BzType.Contractor,
        'color': Colorz.BloodRedZircon,
      },
      {
        'BzType': BzType.Artisan,
        'color': Colorz.BloodRedZircon,
      },
      {
        'BzType': BzType.Manufacturer,
        'color': Colorz.LightBlueZircon,
      },
      {
        'BzType': BzType.Supplier,
        'color': Colorz.LightBlueZircon,
      },

    ];

    // final List<BzType> bzTypes = [
    //   BzType.Developer,
    //   BzType.Broker,
    //   BzType.Designer,
    //   BzType.Contractor,
    //   BzType.Artisan,
    //   BzType.Manufacturer,
    //   BzType.Supplier,
    //   BzType.Artisan
    // ];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // double questionHeight = screenHeight * 0.35;
    // double wheelHeight = screenHeight * 0.65;

    return SafeArea(
      child: Scaffold(
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

                  // --- PHARAOH
                  // Flexible(
                  //   flex: 1,
                  //   child: Container(
                  //     width: screenWidth,
                  //     // color: Colorz.YellowPlastic,
                  //     alignment: Alignment.center,
                  //     child: WebsafeSvg.asset(Iconz.Bz),
                  //   ),
                  // ),

                  // --- THE QUESTION
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: screenWidth,
                      alignment: Alignment.center,
                      // color: Colorz.Yellow,
                      child: SuperVerse(
                        verse: 'What kind of a business account would you like to open ?',
                        centered: true,
                        italic: true,
                        size: 3,
                        weight: VerseWeight.black,
                        maxLines: 3,
                        margin: 10,
                      ),
                    ),
                  ),


                  // --- BZ WHEEL
                  Flexible(
                    flex: 5,
                    child: ClipRRect(
                      child: Container(
                        width: screenWidth,
                        // height: wheelHeight,
                        alignment: Alignment.center,
                        // color: Colorz.YellowGlass,
                        child: CircleList(
                            animationSetting: AnimationSetting(
                                duration: Duration(seconds: 3),
                                curve: Curves.ease,),
                            isChildrenVertical: true,
                            showInitialAnimation: false,
                            rotateMode: RotateMode.allRotate,
                            origin: Offset((screenWidth*-0.125),0),
                            childrenPadding: 0,
                            outerRadius: (screenWidth*0.5)*1.25,
                            gradient: RadialGradient(
                              colors: [Colorz.Nothing, Colorz.WhiteAir,Colorz.Nothing],
                              stops: [0.4,0.8,1],
                            ),
                            // centerWidget: DreamBox(
                            //   height: 50,
                            //   icon: Iconz.DvRageh,
                            //
                            // ),
                            children: List.generate(
                                _bzTypes.length, (index) {
                                  return
                                    DreamBox(
                                      height: 50,
                                      width: 100,
                                      verse: bzTypeStringer(context, _bzTypes[index]['BzType']),
                                      verseWeight: VerseWeight.bold,
                                      verseScaleFactor: 0.5,
                                      boxMargins: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      verseMaxLines: 2,
                                      color: _bzTypes[index]['color'],
                                      boxFunction: ()=> goToAddBzLogo(context, _bzTypes[index]['BzType']),
                                    );
                                }
                                )
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),

            Pyramids(
              whichPyramid: Iconz.PyramidzYellow,
            ),

          ],
        ),
      ),
    );
  }
}


