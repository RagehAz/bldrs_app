import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class NumberDataCreatorFieldRow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NumberDataCreatorFieldRow({
    @required this.hasUnit,
    @required this.formKey,
    @required this.textController,
    @required this.validator,
    @required this.onKeyboardChanged,
    @required this.onKeyboardSubmitted,
    @required this.selectedUnitID,
    @required this.onUnitSelectorButtonTap,
    @required this.hintVerse,
    @required this.appBarType,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool hasUnit;
  final GlobalKey<FormState> formKey;
  final TextEditingController textController;
  final String Function(String) validator;
  final ValueChanged<String> onKeyboardChanged;
  final ValueChanged<String> onKeyboardSubmitted;
  final ValueNotifier<String> selectedUnitID;
  final Function onUnitSelectorButtonTap;
  final Verse hintVerse;
  final AppBarType appBarType;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// HEIGHT
    const int _textSize = 4;
    final double _buttonHeight = BldrsTextField.getFieldHeight(
      context: context,
      minLines: 1,
      textSize: _textSize,
      scaleFactor: 1,
      withBottomMargin: false,
      withCounter: false,
    );
    // --------------------
    /// WIDTH
    final double _clearWidth = width ?? Bubble.clearWidth(context);
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
            titleVerse: const Verse(
              text: 'phid_number',
              translate: true,
            ),
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
              builder: (_, String selectedUnitID, Widget child){


                Verse _verse = Verse(
                  text: Phider.removeIndexFromPhid(phid: selectedUnitID),
                  translate: true,
                );

                final bool _isCurrency = Phider.checkVerseIsCurrency(selectedUnitID);
                if (_isCurrency == true){
                  final CurrencyModel _currency = ZoneProvider.proGetCurrencyByCurrencyID(
                      context: context,
                      currencyID: selectedUnitID,
                      listen: false,
                  );
                  _verse = Verse(
                    text: _currency.symbol,
                    translate: false,
                  );
                }

                return DreamBox(
                  width: _unitButtonWidth,
                  height: _buttonHeight,
                  verse: _verse,
                  verseScaleFactor: 0.7,
                  verseMaxLines: 2,
                  onTap: onUnitSelectorButtonTap,
                );

              }
          ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
