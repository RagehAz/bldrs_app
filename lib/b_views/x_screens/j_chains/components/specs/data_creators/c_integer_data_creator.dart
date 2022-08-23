import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/picker_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class IntegerAndDoubleDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const IntegerAndDoubleDataCreator({
    @required this.onExportSpecs,
    @required this.initialValue,
    @required this.initialUnit,
    @required this.specPicker,
    @required this.onKeyboardSubmitted,
    @required this.dataCreatorType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final dynamic initialValue;
  final String initialUnit;
  final PickerModel specPicker;
  final Function onKeyboardSubmitted;
  final DataCreator dataCreatorType;
  /// --------------------------------------------------------------------------
  @override
  State<IntegerAndDoubleDataCreator> createState() => _IntegerAndDoubleDataCreatorState();
  /// --------------------------------------------------------------------------
}

class _IntegerAndDoubleDataCreatorState extends State<IntegerAndDoubleDataCreator> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  ValueNotifier<dynamic> _specValue;
  ValueNotifier<String> _selectedUnit;
  Chain _unitChain;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

// ---------------------------------
    controller.text = widget.initialValue?.toString();
    _specValue = ValueNotifier(widget.initialValue);
// ---------------------------------
    _unitChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: widget.specPicker.unitChainID,
    );
    final String _initialUnit = _unitChain == null ? null : widget.initialUnit ?? _unitChain.sons[0];
    _selectedUnit = ValueNotifier<String>(_initialUnit);
// ---------------------------------
//     blog('initializing data creator with this spec picker : -');
//     widget.specPicker.blogSpecPicker();
// ---------------------------------
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    controller.dispose();
    _specValue.dispose();
    _selectedUnit.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _validate() {
    _formKey.currentState.validate();
  }
// -----------------------------------------------------------------------------
  String _validator() {

    /// NEED TO VALIDATE IF FIELD IS REQUIRED
    /// IF ITS INT OR DOUBLE

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
  List<SpecModel> _createSpecs(){
    final List<SpecModel> _output = <SpecModel>[];

    /// when there is value
    if (Stringer.checkStringIsNotEmpty(controller.text) == true){
      final SpecModel _valueSpec = SpecModel(
        pickerChainID: widget.specPicker.chainID,
        value: _specValue.value,
      );
      _output.add(_valueSpec);

      /// when there is unit chain
      if (widget.specPicker.unitChainID != null){
        final SpecModel _unitSpec = SpecModel(
          pickerChainID: widget.specPicker.unitChainID,
          value: _selectedUnit.value,
        );
        _output.add(_unitSpec);
      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
  void _fixValueDataTypeAndSetValue(String text){
    // NOTE : controller.text = '$_value'; => can not redefine controller, it bugs text field

    /// IF INT
    if (isIntDataCreator(widget.dataCreatorType) == true){
      final double _doubleFromString = Numeric.transformStringToDouble(text);
      _specValue.value = _doubleFromString.toInt();
    }

    /// IF DOUBLE
    else if (isDoubleDataCreator(widget.dataCreatorType) == true){
      _specValue.value = Numeric.transformStringToDouble(text);
    }

    /// OTHERWISE
    else {
      _specValue.value = text;
    }

  }
// -----------------------------------------------------------------------------
  void _onTextChanged(String text) {

    /// VALIDATE
    _validate();

    /// FIX VALUE TYPE AND SET VALUE NOTIFIER
    _fixValueDataTypeAndSetValue(text);

    /// PASS VALUES UP
    final List<SpecModel> _specs = _createSpecs();
    widget.onExportSpecs(_specs);

  }
// -----------------------------------------------------------------------------
  Future<void> _onUnitSelectorTap() async {

    Keyboard.closeKeyboard(context);

    if (Chain.checkSonsAreStrings(_unitChain.sons) == true){

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
                      final String _unitName = xPhrase(context, _unitID, phrasePro: pro);

                      return BottomDialog.wideButton(
                        context: context,
                        verse: _unitName,
                        icon: phidIcon(context, _unitID),
                        verseCentered: true,
                        onTap: () => _onSelectUnit(_unitID),
                      );

                    }
            );

          }
      );


    }

  }
// -----------------------------------------------------------------------------
  void _onSelectUnit(String unitID){
    blog('selected unit : $unitID');

    _selectedUnit.value = unitID;
    Nav.goBack(
      context: context,
      invoker: 'IntegerAndDoubleDataCreator._onSelectUnit',
    );

    _onTextChanged(controller.text);

  }
// -----------------------------------------------------------------------------
  Future<void> _onKeyboardSubmitted(String val) async {
    _onTextChanged(val);
    Keyboard.closeKeyboard(context);
    // await null;

    await Future<void>.delayed(Ratioz.durationSliding400,
            () async {
          widget.onKeyboardSubmitted();
        });
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

    final String _hintText = xPhrase(context, widget.specPicker.chainID);

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
                title: 'Number',
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
                textInputType: TextInputType.number,
                // labelColor: Colorz.blackSemi255,
                validator: () => _validator(),
                onChanged: (String val) => _onTextChanged(val),
                onSubmitted: _onKeyboardSubmitted,
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
                    verse: xPhrase(context, selectedUnitID),
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
