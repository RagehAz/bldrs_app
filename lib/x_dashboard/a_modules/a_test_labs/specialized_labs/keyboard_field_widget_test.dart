import 'dart:async';

import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/a_keyboard_floating_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart' as LDBOps;

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
    _keyboardType = _types[_index];
    super.initState();
  }
// -------------------------------------
  Future<void> _saveKeyboardHeight({
    @required double keyboardHeight,
    @required TextInputType textInputType,
  }) async {

    await LDBOps.insertMap(
        docName: 'keyboard',
        input: {
          'id' : textInputType.toString(),
          'height' : keyboardHeight,
        },
    );

  }
// -------------------------------------
  final List<TextInputType> _types = <TextInputType>[
    TextInputType.text,
    TextInputType.multiline,
    TextInputType.number,
    TextInputType.phone,
    TextInputType.datetime,
    TextInputType.emailAddress,
    TextInputType.url,
    TextInputType.visiblePassword,
    TextInputType.name,
    TextInputType.streetAddress,
    TextInputType.none,
  ];
// -------------------------------------
  int _index = 0;
  TextInputType _keyboardType;
  void _increaseIndex(){

    if (_index + 1 == _types.length){
      _index = 0;
    }
    else {
      _index++;
    }

  }
// -------------------------------------
  Future<void> _closeAndChangeKeyboard() async {

    final bool _keyboardIsOn = UiProvider.proGetKeyboardIsOn(context);

    if (_keyboardIsOn == true){

      await Future.delayed(const Duration(seconds: 1), (){

        closeKeyboard(context);

        setState(() {
          _increaseIndex();
          _keyboardType = _types[_index];
        });

      });

    }

  }
// -------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    unawaited(_saveKeyboardHeight(
      keyboardHeight: _keyboardHeight,
      textInputType: _keyboardType,
    ));

    return Scaffold(

      backgroundColor: Colorz.skyDarkBlue,

      body: ListView(
        children: <Widget>[

          const Stratosphere(),

          SuperTextField(
            title: 'Test',
            width: 200,
            fieldColor: Colorz.bloodTest,
            textController: _controller,
            onTap: () async {

              final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

              final KeyboardModel model = KeyboardModel(
                title: 'Hey There !',
                hintText: null,
                controller: _controller,
                minLines: 1,
                maxLines: 5,
                maxLength: 100,
                textInputAction: TextInputAction.newline,
                textInputType: _keyboardType,
                focusNode: FocusNode(),
                canObscure: false,
                counterIsOn: false,
              );

              _uiProvider.setKeyboard(
                  model: model,
                  notify: true,
              );

              await _closeAndChangeKeyboard();

            },
          ),

          SuperVerse(
            verse: 'keyboardHeight is : $_keyboardHeight : type $_keyboardType',
            labelColor: Colorz.black255,
            size: 3,
          ),

        ],
      ),
      bottomSheet: const KeyboardFloatingField(),

    );

  }
}
