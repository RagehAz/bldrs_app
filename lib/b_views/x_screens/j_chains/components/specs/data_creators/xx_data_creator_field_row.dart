import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NumberDataCreatorFieldRow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NumberDataCreatorFieldRow({
    @required this.picker,
    @required this.formKey,
    @required this.textController,
    @required this.validator,
    @required this.onKeyboardChanged,
    @required this.onKeyboardSubmitted,
    @required this.selectedUnitID,
    @required this.onUnitSelectorButtonTap,
    @required this.hintText,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final String Function() validator;
  final ValueChanged<String> onKeyboardChanged;
  final ValueChanged<String> onKeyboardSubmitted;
  final ValueNotifier<String> selectedUnitID;
  final Function onUnitSelectorButtonTap;
  final String hintText;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------
    /// UNIT CHAIN
    final Chain _unitChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker.unitChainID,
    );
// -----------------------------------------------------------
    /// HEIGHT
    const int _textSize = 4;
    final double _buttonHeight = SuperTextField.getFieldHeight(
      context: context,
      minLines: 1,
      textSize: _textSize,
      scaleFactor: 1,
      withBottomMargin: false,
      withCounter: false,
    );
// -----------------------------------------------------------
    /// WIDTH
    final double _clearWidth = Bubble.clearWidth(context);
    final double _unitButtonSpacer = _unitChain == null ? 0 : Ratioz.appBarMargin;
    final double _unitButtonWidth = _unitChain == null ? 0 : 80;
    final double _textFieldWidth = _clearWidth - _unitButtonWidth - _unitButtonSpacer;
// -----------------------------------------------------------
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// NUMBER TEXT FIELD
        Form(
          key: formKey,
          child: SuperTextField(
            titleVerse: '##Number',
            isFormField: true,
            autofocus: true,
            width: _textFieldWidth,
            textController: textController,
            hintVerse: hintText,
            centered: true,
            // counterIsOn: false,
            textSize: _textSize,
            textWeight: VerseWeight.black,
            corners: Ratioz.appBarCorner,
            textInputType: TextInputType.number,
            // labelColor: Colorz.blackSemi255,
            validator: validator,
            onChanged: onKeyboardChanged,
            onSubmitted: onKeyboardSubmitted,
          ),
        ),

        /// UNIT BUTTON SPACER
        if (_unitChain != null)
        const SizedBox(
            width: Ratioz.appBarMargin,
        ),

        /// UNIT SELECTOR BUTTON
        if (_unitChain != null)
          ValueListenableBuilder(
              valueListenable: selectedUnitID,
              builder: (_, String selectedUnitID, Widget child){

                return DreamBox(
                  width: _unitButtonWidth,
                  height: _buttonHeight,
                  // color: Colorz.bloodTest,
                  verse: selectedUnitID,
                  translateVerse: true,
                  verseScaleFactor: 0.65,
                  verseMaxLines: 2,
                  onTap: onUnitSelectorButtonTap,
                );

              }
          ),

      ],
    );

  }
}
