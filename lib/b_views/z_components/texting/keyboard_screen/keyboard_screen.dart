import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';

class KeyboardScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeyboardScreen({
    required this.keyboardModel,
    this.confirmButtonIsOn = true,
    this.columnChildren,
    this.screenTitleVerse,
    super.key
  });
  /// --------------------------------------------------------------------------
  final KeyboardModel keyboardModel;
  final bool confirmButtonIsOn;
  final List<Widget> columnChildren;
  final Verse screenTitleVerse;
  /// --------------------------------------------------------------------------
  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> goToKeyboardScreen({
    required BuildContext context,
    KeyboardModel keyboardModel,
    Verse screenTitleVerse,
  }) async {

    final String _output = await Nav.goToNewScreen(
      context: context,
      screen: KeyboardScreen(
        keyboardModel: keyboardModel ?? KeyboardModel.standardModel(),
        screenTitleVerse: screenTitleVerse,
        // confirmButtonIsOn: true,
      ),
    );

    return _output;
  }
  // -----------------------------------------------------------------------------
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey _globalKey = GlobalKey<FormState>();
  KeyboardModel _keyboardModel;
  final ValueNotifier<bool> _canSubmit = ValueNotifier<bool>(false);
  final TextEditingController _controller = TextEditingController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
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

    /// VALIDATOR IS DEFINED
    if (_keyboardModel.validator != null){

      /// VALIDATOR IS VALID
      if (_keyboardModel.validator(_controller.text) == null){
        setNotifier(
          notifier: _canSubmit,
          mounted: mounted,
          value: true,
        );
      }

      /// VALIDATOR IS NOT VALID
      else {
        setNotifier(
          notifier: _canSubmit,
          mounted: mounted,
          value: false,
        );
      }

    }

    /// VALIDATOR IS NOT DEFINED
    else {
      setNotifier(
        notifier: _canSubmit,
        mounted: mounted,
        value: true,
      );
    }

  }
  // --------------------
  Future<void> _onSubmit (String text) async {

    if (_keyboardModel.onSubmitted != null){
      if (_keyboardModel.validator == null || _keyboardModel.validator(text) == null){
        _keyboardModel.onSubmitted(text);
      }
    }

    Keyboard.closeKeyboard();

    await Nav.goBack(
      context: context,
      invoker: 'KeyboardScreen',
      passedData: _controller.text,
    );

  }
  // --------------------
  Future<void> _onPaste() async {
    await TextMod.controllerPaste(_controller);
    _onTextChanged(_controller.text);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      title: widget.screenTitleVerse,
      child: ValueListenableBuilder(
        valueListenable: _canSubmit,
        builder: (_, bool canSubmit, Widget? child){

          return Column(
            children: <Widget>[

              const Stratosphere(),

              /// TEXT FIELD
              BldrsTextFieldBubble(
                formKey: _globalKey,
                bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                  context: context,
                  headlineVerse: _keyboardModel.titleVerse,
                ),
                appBarType: AppBarType.basic,
                isFloatingField: _keyboardModel.isFloatingField,
                textController: _controller,
                maxLines: _keyboardModel.maxLines,
                minLines: _keyboardModel.minLines,
                maxLength: _keyboardModel.maxLength,
                hintVerse: _keyboardModel.hintVerse,
                counterIsOn: _keyboardModel.counterIsOn,
                isObscured: _keyboardModel.isObscured,
                keyboardTextInputType: _keyboardModel.textInputType,
                keyboardTextInputAction: _keyboardModel.textInputAction,
                autoFocus: true,
                isFormField: true,
                onSubmitted: (String text) => _onSubmit(text),
                // autoValidate: true,
                validator: (String text){
                  if (_keyboardModel?.validator != null){
                    return _keyboardModel.validator(_controller.text);
                  }
                  else {
                    return null;
                  }
                },
                onTextChanged: _onTextChanged,
                pasteFunction: () => _onPaste(),
              ),

              /// CONFIRM BUTTON
              if (widget.confirmButtonIsOn == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    BldrsBox(
                      isDisabled: !canSubmit,
                      height: 40,
                      verseScaleFactor: 0.6,
                      margins: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      verse: const Verse(
                        id: 'phid_confirm',
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
