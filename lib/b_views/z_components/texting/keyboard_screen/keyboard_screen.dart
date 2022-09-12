import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class KeyboardScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeyboardScreen({
    @required this.keyboardModel,
    @required this.onSubmit,
    this.confirmButtonIsOn = true,
    this.columnChildren,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final KeyboardModel keyboardModel;
  final ValueChanged<String> onSubmit;
  final bool confirmButtonIsOn;
  final List<Widget> columnChildren;
  /// --------------------------------------------------------------------------
  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> goToKeyboardScreen({
    @required BuildContext context,
    KeyboardModel keyboardModel,
  }) async {
    String _output;

    await Nav.goToNewScreen(
      context: context,
      screen: KeyboardScreen(
        keyboardModel: keyboardModel ?? KeyboardModel.standardModel(),
        // confirmButtonIsOn: true,
        onSubmit: (String text){
          _output = text;
        },
      ),
    );

    return _output;
  }
  // -----------------------------------------------------------------------------
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  // -----------------------------------------------------------------------------
  KeyboardModel _keyboardModel;
  final ValueNotifier<bool> _canSubmit = ValueNotifier<bool>(false);
  final TextEditingController _controller = TextEditingController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({
    bool setTo,
  }) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'KeyboardScreen',);
    }
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _keyboardModel = widget.keyboardModel;
    _controller.text = _keyboardModel.initialText;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading().then((_) async {
      //
      //   /// FUCK
      //
      //   await _triggerLoading();
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _canSubmit.dispose();
    _controller.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _onTextChanged(String text){

    if (_keyboardModel.onChanged != null){
      _keyboardModel.onChanged(text);
    }

    if (_keyboardModel.validator != null){

      if (_keyboardModel.validator(_controller.text) == null){
        _canSubmit.value = true;
      }
      else {
        _canSubmit.value = false;
      }

    }

  }
  // --------------------
  void _onSubmit (String text){

    Keyboard.closeKeyboard(context);

    Nav.goBack(
      context: context,
      invoker: 'KeyboardScreen',
    );

    if (_keyboardModel.onSubmitted != null){
      if (_keyboardModel.validator == null || _keyboardModel.validator(text) == null){
        _keyboardModel.onSubmitted(text);
      }
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      layoutWidget: ValueListenableBuilder(
        valueListenable: _canSubmit,
        builder: (_, bool canSubmit, Widget child){

          return Column(
            children: <Widget>[

              const Stratosphere(),

              /// TEXT FIELD
              TextFieldBubble(
                globalKey: _keyboardModel.globalKey,
                appBarType: AppBarType.basic,
                isFloatingField: _keyboardModel.isFloatingField,
                titleVerse: _keyboardModel.titleVerse,
                translateTitle: _keyboardModel.translateTitle,
                textController: _controller,
                maxLines: _keyboardModel.maxLines,
                minLines: _keyboardModel.minLines,
                maxLength: _keyboardModel.maxLength,
                hintVerse: _keyboardModel.hintVerse,
                counterIsOn: _keyboardModel.counterIsOn,
                canObscure: _keyboardModel.canObscure,
                keyboardTextInputType: _keyboardModel.textInputType,
                keyboardTextInputAction: _keyboardModel.textInputAction,
                autoFocus: true,
                isFormField: _keyboardModel.isFormField,
                onSubmitted: widget.onSubmit,
                // autoValidate: true,
                validator: () => _keyboardModel.validator(_controller.text),
                textOnChanged: _onTextChanged,
              ),

              /// CONFIRM BUTTON
              if (widget.confirmButtonIsOn == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DreamBox(
                      isDeactivated: !canSubmit,
                      height: 40,
                      verseScaleFactor: 0.6,
                      margins: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      verse: const Verse(
                        text: 'phid_confirm',
                        translate: true,
                        casing: Casing.upperCase,
                      ),
                      verseItalic: true,
                      onTap: () => _onSubmit(_controller.text),
                    ),
                  ],
                ),

              /// EXTRA CHILDREN
              if (widget.columnChildren != null)
                ... widget.columnChildren,

              const Horizon(),

            ],
          );

        },
      ),
    );

  }
// -----------------------------------------------------------------------------
}
