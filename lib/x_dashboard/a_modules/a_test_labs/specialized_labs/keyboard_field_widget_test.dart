import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
// -------------------------------------
  @override
  void initState() {
    super.initState();
    // _keyboardType = textInputTypes[_index];
  }
// -------------------------------------
  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
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
  final FocusNode _firstNode = FocusNode();
  final FocusNode _secondNode = FocusNode(
    // canRequestFocus: true,
    // descendantsAreFocusable: true,
    // descendantsAreTraversable: true,
    onKey: (FocusNode node, RawKeyEvent event){
      blog('node : ${node.toStringShort()}');
      blog('event : ${event.character}');
      const KeyEventResult _keyEventResult = KeyEventResult.handled;
      return _keyEventResult;
    }
  );

  @override
  Widget build(BuildContext context) {

    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // blog('above scaffold : _keyboardHeight : $_keyboardHeight');

    // unawaited(_saveKeyboardHeight(
    //   keyboardHeight: _keyboardHeight,
    //   textInputType: _keyboardType,
    // ));

    return MainLayout(
      skyType: SkyType.black,
      layoutWidget: Stack(
        children: <Widget>[

          ListView(
            children: <Widget>[

              const Stratosphere(),

              SuperTextField(
                focusNode: _firstNode,
                isFloatingField: true,
                titleVerse:  'AAA',
                width: 200,
                fieldColor: Colorz.bloodTest,
                textController: _controllerA,
                textInputAction: TextInputAction.next,
                textInputType: Keyboard.textInputTypes[_index],
              ),

              SuperVerse(
                verse:  '$_index : keyboardHeight is : $_keyboardHeight\ntype : ${Keyboard.cipherTextInputType(Keyboard.textInputTypes[_index])}',
                labelColor: Colorz.black255,
                size: 3,
                maxLines: 3,
                centered: false,
                weight: VerseWeight.thin,
              ),

              SuperTextField(
                focusNode: _secondNode,
                isFloatingField: true,
                titleVerse: 'BBB',
                width: 200,
                fieldColor: Colorz.bloodTest,
                textController: _controllerB,
                textInputAction: TextInputAction.next,
                textInputType: Keyboard.textInputTypes[_index],
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
    );

  }
}
