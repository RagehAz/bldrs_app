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

  const KeyboardFieldWidgetTest({
    Key key
  }) : super(key: key);

  @override
  State<KeyboardFieldWidgetTest> createState() => _KeyboardFieldWidgetTestState();

}

class _KeyboardFieldWidgetTestState extends State<KeyboardFieldWidgetTest> {

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // _keyboardType = textInputTypes[_index];
    super.initState();
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
                title: 'Test',
                width: 200,
                fieldColor: Colorz.bloodTest,
                textController: _controller,
                // textInputAction: TextInputAction.done,
                textInputType: textInputTypes[_index],
                onTap: () async {

                  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

                  final KeyboardModel model = KeyboardModel(
                    title: 'Hey There !',
                    hintText: null,
                    controller: _controller,
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 100,
                    textInputAction: TextInputAction.done,
                    textInputType: textInputTypes[_index],
                    focusNode: FocusNode(),
                    canObscure: false,
                    counterIsOn: false,
                    onSubmitted: null,
                    onSavedForForm: null,
                    onEditingComplete: null,
                    onChanged: null,
                    isFormField: false,
                  );

                  _uiProvider.setKeyboard(
                    model: model,
                    notify: true,
                  );

                  // await _closeAndChangeKeyboard();

                },
              ),

              SuperVerse(
                verse: '$_index : keyboardHeight is : $_keyboardHeight\ntype : ${cipherTextInputType(textInputTypes[_index])}',
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
