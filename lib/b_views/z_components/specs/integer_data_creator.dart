import 'package:bldrs/a_models/kw/specs/spec_list_model.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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
    @required this.specList,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<int> onIntegerChanged;
  final int initialValue;
  final Function onSubmitted;
  final SpecList specList;
  /// --------------------------------------------------------------------------
  @override
  State<IntegerDataCreator> createState() => _IntegerDataCreatorState();
  /// --------------------------------------------------------------------------
}

class _IntegerDataCreatorState extends State<IntegerDataCreator> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<int> _integer = ValueNotifier<int>(null);
// -----------------------------------------------------------------------------
  @override
  void initState() {
    controller.text = widget.initialValue?.toString();
    super.initState();
  }
// -----------------------------------------------------------------------------
  void _validate() {
    _formKey.currentState.validate();
  }
// -----------------------------------------------------------------------------
  String _validator(String val) {
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
  Future<void> _increment() async {
    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    /// give it a zero if the value is null
    _integer.value ??= 0;

    _integer.value++;
    controller.text = _integer.value.toString();
    widget.onIntegerChanged(_integer.value);
  }

// -----------------------------------------------------------------------------
  Future<void> _decrement() async {
    Keyboarders.minimizeKeyboardOnTapOutSide(context);
    _integer.value--;
    controller.text = _integer.value.toString();
    widget.onIntegerChanged(_integer.value);
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    const double _bubbleHeight = 150;
    final double _bubbleWidth = BldrsAppBar.width(context);
    final BorderRadius _bubbleCorners = Borderers.superBorderAll(context, Ratioz.appBarCorner);

    const double _buttonsBoxWidth = 70;
    final double _textFieldWidth = _bubbleWidth - _buttonsBoxWidth - (Ratioz.appBarMargin * 2);
    const double _fieldHeight = 100;

    const double _buttonSize = _buttonsBoxWidth - 25;

    final String _hintText = Name.getNameByCurrentLingoFromNames(context: context, names: widget.specList.names)?.value;

    return Container(
      width: _screenWidth,
      height: _bubbleHeight,
      alignment: Alignment.center,
      // color: Colorz.red230,
      child: Container(
        width: _bubbleWidth,
        height: _bubbleHeight - (2 * Ratioz.appBarMargin),
        decoration: BoxDecoration(
          color: Colorz.white10,
          borderRadius: _bubbleCorners,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// NUMBER INPUT
            Container(
              width: _textFieldWidth,
              height: _fieldHeight,
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: SuperTextField(
                  fieldIsFormField: true,
                  // key: ValueKey('price_text_field'),
                  autofocus: true,
                  width: _textFieldWidth,
                  height: _fieldHeight,
                  textController: controller,
                  hintText: _hintText,
                  fieldColor: Colorz.black20,
                  centered: true,
                  counterIsOn: false,
                  inputSize: 4,
                  inputWeight: VerseWeight.black,
                  corners: Ratioz.appBarCorner,
                  keyboardTextInputType: TextInputType.number,
                  labelColor: Colorz.blackSemi255,
                  validator: (String val) => _validator(val),
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
            ),

            /// INCREMENTER BUTTONS
            SizedBox(
              width: _buttonsBoxWidth,
              height: _fieldHeight,
              // color: Colorz.bloodTest,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  DreamBox(
                    width: _buttonSize,
                    height: _buttonSize,
                    icon: Iconz.arrowUp,
                    iconSizeFactor: 0.4,
                    onTap: _increment,
                  ),

                  const SizedBox(
                    width: 5,
                    height: 5,
                  ),

                  DreamBox(
                    width: _buttonSize,
                    height: _buttonSize,
                    icon: Iconz.arrowDown,
                    iconSizeFactor: 0.4,
                    onTap: _decrement,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
