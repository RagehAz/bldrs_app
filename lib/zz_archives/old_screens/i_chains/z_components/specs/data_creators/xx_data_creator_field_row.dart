import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/json/currency_json_ops.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class NumberDataCreatorFieldRow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NumberDataCreatorFieldRow({
    required this.hasUnit,
    required this.formKey,
    required this.textController,
    required this.validator,
    required this.onKeyboardChanged,
    required this.onKeyboardSubmitted,
    required this.selectedUnitID,
    required this.onUnitSelectorButtonTap,
    required this.hintVerse,
    required this.appBarType,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool hasUnit;
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final String? Function(String?) validator;
  final ValueChanged<String?>? onKeyboardChanged;
  final ValueChanged<String?>? onKeyboardSubmitted;
  final ValueNotifier<String?> selectedUnitID;
  final Function onUnitSelectorButtonTap;
  final Verse hintVerse;
  final AppBarType appBarType;
  final double? width;
  /// --------------------------------------------------------------------------
  Widget _theBox({
    required Verse verse,
    required bool loading,
  }){

    const int _textSize = 4;
    final double _buttonHeight = BldrsTextField.getFieldHeight(
      context: getMainContext(),
      minLines: 1,
      textSize: _textSize,
      scaleFactor: 1,
      withBottomMargin: false,
      withCounter: false,
    );
    final double _unitButtonWidth = hasUnit == true ? 80 : 0;

    return BldrsBox(
      width: _unitButtonWidth,
      height: _buttonHeight,
      verse: verse,
      verseScaleFactor: 0.7,
      verseMaxLines: 2,
      onTap: onUnitSelectorButtonTap,
      loading: loading,
    );

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// HEIGHT
    const int _textSize = 4;
    // --------------------
    /// WIDTH
    final double _clearWidth = width ?? Bubble.clearWidth(context: context);
    final double _unitButtonSpacer = hasUnit == true ? Ratioz.appBarMargin : 0;
    final double _unitButtonWidth = hasUnit == true ? 80 : 0;
    final double _textFieldWidth = _clearWidth - _unitButtonWidth - _unitButtonSpacer - 20;
    // --------------------
    return Row(
      key: const ValueKey<String>('NumberDataCreatorFieldRow'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// NUMBER TEXT FIELD
        Form(
          key: formKey,
          child: BldrsTextField(
            appBarType: appBarType,
            globalKey: formKey,
            // titleVerse: const Verse(
            //   id: 'phid_number',
            //   translate: true,
            // ),
            isFormField: true,
            autofocus: true,
            width: _textFieldWidth,
            textController: textController,
            hintVerse: hintVerse,
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
        if (hasUnit == true)
          const SizedBox(
            width: Ratioz.appBarMargin,
          ),

        /// UNIT SELECTOR BUTTON
        if (hasUnit == true)
          ValueListenableBuilder(
              valueListenable: selectedUnitID,
              builder: (_, String? selectedUnitID, Widget? child){

                final bool _isCurrency = Phider.checkVerseIsCurrency(selectedUnitID);

                if (_isCurrency == true){

                  final CurrencyModel? _currency = CurrencyJsonOps.proGetCurrencyByCurrencyID(currencyID: selectedUnitID);

                  return _theBox(
                    loading: false,
                    verse: Verse(
                      id: _currency?.symbol ?? '...',
                      translate: false,
                    ),
                  );

                }

                else {

                  return _theBox(
                    loading: false,
                    verse: Verse(
                      id: Phider.removeIndexFromPhid(phid: selectedUnitID),
                      translate: true,
                    ),
                  );

                }

              }
          ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
