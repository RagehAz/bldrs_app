import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs/views/widgets/buttons/bt_rageh.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/the_golden_scroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // ---
    int fontSize1 = 1;
    int fontSize2 = 2;
    int fontSize3 = 3;
    int fontSize4 = 4;
    int fontSize5 = 5;
    int fontSize6 = 6;
    int fontSize7 = 7;
    int fontSize8 = 8;
    String testVerse = '${Wordz.bldrsFullName(context)}';

    VerseWeight weightTest = VerseWeight.thin;

    // --- SHADOW TEST PARAMETERS
    dynamic shadowTestColor = Colorz.White;
    String shadowTestVerse = 'AaBb أبجدية';
    bool italiany = false;
    bool centeredOn = true;
    bool designModeOn = false;

    final List<String> fields = ['Architecture', 'abcd', 'Interior', 'Landscape', '1', 'test', '3abbas ebn fernas', 'thing', 'wtf'];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [

            NightSky(),

            ListView(

              children: [

                // --- BEGINNING OF SCROLLABLE SCREEN
                Container(
                  height: Ratioz.ddPyramidsHeight * 2,
                  width: screenWidth,
                ),

                // --- FONT CHARACTERS TEST
                SuperVerse(
                  verse: 'Text test\n'
                      'ABCDEFGHIJKLMNOPQRSTUVWXYZ.\n'
                      'abcdefghijklmnopqrstuvwxyz\n'
                      '1234567890\n'
                      '`~!@#\$%^&*()-_=+[]{}|\';\":/?><,\n'
                      'اختبار الخطوط\n'
                      'أإاآؤئيئءلألإ ببب تتت ثثث ججج ححح خخخ د ذ ر ز سسس ششش صصص ضضض ططط ظظظ ععع غغغ ففف ققق ككك للل ممم ننن ههه و ييي\n'
                      '1234567890\n'
                      'ّ أَ أً أُ أٌ أ ثَثاً ثُثٌثِثْثثّثٍ خّ خٌ خْخٍ غٍ غَ غٌ غَّ غٌّ يٍ يٍّ شٌ ش \n'
                      '~{}’,.؟":/،ـ><؛×÷‘][!@#\$|%^&*)(\n'
                      'A|أ',
                  color: Colorz.Yellow,
                  size: 4,
                  weight: weightTest,
                  italic: false,
                  shadow: false,
                  centered: false,
                  designMode: true,
                  maxLines: 100,
              ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.02,
                  color: Colorz.BlackBlack,
                ),

                // --- VERSE HEIGHT REVERSE ENGINEERING
                Stack(
                  children: [
                    // --- BACKGROUND REVERSE ENGINEERING BOX TO MEASURE FONT HEIGHT FACTOR
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.034 * 1.42, // 0.034 is ratio of fontSize 4
                      color: Colorz.White,
                    ),

                    Center(
                      child: SuperVerse(
                        verse: '| أختبر أنا العبد لله هذا الفونط و إنه لشيء عظيمٌ جدا Ohh baby',
                        size: 4,
                        color: Colorz.Green,
                        shadow: true,
                        italic: false,
                        weight: VerseWeight.bold,
                        centered: true,
                        designMode: true,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),

                // --- FONT SIZE TEST
                Column(
                  children: [
                    SuperVerse(
                      verse: '$fontSize1 Nano Text test\n$testVerse',
                      size: fontSize1,
                      centered: true,
                      color: Colorz.White,
                      weight: VerseWeight.regular,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),

                    SuperVerse(
                      verse: '$fontSize2 Micro Text test\n$testVerse',
                      size: fontSize2,
                      centered: true,
                      color: Colorz.White,
                      weight: VerseWeight.regular,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),

                    SuperVerse(
                      verse: '$fontSize3 Mini Text test\n$testVerse',
                      size: fontSize3,
                      centered: true,
                      color: Colorz.White,
                      weight: weightTest,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),

                    SuperVerse(
                      verse: '$fontSize4 Medium Text test\n$testVerse',
                      size: fontSize4,
                      centered: true,
                      color: Colorz.White,
                      weight: weightTest,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),

                    SuperVerse(
                      verse: '$fontSize5 Macro Text test\n$testVerse',
                      size: fontSize5,
                      centered: true,
                      color: Colorz.White,
                      weight: weightTest,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),

                    SuperVerse(
                      verse: '$fontSize6 Big Text test\n$testVerse',
                      size: fontSize6,
                      centered: true,
                      color: Colorz.White,
                      weight: weightTest,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),

                    SuperVerse(
                      verse: '$fontSize7 Massive Text test\n$testVerse',
                      size: fontSize7,
                      centered: true,
                      color: Colorz.White,
                      weight: weightTest,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),

                    SuperVerse(
                      verse: '$fontSize8 Gigantic Text test\n$testVerse',
                      size: fontSize8,
                      centered: true,
                      color: Colorz.White,
                      weight: weightTest,
                      italic: false,
                      shadow: false,
                      designMode: true,
                    ),
                  ],
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),

                // --- PARAGRAPH TEST
                Column(
                  children: [
                    SuperVerse(
                      verse: 'عنوان المقال',
                      size: 5,
                      weight: VerseWeight.bold,
                      designMode: false,
                      shadow: false,
                      centered: true,
                      italic: false,
                      color: Colorz.White,
                    ),

                    SuperVerse(
                      verse: 'Lo más correcto es jugar y divertirse\n'
                          'The most correct is playing and having fun\n'
                          'Le plus correct est de jouer et de s\'amuser\n'
                          'Најправилно е играње и забава\n'
                          'Το πιο σωστό είναι το παιχνίδι και η διασκέδαση\n'
                          'الراجح يلعب و يلهو',
                      color: Colorz.White,
                      italic: false,
                      centered: true,
                      shadow: false,
                      designMode: false,
                      size: 3,
                      weight: weightTest,
                    ),
                  ],
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),

                // --- FONT WEIGHT TEST
                Column(
                  children: [
                    SuperVerse(
                      verse: 'black : ABC | أبح | лгзб |πωσαχδ | ',
                      weight: VerseWeight.black,
                      size: 4,
                      designMode: true,
                      shadow: false,
                      centered: true,
                      italic: false,
                      color: Colorz.White,
                    ),

                    SuperVerse(
                      verse: 'bold : ABC | أبح | лгзб |πωσαχδ | ',
                      weight: VerseWeight.bold,
                      size: 4,
                      designMode: true,
                      shadow: false,
                      centered: true,
                      italic: false,
                      color: Colorz.White,
                    ),

                    SuperVerse(
                      verse: 'regular : ABC | أبح | лгзб |πωσαχδ | ',
                      weight: VerseWeight.regular,
                      size: 4,
                      designMode: true,
                      shadow: false,
                      centered: true,
                      italic: false,
                      color: Colorz.White,
                    ),

                    SuperVerse(
                      verse: 'thin : ABC | أبح | лгзб |πωσαχδ | ',
                      weight: VerseWeight.thin,
                      size: 4,
                      designMode: true,
                      shadow: false,
                      centered: true,
                      italic: false,
                      color: Colorz.White,
                    ),
                  ],
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),

                // --- SHADOW TEST
                Column(
                  children: [

                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 1,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 2,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 3,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 4,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 5,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 6,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 7,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.thin, size: 8,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 1,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 2,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 3,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 4,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 5,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 6,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 7,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.regular, size: 8,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 1,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 2,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 3,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 4,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 5,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 6,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 7,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.bold, size: 8,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 1,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 2,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 3,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 4,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 5,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 6,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 7,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    SuperVerse(
                      verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true, designMode: designModeOn,
                      weight: VerseWeight.black, size: 8,
                    ),
                    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                  ],
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),


                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),


                SuperVerse(
                  verse: 'SuperVerse.dart',
                  size: 5,
                ),

                SuperVerse(
                  verse: 'SuperVerse Label',
                  labelColor: Colorz.Yellow,
                  color: Colorz.BlackSmoke,
                  size: 6,
                ),

                SuperVerse(
                  verse: 'SuperVerse paragraph \n This is a new Line,'
                      ' and continues to exceed screen width to '
                      'automatically wrap when maxLines is '
                      'assigned more than 1',
                  margin: 20,
                  size: 3,
                  maxLines: 3,
                  centered: true,
                  color: Colorz.White,
                  labelColor: Colorz.WhiteGlass,
                  designMode: true,
                  shadow: true,
                  italic: true,
                  weight:  VerseWeight.black,

                ),

                GoldenScroll(
                  scrollScript: 'the_golden_scroll.dart',
                  scrollTitle: 'Scroll title',
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- CHIPS LIST
                Center(
                  child: Wrap(
                      children:
                      List<Widget>.generate(
                          fields.length,
                              (index) {
                            return
                              Chip(
                                label:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(fields[index]),
                                  ],
                                ),
                              );
                          })
                      ),
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                Container(
                  height: 10,
                  width: screenWidth,
                  color: Colorz.BlackBlack,
                ),

                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- GENERATED LIST
                Center(
                  child: Wrap(
                      children:
                      List<Widget>.generate(
                          fields.length,
                              (index) {
                            return
                              SuperVerse(
                                verse: fields[index],
                                size: 3,
                                maxLines: 1,
                                weight:  VerseWeight.bold,
                                shadow: true,
                                designMode: true,
                                labelColor: Colorz.Yellow,
                                color: Colorz.BlackBlack,
                                centered: true,
                                margin: 0,
                                italic: false,
                              );
                          })
                      ),
                ),
                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- NOTHING GOES BEYOND THIS FUCKING LINE
                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- NOTHING GOES BEYOND THIS FUCKING LINE
                // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- NOTHING GOES BEYOND THIS FUCKING LINE
                // --- END OF SCROLLABLE SCREEN
                Container(
                  height: Ratioz.ddPyramidsHeight * 3,
                  width: screenWidth,
                ),

              ],

            ),

            Pyramids(
              pyramidsIcon: Iconz.PyramidsYellow,
              loading: true,
            ),

            Rageh(
              tappingRageh:
                Wordz.activeLanguage(context) == 'Arabic' ?
                    () async {
                Locale temp = await setLocale('en');
                BldrsApp.setLocale(context, temp);
              }
              :
                  () async {
                Locale temp = await setLocale('ar');
                BldrsApp.setLocale(context, temp);
              },

              doubleTappingRageh: (){
                print(screenHeight * 0.022 * 1.48);
              },
            ),

          ],
        ),
      ),
    );
  }
}
