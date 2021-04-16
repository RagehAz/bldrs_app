import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/localization/change_language.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:flutter/material.dart';

class TextFieldTest extends StatefulWidget {
  @override
  _TextFieldTestState createState() => _TextFieldTestState();
}

class _TextFieldTestState extends State<TextFieldTest> {
  TextEditingController _controller = TextEditingController();
  String x;
  bool _textIsEnglish;
  bool _textIsArabic;

  @override
  void initState() {
    _controller.text = ' ‎ gj‎ ‎ ‎gdx ggvgf';
    x = _controller.text;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void listenToController(){
  //   _controller.addListener(() {
  //     print(_controller.text);
  //     setState(() {
  //       _textDirection = superTextDirectionSwitcher(_controller);
  //     });
  //   });
  // }

  Future<void> _changeLanguage() async {
    print('a77a');
    await switchBetweenArabicAndEnglish(context);



  }

// ---------------------------------------------------------------------------
//   /// --- TEXT DIRECTION BLOCK
//   /// USER LIKE THIS :-
//   /// onChanged: (val){_changeTextDirection();},
//   TextDirection _textDirection;
//   void _changeTextDirection(){
//     setState(() {
//       _textDirection = superTextDirectionSwitcher(_controller.text);
//       x = _controller.text;
//     });
//   }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    String _verse = firstCharacterAfterRemovingSpacesFromAString(x);
    print('_verse is ($_verse)');

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      tappingRageh: (){
        _changeLanguage();
      },
      layoutWidget: Container(
        width: superScreenWidth(context) * 0.8,
        height: superScreenHeight(context),
        child: Column(
          children: [
            Stratosphere(),

            SuperTextField(
              fieldIsFormField: true,
              textController: _controller,
              maxLines: 5,

              onChanged: (val){
                setState(() {
                  x = val;
                  _textIsArabic = textStartsInArabic(val);
                  _textIsEnglish = textStartsInEnglish(val);
                });
              },
            ),

            DreamBox(
              height: 50,
              verse: _verse,
              verseScaleFactor: 0.8,
            ),

            DreamBox(
              height: 50,
              verse: 'Text Starts in Arabic ? : $_textIsArabic',
              verseScaleFactor: 0.8,
            ),

            DreamBox(
              height: 50,
              verse: 'Text Starts in English ? : $_textIsEnglish',
              verseScaleFactor: 0.8,
            ),

            DreamBox(
                height: 50,
              verse: 'change language',
              boxFunction: _changeLanguage,
            )
          ],
        ),
      ),
    );
  }
}
