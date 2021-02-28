import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/text_directionz.dart';
import 'package:bldrs/view_brains/localization/change_language.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class TextFieldTest extends StatefulWidget {
  @override
  _TextFieldTestState createState() => _TextFieldTestState();
}

class _TextFieldTestState extends State<TextFieldTest> {
  TextEditingController _controller = TextEditingController();


  @override
  void initState() {
    // listenToController();
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
    print(Wordz.languageCode(context));



  }

// ---------------------------------------------------------------------------
  /// --- TEXT DIRECTION BLOCK
  /// USER LIKE THIS :-
  /// onChanged: (val){_changeTextDirection();},
  TextDirection _textDirection;
  void _changeTextDirection(){
    setState(() {
      _textDirection = superTextDirectionSwitcher(_controller);
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      tappingRageh: (){
        _changeLanguage();
      },
      layoutWidget: Container(
        width: superScreenWidth(context) * 0.8,
        height: superScreenHeight(context),
        child: Center(
          child: TextFormField(
            controller: _controller,
            textDirection: _textDirection,
            style: TextStyle(
              color: Colorz.Yellow,
            ),
            onChanged: (val){_changeTextDirection();},

          ),
        ),
      ),
    );
  }
}
