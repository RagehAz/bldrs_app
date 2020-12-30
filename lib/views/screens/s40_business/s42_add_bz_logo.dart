import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/header/mini_header/mini_header_items/mini_header_strip/mini_header_strip_items/bz_logo.dart';
import 'package:bldrs/views/widgets/planet/continents.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 's43_add_bz_details.dart';



class AddBzLogoScreen extends StatelessWidget {
  final BzType bzType;

  AddBzLogoScreen({@required this.bzType});

  void gotToAddBzDetails(BuildContext ctx, BzType bzType, String bzLogo, String bzName, String bzCountry, String bzCity
      // String bzLogo, String bzName, Country bzCountry, City city
      ){
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_){
      return AddBzDetailsScreen(
        bzType: bzType,
        bzLogo: bzLogo,
        bzName: bzName,
        bzCountry: bzCountry,
        bzCity: bzCity,
      );
      },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String bzLogo = Iconz.DumBusinessLogo ;
    String bzName = 'Union & Light' ;
    String bzCountry = 'Damn Country ' ;
    String bzCity = 'Fucking city' ;

    String bzTypeString = bzTypeSingleStringer(context, bzType);

    // void tappingCity() {
    //   print('city is tapped');
    // }
    //
    // void tappingCountry() {
    //   print('country is tapped');
    // }

    return GestureDetector(
      onTap: () => minimizeKeyboardOnTapOutSite(context),
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
                      child: DreamBox(
                        height: screenHeight * 1/6,
                        width: screenWidth,
                        verse: 'Creating a $bzTypeString business account',
                        verseMaxLines: 2,
                        verseScaleFactor: 0.8,
                        secondLine: 'Add Logo, Name & Edit x_dummy_database.location',
                        bubble: false,
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

                            // --- BZ LOGO
                            Container(
                              width: 150,
                              margin: EdgeInsets.all(20),
                              child: BzLogo(
                                image: Iconz.DumBusinessLogo,
                                width: 150,
                              ),
                            ),

                            // --- BZ NAME
                             // don't forget to add the (add ™ ℠ ® © Characters) in Business data entry screen
                            SuperTextField(
                              width: screenWidth * 0.7,
                              hintText: 'Business name',
                              centered: true,
                              inputColor: Colorz.White,
                              inputShadow: false,
                              inputSize: 3,
                              inputWeight: VerseWeight.bold,
                              keyboardTextInputType: TextInputType.name,
                            ),

                            // --- LOCALE
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: SuperVerse(
                                verse: 'Business is located in',
                                size: 2,
                              ),
                            ),

                            // --- CITY - COUNTRY
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Continents()));
                              },
                              child: Wrap(
                                spacing: 0,
                                runSpacing: 0,
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.center,
                                children: <Widget>[
                                  SuperVerse(
                                    verse: bzCity,
                                    color: Colorz.Yellow,
                                    labelColor: Colorz.WhiteAir,
                                    size: 4,
                                    // labelTap: tappingCity,
                                  ),
                                  SuperVerse(
                                    verse: ',',
                                    size: 2,
                                  ),
                                  SuperVerse(
                                    verse: bzCountry,
                                    color: Colorz.Yellow,
                                    labelColor: Colorz.WhiteAir,
                                    size: 4,
                                    // labelTap: tappingCountry,
                                  ),
                                ],
                              ),
                            ),

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
                    verse: 'Next',
                    boxFunction: () => gotToAddBzDetails(context, bzType, bzLogo, bzName, bzCountry, bzCity),
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
