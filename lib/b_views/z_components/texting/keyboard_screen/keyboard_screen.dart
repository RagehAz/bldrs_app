

import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class KeyboardScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const KeyboardScreen({
    @required this.keyboardModel,
    @required this.onSubmit,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final KeyboardModel keyboardModel;
  final ValueChanged<String> onSubmit;
  /// --------------------------------------------------------------------------
  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
  /// --------------------------------------------------------------------------
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  // -----------------------------------------------------------------------------
  KeyboardModel _keyboardModel;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
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
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _keyboardModel = widget.keyboardModel;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = BldrsAppBar.width(context);

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      layoutWidget: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            TextFieldBubble(
              globalKey: _keyboardModel.globalKey,
              appBarType: AppBarType.basic,
              bubbleWidth: _bubbleWidth,
              isFloatingField: _keyboardModel.isFloatingField,
              titleVerse: _keyboardModel.titleVerse,
              translateTitle: _keyboardModel.translateTitle,
              textController: _keyboardModel.controller,
              maxLines: _keyboardModel.maxLines,
              minLines: _keyboardModel.minLines,
              maxLength: _keyboardModel.maxLength,
              hintText: _keyboardModel.hintVerse,
              counterIsOn: _keyboardModel.counterIsOn,
              canObscure: _keyboardModel.canObscure,
              keyboardTextInputType: _keyboardModel.textInputType,
              keyboardTextInputAction: _keyboardModel.textInputAction,
              autoFocus: true,
              isFormField: _keyboardModel.isFormField,
              onSubmitted: widget.onSubmit,
              // autoValidate: true,
              validator: validator,
              textOnChanged: (String text){

                if (_keyboardModel.onChanged != null){
                  _keyboardModel.onChanged(text);
                }

                if (validator != null){

                  setState((){
                    if (validator() == null){
                      _buttonDeactivated = false;
                    }
                    else {
                      _buttonDeactivated = true;
                    }
                  });

                }
              },

            ),

            if (confirmButtonIsOn == true)
              DreamBox(
                isDeactivated: _buttonDeactivated,
                height: 40,
                verseScaleFactor: 0.6,
                margins: const EdgeInsets.symmetric(horizontal: 10),
                verse:'Confirm',

                onTap: () => _onSubmit(_keyboardModel.controller.text),
              ),

          ],
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
