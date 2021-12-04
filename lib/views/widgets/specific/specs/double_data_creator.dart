import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DoubleDataCreator extends StatefulWidget {
  final ValueChanged<double> onDoubleChanged;
  final double initialValue;
  final Function onSubmitted;
  final SpecList specList;

  const DoubleDataCreator({
    @required this.onDoubleChanged,
    @required this.initialValue,
    @required this.onSubmitted,
    @required this.specList,
    Key key
  }) : super(key: key);

  @override
  State<DoubleDataCreator> createState() => _DoubleDataCreatorState();
}

class _DoubleDataCreatorState extends State<DoubleDataCreator> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  ValueNotifier<double> _double = ValueNotifier<double>(null);
// -----------------------------------------------------------------------------
  @override
  void initState() {

    controller.text = widget.initialValue?.toString() ?? null;

    super.initState();
  }
// -----------------------------------------------------------------------------
  void _validate(){
    _formKey.currentState.validate();
  }
// -----------------------------------------------------------------------------
  String _validator(String val){

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
  void _onTextChanged(String val){

    _validate();

    final double _doubleFromString = Numeric.stringToDouble(val);
    _double.value = _doubleFromString;
    widget.onDoubleChanged(_doubleFromString);

  }
// -----------------------------------------------------------------------------
//   Future<void> _increment() async {
//     Keyboarders.minimizeKeyboardOnTapOutSide(context);
//
//     if (_double.value == null){
//       _double.value = 0;
//     }
//
//     _double.value ++;
//     controller.text = _double.value.toString();
//     widget.onDoubleChanged(_double.value);
//   }
// // -----------------------------------------------------------------------------
//   Future<void> _decrement() async {
//     Keyboarders.minimizeKeyboardOnTapOutSide(context);
//     _double.value --;
//     controller.text = _double.value.toString();
//     widget.onDoubleChanged(_double.value);
//   }
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

    // const double _buttonSize = _buttonsBoxWidth - 25;

    final String _hintText = '${Name.getNameByCurrentLingoFromNames(context, widget.specList.names)}';

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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  onSubmitted: (String val) async  {

                    _onTextChanged(val);
                    await Keyboarders.minimizeKeyboardOnTapOutSide(context);

                    await Future<void>.delayed(Ratioz.durationSliding400, ()async {
                      widget.onSubmitted();
                    });

                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
