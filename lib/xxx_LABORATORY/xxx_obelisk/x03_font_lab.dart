import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs/views/widgets/general/artworks/pyramids.dart';
import 'package:bldrs/views/widgets/general/buttons/rageh_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/general/textings/the_golden_scroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontLab extends StatefulWidget {
  const FontLab({Key key}) : super(key: key);

  @override
  _FontLabState createState() => _FontLabState();
}

class _FontLabState extends State<FontLab> {
  TextEditingController _textController = new TextEditingController();


  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget _superVerse(int size){

    String _pixelsAsString = '${SuperVerse.superVerseSizeValue(context, size, 1)}';
    String _pixels = TextMod.removeTextAfterFirstSpecialCharacter(_pixelsAsString, '.');

    return
      SuperVerse(
        verse: 'size $size : $_pixels pixels',
        size: size,
        labelColor: Colorz.bloodTest,
      );
  }

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeight(context);
    final double _screenWidth = Scale.superScreenWidth(context);
    // ---
    const int fontSize1 = 1;
    const int fontSize2 = 2;
    const int fontSize3 = 3;
    const int fontSize4 = 4;
    const int fontSize5 = 5;
    const int fontSize6 = 6;
    const int fontSize7 = 7;
    const int fontSize8 = 8;
    final String testVerse = '${Wordz.bldrsFullName(context)}';

    const VerseWeight weightTest = VerseWeight.thin;

    // --- SHADOW TEST PARAMETERS
    const dynamic shadowTestColor = Colorz.white255;
    const String shadowTestVerse = 'AaBb أبجدية';
    const bool italiany = false;
    const bool centeredOn = true;

    final List<String> fields = <String>['Architecture', 'abcd', 'Interior', 'Landscape', '1', 'test', '3abbas ebn fernas', 'thing', 'wtf'];

    // TextStyle _style = SuperVerse.createStyle(
    //   context: context,
    //   color: Colorz.White255,
    //   weight: VerseWeight.bold,
    //   italic: false,
    //   size: 2,
    //   shadow: false,
    // );

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[

            const Sky(),

            Scroller(
              child: ListView(

                children: <Widget>[

                  const Stratosphere(),

                  _superVerse(0),
                  _superVerse(1),
                  _superVerse(2),
                  _superVerse(3),
                  _superVerse(4),
                  _superVerse(5),
                  _superVerse(6),
                  _superVerse(7),
                  _superVerse(8),


                  // --- BEGINNING OF SCROLLABLE SCREEN
                  Container(
                    height: Ratioz.pyramidsHeight * 2,
                    width: _screenWidth,
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
                    color: Colorz.yellow255,
                    size: 4,
                    weight: weightTest,
                    italic: false,
                    shadow: false,
                    centered: false,
                    maxLines: 100,
                ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                  Container(
                    width: _screenWidth,
                    height: _screenHeight * 0.02,
                    color: Colorz.black230,
                  ),

                  // --- VERSE HEIGHT REVERSE ENGINEERING
                  Stack(
                    children: <Widget>[
                      // --- BACKGROUND REVERSE ENGINEERING BOX TO MEASURE FONT HEIGHT FACTOR
                      Container(
                        width: _screenWidth,
                        height: _screenHeight * 0.034 * 1.42, // 0.034 is ratio of fontSize 4
                        color: Colorz.white255,
                      ),

                      Center(
                        child: SuperVerse(
                          verse: '| أختبر أنا العبد لله هذا الفونط و إنه لشيء عظيمٌ جدا Ohh baby',
                          size: 4,
                          color: Colorz.green255,
                          shadow: true,
                          italic: false,
                          weight: VerseWeight.bold,
                          centered: true,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                  Container(
                    height: 10,
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),

                  // --- FONT SIZE TEST
                  Column(
                    children: <Widget>[
                      SuperVerse(
                        verse: '$fontSize1 Nano Text test\n$testVerse',
                        size: fontSize1,
                        centered: true,
                        color: Colorz.white255,
                        weight: VerseWeight.regular,
                        italic: false,
                        shadow: false,
                      ),

                      SuperVerse(
                        verse: '$fontSize2 Micro Text test\n$testVerse',
                        size: fontSize2,
                        centered: true,
                        color: Colorz.white255,
                        weight: VerseWeight.regular,
                        italic: false,
                        shadow: false,
                      ),

                      SuperVerse(
                        verse: '$fontSize3 Mini Text test\n$testVerse',
                        size: fontSize3,
                        centered: true,
                        color: Colorz.white255,
                        weight: weightTest,
                        italic: false,
                        shadow: false,
                      ),

                      SuperVerse(
                        verse: '$fontSize4 Medium Text test\n$testVerse',
                        size: fontSize4,
                        centered: true,
                        color: Colorz.white255,
                        weight: weightTest,
                        italic: false,
                        shadow: false,
                      ),

                      SuperVerse(
                        verse: '$fontSize5 Macro Text test\n$testVerse',
                        size: fontSize5,
                        centered: true,
                        color: Colorz.white255,
                        weight: weightTest,
                        italic: false,
                        shadow: false,
                      ),

                      SuperVerse(
                        verse: '$fontSize6 Big Text test\n$testVerse',
                        size: fontSize6,
                        centered: true,
                        color: Colorz.white255,
                        weight: weightTest,
                        italic: false,
                        shadow: false,
                      ),

                      SuperVerse(
                        verse: '$fontSize7 Massive Text test\n$testVerse',
                        size: fontSize7,
                        centered: true,
                        color: Colorz.white255,
                        weight: weightTest,
                        italic: false,
                        shadow: false,
                      ),

                      SuperVerse(
                        verse: '$fontSize8 Gigantic Text test\n$testVerse',
                        size: fontSize8,
                        centered: true,
                        color: Colorz.white255,
                        weight: weightTest,
                        italic: false,
                        shadow: false,
                      ),
                    ],
                  ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                  Container(
                    height: 10,
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),

                  // --- PARAGRAPH TEST
                  Column(
                    children: <Widget>[
                      SuperVerse(
                        verse: 'عنوان المقال',
                        size: 5,
                        weight: VerseWeight.bold,
                        shadow: false,
                        centered: true,
                        italic: false,
                        color: Colorz.white255,
                      ),

                      SuperVerse(
                        verse: 'Lo más correcto es jugar y divertirse\n'
                            'The most correct is playing and having fun\n'
                            'Le plus correct est de jouer et de s\'amuser\n'
                            'Најправилно е играње и забава\n'
                            'Το πιο σωστό είναι το παιχνίδι και η διασκέδαση\n'
                            'الراجح يلعب و يلهو',
                        color: Colorz.white255,
                        italic: false,
                        centered: true,
                        shadow: false,
                        size: 3,
                        weight: weightTest,
                      ),
                    ],
                  ),

                  Container(
                    height: 10,
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),

                  // --- FONT WEIGHT TEST
                  Column(
                    children: <Widget>[
                      SuperVerse(
                        verse: 'black : ABC | أبح | лгзб |πωσαχδ | ',
                        weight: VerseWeight.black,
                        size: 4,
                        shadow: false,
                        centered: true,
                        italic: false,
                        color: Colorz.white255,
                      ),

                      SuperVerse(
                        verse: 'bold : ABC | أبح | лгзб |πωσαχδ | ',
                        weight: VerseWeight.bold,
                        size: 4,
                        shadow: false,
                        centered: true,
                        italic: false,
                        color: Colorz.white255,
                      ),

                      SuperVerse(
                        verse: 'regular : ABC | أبح | лгзб |πωσαχδ | ',
                        weight: VerseWeight.regular,
                        size: 4,
                        shadow: false,
                        centered: true,
                        italic: false,
                        color: Colorz.white255,
                      ),

                      SuperVerse(
                        verse: 'thin : ABC | أبح | лгзб |πωσαχδ | ',
                        weight: VerseWeight.thin,
                        size: 4,
                        shadow: false,
                        centered: true,
                        italic: false,
                        color: Colorz.white255,
                      ),
                    ],
                  ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                  Container(
                    height: 10,
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),

                  // --- SHADOW TEST
                  Column(
                    children: <Widget>[

                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 1,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 2,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 3,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 4,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 5,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 6,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 7,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.thin, size: 8,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 1,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 2,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 3,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 4,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 5,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 6,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 7,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.regular, size: 8,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 1,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 2,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 3,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 4,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 5,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 6,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 7,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.bold, size: 8,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 1,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 2,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 3,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 4,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 5,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 6,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 7,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                      SuperVerse(
                        verse: shadowTestVerse,color: shadowTestColor, italic: italiany, centered: centeredOn, shadow: true,
                        weight: VerseWeight.black, size: 8,
                      ),
                      // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
                    ],
                  ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                  Container(
                    height: 10,
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),


                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                  Container(
                    height: 10,
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),


                  SuperVerse(
                    verse: 'SuperVerse.dart',
                    size: 5,
                  ),

                  SuperVerse(
                    verse: 'SuperVerse Label',
                    labelColor: Colorz.yellow255,
                    color: Colorz.black80,
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
                    color: Colorz.white255,
                    labelColor: Colorz.white20,
                    shadow: true,
                    italic: true,
                    weight:  VerseWeight.black,

                  ),

                  const GoldenScroll(
                    scrollScript: 'the_golden_scroll.dart',
                    scrollTitle: 'Scroll title',
                  ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SEPARATOR
                  Container(
                    height: 10,
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- CHIPS LIST
                  Center(
                    child: Wrap(
                        children:
                        List<Widget>.generate(
                            fields.length,
                                (int index) {
                              return
                                Chip(
                                  label:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
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
                    width: _screenWidth,
                    color: Colorz.black230,
                  ),

                  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- GENERATED LIST
                  Center(
                    child: Wrap(
                        children:
                        List<Widget>.generate(
                            fields.length,
                                (int index) {
                              return
                                SuperVerse(
                                  verse: fields[index],
                                  size: 3,
                                  maxLines: 1,
                                  weight:  VerseWeight.bold,
                                  shadow: true,
                                  labelColor: Colorz.yellow255,
                                  color: Colorz.black230,
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
                    height: Ratioz.pyramidsHeight * 3,
                    width: _screenWidth,
                  ),

                  Container(
                    width: _screenWidth,
                    height: _screenHeight,
                    color: Colorz.bloodTest,
                    child: SuperTextField(
                      width: _screenWidth * 0.8,
                      inputSize: 2,
                      height: 100,
                      maxLength: 500,
                      minLines: 2,
                      maxLines: 3,
                      fieldIsFormField: false,
                      autofocus: false,
                      textController: _textController,
                      keyboardTextInputAction: TextInputAction.newline,
                      keyboardTextInputType: TextInputType.multiline,
                      textDirection: superTextDirectionSwitcher(_textController?.text),
                      // onChanged: (val){},
                    ),
                  ),

                ],

              ),
            ),

            const Pyramids(
              pyramidsIcon: Iconz.PyramidsYellow,
              loading: true,
            ),

            Rageh(
              tappingRageh:
                Wordz.activeLanguage(context) == Lingo.arabicLingo.code ?
                    () async {
                Locale temp = await Localizer.setLocale(Lingo.englishLingo.code);
                BldrsApp.setLocale(context, temp);
              }
              :
                  () async {
                Locale temp = await Localizer.setLocale(Lingo.arabicLingo.code);
                BldrsApp.setLocale(context, temp);
              },

              doubleTappingRageh: (){
                print(_screenHeight * 0.022 * 1.48);
              },
            ),

          ],
        ),
      ),
    );
  }
}
