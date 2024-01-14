import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/z_components/sizing/horizon.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class KeyboardScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeyboardScreen({
    required this.keyboardModel,
    this.confirmButtonIsOn = true,
    this.columnChildren,
    this.screenTitleVerse,
    this.initialText,
    super.key
  });
  /// --------------------------------------------------------------------------
  final KeyboardModel keyboardModel;
  final bool confirmButtonIsOn;
  final List<Widget>? columnChildren;
  final Verse? screenTitleVerse;
  final String? initialText;
  /// --------------------------------------------------------------------------
  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> goToKeyboardScreen({
    KeyboardModel? keyboardModel,
    Verse? screenTitleVerse,
    String? initialText,
  }) async {

    final String? _output = await BldrsNav.goToNewScreen(
      screen: KeyboardScreen(
        keyboardModel: keyboardModel ?? KeyboardModel.standardModel(),
        screenTitleVerse: screenTitleVerse,
        initialText: initialText,
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
  late KeyboardModel _keyboardModel;
  final ValueNotifier<bool> _canSubmit = ValueNotifier<bool>(false);
  final TextEditingController _controller = TextEditingController();
  String _initialText = '';
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
    _initialText = widget.initialText ?? _keyboardModel.initialText ?? '';
    _controller.text = _initialText;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      // _triggerLoading().then((_) async {
      //
      //   /// FUCK
      //
      //   await _triggerLoading();
      // });

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
  void _onTextChanged(String? text){

    if (_keyboardModel.onChanged != null){
      _keyboardModel.onChanged?.call(text);
    }

    bool _can = true;

    /// VALIDATOR IS DEFINED
    if (_keyboardModel.validator != null){

      /// VALIDATOR IS VALID
      if (_keyboardModel.validator?.call(_controller.text) == null){

        if (_initialText == text){
          _can = false;
        }
        else {
          _can = true;
        }

      }

      /// VALIDATOR IS NOT VALID
      else {
        _can = false;
      }

    }

    /// VALIDATOR IS NOT DEFINED
    else {
      _can = true;
    }

    setNotifier(
      notifier: _canSubmit,
      mounted: mounted,
      value: _can,
    );

  }
  // --------------------
  Future<void> _onSubmit (String? text) async {

    if (_keyboardModel.onSubmitted != null){
      if (_keyboardModel.validator == null || _keyboardModel.validator?.call(text) == null){
        _keyboardModel.onSubmitted?.call(text);
      }
    }

    await Keyboard.closeKeyboard();

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
      canSwipeBack: true,
      skyType: SkyType.grey,
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
                onSubmitted: (String? text) => _onSubmit(text),
                // autoValidate: true,
                validator: (String? text){
                  if (_keyboardModel.validator != null){
                    return _keyboardModel.validator?.call(_controller.text);
                  }
                  else {
                    return null;
                  }
                },
                onTextChanged: _onTextChanged,
                pasteFunction: () => _onPaste(),
                enableSuggestions: _keyboardModel.enableSuggestions,
                autoCorrect: _keyboardModel.autoCorrect,
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
                      margins: const EdgeInsets.symmetric(
                          horizontal: 10,
                          // vertical: 0
                      ),
                      color: Colorz.yellow255,
                      verseColor: Colorz.black255,
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
                ... widget.columnChildren!,

              const Horizon(),

            ],
          );

        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
