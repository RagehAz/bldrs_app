import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

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
  final TextEditingController _controllerC = TextEditingController();
  final TextEditingController _controllerD = TextEditingController();
  final FocusNode _nodeA = FocusNode();
  final FocusNode _nodeB = FocusNode(
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
  final FocusNode _nodeC = FocusNode();
  final FocusNode _nodeD = FocusNode();
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
    _controllerC.dispose();
    _nodeA.dispose();
    _nodeB.dispose();
    _nodeC.dispose();
    _nodeD.dispose();

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
  final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {

    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // blog('above scaffold : _keyboardHeight : $_keyboardHeight');

    // unawaited(_saveKeyboardHeight(
    //   keyboardHeight: _keyboardHeight,
    //   textInputType: _keyboardType,
    // ));

    const AppBarType _appBarType = AppBarType.search;

    return MainLayout(
      appBarType: _appBarType,
      skyType: SkyType.black,
      child: Stack(
        children: <Widget>[

          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[

                const Stratosphere(bigAppBar: true),

                TextFieldBubble(
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineVerse: Verse.plain('AAA'),
                  ),
                  appBarType: _appBarType,
                  formKey: globalKey,
                  focusNode: _nodeA,
                  textController: _controllerA,
                  // isFloatingField: false,
                  bubbleColor: Colorz.bloodTest,
                  keyboardTextInputAction: TextInputAction.next,
                  keyboardTextInputType: Keyboard.textInputTypes[_index],
                ),

                SuperVerse(
                  verse: Verse.plain('$_index : keyboardHeight is : $_keyboardHeight\ntype : ${Keyboard.cipherTextInputType(Keyboard.textInputTypes[_index])}'),
                  labelColor: Colorz.black255,
                  size: 3,
                  maxLines: 3,
                  centered: false,
                  weight: VerseWeight.thin,
                ),

                Container(
                  width: Scale.screenWidth(context),
                  height: 80,
                  color: Colorz.white20,
                ),

                TextFieldBubble(
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineVerse: Verse.plain('BBB'),
                  ),
                  appBarType: _appBarType,
                  formKey: globalKey,
                  focusNode: _nodeB,
                  textController: _controllerB,
                  // isFloatingField: false,
                  bubbleColor: Colorz.bloodTest,
                  keyboardTextInputAction: TextInputAction.next,
                  keyboardTextInputType: Keyboard.textInputTypes[_index],
                ),

                Container(
                  width: Scale.screenWidth(context),
                  height: 80,
                  color: Colorz.white20,
                ),

                TextFieldBubble(
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineVerse: Verse.plain('CCC'),
                  ),
                  appBarType: _appBarType,
                  formKey: globalKey,
                  focusNode: _nodeC,
                  textController: _controllerC,
                  bubbleColor: Colorz.bloodTest,
                  keyboardTextInputAction: TextInputAction.next,
                  keyboardTextInputType: Keyboard.textInputTypes[_index],
                ),

                Container(
                  width: Scale.screenWidth(context),
                  height: 80,
                  color: Colorz.white20,
                ),

                TextFieldBubble(
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineVerse: Verse.plain('DDD'),
                  ),
                  appBarType: _appBarType,
                  formKey: globalKey,
                  focusNode: _nodeD,
                  textController: _controllerD,
                  // isFloatingField: false,
                  bubbleColor: Colorz.bloodTest,
                  keyboardTextInputAction: TextInputAction.next,
                  keyboardTextInputType: Keyboard.textInputTypes[_index],
                ),

                Container(
                  width: Scale.screenWidth(context),
                  height: 80,
                  color: Colorz.white20,
                ),

                Container(
                    color: Colorz.bloodTest,
                    child: const Horizon()
                ),

              ],
            ),
          ),


        ],
      ),
    );

  }
}
