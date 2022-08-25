import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/a_keyboard_floating_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardFieldWidgetTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeyboardFieldWidgetTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<KeyboardFieldWidgetTest> createState() => _KeyboardFieldWidgetTestState();
/// --------------------------------------------------------------------------
}

class _KeyboardFieldWidgetTestState extends State<KeyboardFieldWidgetTest> {
// -------------------------------------
  final TextEditingController _controller = TextEditingController();
// -------------------------------------
  @override
  void initState() {
    super.initState();
    // _keyboardType = textInputTypes[_index];
  }
// -------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
// -------------------------------------
/*
  Future<void> _saveKeyboardHeight({
    @required double keyboardHeight,
    @required TextInputType textInputType,
  }) async {

    if (keyboardHeight != 0){
      await LDBOps.insertMap(
        docName: LDBDoc.keyboards,
        input: {
          'id' : cipherTextInputType(textInputType),
          'height' : keyboardHeight,
        },
      );
    }

  }
 */
// -------------------------------------
  final int _index = 0;
  /*
  TextInputType _keyboardType;
  void _increaseIndex(){

    if (_index + 1 == textInputTypes.length){
      _index = 0;
    }
    else {
      _index++;
    }

  }
   */
// -------------------------------------
  /*
  Future<void> _closeAndChangeKeyboard() async {

    final bool _keyboardIsOn = UiProvider.proGetKeyboardIsOn(context);

    if (_keyboardIsOn == true){

      await Future.delayed(const Duration(seconds: 1), (){

        closeKeyboard(context);

        setState(() {
          _increaseIndex();
          _keyboardType = textInputTypes[_index];
        });

      });

    }

  }
   */
// -------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    blog('above scaffold : _keyboardHeight : $_keyboardHeight');

    // unawaited(_saveKeyboardHeight(
    //   keyboardHeight: _keyboardHeight,
    //   textInputType: _keyboardType,
    // ));

    return Scaffold(

      backgroundColor: Colorz.skyDarkBlue,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[

          ListView(
            children: <Widget>[

              const Stratosphere(),

              SuperTextField(
                titleVerse: 'Test',
                width: 200,
                fieldColor: Colorz.bloodTest,
                textController: _controller,
                // textInputAction: TextInputAction.done,
                textInputType: Keyboard.textInputTypes[_index],
                onTap: () async {

                  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

                  final KeyboardModel model = KeyboardModel(
                    titleVerse: 'Hey There !',
                    hintVerse: null,
                    controller: _controller,
                    maxLines: 5,
                    maxLength: 100,
                    textInputType: Keyboard.textInputTypes[_index],
                    focusNode: FocusNode(),
                  );

                  _uiProvider.setKeyboard(
                    model: model,
                    notify: true,
                  );

                  // await _closeAndChangeKeyboard();

                },
              ),

              SuperVerse(
                verse:  '$_index : keyboardHeight is : $_keyboardHeight\ntype : ${Keyboard.cipherTextInputType(Keyboard.textInputTypes[_index])}',
                labelColor: Colorz.black255,
                size: 3,
                maxLines: 3,
                centered: false,
                weight: VerseWeight.thin,
              ),

            ],
          ),

          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     width: superScreenWidth(context),
          //     height: _keyboardHeight,
          //     color: Colorz.bloodTest,
          //   ),
          // ),

        ],
      ),

      bottomSheet: const KeyboardFloatingField(),

    );

  }
}
