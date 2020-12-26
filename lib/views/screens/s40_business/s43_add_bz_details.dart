import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';


class AddBzDetailsScreen extends StatelessWidget {
  final BzType bzType;
  final String bzLogo;
  final String bzName;
  final String bzCity;
  final String bzCountry;

  AddBzDetailsScreen({
    @required this.bzType,
    @required this.bzLogo,
    @required this.bzName,
    @required this.bzCity,
    @required this.bzCountry,
});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
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
                        verse: 'Add which fields of services / products your business provides',
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

                          // --- BZ NAME
                          SuperTextField(
                            width: screenWidth * 0.95,
                            hintText: 'Business fields',
                            centered: true,
                            inputColor: Colorz.White,
                            inputShadow: false,
                            inputSize: 3,
                            inputWeight: VerseWeight.bold,
                            keyboardTextInputType: TextInputType.name,
                            maxLength: 250,
                            counterIsOn: false,
                            minLines: 2,
                          ),

                          SuperVerse(
                            verse: 'Write a short description about your business',
                            centered: true,
                            italic: true,
                            size: 3,
                            weight: VerseWeight.black,
                            maxLines: 3,
                            margin: 10,
                          ),

                          // --- BZ NAME
                          SuperTextField(
                            width: screenWidth * 0.95,
                            hintText: 'About $bzName ...',
                            centered: true,
                            inputColor: Colorz.White,
                            inputShadow: false,
                            inputSize: 3,
                            inputWeight: VerseWeight.bold,
                            keyboardTextInputType: TextInputType.name,
                            maxLength: 250,
                            counterIsOn: false,
                            minLines: 5,
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
                  boxFunction: (){Navigator.pushNamed(context, Routez.BzCardReview);},
                ),

            ),

            Positioned(
              bottom: 0,
              left: 0,
              child: DreamBox(
                icon: bzLogo,
                height: 60,
                width: 200,
                color: Colorz.BloodRed,
                verse: '${bzTypeStringer(context, bzType)}\n$bzName\n$bzCity\n$bzCountry',
                verseMaxLines: 4,
                verseScaleFactor: 0.35,
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
