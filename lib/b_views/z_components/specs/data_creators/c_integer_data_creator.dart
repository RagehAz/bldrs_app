import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/b_super_text_field_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class IntegerDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const IntegerDataCreator({
    @required this.onIntegerChanged,
    @required this.initialValue,
    @required this.onSubmitted,
    @required this.specPicker,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<int> onIntegerChanged;
  final int initialValue;
  final Function onSubmitted;
  final SpecPicker specPicker;
  /// --------------------------------------------------------------------------
  @override
  State<IntegerDataCreator> createState() => _IntegerDataCreatorState();
  /// --------------------------------------------------------------------------
}

class _IntegerDataCreatorState extends State<IntegerDataCreator> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController(); /// tamam disposed
  final ValueNotifier<int> _integer = ValueNotifier<int>(null); /// tamam disposed
  ValueNotifier<String> _selectedUnit;
  Chain _unitChain;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
// ---------------------------------
    controller.text = widget.initialValue?.toString();
// ---------------------------------
    _unitChain = superGetChain(context, widget.specPicker.unitChainID);
    final String _initialUnit = _unitChain == null ? null : _unitChain.sons[0];
    _selectedUnit = ValueNotifier<String>(_initialUnit);
// ---------------------------------
    blog('initializing data creator with this spec picker : -');
    widget.specPicker.blogSpecPicker();
// ---------------------------------
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _integer.dispose();
    _selectedUnit.dispose();
  }
// -----------------------------------------------------------------------------
  void _validate() {
    _formKey.currentState.validate();
  }
// -----------------------------------------------------------------------------
  String _validator() {
    // final int _maxDigits = _currency.value.digits;
    //
    // final String _numberString = controller.text;
    // final String _fractionsStrings = TextMod.removeTextBeforeFirstSpecialCharacter(_numberString, '.');
    // final int _numberOfFractions = _fractionsStrings.length;
    //
    // bool _invalidDigits = _numberOfFractions > _maxDigits;
    //
    // print('_numberOfFractions : $_numberOfFractions : _numberString : $_numberString : _fractionsStrings : $_fractionsStrings');
    //
    // if (_invalidDigits == true){
    //
    //   final String _error = 'Can not add more than ${_maxDigits} fractions';
    //
    //   print(_error);
    //
    //   return _error;
    //
    // } else {
    //
    //   print('tamam');
    //
    //   return null;
    //
    // }

    return null;
  }
// -----------------------------------------------------------------------------
  void _onTextChanged(String val) {
    _validate();

    final int _intFromString = Numeric.stringToInt(val);
    _integer.value = _intFromString;
    widget.onIntegerChanged(_intFromString);
  }
// -----------------------------------------------------------------------------
  Future<void> _onUnitSelectorTap() async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    if (Chain.sonsAreStrings(_unitChain.sons) == true){

      final List<String> _units = _unitChain.sons;

      await BottomDialog.showButtonsBottomDialog(
          context: context,
          draggable: true,
          buttonHeight: 40,
          numberOfWidgets: _unitChain.sons.length,
          builder: (_, PhraseProvider pro){


            return List.generate(_unitChain.sons.length,
                    (index){

                      final String _unitID = _units[index];
                      final String _unitName = superPhrase(context, _unitID, providerOverride: pro);

                      return BottomDialog.wideButton(
                        context: context,
                        verse: _unitName,
                        icon: superIcon(context, _unitID),
                        verseCentered: true,
                        onTap: () => onUnitTap(_unitID),
                      );

                    }
            );

          }
      );


    }

  }
// -----------------------------------------------------------------------------
  void onUnitTap(String unitID){
    blog('selected unit : $unitID');

    _selectedUnit.value = unitID;
    Nav.goBack(context);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = BldrsAppBar.width(context);
    final double _clearWidth = Bubble.clearWidth(context);

    final double _textFieldWidth = _clearWidth - 100;

    const int _textSize = 4;
    const double _spacer = Ratioz.appBarMargin;
    final double _buttonWidth = _clearWidth - _textFieldWidth - _spacer;
    final double _buttonHeight = SuperTextField.getFieldHeight(
        context: context,
        minLines: 1,
        textSize: _textSize,
        scaleFactor: 1,
        withBottomMargin: false,
        withCounter: false,
    );

    final String _hintText = superPhrase(context, widget.specPicker.chainID);


    return Bubble(
      title: 'Add ...',
      width: _bubbleWidth,
      columnChildren: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// NUMBER INPUT
            Form(
              key: _formKey,
              child: SuperTextField(
                isFormField: true,
                autofocus: true,
                width: _textFieldWidth,
                textController: controller,
                hintText: _hintText,
                centered: true,
                // counterIsOn: false,
                textSize: _textSize,
                textWeight: VerseWeight.black,
                corners: Ratioz.appBarCorner,
                keyboardTextInputType: TextInputType.number,
                // labelColor: Colorz.blackSemi255,
                validator: () => _validator(),
                onChanged: (String val) => _onTextChanged(val),
                onSubmitted: (String val) async {
                  _onTextChanged(val);
                  Keyboarders.minimizeKeyboardOnTapOutSide(context);
                  // await null;

                  await Future<void>.delayed(Ratioz.durationSliding400,
                          () async {
                        widget.onSubmitted();
                      });
                },
              ),
            ),

            const SizedBox(width: _spacer),

            if (_unitChain != null)
            ValueListenableBuilder(
                valueListenable: _selectedUnit,
                builder: (_, String selectedUnitID, Widget child){

                  return DreamBox(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    // color: Colorz.bloodTest,
                    verse: superPhrase(context, selectedUnitID),
                    verseScaleFactor: 0.7,
                    verseMaxLines: 2,
                    onTap: _onUnitSelectorTap,
                  );

                }
            ),

          ],
        ),

      ],
    );
  }
}
